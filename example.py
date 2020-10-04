import piplates.RELAYplate as RELAY
import math

a = [8, 9, 12, 13]

for i in a:
    ti = int(i)
    taddress = math.floor(ti/7)+1
    trelay = ti%7 
    RELAY.relayON(taddress, trelay)