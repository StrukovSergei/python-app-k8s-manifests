import requests

def get_weather(location):
    """
    Retrieve weather data for a specific location using the Visual Crossing Weather API.
    """
    
    API_KEY = 'AP3HDJLZV4BMQ8CGETTAPVC9T'
    base_url = f"https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/{location}?key={API_KEY}&lang=en"

    response = requests.get(base_url)
    if response.status_code != 200:
        return False
    else:
        return response.json()

