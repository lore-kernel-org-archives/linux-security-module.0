From: ztong@vt.edu (Tong Zhang)
Date: Tue, 25 Sep 2018 13:27:00 -0400
Subject: Leaking path or inconsistency LSM checking observed in fs/net
Message-ID: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

We found several leaking path or inconsistency LSM design issue in fs/net.

Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
So, we think that those net/socket related stuff should all go through LSM check and being audited 
even it is not a user thread or process.


Here?s an example where we have a check: 
in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
where a LSM check security_socket_create is called(net/socket.c:1242)


And where we don?t have a check

fs/ocfs2/cluster/tcp.c:2052 bind
fs/ocfs2/cluster/tcp.c:2059 listen

fs/dlm/lowcomms.c:1264 bind
fs/dlm/lowcomms.c:1278 listen
fs/dlm/lowcomms.c:1354 listen

several places that use kernel_bind/kernel_listen/kernel_connect

net/socket.c:3231 kernel_bind
net/socket.c:3237 kernel_listen
net/socket.c:3286 kernel_connect


- Tong
