from pynput import mouse
import time

event_list = []
t_end = time.time() + 10

with mouse.Events() as events:
    for event in events:
        if time.time() > t_end:
            break
        else:
            event_list.append([event, time.ctime()])
