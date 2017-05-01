From: jmorris@namei.org (James Morris)
Date: Mon, 1 May 2017 19:41:19 +1000 (AEST)
Subject: [GIT PULL] Security subsystem updates for v4.12
Message-ID: <alpine.LRH.2.20.1705011909530.24884@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Here are the security subsystem updates for v4.12.

Highlights:

    - IMA: provide ">" and "<" operators for fowner/uid/euid rules

    - KEYS: add a system blacklist keyring

    - KEYS: add KEYCTL_RESTRICT_KEYRING, exposes keyring link restriction 
      functionality to userland via keyctl()

    - LSM: harden LSM API with __ro_after_init

    - LSM: add prlmit security hook, implement for SELinux 

    - LSM: revive security_task_alloc hook

    - TPM: implement contextual TPM command "spaces"


Please pull!

---

The following changes since commit a351e9b9fc24e982ec2f0e76379a49826036da12:

  Linux 4.11 (2017-04-30 19:47:48 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

Alexander Potapenko (1):
      selinux: check for address length in selinux_socket_bind()

Alexander Steffen (1):
      tpm_tis_core: Choose appropriate timeout for reading burstcount

Andy Shevchenko (1):
      tpm/st33zp24: Add GPIO ACPI mapping table

Arnd Bergmann (1):
      tpm: select CONFIG_CRYPTO

Dan Carpenter (1):
      selinux: Fix an uninitialized variable bug

Daniel Gl?ckner (1):
      ima: accept previously set IMA_NEW_FILE

David Howells (5):
      KEYS: Add a system blacklist keyring
      X.509: Allow X.509 certs to be blacklisted
      PKCS#7: Handle blacklisted certificates
      Merge branch 'keys-blacklist' into keys-next
      Merge branch 'keyctl-restrict' of git://git.kernel.org/.../martineau/linux into keys-next

Elena Reshetova (2):
      security, keys: convert key.usage from atomic_t to refcount_t
      security, keys: convert key_user.usage from atomic_t to refcount_t

Hon Ching \(Vicky\) Lo (1):
      vTPM: Fix missing NULL check

James Bottomley (3):
      tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c
      tpm: expose spaces via a device link /dev/tpmrm<n>
      tpm2: add session handle context saving and restoring to the space code

James Morris (9):
      security: introduce CONFIG_SECURITY_WRITABLE_HOOKS
      security: mark LSM hooks as __ro_after_init
      selinux: constify nlmsg permission tables
      integrity: mark default IMA rules as __ro_after_init
      update to v4.11-rc4 due to memory corruption bug in rc2
      Merge tag 'keys-next-20170412' of git://git.kernel.org/.../dhowells/linux-fs into next
      Merge branch 'stable-4.12' of git://git.infradead.org/users/pcmoore/selinux into next
      Merge branch 'smack-for-4.12' of git://github.com/cschaufler/smack-next into next
      Merge branch 'next' of git://git.kernel.org/.../zohar/linux-integrity into next

Jarkko Sakkinen (8):
      tpm_crb: map locality registers
      tpm_crb: encapsulate crb_wait_for_reg_32
      tpm: move length validation to tpm_transmit()
      tpm: export tpm2_flush_context_cmd
      tpm: validate TPM 2.0 commands
      tpm: infrastructure for TPM spaces
      tpm_crb: request and relinquish locality 0
      tpm_crb: remove a cruft constant

Jason Gunthorpe (1):
      tpm crb: Work around BIOS's that report the wrong ACPI region size

Jerry Snitselaar (3):
      tpm_crb: check for bad response size
      tpm: make check_locality return bool
      tpm_tis: convert to using locality callbacks

Jiandi An (2):
      ACPICA: Update TPM2 ACPI table
      tpm/tpm_crb: Enable TPM CRB interface for ARM64

John Johansen (3):
      apparmor: fix invalid reference to index variable of iterator line 836
      apparmor: fix parameters so that the permission test is bypassed at boot
      apparmor: Make path_max parameter readonly

J?r?my Lefaure (1):
      tpm/tpm_crb: fix unused warnings on suspend/resume functions

Kees Cook (1):
      TOMOYO: Use designated initializers

Markus Elfring (25):
      selinux: Use kmalloc_array() in cond_init_bool_indexes()
      selinux: Delete an unnecessary return statement in cond_compute_av()
      selinux: Improve size determinations in four functions
      selinux: Use kmalloc_array() in hashtab_create()
      selinux: Adjust four checks for null pointers
      selinux: Use kcalloc() in policydb_index()
      selinux: Delete an unnecessary return statement in policydb_destroy()
      selinux: Return directly after a failed next_entry() in genfs_read()
      selinux: One function call less in genfs_read() after null pointer detection
      selinux: Delete an unnecessary variable assignment in filename_trans_read()
      selinux: Return directly after a failed next_entry() in range_read()
      selinux: Delete an unnecessary variable initialisation in range_read()
      selinux: Return directly after a failed kzalloc() in cat_read()
      selinux: Return directly after a failed kzalloc() in sens_read()
      selinux: Improve another size determination in sens_read()
      selinux: Return directly after a failed kzalloc() in user_read()
      selinux: Return directly after a failed kzalloc() in type_read()
      selinux: Return directly after a failed kzalloc() in role_read()
      selinux: Return directly after a failed kzalloc() in class_read()
      selinux: Return directly after a failed kzalloc() in common_read()
      selinux: Return directly after a failed kzalloc() in perm_read()
      selinux: Return directly after a failed kzalloc() in roles_init()
      selinux: Use kmalloc_array() in sidtab_init()
      selinux: Adjust two checks for null pointers
      selinuxfs: Use seq_puts() in sel_avc_stats_seq_show()

Mat Martineau (10):
      KEYS: Use a typedef for restrict_link function pointers
      KEYS: Split role of the keyring pointer for keyring restrict functions
      KEYS: Add a key restriction struct
      KEYS: Use structure to capture key restriction function and data
      KEYS: Add an optional lookup_restriction hook to key_type
      KEYS: Consistent ordering for __key_link_begin and restrict check
      KEYS: Add KEYCTL_RESTRICT_KEYRING
      KEYS: Add a lookup_restriction function for the asymmetric key type
      KEYS: Restrict asymmetric key linkage using a specific keychain
      KEYS: Keyring asymmetric key restrict method with chaining

Matthias Kaehlcke (1):
      selinux: Remove unnecessary check of array base in selinux_set_mapping()

Mikhail Kurinnoi (1):
      ima: provide ">" and "<" operators for fowner/uid/euid rules.

Nayna Jain (2):
      tpm: msleep() delays - replace with usleep_range() in i2c nuvoton driver
      tpm: add sleep only for retry in i2c_nuvoton_write_status()

Nicolas Iooss (2):
      selinux: include sys/socket.h in host programs to have PF_MAX
      apparmor: use SHASH_DESC_ON_STACK

Peter Huewe (5):
      tpm_tis_spi: Use single function to transfer data
      tpm_tis_spi: Abort transfer when too many wait states are signaled
      tpm_tis_spi: Check correct byte for wait state indicator
      tpm_tis_spi: Remove limitation of transfers to MAX_SPI_FRAMESIZE bytes
      tpm_tis_spi: Add small delay after last transfer

Petr Vandrovec (1):
      tpm: fix handling of the TPM 2.0 event logs

Stefan Berger (1):
      tpm: Fix reference count to main device

Stephan Mueller (1):
      KEYS: add SP800-56A KDF support for DH

Stephan M?ller (1):
      keys: select CONFIG_CRYPTO when selecting DH / KDF

Stephen Smalley (3):
      prlimit,security,selinux: add a security hook for prlimit
      selinux: fix kernel BUG on prlimit(..., NULL, NULL)
      fs: switch order of CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH checks

Tetsuo Handa (4):
      LSM: Initialize security_hook_heads upon registration.
      LSM: Revive security_task_alloc() hook and per "struct task_struct" security blob.
      smack: fix double free in smack_parse_opts_str()
      Smack: Use GFP_KERNEL for smk_netlbl_mls().

Valentin Rothberg (1):
      security/apparmor/lsm.c: set debug messages

Winkler, Tomas (1):
      tpm/tpm_crb: enter the low power state upon device suspend

kbuild test robot (1):
      apparmor: fix boolreturn.cocci warnings

 Documentation/crypto/asymmetric-keys.txt |   51 +++
 Documentation/security/keys.txt          |  100 +++++--
 certs/Kconfig                            |   18 +
 certs/Makefile                           |    6 +
 certs/blacklist.c                        |  174 ++++++++++
 certs/blacklist.h                        |    3 +
 certs/blacklist_hashes.c                 |    6 +
 certs/blacklist_nohashes.c               |    5 +
 certs/system_keyring.c                   |   39 ++-
 crypto/asymmetric_keys/asymmetric_type.c |  102 ++++++-
 crypto/asymmetric_keys/pkcs7_parser.h    |    1 +
 crypto/asymmetric_keys/pkcs7_verify.c    |   32 ++-
 crypto/asymmetric_keys/restrict.c        |  161 +++++++++-
 crypto/asymmetric_keys/x509_parser.h     |    1 +
 crypto/asymmetric_keys/x509_public_key.c |   15 +
 drivers/char/tpm/Kconfig                 |    3 +-
 drivers/char/tpm/Makefile                |    3 +-
 drivers/char/tpm/st33zp24/i2c.c          |   23 ++-
 drivers/char/tpm/st33zp24/spi.c          |   23 ++-
 drivers/char/tpm/st33zp24/st33zp24.c     |   12 +-
 drivers/char/tpm/tpm-chip.c              |   71 ++++-
 drivers/char/tpm/tpm-dev-common.c        |  148 +++++++++
 drivers/char/tpm/tpm-dev.c               |  143 +--------
 drivers/char/tpm/tpm-dev.h               |   27 ++
 drivers/char/tpm/tpm-interface.c         |  152 +++++++--
 drivers/char/tpm/tpm-sysfs.c             |    2 +-
 drivers/char/tpm/tpm.h                   |   52 +++-
 drivers/char/tpm/tpm2-cmd.c              |  173 +++++++---
 drivers/char/tpm/tpm2-space.c            |  528 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2_eventlog.c         |   14 +-
 drivers/char/tpm/tpm_crb.c               |  279 +++++++++++++---
 drivers/char/tpm/tpm_i2c_infineon.c      |   12 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c       |   24 +-
 drivers/char/tpm/tpm_ibmvtpm.c           |    8 +-
 drivers/char/tpm/tpm_tis_core.c          |   60 ++--
 drivers/char/tpm/tpm_tis_spi.c           |  160 ++++------
 drivers/char/tpm/tpmrm-dev.c             |   65 ++++
 fs/namei.c                               |   20 +-
 include/acpi/actbl2.h                    |    1 +
 include/crypto/public_key.h              |   15 +-
 include/keys/system_keyring.h            |   18 +-
 include/linux/compat.h                   |    7 +
 include/linux/init_task.h                |    7 +
 include/linux/key-type.h                 |    8 +
 include/linux/key.h                      |   39 ++-
 include/linux/lsm_hooks.h                |   34 ++-
 include/linux/sched.h                    |    4 +
 include/linux/security.h                 |   20 ++
 include/linux/tpm.h                      |    3 +-
 include/uapi/linux/keyctl.h              |    8 +
 kernel/fork.c                            |    7 +-
 kernel/sys.c                             |   30 +-
 scripts/selinux/genheaders/genheaders.c  |    1 +
 scripts/selinux/mdp/mdp.c                |    1 +
 security/Kconfig                         |    5 +
 security/apparmor/crypto.c               |   32 +-
 security/apparmor/include/lib.h          |    2 +-
 security/apparmor/lib.c                  |    4 +-
 security/apparmor/lsm.c                  |   53 ++--
 security/apparmor/policy.c               |    6 +-
 security/commoncap.c                     |    2 +-
 security/integrity/digsig.c              |    9 +-
 security/integrity/ima/ima_appraise.c    |    5 +-
 security/integrity/ima/ima_mok.c         |   11 +-
 security/integrity/ima/ima_policy.c      |  123 +++++--
 security/keys/Kconfig                    |    2 +
 security/keys/Makefile                   |    3 +-
 security/keys/compat.c                   |    9 +-
 security/keys/compat_dh.c                |   38 +++
 security/keys/dh.c                       |  220 ++++++++++++-
 security/keys/gc.c                       |   13 +-
 security/keys/internal.h                 |   32 ++-
 security/keys/key.c                      |   58 ++--
 security/keys/keyctl.c                   |   60 ++++-
 security/keys/keyring.c                  |  187 ++++++++++-
 security/keys/proc.c                     |    4 +-
 security/keys/process_keys.c             |    2 +-
 security/keys/request_key_auth.c         |    2 +-
 security/loadpin/loadpin.c               |    2 +-
 security/security.c                      |  370 +--------------------
 security/selinux/Kconfig                 |    6 +
 security/selinux/hooks.c                 |   26 ++-
 security/selinux/include/classmap.h      |    2 +-
 security/selinux/nlmsgtab.c              |   10 +-
 security/selinux/selinuxfs.c             |    8 +-
 security/selinux/ss/conditional.c        |   14 +-
 security/selinux/ss/hashtab.c            |   10 +-
 security/selinux/ss/policydb.c           |   59 ++--
 security/selinux/ss/services.c           |    2 +-
 security/selinux/ss/sidtab.c             |    6 +-
 security/smack/smack_access.c            |    2 +-
 security/smack/smack_lsm.c               |    6 +-
 security/tomoyo/file.c                   |   12 +-
 security/tomoyo/tomoyo.c                 |   22 +-
 security/yama/yama_lsm.c                 |    2 +-
 95 files changed, 3240 insertions(+), 1120 deletions(-)
 create mode 100644 certs/blacklist.c
 create mode 100644 certs/blacklist.h
 create mode 100644 certs/blacklist_hashes.c
 create mode 100644 certs/blacklist_nohashes.c
 create mode 100644 drivers/char/tpm/tpm-dev-common.c
 create mode 100644 drivers/char/tpm/tpm-dev.h
 create mode 100644 drivers/char/tpm/tpm2-space.c
 create mode 100644 drivers/char/tpm/tpmrm-dev.c
 create mode 100644 security/keys/compat_dh.c
