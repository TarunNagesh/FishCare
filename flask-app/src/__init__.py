# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'FishCare'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to FishCare</h1>"

    # Import the various Beluprint Objects
    from src.employees.employees import Employees
    from src.finances.finances  import Finances
    from src.fish.fish import Fish
    from src.plans.plans  import Plans
    from src.prescriptions.prescriptions import Prescriptions
    from src.procedures.procedures  import Procedures
    from src.reports.reports import Reports
    from src.tanks.Tanks  import Tanks


    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(Employees,   url_prefix='/e')
    app.register_blueprint(Finances,    url_prefix='/fin')
    app.register_blueprint(Fish,   url_prefix='/f')
    app.register_blueprint(Plans,    url_prefix='/pl')
    app.register_blueprint(Prescriptions,   url_prefix='/pe')
    app.register_blueprint(Procedures,    url_prefix='/pr')
    app.register_blueprint(Reports,   url_prefix='/r')
    app.register_blueprint(Tanks,    url_prefix='/ta')

    # Don't forget to return the app object
    return app