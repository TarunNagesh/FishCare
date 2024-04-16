from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Fish = Blueprint('Fish', __name__)

@Fish.route('/Fish', methods=['GET'])
def get_fish():
    """ get all fish """ 
    # construct the query 
    query = 'SELECT * from Fish' 
    current_app.logger.info(query)


    # execute the query 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Fish.route('/Fish/<id>', methods=['GET'])
def get_fish_detail(id):
    """ gets a specific fish """
# create the query
    query = 'select * from Fish where fishid =' + str(id)
    current_app.logger.info(query)

# execute the id 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Fish.route('/Fish', methods=['POST'])
def add_new_fish():
    """ adds a new fish to the table """
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    fishID = the_data['FishID']
    housed= the_data['housedin']
    kept = the_data['keptby']
    notes = the_data['notes'] 
    sex = the_data['sex']
    species = the_data['species']
    status = the_data['status']

    # Constructing the query
    query = 'insert into Fish values ("'
    query += fishID + '", "'
    query += housed + '", "'
    query += kept + '", '
    query += notes + '", '
    query += sex + '", '
    query += species + '", '
    query += status + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@Fish.route('/Fish/<id>', methods =['PUT']) 
def update_fish(id): 
    """ updates fish details """
    # collecting data 
    the_data = request.json 

    # extracting the information
    id = the_data['fishid']
    housed= the_data['housedin']
    kept = the_data['keptby']
    notes = the_data['notes'] 
    sex = the_data['sex']
    species = the_data['species']
    status = the_data['status']
    
    # make query and execute 
    query = 'update Fish set fishid = %s, housedin = %s, keptby = %s, notes = %s, sex = %s, species = %s, status = %s where fishid = %s'
    data = (id, housed, kept, notes, sex, species, status)

    cursor = db.get_db().cursor() 
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Success!'

@Fish.route('/Fish/<id>', methods =['DELETE']) 
def delete_fish(id): 
    """ delete from a fish with a specific ID """
    the_data = request.json 
    
    current_app.logger.info(the_data)
    id = the_data['fishid']

    query = 'delete from Fish where fishid =' + str(id)

    current_app.logger.info(query) 
   
    # execute and commit query 
    cursor = db.get_db().cursor() 
    cursor.execute(query)
    db.get_db().commit()
    return 'Bye Fish!'

@Fish.route('/Fish', methods =['DELETE']) 
def delete_allfish(): 
    """delete all fish where they are dead"""
    the_data = request.json 

    current_app.logger.info(the_data) 
    

    query = 'delete from Fish where status = "dead"'

    current_app.logger.info(query) 

    # execute and commit the query
    cursor = db.get_db.cursor()
    cursor.execute(query) 
    db.get_db().commit() 
    return 'all dead fish deleted!'

@Fish.route('/Fish/<housedin>', methods=['GET'])
def get_fish_from_tank(housedin):
    """ selects all fish from a given tank """
    # create the query
    query = 'select * from Fish where HousedIn =' + str(housedin)
    current_app.logger.info(query)

    # execute the id 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)