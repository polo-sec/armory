import pickle
import base64 

serial = b"gASVDgAAAAAAAACMCnNlYXJjaFRlc3SULg=="
decoded_serial = base64.b64decode(serial)
deserialised = pickle.loads(decoded_serial)
print(deserialised)
