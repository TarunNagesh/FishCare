from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


finances = Blueprint('finances', __name__)

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