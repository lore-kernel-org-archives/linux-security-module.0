From: john.johansen@canonical.com (John Johansen)
Date: Sat, 10 Jun 2017 18:26:11 -0700
Subject: [GIT PULL] AppArmor for 4.13
Message-ID: <e90cdd91-1979-bdde-358a-430a89be0d08@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Here is the apparmor pull request for 4.13

It contains
* several bug fixes and cleanups
* the patch to add symlink support to securityfs that was floated on
  the list earlier and the apparmorfs changes that make use of
  securityfs symlinks
* it introduces the domain labeling base code that Ubuntu has been
  carrying for several years, with several cleanups applied. And it
  converts the current mediation over to using the domain labeling
  base, which brings domain stacking support with it. This finally
  will bring the base upstream code in line with Ubuntu and provide a
  base to upstream the new feature work that Ubuntu carries.

This request does not contain any of the newer apparmor mediation
features/controls (mount, signals, network, keys, ...) that Ubuntu is
currently carrying, all of which will be RFC'd on top of this.


The following changes since commit d68c51e0b377838dd31b37707813bb62089f399c:

  Sync to mainline for security submaintainers to work against (2017-05-22 16:32:40 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor for-security

for you to fetch changes up to 33f2eadabba59cf1c763c46c4470279ec2054099:

  apparmor: export that basic profile namespaces are supported (2017-06-10 17:11:48 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      apparmor: Fix error cod in __aa_fs_profile_mkdir()

John Johansen (59):
      apparmor: move file context into file.h
      apparmor: make internal lib fn skipn_spaces available to the rest of apparmor
      apparmor: allow profiles to provide info to disconnected paths
      apparmor: Move path lookup to using preallocated buffers
      securityfs: add the ability to support symlinks
      apparmor: move to per loaddata files, instead of replicating in profiles
      apparmor: use macro template to simplify profile seq_files
      apparmor: use macro template to simplify namespace seq_files
      apparmor: add custom apparmorfs that will be used by policy namespace files
      apparmor: rename apparmor file fns and data to indicate use
      apparmor: allow specifying an already created dir to create ns entries in
      apparmor: convert from securityfs to apparmorfs for policy ns files
      apparmor: move permissions into their own file to be more easily shared
      apparmor: rework perm mapping to a slightly broader set
      apparmor: provide finer control over policy management
      apparmor: add policy revision file interface
      apparmor: add mkdir/rmdir interface to manage policy namespaces
      apparmor: add label data availability to the feature set
      apparmor: speed up transactional queries
      apparmor: add fn to test if profile supports a given mediation class
      apparmor: add gerneric permissions struct and support fns
      apparmor: switch from file_perms to aa_perms
      apparmor: add profile permission query ability
      apparmor: provide information about path buffer size at boot
      apparmor: cleanup __find_child()
      apparmor: add namespace lookup fns()
      apparmor: fix policy load/remove semantics
      apparmor: fix apparmor_query data
      apparmor: fix display of ns name
      apparmor: move bprm_committing_creds/committed_creds to lsm.c
      apparmor: convert to profile block critical sections
      apparmor: share profile name on replacement
      apparmor: refactor updating profiles to the newest parent
      apparmor: cleanup remove unused and not fully implemented profile rename
      apparmor: convert aa_change_XXX bool parameters to flags
      apparmor: cleanup rename XXX_file_context() to XXX_file_ctx()
      apparmor: revalidate files during exec
      apparmor: add the base fns() for domain labels
      apparmor: switch from profiles to using labels on contexts
      apparmor: switch getprocattr to using label_print fns()
      apparmor: update query interface to support label queries
      apparmor: move capability checks to using labels
      apparmor: move resource checks to using labels
      apparmor: add cross check permission helper macros
      apparmor: move ptrace checks to using labels
      apparmor: allow ptrace checks to be finer grained than just capability
      apparmor: move aa_file_perm() to use labels
      apparmor: update aa_audit_file() to use labels
      apparmor: refactor path name lookup and permission checks around labels
      apparmor: move path_link mediation to using labels
      apparmor: rework file permission to cache file access in file->ctx
      apparmor: mediate files when they are received
      apparmor: support v7 transition format compatible with label_parse
      apparmor: move exec domain mediation to using labels
      apparmor: move change_hat mediation to using labels
      apparmor: move change_profile mediation to using labels
      apparmor: add domain label stacking info to apparmorfs
      apparmor: add stacked domain labels interface
      apparmor: export that basic profile namespaces are supported

Markus Elfring (2):
      apparmorfs: Combine two function calls into one in aa_fs_seq_raw_abi_show()
      apparmorfs: Use seq_putc() in two functions

Thomas Schneider (1):
      security/apparmor: Use POSIX-compatible "printf '%s'"

 include/linux/security.h                  |   12 +
 include/uapi/linux/magic.h                |    2 +
 security/apparmor/Makefile                |    8 +-
 security/apparmor/apparmorfs.c            | 1676 ++++++++++++++++++-----
 security/apparmor/audit.c                 |   27 +-
 security/apparmor/capability.c            |   61 +-
 security/apparmor/context.c               |   87 +-
 security/apparmor/domain.c                | 1393 ++++++++++++-------
 security/apparmor/file.c                  |  517 +++++--
 security/apparmor/include/apparmor.h      |    6 +-
 security/apparmor/include/apparmorfs.h    |   67 +-
 security/apparmor/include/audit.h         |   17 +-
 security/apparmor/include/capability.h    |    8 +-
 security/apparmor/include/context.h       |  201 +--
 security/apparmor/include/domain.h        |   13 +-
 security/apparmor/include/file.h          |  114 +-
 security/apparmor/include/ipc.h           |   16 +-
 security/apparmor/include/label.h         |  441 ++++++
 security/apparmor/include/lib.h           |  120 +-
 security/apparmor/include/path.h          |    7 +-
 security/apparmor/include/perms.h         |  155 +++
 security/apparmor/include/policy.h        |  131 +-
 security/apparmor/include/policy_ns.h     |   21 +
 security/apparmor/include/policy_unpack.h |   68 +-
 security/apparmor/include/procattr.h      |    8 +-
 security/apparmor/include/resource.h      |    6 +-
 security/apparmor/ipc.c                   |  140 +-
 security/apparmor/label.c                 | 2120 +++++++++++++++++++++++++++++
 security/apparmor/lib.c                   |  368 ++++-
 security/apparmor/lsm.c                   |  245 ++--
 security/apparmor/path.c                  |  130 +-
 security/apparmor/policy.c                |  392 +++---
 security/apparmor/policy_ns.c             |   80 +-
 security/apparmor/policy_unpack.c         |   96 +-
 security/apparmor/procattr.c              |   71 +-
 security/apparmor/resource.c              |  116 +-
 security/inode.c                          |  144 +-
 37 files changed, 7275 insertions(+), 1809 deletions(-)
 create mode 100644 security/apparmor/include/label.h
 create mode 100644 security/apparmor/include/perms.h
 create mode 100644 security/apparmor/label.c


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
