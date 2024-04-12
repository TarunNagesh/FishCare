from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


finances = Blueprint('finances', __name__)

# Get all the plans from the database
@finances.route('/plans', methods=['GET'])
def finances():
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


@finances.route('/finances', methods=['POST'])
def add_new_plans():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    id = the_data['TransactionID']
    manager = the_data['ManagedBy']
    rec = the_data['Recievables']
    pay = the_data['Payables']
    sent = the_data['DateSent']

    # Constructing the query
    query = 'insert into finances (TransactionID, ManagedBy, Recievables, Payables, DateSent) values ("'
    query += id + '", "'
    query += manager + '", "'
    query += rec + '", "'
    query += pay + '", "'
    query += sent + '", "'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'