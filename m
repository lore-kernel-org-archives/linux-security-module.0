From: mahesh@bandewar.net (Mahesh Bandewar)
Date: Tue,  2 Jan 2018 23:26:42 -0800
Subject: [PATCHv4 0/2] capability controlled user-namespaces
Message-ID: <20180103072642.161742-1-mahesh@bandewar.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

TL;DR version
-------------
Creating a sandbox environment with namespaces is challenging
considering what these sandboxed processes can engage into. e.g.
CVE-2017-6074, CVE-2017-7184, CVE-2017-7308 etc. just to name few.
Current form of user-namespaces, however, if changed a bit can allow
us to create a sandbox environment without locking down user-
namespaces.

Detailed version
----------------

Problem
-------
User-namespaces in the current form have increased the attack surface as
any process can acquire capabilities which are not available to them (by
default) by performing combination of clone()/unshare()/setns() syscalls.

    #define _GNU_SOURCE
    #include <stdio.h>
    #include <sched.h>
    #include <netinet/in.h>

    int main(int ac, char **av)
    {
        int sock = -1;

        printf("Attempting to open RAW socket before unshare()...\n");
        sock = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
        if (sock < 0) {
            perror("socket() SOCK_RAW failed: ");
        } else {
            printf("Successfully opened RAW-Sock before unshare().\n");
            close(sock);
            sock = -1;
        }

        if (unshare(CLONE_NEWUSER | CLONE_NEWNET) < 0) {
            perror("unshare() failed: ");
            return 1;
        }

        printf("Attempting to open RAW socket after unshare()...\n");
        sock = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
        if (sock < 0) {
            perror("socket() SOCK_RAW failed: ");
        } else {
            printf("Successfully opened RAW-Sock after unshare().\n");
            close(sock);
            sock = -1;
        }

        return 0;
    }

The above example shows how easy it is to acquire NET_RAW capabilities
and once acquired, these processes could take benefit of above mentioned
or similar issues discovered/undiscovered with malicious intent. Note
that this is just an example and the problem/solution is not limited
to NET_RAW capability *only*. 

The easiest fix one can apply here is to lock-down user-namespaces which
many of the distros do (i.e. don't allow users to create user namespaces),
but unfortunately that prevents everyone from using them.

Approach
--------
Introduce a notion of 'controlled' user-namespaces. Every process on
the host is allowed to create user-namespaces (governed by the limit
imposed by per-ns sysctl) however, mark user-namespaces created by
sandboxed processes as 'controlled'. Use this 'mark' at the time of
capability check in conjunction with a global capability whitelist.
If the capability is not whitelisted, processes that belong to 
controlled user-namespaces will not be allowed.

Processes that do not have CAP_SYS_ADMIN in init-ns can *only* create
controlled user-namespaces. In other words, user-namespaces created by
privileged processes (those which have CAP_SYS_ADMIN in init-ns) are
not controlled. A hierarchy underneath any controlled user-ns is always
controlled.

A global whitelist is list of capabilities governed by a sysctl
(kernel.controlled_userns_caps_whitelist) which is available to
(privileged) user in init-ns to modify while it's applicable to all
controlled user-namespaces on the host irrespective of when that user-ns
was created.

Marking user-namespaces controlled without modifying the whitelist is
equivalent of the current behavior. The default value of whitelist includes
all capabilities so that the compatibility is maintained. However it gives
admins fine-grained ability to control various capabilities system wide
without locking down user-namespaces.

Example
-------
Here is the example that demonstrates the behavior of a kernel that has
this patch-set applied. It uses the same c-code from this commit-log and
is called acquire_raw.c -

(a) The 'root' user has all the capabilities all the time (before and
    after taking capability).

    root at vm0:~# id
    uid=0(root) gid=0(root) groups=0(root)

    root at vm0:~# sysctl -q kernel.controlled_userns_caps_whitelist 
    kernel.controlled_userns_caps_whitelist = 1f,ffffffff

    root at vm0:~# ./acquire_raw 
    Attempting to open RAW socket before unshare()...
    Successfully opened RAW-Sock before unshare().
    Attempting to open RAW socket after unshare()...
    Successfully opened RAW-Sock after unshare().

    root at vm0:~# sysctl -w kernel.controlled_userns_caps_whitelist=1f,ffffdfff
    kernel.controlled_userns_caps_whitelist = 1f,ffffdfff

    root at vm0:~# ./acquire_raw 
    Attempting to open RAW socket before unshare()...
    Successfully opened RAW-Sock before unshare().
    Attempting to open RAW socket after unshare()...
    Successfully opened RAW-Sock after unshare().

(b) Unprivileged user cannot change the mask.

    mahesh at vm0:~$ id
    uid=1000(mahesh) gid=1000(mahesh)
    groups=1000(mahesh),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),118(lpadmin),128(sambashare)

    mahesh at vm0:~$ sysctl -q kernel.controlled_userns_caps_whitelist 
    kernel.controlled_userns_caps_whitelist = 1f,ffffffff

    mahesh at vm0:~$ sysctl -w kernel.controlled_userns_caps_whitelist=1f,ffffdfff
    sysctl: permission denied on key 'kernel.controlled_userns_caps_whitelist'

(c) Unprivileged user does not have CAP_NET_RAW in init-ns but can get
    that capability inside child-user-ns when the controlled_userns_caps
    mask is unchanged (current behavior).

    mahesh at vm0:~$ sysctl -q kernel.controlled_userns_caps_whitelist 
    kernel.controlled_userns_caps_whitelist = 1f,ffffffff

    mahesh at vm0:~$ ./acquire_raw 
    Attempting to open RAW socket before unshare()...
    socket() SOCK_RAW failed: : Operation not permitted
    Attempting to open RAW socket after unshare()...
    Successfully opened RAW-Sock after unshare().

(d) Changing the controlled_userns_caps_whitelist mask will prevent user
    for acquiring 'controlled capability' inside user-namespace.

    mahesh at vm0:~$ sysctl -q kernel.controlled_userns_caps_whitelist 
    kernel.controlled_userns_caps_whitelist = 1f,ffffdfff
    mahesh at vm0:~$ ./acquire_raw 
    Attempting to open RAW socket before unshare()...
    socket() SOCK_RAW failed: : Operation not permitted
    Attempting to open RAW socket after unshare()...
    socket() SOCK_RAW failed: : Operation not permitted


Please see individual patches in this series.

Mahesh Bandewar (2):
  capability: introduce sysctl for controlled user-ns capability whitelist
  userns: control capabilities of some user namespaces

 Documentation/sysctl/kernel.txt | 21 +++++++++++++++++
 include/linux/capability.h      |  7 ++++++
 include/linux/user_namespace.h  | 25 ++++++++++++++++++++
 kernel/capability.c             | 52 +++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c                 |  5 ++++
 kernel/user_namespace.c         |  4 ++++
 security/commoncap.c            |  8 +++++++
 7 files changed, 122 insertions(+)

-- 
2.15.1.620.gb9897f4670-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
