import os

get_token_endpoint = 'http://127.0.0.1:8000/backend/api/auth/token/'

a = os.system("curl --request POST --url http://127.0.0.1:8000/backend/api/auth/token/ --data password=propulsion --data email=nico@email.com")