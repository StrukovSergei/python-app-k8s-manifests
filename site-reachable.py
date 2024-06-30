import unittest
import requests

class TestWebsiteAvailability(unittest.TestCase):
    """
        This method sends a GET request to the specified URL and asserts
        that the response status code is 200, indicating that the website
        is reachable.
    """
    def test_website_reachable(self):
        url = 'http://localhost:5000'  
        response = requests.get(url)
        self.assertEqual(response.status_code, 200, f"Website {url} is unreachable.")

if __name__ == '__main__':
    unittest.main()