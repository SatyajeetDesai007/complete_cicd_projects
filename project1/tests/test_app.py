import sys
import os
import pytest

# Add the root directory (project1) to the sys.path so that we can import 'app' from app.py
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../')))

from app import app  # Now we can import the app from app.py

@pytest.fixture
def client():
    """Create a test client for the Flask app."""
    with app.test_client() as client:
        yield client  # This makes sure the test client is provided for each test

def test_home_route(client):
    """Test the / route."""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, World!" in response.data