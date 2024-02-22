import time

i = 0
while True:
    with open("/dev/stdout", "a") as f:
        f.write("hello_world_%i\n" % i)
    time.sleep(1)
    i+=1