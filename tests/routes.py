from main import app

def test_root():
    response = app.test_client().get('/')
    assert response.status_code == 200
    assert response.data == b'Hello World!'

def test_version():
    response = app.test_client().get('/version')
    assert response.status_code == 200
    assert response.data == b'1.0'