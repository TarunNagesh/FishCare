from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


plans = Blueprint('plans', __name__)

# Get all the plans from the database
@plans.route('/plans', methods=['GET'])
def plans():
    query = '''
        SELECT DISTINCT type AS Label
        FROM plans
        WHERE type IS NOT NULL
        ORDER BY type
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query)

    json_data = []
    # fetch all the column headers and then all the data from the cursor
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    # zip headers and data together into dictionary and then append to json data dict.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

@plans.route('/plans/<id>', methods=['GET'])
def get_plan_detail (id):

    query = 'SELECT planID, madeBy, approvedBy, type, details, status, cost FROM plans WHERE planID = ' + str(id)
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
def add_new_plan():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['planId']
    madeBy = the_data['madeBy']
    approvedBy = the_data['approvedBy']
    type = the_data['type']
    details = the_data['details']
    status = the_data['status']
    cost = the_data['cost']

    # Constructing the query
    query = 'insert into plans (planID, madeBy, approvedBy, type, details, status, cost) values ("'
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


@plans.route('/plans', methods=['PUT'])
def update_plan():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['planId']
    madeBy = the_data['madeBy']
    approvedBy = the_data['approvedBy']
    type = the_data['type']
    details = the_data['details']
    status = the_data['status']
    cost = the_data['cost']


    # Constructing the query
    query = 'UPDATE plans SET madeBy = %s, approvedBy = %s, type = %s, details = %s, status = %s, cost = %s, WHERE planID = %s'
    current_app.logger.info(query)
    
    
    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (madeBy, approvedBy, type, details, status, cost, id))
    db.get_db().commit()
    
    return 'Success!'

# Delete a prescription given an ID
@plans.route('/plans/<id>', methods = ['DELETE'])
def delete_plan_id():
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['planID']

    query = 'DELETE FROM plans WHERE planID = ' + str(id)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'

# Delete plans where status = 'Denied'
@plans.route('/plans', methods = ['DELETE'])
def delete_denied_plans():
    the_data = request.json
    current_app.logger.info(the_data) 

    query = 'DELETE FROM plans WHERE status = "Denied"'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'