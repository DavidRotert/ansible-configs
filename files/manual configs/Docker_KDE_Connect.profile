[fwBasic]
status = enabled
incoming = deny
outgoing = allow
routed = disabled

[Rule0]
ufw_rule = 1714:1764/tcp ALLOW IN Anywhere
description = KDE Connect
command = /usr/sbin/ufw allow in proto tcp from any to any port 1714:1764
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 1714:1764/tcp
iface = 
routed = 
logging = 

[Rule1]
ufw_rule = 1714:1764/udp ALLOW IN Anywhere
description = KDE Connect
command = /usr/sbin/ufw allow in proto udp from any to any port 1714:1764
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 1714:1764/udp
iface = 
routed = 
logging = 

[Rule2]
ufw_rule = 172.17.0.1 ALLOW IN 192.168.0.0/16
description = Docker
command = /usr/sbin/ufw allow in from 192.168.0.0/16 to 172.17.0.1
policy = allow
direction = in
protocol = 
from_ip = 192.168.0.0/16
from_port = 
to_ip = 172.17.0.1
to_port = 
iface = 
routed = 
logging = 

[Rule3]
ufw_rule = 172.17.0.1 ALLOW IN 172.0.0.0/8 (log-all)
description = Docker
command = /usr/sbin/ufw allow in log-all from 172.0.0.0/8 to 172.17.0.1
policy = allow
direction = in
protocol = 
from_ip = 172.0.0.0/8
from_port = 
to_ip = 172.17.0.1
to_port = 
iface = 
routed = 
logging = log-all

[Rule4]
ufw_rule = 1714:1764/tcp (v6) ALLOW IN Anywhere (v6)
description = KDE Connect
command = /usr/sbin/ufw allow in proto tcp from any to any port 1714:1764
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 1714:1764/tcp
iface = 
routed = 
logging = 

[Rule5]
ufw_rule = 1714:1764/udp (v6) ALLOW IN Anywhere (v6)
description = KDE Connect
command = /usr/sbin/ufw allow in proto udp from any to any port 1714:1764
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 1714:1764/udp
iface = 
routed = 
logging = 

