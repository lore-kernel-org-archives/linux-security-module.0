From: jmorris@namei.org (James Morris)
Date: Mon, 4 Sep 2017 20:29:54 +1000 (AEST)
Subject: [GIT PULL] Security subsystem updates for 4.14
Message-ID: <alpine.LRH.2.21.1709041959220.27950@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Here are the security subsystem updates for 4.14.  Highlights:

AppArmor:
  - Add mediation of mountpoints and signals
  - Add support for absolute root view based labels
  - add base infastructure for socket mediation

LSM:
  - Remove unused security_task_create() hook

TPM: 
  - Some constification and minor updates.

IMA: 
  - A new integrity_read file operation method, avoids races when 
    calculating file hashes

SELinux:
  - from Paul Moore:
  "A relatively quiet period for SELinux, 11 patches with only two/three
   having any substantive changes.  These noteworthy changes include 
   another tweak to the NNP/nosuid handling, per-file labeling for 
   cgroups, and an object class fix for AF_UNIX/SOCK_RAW sockets; the rest 
   of the changes are minor tweaks or administrative updates (Stephen's 
   email update explains the file explosion in the diffstat)."

Seccomp:
  - from Kees Cook:
  "Major additions:
   - sysctl and seccomp operation to discover available actions. (tyhicks) 
   - new per-filter configurable logging infrastructure and sysctl. (tyhicks) 
   - SECCOMP_RET_LOG to log allowed syscalls. (tyhicks) 
   - SECCOMP_RET_KILL_PROCESS as the new strictest possible action. 
   - self-tests for new behaviors."


And nothing for Smack, for the first time perhaps.


Please pull.

---

The following changes since commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432:

  Merge branch 'docs-next' of git://git.lwn.net/linux (2017-09-03 21:07:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

Antonio Murdaca (1):
      selinux: allow per-file labeling for cgroupfs

Arvind Yadav (3):
      tpm: tpm_crb: constify acpi_device_id.
      tpm: vtpm: constify vio_device_id
      selinux: constify nf_hook_ops

Christoph Hellwig (1):
      ima: use fs method to read integrity data

Christos Gkekas (1):
      apparmor: Fix logical error in verify_header()

Dan Carpenter (1):
      apparmor: Fix an error code in aafs_create()

Enric Balletbo i Serra (1):
      Documentation: tpm: add powered-while-suspended binding documentation

Geert Uytterhoeven (1):
      apparmor: Fix shadowed local variable in unpack_trans_table()

Hamza Attak (1):
      tpm: replace msleep() with  usleep_range() in TPM 1.2/2.0 generic drivers

James Morris (3):
      sync to Linus v4.13-rc2 for subsystem developers to work against
      Merge tag 'seccomp-next' of git://git.kernel.org/.../kees/linux into next
      Merge tag 'selinux-pr-20170831' of git://git.kernel.org/.../pcmoore/selinux into next

John Johansen (13):
      apparmor: Redundant condition: prev_ns. in [label.c:1498]
      apparmor: add the ability to mediate signals
      apparmor: add mount mediation
      apparmor: cleanup conditional check for label in label_print
      apparmor: add support for absolute root view based labels
      apparmor: make policy_unpack able to audit different info messages
      apparmor: add more debug asserts to apparmorfs
      apparmor: add base infastructure for socket mediation
      apparmor: move new_null_profile to after profile lookup fns()
      apparmor: fix race condition in null profile creation
      apparmor: ensure unconfined profiles have dfas initialized
      apparmor: fix incorrect type assignment when freeing proxies
      apparmor: fix build failure on sparc caused by undeclared, signals

Kees Cook (9):
      selftests/seccomp: Add tests for basic ptrace actions
      selftests/seccomp: Add simple seccomp overhead benchmark
      selftests/seccomp: Refactor RET_ERRNO tests
      seccomp: Provide matching filter for introspection
      seccomp: Rename SECCOMP_RET_KILL to SECCOMP_RET_KILL_THREAD
      seccomp: Introduce SECCOMP_RET_KILL_PROCESS
      seccomp: Implement SECCOMP_RET_KILL_PROCESS action
      selftests/seccomp: Test thread vs process killing
      samples: Unrename SECCOMP_RET_KILL

Luis Ressel (1):
      selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets

Michal Hocko (1):
      selinux: use GFP_NOWAIT in the AVC kmem_caches

Michal Suchanek (1):
      tpm: ibmvtpm: simplify crq initialization and document crq format

Mimi Zohar (6):
      ima: don't remove the securityfs policy file
      libfs: define simple_read_iter_from_buffer
      efivarfs: replaces the read file operation with read_iter
      ima: always measure and audit files in policy
      ima: define "dont_failsafe" policy action rule
      ima: define "fs_unsafe" builtin policy

Paul Moore (4):
      credits: update Paul Moore's info
      selinux: update the selinux info in MAINTAINERS
      MAINTAINERS: update the NetLabel and Labeled Networking information
      MAINTAINERS: update the NetLabel and Labeled Networking information

Stefan Berger (1):
      security: fix description of values returned by cap_inode_need_killpriv

Stephen Smalley (4):
      selinux: genheaders should fail if too many permissions are defined
      selinux: Generalize support for NNP/nosuid SELinux domain transitions
      selinux: update my email address
      lsm_audit: update my email address

Tetsuo Handa (2):
      LSM: Remove security_task_create() hook.
      tomoyo: Update URLs in Documentation/admin-guide/LSM/tomoyo.rst

Tyler Hicks (6):
      seccomp: Sysctl to display available actions
      seccomp: Operation for checking if an action is available
      seccomp: Sysctl to configure actions that are allowed to be logged
      seccomp: Selftest for detection of filter flag support
      seccomp: Filter flag to log all actions except SECCOMP_RET_ALLOW
      seccomp: Action to log before allowing

 CREDITS                                            |    8 +-
 Documentation/ABI/testing/ima_policy               |    3 +-
 Documentation/admin-guide/LSM/tomoyo.rst           |   24 +-
 Documentation/admin-guide/kernel-parameters.txt    |    8 +-
 .../devicetree/bindings/security/tpm/tpm-i2c.txt   |    6 +
 Documentation/networking/filter.txt                |    2 +-
 Documentation/sysctl/kernel.txt                    |    1 +
 Documentation/userspace-api/seccomp_filter.rst     |   52 ++-
 MAINTAINERS                                        |   29 +-
 drivers/char/tpm/tpm-interface.c                   |   10 +-
 drivers/char/tpm/tpm.h                             |    9 +-
 drivers/char/tpm/tpm2-cmd.c                        |    2 +-
 drivers/char/tpm/tpm_crb.c                         |    2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   98 ++-
 drivers/char/tpm/tpm_infineon.c                    |    6 +-
 drivers/char/tpm/tpm_tis_core.c                    |    8 +-
 fs/btrfs/file.c                                    |    1 +
 fs/efivarfs/file.c                                 |   12 +-
 fs/ext2/file.c                                     |   17 +
 fs/ext4/file.c                                     |   20 +
 fs/f2fs/file.c                                     |    1 +
 fs/jffs2/file.c                                    |    1 +
 fs/jfs/file.c                                      |    1 +
 fs/libfs.c                                         |   32 +
 fs/nilfs2/file.c                                   |    1 +
 fs/ramfs/file-mmu.c                                |    1 +
 fs/ramfs/file-nommu.c                              |    1 +
 fs/ubifs/file.c                                    |    1 +
 fs/xfs/xfs_file.c                                  |   21 +
 include/linux/audit.h                              |    6 +-
 include/linux/fs.h                                 |    3 +
 include/linux/lsm_audit.h                          |    2 +-
 include/linux/lsm_hooks.h                          |    7 -
 include/linux/seccomp.h                            |    3 +-
 include/linux/security.h                           |    6 -
 include/uapi/linux/seccomp.h                       |   23 +-
 kernel/fork.c                                      |    4 -
 kernel/seccomp.c                                   |  321 +++++++++-
 mm/shmem.c                                         |    1 +
 scripts/selinux/genheaders/genheaders.c            |    7 +-
 security/apparmor/.gitignore                       |    1 +
 security/apparmor/Makefile                         |   43 ++-
 security/apparmor/apparmorfs.c                     |   37 +-
 security/apparmor/domain.c                         |    4 +-
 security/apparmor/file.c                           |   30 +
 security/apparmor/include/apparmor.h               |    2 +
 security/apparmor/include/audit.h                  |   39 +-
 security/apparmor/include/domain.h                 |    5 +
 security/apparmor/include/ipc.h                    |    6 +
 security/apparmor/include/label.h                  |    1 +
 security/apparmor/include/mount.h                  |   54 ++
 security/apparmor/include/net.h                    |  114 ++++
 security/apparmor/include/perms.h                  |    5 +-
 security/apparmor/include/policy.h                 |   13 +
 security/apparmor/include/sig_names.h              |   98 +++
 security/apparmor/ipc.c                            |   99 +++
 security/apparmor/label.c                          |   36 +-
 security/apparmor/lib.c                            |    5 +-
 security/apparmor/lsm.c                            |  472 +++++++++++++
 security/apparmor/mount.c                          |  696 ++++++++++++++++++++
 security/apparmor/net.c                            |  184 ++++++
 security/apparmor/policy.c                         |  166 +++---
 security/apparmor/policy_ns.c                      |    2 +
 security/apparmor/policy_unpack.c                  |  105 +++-
 security/commoncap.c                               |    6 +-
 security/integrity/iint.c                          |   20 +-
 security/integrity/ima/ima.h                       |    1 +
 security/integrity/ima/ima_api.c                   |   67 ++-
 security/integrity/ima/ima_crypto.c                |   10 +
 security/integrity/ima/ima_fs.c                    |    4 +-
 security/integrity/ima/ima_main.c                  |   19 +-
 security/integrity/ima/ima_policy.c                |   41 ++-
 security/lsm_audit.c                               |    2 +-
 security/security.c                                |    5 -
 security/selinux/avc.c                             |   16 +-
 security/selinux/hooks.c                           |   56 ++-
 security/selinux/include/avc.h                     |    2 +-
 security/selinux/include/avc_ss.h                  |    2 +-
 security/selinux/include/classmap.h                |    2 +
 security/selinux/include/objsec.h                  |    2 +-
 security/selinux/include/security.h                |    4 +-
 security/selinux/ss/avtab.c                        |    2 +-
 security/selinux/ss/avtab.h                        |    2 +-
 security/selinux/ss/constraint.h                   |    2 +-
 security/selinux/ss/context.h                      |    2 +-
 security/selinux/ss/ebitmap.c                      |    2 +-
 security/selinux/ss/ebitmap.h                      |    2 +-
 security/selinux/ss/hashtab.c                      |    2 +-
 security/selinux/ss/hashtab.h                      |    2 +-
 security/selinux/ss/mls.c                          |    2 +-
 security/selinux/ss/mls.h                          |    2 +-
 security/selinux/ss/mls_types.h                    |    2 +-
 security/selinux/ss/policydb.c                     |    2 +-
 security/selinux/ss/policydb.h                     |    2 +-
 security/selinux/ss/services.c                     |    9 +-
 security/selinux/ss/services.h                     |    2 +-
 security/selinux/ss/sidtab.c                       |    2 +-
 security/selinux/ss/sidtab.h                       |    2 +-
 security/selinux/ss/symtab.c                       |    2 +-
 security/selinux/ss/symtab.h                       |    2 +-
 tools/testing/selftests/seccomp/Makefile           |   18 +-
 .../testing/selftests/seccomp/seccomp_benchmark.c  |   99 +++
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  610 +++++++++++++++---
 103 files changed, 3540 insertions(+), 469 deletions(-)
 create mode 100644 security/apparmor/include/mount.h
 create mode 100644 security/apparmor/include/net.h
 create mode 100644 security/apparmor/include/sig_names.h
 create mode 100644 security/apparmor/mount.c
 create mode 100644 security/apparmor/net.c
 create mode 100644 tools/testing/selftests/seccomp/seccomp_benchmark.c
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
