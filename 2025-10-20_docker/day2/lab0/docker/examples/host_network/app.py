import os
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(os.environ.get('REDIS', "127.0.0.1"))
hostname = os.environ['HOSTNAME']

@app.route('/')
def index():
    counter = redis.incr('counter')
    return '<h1>%s %d</h1>\n' % (hostname, counter)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80')
