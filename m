From: jmorris@namei.org (James Morris)
Date: Tue, 4 Jul 2017 09:33:31 +1000 (AEST)
Subject: [GIT PULL] security subsystem updates for v4.13
Message-ID: <alpine.LRH.2.20.1707040908580.27307@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

- This update includes a major update for AppArmor. From JJ: 

" * several bug fixes and cleanups
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
  currently carrying, all of which will be RFC'd on top of this.  "

- Notable also is the Infiniband work in SELinux, and the new file:map 
permission.  From Paul:

" While we're down to 21 patches for v4.13 (it was 31 for v4.12), the
  diffstat jumps up tremendously with over 2k of line changes.  Almost  
  all of these changes are the SELinux/IB work done by Daniel Jurgens;
  some other noteworthy changes include a NFS v4.2 labeling fix, a new
  file:map permission, and reporting of policy capabilities on policy
  load.  "

There's also now genfscon labeling support for tracefs, which was lost in 
v4.1 with the separation from debugfs.

- Smack incorporates a safer socket check in file_receive, and adds a 
cap_capable call in privilege check.

- TPM as usual has a bunch of fixes and enhancements.

- Multiple calls to security_add_hooks() can now be made for the same LSM, 
to allow LSMs to have hook declarations across multiple files.

- IMA now supports different "ima_appraise=" modes (eg. log, fix) from the 
  boot command line.

Please pull!


---

The following changes since commit e0f3e8f14da868047c524a0cf11e08b95fd1b008:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2017-07-03 15:39:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

Andy Shevchenko (1):
      tpm/st33zp24: Switch to devm_acpi_dev_add_driver_gpios()

Ben Hutchings (1):
      IMA: Correct Kconfig dependencies for hash selection

Bryan Freed (1):
      tpm: Apply a sane minimum adapterlimit value for retransmission.

Casey Schaufler (2):
      Smack: Safer check for a socket in file_receive
      Smack: Use cap_capable in privilege check

Dan Carpenter (1):
      apparmor: Fix error cod in __aa_fs_profile_mkdir()

Daniel Jurgens (9):
      IB/core: IB cache enhancements to support Infiniband security
      IB/core: Enforce PKey security on QPs
      selinux lsm IB/core: Implement LSM notification system
      IB/core: Enforce security on management datagrams
      selinux: Create policydb version for Infiniband support
      selinux: Allocate and free infiniband security hooks
      selinux: Implement Infiniband PKey "Access" access vector
      selinux: Add IB Port SMP access vector
      selinux: Add a cache for quicker retreival of PKey SIDs

Eric Richter (1):
      IMA: update IMA policy documentation to include pcr= option

Florian Westphal (2):
      smack: use pernet operations for hook registration
      selinux: use pernet operations for hook registration

Geert Uytterhoeven (1):
      security: Grammar s/allocates/allocated/

Geliang Tang (1):
      ima: use memdup_user_nul

Gustavo A. R. Silva (1):
      tpm/tpm_atmel: remove unnecessary NULL check

James Morris (4):
      Sync to mainline for security submaintainers to work against
      Merge branch 'smack-for-4.13' of git://github.com/cschaufler/smack-next into next
      Merge branch 'stable-4.13' of git://git.infradead.org/users/pcmoore/selinux into next
      Merge tag 'seccomp-next' of git://git.kernel.org/.../kees/linux into next

Jarkko Sakkinen (3):
      tpm: fix byte order related arithmetic inconsistency in tpm_getcap()
      tpm, tpm_infineon: remove useless snprintf() calls
      tpm: remove struct tpm_pcrextend_in

Jason Gunthorpe (3):
      tpm_tis: Fix IRQ autoprobing when using platform_device
      tpm_tis: Use platform_get_irq
      tpm_tis: Consolidate the platform and acpi probe flow

Jeff Vander Stoep (1):
      selinux: enable genfscon labeling for tracefs

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

Junil Lee (1):
      selinux: use kmem_cache for ebitmap

Kees Cook (3):
      seccomp: Clean up core dump logic
      seccomp: Adjust selftests to avoid double-join
      seccomp: Switch from atomic_t to recount_t

Laura Abbott (1):
      ima: Add cgroups2 to the defaults list

Markus Elfring (4):
      selinux: Return directly after a failed memory allocation in policydb_index()
      selinux: Return an error code only as a constant in sidtab_insert()
      apparmorfs: Combine two function calls into one in aa_fs_seq_raw_abi_show()
      apparmorfs: Use seq_putc() in two functions

Matthias Kaehlcke (1):
      selinux: Remove redundant check for unknown labeling behavior

Micka?l Sala?n (1):
      LSM: Enable multiple calls to security_add_hooks() for the same LSM

Mimi Zohar (4):
      ima: extend the "ima_policy" boot command line to support multiple policies
      ima: define a set of appraisal rules requiring file signatures
      ima: define Kconfig IMA_APPRAISE_BOOTPARAM option
      ima: define is_ima_appraise_enabled()

Peter Huewe (1):
      tpm, tpmrm: Mark tpmrm_write as static

Roberto Sassu (7):
      tpm: move endianness conversion of TPM_TAG_RQU_COMMAND to tpm_input_header
      tpm: move endianness conversion of ordinals to tpm_input_header
      tpm: move TPM 1.2 code of tpm_pcr_extend() to tpm1_pcr_extend()
      ima: introduce ima_parse_buf()
      ima: use ima_parse_buf() to parse measurements headers
      ima: use ima_parse_buf() to parse template data
      ima: fix get_binary_runtime_size()

Scott Mayhew (1):
      security/selinux: allow security_sb_clone_mnt_opts to enable/disable native labeling behavior

Stefan Berger (4):
      tpm: vtpm_proxy: Suppress error logging when in closed state
      tpm: Introduce flag TPM_TRANSMIT_RAW
      tpm: vtpm_proxy: Implement request_locality function.
      tpm: vtpm_proxy: Prevent userspace from sending driver command

Stephen Rothwell (1):
      apparmor: put back designators in struct initialisers

Stephen Smalley (4):
      selinux: only invoke capabilities and selinux for CAP_MAC_ADMIN checks
      selinux: add a map permission check for mmap
      selinux: do not check open permission on sockets
      selinux: log policy capability state when a policy is loaded

Tetsuo Handa (1):
      selinux: Use task_alloc hook rather than task_create hook

Thiago Jung Bauermann (3):
      integrity: Small code improvements
      ima: Simplify policy_func_show.
      ima: Log the same audit cause whenever a file has no signature

Thomas Schneider (1):
      security/apparmor: Use POSIX-compatible "printf '%s'"

Tycho Andersen (1):
      ima: fix up #endif comments

 Documentation/ABI/testing/ima_policy            |    8 +-
 Documentation/admin-guide/kernel-parameters.txt |   21 +-
 drivers/char/tpm/st33zp24/i2c.c                 |    3 +-
 drivers/char/tpm/st33zp24/spi.c                 |    3 +-
 drivers/char/tpm/tpm-interface.c                |  118 +-
 drivers/char/tpm/tpm-sysfs.c                    |    6 +-
 drivers/char/tpm/tpm.h                          |   22 +-
 drivers/char/tpm/tpm2-cmd.c                     |    2 +-
 drivers/char/tpm/tpm_atmel.c                    |   12 +-
 drivers/char/tpm/tpm_i2c_infineon.c             |   76 +-
 drivers/char/tpm/tpm_infineon.c                 |    8 +-
 drivers/char/tpm/tpm_tis.c                      |  175 +--
 drivers/char/tpm/tpm_vtpm_proxy.c               |   69 +
 drivers/char/tpm/tpmrm-dev.c                    |    2 +-
 drivers/infiniband/core/Makefile                |    3 +-
 drivers/infiniband/core/cache.c                 |   43 +-
 drivers/infiniband/core/core_priv.h             |  115 ++
 drivers/infiniband/core/device.c                |   86 +
 drivers/infiniband/core/mad.c                   |   52 +-
 drivers/infiniband/core/security.c              |  705 ++++++++
 drivers/infiniband/core/uverbs_cmd.c            |   15 +-
 drivers/infiniband/core/verbs.c                 |   27 +-
 fs/nfs/super.c                                  |   17 +-
 include/linux/ima.h                             |    6 +
 include/linux/lsm_audit.h                       |   15 +
 include/linux/lsm_hooks.h                       |   39 +-
 include/linux/security.h                        |   70 +-
 include/rdma/ib_mad.h                           |    4 +
 include/rdma/ib_verbs.h                         |   49 +
 include/uapi/linux/magic.h                      |    2 +
 include/uapi/linux/vtpm_proxy.h                 |    4 +
 kernel/seccomp.c                                |   16 +-
 security/Kconfig                                |   11 +-
 security/apparmor/Makefile                      |    8 +-
 security/apparmor/apparmorfs.c                  | 1672 +++++++++++++++----
 security/apparmor/audit.c                       |   27 +-
 security/apparmor/capability.c                  |   61 +-
 security/apparmor/context.c                     |   87 +-
 security/apparmor/domain.c                      | 1393 ++++++++++-----
 security/apparmor/file.c                        |  517 ++++--
 security/apparmor/include/apparmor.h            |    6 +-
 security/apparmor/include/apparmorfs.h          |   67 +-
 security/apparmor/include/audit.h               |   17 +-
 security/apparmor/include/capability.h          |    8 +-
 security/apparmor/include/context.h             |  201 ++-
 security/apparmor/include/domain.h              |   13 +-
 security/apparmor/include/file.h                |  114 +-
 security/apparmor/include/ipc.h                 |   16 +-
 security/apparmor/include/label.h               |  441 +++++
 security/apparmor/include/lib.h                 |  120 ++-
 security/apparmor/include/path.h                |    7 +-
 security/apparmor/include/perms.h               |  155 ++
 security/apparmor/include/policy.h              |  131 +-
 security/apparmor/include/policy_ns.h           |   21 +
 security/apparmor/include/policy_unpack.h       |   68 +-
 security/apparmor/include/procattr.h            |    8 +-
 security/apparmor/include/resource.h            |    6 +-
 security/apparmor/ipc.c                         |  140 +-
 security/apparmor/label.c                       | 2120 +++++++++++++++++++++++
 security/apparmor/lib.c                         |  368 ++++-
 security/apparmor/lsm.c                         |  245 ++-
 security/apparmor/path.c                        |  130 +-
 security/apparmor/policy.c                      |  392 +++--
 security/apparmor/policy_ns.c                   |   80 +-
 security/apparmor/policy_unpack.c               |   96 +-
 security/apparmor/procattr.c                    |   71 +-
 security/apparmor/resource.c                    |  116 +-
 security/inode.c                                |  144 ++-
 security/integrity/digsig_asymmetric.c          |    4 +-
 security/integrity/iint.c                       |    2 +-
 security/integrity/ima/Kconfig                  |   16 +-
 security/integrity/ima/ima.h                    |   31 +-
 security/integrity/ima/ima_appraise.c           |   16 +-
 security/integrity/ima/ima_fs.c                 |   13 +-
 security/integrity/ima/ima_policy.c             |  106 +-
 security/integrity/ima/ima_queue.c              |    2 +-
 security/integrity/ima/ima_template.c           |  124 +-
 security/integrity/ima/ima_template_lib.c       |   61 +
 security/integrity/ima/ima_template_lib.h       |    6 +
 security/integrity/integrity.h                  |    7 +-
 security/lsm_audit.c                            |   16 +
 security/security.c                             |   74 +-
 security/selinux/Makefile                       |    2 +-
 security/selinux/hooks.c                        |  212 ++-
 security/selinux/ibpkey.c                       |  245 +++
 security/selinux/include/classmap.h             |    6 +-
 security/selinux/include/ibpkey.h               |   31 +
 security/selinux/include/objsec.h               |   11 +
 security/selinux/include/security.h             |    9 +-
 security/selinux/selinuxfs.c                    |   15 +-
 security/selinux/ss/ebitmap.c                   |   26 +-
 security/selinux/ss/ebitmap.h                   |    3 +
 security/selinux/ss/policydb.c                  |  127 ++-
 security/selinux/ss/policydb.h                  |   27 +-
 security/selinux/ss/services.c                  |  108 ++
 security/selinux/ss/sidtab.c                    |   27 +-
 security/smack/smack.h                          |    2 +-
 security/smack/smack_access.c                   |   19 +-
 security/smack/smack_lsm.c                      |    2 +-
 security/smack/smack_netfilter.c                |   26 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c   |   51 +-
 101 files changed, 9902 insertions(+), 2395 deletions(-)
 create mode 100644 drivers/infiniband/core/security.c
 create mode 100644 security/apparmor/include/label.h
 create mode 100644 security/apparmor/include/perms.h
 create mode 100644 security/apparmor/label.c
 create mode 100644 security/selinux/ibpkey.c
 create mode 100644 security/selinux/include/ibpkey.h
