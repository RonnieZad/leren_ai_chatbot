import requests

def Weather():
    api_address='http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&q=Kikoni'
    
    json_data = requests.get(api_address).json()
    format_add = json_data['main']
    print(json_data)
    say = "The current weather condition at Kikoni is {0}, minimum temperature is {1}° Celcius and maximum is {2}° Celcius".format(
        json_data['weather'][0]['main'],int(format_add['temp_min']-273),int(format_add['temp_max']-272))
    
    print(say)

    return say
