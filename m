From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 29 Aug 2017 13:52:22 -0700
Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
Message-ID: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules

I am again sending this as an RFC. There are significant differences
from the previous versions. These are in response to feedback on
the mechanisms for dealing with security contexts outside of the
security modules, including user space code.

This patch set implements stacking for "major" security modules
that use cred and file blobs. Management of security blobs is
moved from the security modules and into the LSM infrastructure.
This has been proposed in the past by Serge Hallyn and David Howells.
This implementation owes much to their work.

The bulk of the change is in abstracting use of blobs within the
security modules. This allows the modules to share a single blob
and hides the details from the code. Modules are required to
declare the amount of space they require for each blob they use.
Because modules deal with blobs during their initialization the
blob sizes must be declared prior to module initialization.
The module initialization becomes a two step process.

Security module stacking is optional. If stacking is not configured,
the CONFIG_DEFAULT_SECURITY value is used, just as before. If stacking
is configured using CONFIG_SECURITY_STACKING the modules desired for
the stack are selected individually. AppArmor would be selected by
specifying CONFIG_SECURITY_APPARMOR_STACKED. The CONFIG_DEFAULT_SECURITY
is ignored. The security= boot option is still respected and has the
same behavior as before, allowing a single module to be used instead of
the specified stack.

A prctl() interface is provided to direct the LSM interface as to
which module's information should be reported to user space. If
not specified, the first registered module will be presented.

Some filesystems, including kernfs, use security context strings
to represent the security attributes on a file. To accommodate
multiple active modules a security "context" is defined to use
a regular format:

	lsmname='lsmvalue'[,lsmname='lsmvalue']...

This is not exposed to user space run time code except in the
/proc/.../attr/context interface.

I have tested these patches in various configurations of Ubuntu and
Fedora. Smack and SELinux together pass test suites with some exceptions.
Smack does not (yet) deal with overlayfs, so those tests are omitted.
There are conflicts with the way the modules treat network configurations.
These conflicts are under investigation, and changes to Smack (and
possibly SELinux) to reconcile the worst of the issues are in development.

Patch 01 Adds a smack subdirectory in /proc/.../attr
Patch 02 Move management of the cred blob to the LSM infrastructure.
Patch 03 Move management of the file blob to the LSM infrastructure.
Patch 04 Move management of the task blob to the LSM infrastructure.
Patch 05 Infrastructure blob management for IPC, keys, sockets.
Patch 06 Allow stacking of modules except for SELinux and Smack
Patch 07 Mapping from module secids to system secids (tokens)
Patch 08 Fix superblock blobs in Smack.
Patch 09 Mount options for multiple modules.
Patch 10 Allocate task blobs.
Patch 11 Allow stacking of all modules.

These patches can be found in git at:

	https://github.com/cschaufler/smack-next.git#stacking-4.13-rc2

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---

 Documentation/admin-guide/LSM/index.rst |   31 +-
 fs/btrfs/super.c                        |   10 +-
 fs/proc/base.c                          |   96 ++-
 fs/proc/internal.h                      |    1 +
 fs/xattr.c                              |    6 +-
 include/linux/lsm_audit.h               |    4 +
 include/linux/lsm_hooks.h               |   86 +-
 include/linux/security.h                |   69 +-
 include/net/request_sock.h              |    2 +
 include/uapi/linux/prctl.h              |    6 +
 kernel/cred.c                           |   13 -
 kernel/fork.c                           |    3 +
 net/netlabel/netlabel_unlabeled.c       |    2 +-
 security/Kconfig                        |   90 +++
 security/Makefile                       |    1 +
 security/apparmor/context.c             |    2 -
 security/apparmor/include/context.h     |   24 +-
 security/apparmor/include/file.h        |    2 +-
 security/apparmor/lsm.c                 |  105 ++-
 security/security.c                     | 1332 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c                |  651 ++++++---------
 security/selinux/include/objsec.h       |  100 ++-
 security/selinux/include/security.h     |    3 +-
 security/selinux/include/xfrm.h         |    2 +-
 security/selinux/netlabel.c             |   20 +-
 security/selinux/selinuxfs.c            |    5 +-
 security/selinux/ss/services.c          |    7 +-
 security/selinux/xfrm.c                 |   10 +-
 security/smack/smack.h                  |  101 ++-
 security/smack/smack_access.c           |    2 +-
 security/smack/smack_lsm.c              |  655 ++++++---------
 security/smack/smack_netfilter.c        |   12 +-
 security/smack/smackfs.c                |   21 +-
 security/stacking.c                     |  198 +++++
 security/tomoyo/common.h                |   30 +-
 security/tomoyo/domain.c                |    4 +-
 security/tomoyo/securityfs_if.c         |   13 +-
 security/tomoyo/tomoyo.c                |   52 +-
 38 files changed, 2739 insertions(+), 1032 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
