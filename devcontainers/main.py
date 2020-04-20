from flask import Flask
from faker import Faker

app = Flask(__name__)
fake = Faker()

@app.route('/')
def hello_world():
    return 'Hello, ' + fake.name()
