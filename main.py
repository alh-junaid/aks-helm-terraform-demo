from flask import Flask
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)

class HelloWorld(Resource):
    def get(self):
        return {"data": "Hello World"}

class HealthCheck(Resource):
    def get(self):
        return {"status": "healthy"}, 200

api.add_resource(HelloWorld, '/hello')
api.add_resource(HealthCheck, '/health')

if __name__ == '__main__':
    app.run(debug=True)
