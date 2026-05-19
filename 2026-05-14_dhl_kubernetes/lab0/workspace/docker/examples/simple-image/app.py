import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello DHL v3 from %s' % os.environ.get('HOSTNAME')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80')

