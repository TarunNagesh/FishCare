from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Plans = Blueprint('Plans', __name__)

@Plans.route('/Plans', methods=['GET'])
def get_plans():
    """ Get all the Plans from the database """
    query = '''
        SELECT DISTINCT Type AS Label
        FROM Plans
        WHERE Type IS NOT NULL
        ORDER BY Type
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

@Plans.route('/Plans/<id>', methods=['GET'])
def get_plan_detail (id):
    """ get plan's details """
    query = 'SELECT PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost FROM Plans WHERE PlanID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
    
@Plans.route('/Plans', methods=['POST'])
def add_new_plan():
    """ add a new plan """
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
    query = 'insert into Plans (PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost) values ("'
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

@Plans.route('/Plans/<id>', methods=['PUT'])
def update_plan():
    """ update a plan given it's ID """
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
    query = 'UPDATE Plans SET MadeBy = %s, ApprovedBy = %s, Type = %s, Details = %s, Status = %s, Cost = %s, WHERE PlanID = %s'
    current_app.logger.info(query)
    
    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (madeBy, approvedBy, type, details, status, cost, id))
    db.get_db().commit()
    
    return 'Success!'

@Plans.route('/Plans/<id>', methods = ['DELETE'])
def delete_plan_id():
    """ Delete a prescription given an ID """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['PlanID']

    query = 'DELETE FROM Plans WHERE PlanID = ' + str(id)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Plan deleted!'

@Plans.route('/Plans', methods = ['DELETE'])
def delete_denied_Plans():
    """ Delete Plans where status = 'Denied' """
    the_data = request.json
    current_app.logger.info(the_data) 

    query = 'DELETE FROM Plans WHERE Status = "Denied"'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Plans deleted!'