from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


plans = Blueprint('plans', __name__)

# Get all the plans from the database
@plans.route('/plans', methods=['GET'])
def plans():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of plans
    # cursor.execute('SELECT id, plans_code, plans_name, list_price FROM plans')
    cursor.execute('')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@plans.route('/plans/<id>', methods=['GET'])
def get_plans_detail (id):

    query = 'SELECT PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost FROM plans WHERE PlanID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
    

@plans.route('/plans', methods=['POST'])
def add_new_plans():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['PlanId']
    madeBy = the_data['MadeBy']
    approvedBy = the_data['ApprovedBy']
    type = the_data['Type']
    details = the_data['Details']
    status = the_data['Status']
    cost = the_data['Cost']

    # Constructing the query
    query = 'insert into plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values ("'
    query += id + '", "'
    query += madeBy + '", "'
    query += approvedBy + '", "'
    query += type + '", "'
    query += details + '", "'
    query += status + '", "'
    query += str(cost) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
