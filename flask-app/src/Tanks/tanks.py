from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Tanks = Blueprint('Tanks', __name__)

@Tanks.route('/Tanks', methods=['GET'])
def get_tanks():
    """ gets all the tanks """
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT TankID, ManagedBy, OverseenBy, AssignedTo, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status FROM Tanks')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    the_data = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@Tanks.route('/Tanks/<id>', methods=['GET'])
def get_tanks_detail (id):
    """ Gets tank details based on a query """
    query = 'SELECT TankID, ManagedBy, OverseenBy, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status FROM Tanks WHERE id = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Tanks.route('/Tanks', methods=['PUT'])
def update_tank_details(): 
    """ updates a tank's details"""
    data = request.json
    # current_app.logger.info(cust_info)
    tank_id = data['TankID']
    food = data['Food']
    phlevel = data['PHlevel']
    status = data['Status']
    temp = data['Temp']
    timecleaned = data['TimeCleaned']
    timefed = data['TimeFed']

    query = "UPDATE Tanks SET Food=%s, PHlevel=%s, Status=%s, Temp=%s, TimeCleaned=%s, TimeFed=%s WHERE TankID = %s"
    data = (food, phlevel, status, temp, timecleaned, timefed, tank_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'customer updated'


@Tanks.route('/Tanks', methods = ['DELETE'])
def delete_tank():
    """ delete a tank """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['TankID']

    query = 'DELETE FROM Tanks WHERE id = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Tank deleted!'

@Tanks.route('/Tanks_managers/<id>', methods=['GET'])
def get_tank_managers(id): 
    """ gets all the managers in the tanks""" 
    query = 'SELECT ManagedBy FROM tanks WHERE tankid = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@Tanks.route('/Tanks', methods=['POST'])
def add_new_tank():
    """ adds a new fish to the table """
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    tankid = the_data['TankID']
    managed= the_data['ManagedBy']
    overseen = the_data['OverseenBy']
    assigned = the_data['AssignedTo']
    food = the_data['Food'] 
    ph = the_data['PHlevel']
    status = the_data['Status']
    temp = the_data['Temp']
    cleaned = the_data['TimeCleaned']
    fed = the_data['TimeFed']
    type = the_data['WaterType']

    # Constructing the query
    query = "INSERT INTO Tanks VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"


    current_app.logger.info(query, (tankid, managed, overseen, assigned, temp, cleaned, type, ph, food, fed, status))

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (tankid, managed, overseen, assigned, temp, cleaned, type, ph, food, fed, status))
    db.get_db().commit()
    
    return 'Success!'
