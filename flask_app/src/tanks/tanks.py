from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


tanks = Blueprint('tanks', __name__)

# Get all the products from the database
@tanks.route('/tanks', methods=['GET'])
def get_tanks():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT TankID, ManagedBy, OverseenBy, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status FROM tanks')

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

@tanks.route('/tanks/<id>', methods=['GET'])
def get_tanks_detail (id):
    """ Gets tank details based on a query """
    query = 'SELECT TankID, ManagedBy, OverseenBy, Temp, TimeCleaned, WaterType, PHlevel, Food, TimeFed, Status FROM tanks WHERE id = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@tanks.route('/tanks/<id>', methods=['PUT'])
def update_tank_details(): 
    data = request.json

    vals = [val for key, val in data.items() if key != 'TankID']

    query = "UPDATE tanks SET ManagedBy=%s, OverseenBy=%s, Temp=%s, TimeCleaned=%s, WaterType=%s, PHlevel=%s, Food=%s, TimeFed=%s, Status=%s WHERE TankID = %s"

    cursor = db.get_db().cursor()
    data = tuple(vals)
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'Updated successfully!'

@tanks.route('/tanks', methods = ['DELETE'])
def delete_tank():
    """ delete tank """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['tankid']

    query = 'DELETE FROM tanks WHERE id = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Tank deleted!'

@tanks.route('/tanks/<managers>', methods=['GET'])
def get_tank_managers(id): 
    """ gets all the managers in the tanks""" 
    query = 'SELECT ManagedBy FROM tanks WHERE procid = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a new procedure
@tanks.route('/tanks', methods=['POST'])
def add_new_tanks():
     # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    vals = [f'"{val}"' for key, val in the_data.items() if key != 'TankID']

    keys = [key for key in the_data if key != 'TankID']

    # constructing the query
    query = f'INSERT INTO tanks ({", ".join(keys)}) VALUES ({", ".join(keys)})'

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'