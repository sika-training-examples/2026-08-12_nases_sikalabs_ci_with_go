import os
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(os.environ.get('REDIS', "127.0.0.1"))
suffix = os.environ.get('SUFFIX', "")
hostname = os.environ['HOSTNAME']

@app.route('/')
def index():
    counter = redis.incr('counter')
    return '<center><h1>%s %s! %d</h1></center>\n' % (hostname, suffix, counter)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80')
