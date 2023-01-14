import requests

SERVER_URL = 'http://0.0.0.0:8000'

def test_normal_plus():
    res = requests.get(SERVER_URL + '/plus?x=1&y=1')
    assert res.status_code == 200
    assert res.json() == {'total': 2}
