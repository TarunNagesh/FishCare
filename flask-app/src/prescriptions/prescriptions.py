from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

prescriptions = Blueprint('prescriptions', __name__)

@Prescriptions.route('/Prescriptions', methods=['GET'])
def get_prescriptions():
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

@Prescriptions.route('/Prescriptions/<id>', methods=['GET'])
def get_prescriptions_detail (id):
    """ Get details of a specific prescriptions """
    query = 'SELECT * FROM Prescriptions WHERE MedID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Prescriptions.route('/Prescriptions', methods=['POST'])
def add_new_prescriptions():
    """ Add a new prescription """
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    procedure_for = the_data['ProcFor']
    id = the_data['MedID']
    med = the_data['Medicine']
    dosage = the_data['Dosage']

    # Constructing the query
    query = 'INSERT INTO Prescriptions (ProcFor, MedID, Medicine, Dosage) VALUES ("'
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

@Prescriptions.route('/Prescriptions', methods=['PUT'])
def update_prescriptions():
    """ Update the details of a prescriptions """
    pres_info = request.json
    # current_app.logger.info(cust_info)
    procedure_for = pres_info['ProcFor']
    id = pres_info['MedID']
    med = pres_info['Medicine']
    dosage = pres_info['Dosage']

    query = 'UPDATE Prescriptions SET ProcFor = %s, Medicine = %s, Dosage = %s, WHERE MedID = %s'
    data = (procedure_for, med, dosage, id)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Prescription updated!'

@Prescriptions.route('/Prescriptions', methods = ['DELETE'])
def delete_prescription():
    """ Delete a prescription """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['MedID']

    query = 'DELETE FROM Prescriptions WHERE MedID = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'

@Prescriptions.route('/Prescriptions_no_dosage', methods = ['DELETE'])
def delete_empty_prescriptions():
    """ Delete prescriptions where dosage = 0 """ 
    the_data = request.json
    current_app.logger.info(the_data) 

    query = 'DELETE FROM Prescriptions WHERE Dosage = 0'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Prescription deleted!'