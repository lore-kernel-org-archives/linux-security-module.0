From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 27 Oct 2017 14:34:42 -0700
Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on
	4.14-rc2
Message-ID: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on 4.14-rc2

This patch set implements stacking for "major" security modules.
A major security module is any that uses security blobs.
Management of security blobs is moved from the security modules
and into the LSM infrastructure. This has been proposed in the
past by Serge Hallyn and David Howells. This implementation owes
much to their work.

The use of secids has been changed. Within a security module the
meaning is the same as before. At the security module interface
the module specific values are mapped into a "token", which is used
outside the modules. The "tokens" are translated into individual
secids for consumption by the security modules as required. The
mechanism for mapping (in security/stacking.c) provided has known
issues (To quote Stephen. "-ENOLOCKING") and any and all suggestions
on how to do it correctly are solicited.

Subdirectories in /proc/.../attr for each security module that uses
the /proc/.../attr interface are provided. This will allow user-space
to disambiguate the data coming from "current". Previous versions of
this work included a "context" entry, but feedback on that interface
is that it is unnecessary.

A new sockopt, SO_LSMSEC, is introduced to allow an application to
specify which security module data will be presented by SO_PEERSEC.

Some filesystems, including kernfs, use security context strings
to represent the security attributes on a file. To accommodate
multiple active modules a security "context" is defined to use
a regular format:

	lsmname='lsmvalue'[,lsmname='lsmvalue']...

This format is not exposed outside the kernel.

I have tested these patches in various configurations of Ubuntu and
Fedora. Smack and SELinux together pass test suites with some exceptions.
There are conflicts with the way the modules treat network configurations.
These conflicts are under investigation, and changes to Smack (and
possibly SELinux) to reconcile the worst of the issues are in development.

An earlier version of parts of this set are being used in Ubuntu 17.10.
Changes made there have not been incorporated here. That's a timing
issue, not a judgement on those updates.

This series can be found at:

	git://github.com/cschaufler/smack-next#stacking-4.14-rc2

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |   23 +-
 arch/alpha/include/uapi/asm/socket.h    |    2 +
 arch/frv/include/uapi/asm/socket.h      |    2 +
 arch/ia64/include/uapi/asm/socket.h     |    2 +
 arch/m32r/include/uapi/asm/socket.h     |    2 +
 arch/mips/include/uapi/asm/socket.h     |    2 +
 arch/mn10300/include/uapi/asm/socket.h  |    2 +
 arch/parisc/include/uapi/asm/socket.h   |    2 +
 arch/s390/include/uapi/asm/socket.h     |    2 +
 arch/sparc/include/uapi/asm/socket.h    |    2 +
 arch/xtensa/include/uapi/asm/socket.h   |    2 +
 fs/btrfs/super.c                        |   10 +-
 fs/proc/base.c                          |   92 ++-
 fs/proc/internal.h                      |    1 +
 fs/xattr.c                              |    2 +-
 include/linux/lsm_hooks.h               |   69 +-
 include/linux/security.h                |  103 ++-
 include/net/request_sock.h              |    2 +
 include/net/scm.h                       |    3 +-
 include/uapi/asm-generic/socket.h       |    2 +
 kernel/audit.c                          |   16 +-
 kernel/auditsc.c                        |    4 +-
 kernel/cred.c                           |   15 +-
 net/core/sock.c                         |    4 +
 net/ipv4/ip_sockglue.c                  |    8 +-
 net/netfilter/nf_conntrack_netlink.c    |    9 +-
 net/netfilter/nf_conntrack_standalone.c |    2 +-
 net/netfilter/nfnetlink_queue.c         |    3 +-
 net/netfilter/xt_SECMARK.c              |    2 +-
 net/netlabel/netlabel_unlabeled.c       |   12 +-
 net/netlabel/netlabel_user.c            |    2 +-
 security/Kconfig                        |   67 ++
 security/Makefile                       |    1 +
 security/apparmor/context.c             |    2 -
 security/apparmor/include/context.h     |   24 +-
 security/apparmor/include/file.h        |    2 +-
 security/apparmor/include/net.h         |    6 +
 security/apparmor/lsm.c                 |   91 +--
 security/security.c                     | 1136 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c                |  615 +++++++----------
 security/selinux/include/objsec.h       |   87 ++-
 security/selinux/include/xfrm.h         |    2 +-
 security/selinux/netlabel.c             |   15 +-
 security/selinux/selinuxfs.c            |    5 +-
 security/selinux/ss/services.c          |    3 +-
 security/selinux/xfrm.c                 |   10 +-
 security/smack/smack.h                  |  101 ++-
 security/smack/smack_access.c           |    2 +-
 security/smack/smack_lsm.c              |  608 ++++++-----------
 security/smack/smack_netfilter.c        |   14 +-
 security/smack/smackfs.c                |   18 +-
 security/stacking.c                     |  188 +++++
 security/tomoyo/common.h                |   30 +-
 security/tomoyo/domain.c                |    4 +-
 security/tomoyo/securityfs_if.c         |   13 +-
 security/tomoyo/tomoyo.c                |   52 +-
 56 files changed, 2475 insertions(+), 1025 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
