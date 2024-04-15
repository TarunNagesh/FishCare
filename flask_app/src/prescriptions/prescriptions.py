from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

prescriptions = Blueprint('prescriptions', __name__)

@prescriptions.route('/prescriptions', methods=['GET'])
def prescriptions():
    """ Get all the prescriptions from the database """
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of prescriptions
    # cursor.execute('SELECT id, product_code, product_name, list_price FROM products')
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

@prescriptions.route('/prescriptions/<id>', methods=['GET'])
def get_prescriptions_detail (id):
    """ Get details of a specific prescriptions """
    query = 'SELECT * FROM prescriptions WHERE medid = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@prescriptions.route('/prescriptions', methods=['POST'])
def add_new_prescriptions():
    """ Add a new prescription """
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    procedure_for = the_data['procfor']
    id = the_data['medid']
    med = the_data['medicine']
    dosage = the_data['dosage']

    # Constructing the query
    query = 'INSERT INTO prescriptions (procfor, medid, medicine, dosage) VALUES ("'
    query += procedure_for + '", "'
    query += id + '", "'
    query += med + '", "'
    query += dosage + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@prescriptions.route('/prescriptions', methods=['PUT'])
def update_prescriptions():
    """ Update the details of a prescriptions """
    pres_info = request.json
    # current_app.logger.info(cust_info)
    procedure_for = pres_info['procfor']
    id = pres_info['medid']
    med = pres_info['medicine']
    dosage = pres_info['dosage']

    query = 'UPDATE prescriptions SET procfor = %s, medicine = %s, dosage = %s, WHERE medid = %s'
    data = (procedure_for, med, dosage, id)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Prescription updated!'

@prescriptions.route('/prescriptions', methods = ['DELETE'])
def delete_prescription():
    """ Delete a prescription """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['medid']

    query = 'DELETE FROM prescriptions WHERE medid = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'

@prescriptions.route('/prescriptions_no_dosage', methods = ['DELETE'])
def delete_empty_prescriptions():
    """ Delete prescriptions where dosage = 0 """ 
    the_data = request.json
    current_app.logger.info(the_data) 

    query = 'DELETE FROM prescriptions WHERE dosage = 0'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'