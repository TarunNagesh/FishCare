from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Reports = Blueprint('Reports', __name__)

@Reports.route('/Reports', methods=['GET'])
def get_reports():
    """ Get all the products from the database """
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT ReportID, FishID, MadeBy, SentTo, Type, Description FROM Reports')

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

@Reports.route('/Reports/<id>', methods=['GET'])
def get_reports_detail (id):
    """ Gets tank details based on a query """
    query = 'SELECT ReportID, FishID, MadeBy, SentTo, Type, Description FROM Reports WHERE id = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Reports.route('/Reports', methods=['POST'])
def add_report(): 
    """ adds a report """
     # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)
    rep = the_data["ReportID"]
    fish = the_data["FishID"]
    made = the_data["MadeBy"]
    sent = the_data["SentTo"]
    type = the_data["Type"]
    desc = the_data["Description"]

    # Constructing the query
    query = 'INSERT INTO Reports VALUES(%s, %s, %s, %s, %s, %s)'

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (rep, fish, made, sent, type, desc))
    db.get_db().commit()
    
    return 'Success!'

# Delete a procedure
@Reports.route('/Reports', methods = ['DELETE'])
def delete_report():
    """ deletes a report """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['ReportID']

    query = 'DELETE FROM Reports WHERE id = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Report deleted!'

@Reports.route('/Reports_managers/<id>', methods=['GET'])
def get_report_author(id): 
    """ gets all the managers in the tanks""" 
    query = 'SELECT MadeBy FROM Reports WHERE reportid = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@Reports.route('/Reports/<id>', methods=['PUT'])
def update_report_details(id): 
    """ updates a given report's details""" 
    data = request.json

    vals = [val for key, val in data.items() if key != 'ReportID']

    query = "UPDATE Reports SET ReportID=%s, FishID=%s, MadeBy=%s, SentTo=%s, Type=%s, Description=%s WHERE ReportID = %s"

    cursor = db.get_db().cursor()
    data = tuple(vals)
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'Updated successfully!'