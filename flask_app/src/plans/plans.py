from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


plans = Blueprint('plans', __name__)

# Get all the plans from the database
@plans.route('/plans', methods=['GET'])
def plans():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of planss
    # cursor.execute('SELECT id, plans_code, plans_name, list_price FROM planss')
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

    query = 'SELECT PlanID, MadeBy, ApprovedBy, Type, Details, Status, Cost FROM plans WHERE id = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
    

@planss.route('/plans', methods=['POST'])
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
    query = 'insert into plans (plans_name, description, category, list_price) values ("'
    query += name + '", "'
    query += description + '", "'
    query += category + '", '
    query += str(price) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

### Get all plans categories
@planss.route('/categories', methods = ['GET'])
def get_all_categories():
    query = '''
        SELECT DISTINCT category AS label, category as value
        FROM planss
        WHERE category IS NOT NULL
        ORDER BY category
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