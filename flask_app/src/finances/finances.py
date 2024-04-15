from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


finances = Blueprint('finances', __name__)

# Get all the plans from the database
@finances.route('/finances', methods=['GET'])
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

    # get all finances given a date 
@finances.route('/finances_date', methods=['GET'])
def get_finances_author(date): # idk if this works 
    """ gets all finances on sent on a given date """ 
    query = 'SELECT * FROM finances WHERE DateSent = ' + str(date)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@finances.route('/finances', methods=['GET'])
def update_transaction(): # idk if this works
    """ updates the details of a transaction """ 
    data = request.json

    vals = [val for key, val in data.items() if key != 'TransactionID']

    query = "UPDATE finances SET TransactionID=%s, ManagedBy=%s, Recievables=%s, Payables=%s, DateSent=%s WHERE TransactionID = %s"

    cursor = db.get_db().cursor()
    data = tuple(vals)
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'Updated successfully!'

@finances.route('/finances', methods = ['DELETE'])
def delete_finances():
    """ deletes a transaction """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['TransactionID']

    query = 'DELETE FROM finances WHERE id = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Transaction deleted!'    

@finances.route('/finances/<id>', methods=['GET'])
def get_finances_detail (id):
    """ Gets finances based on an ID """
    query = 'SELECT TransactionID, ManagedBy, Recievables, Payables, DateSent FROM finances WHERE id = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
