import flask
from flask import request, jsonify
import pyautogui
import coordinate as coord
import socket

def get_ip ():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    d = (s.getsockname()[0]).split(".")[-1]
    s.close()
    return d

def skip_ad ():
    print ("premo")
    pyautogui.click(*coord.ad)


app = flask.Flask(__name__)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    return '''
        <h1>
            Pagina ad-skipper
        </h1>
    '''


# A route to return all of the available entries in our catalog.
@app.route('/isAlive', methods=['GET'])
def si_alive():
    return jsonify({"alive":True})

@app.route('/skipAd', methods=['POST'])
def skipAd():
    print ("richiesta ricevuta")
    skip_ad()
    return jsonify({"alive":True})



print (get_ip())
app.run(host= '0.0.0.0')