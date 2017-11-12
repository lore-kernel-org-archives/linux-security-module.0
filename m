From: james.l.morris@oracle.com (James Morris)
Date: Mon, 13 Nov 2017 08:57:18 +1100 (AEDT)
Subject: [GIT PULL] Security subsystem general updates for 4.15
Message-ID: <alpine.LFD.2.20.1711130844150.28856@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In this branch are changes for:

TPM:
----

(from Jarkko)

"Contains mostly minor fixes.
 
Selected more essential changes:
 
* Essential clean up for tpm_crb so that ARM64 and x86 versions do not
  distract each other as much as before.
* /dev/tpm0 rejects now too short writes (shorter buffer than specified 
  in the command header.
* Use DMA-safe buffer in tpm_tis_spi."


Smack:
------
- Base support for overlafs


Capabilities:
-------------

- BPRM_FCAPS fixes, from Richard Guy Briggs:

"The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
application execution (SYSCALL execve). This is not expected as it was
supposed to be limited to when the file system actually had capabilities
in an extended attribute.  It lists all capabilities making the event
really ugly to parse what is happening.  The PATH record correctly
records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
set*id."


TOMOYO:
-------
- Y2038 timestamping fixes


I'll push the Integrity susbsytem changes in a separate branch.


Please pull.


The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 34d8751fd4ffa34e85ee7e85d34168b3f3f62b42:

  MAINTAINERS: update the IMA, EVM, trusted-keys, encrypted-keys entries (2017-11-06 02:21:44 +1100)

----------------------------------------------------------------
Alexander Steffen (5):
      tpm_tis_spi: Use DMA-safe memory for SPI transfers
      tpm: Trigger only missing TPM 2.0 self tests
      tpm: Use dynamic delay to wait for TPM 2.0 self test result
      tpm: React correctly to RC_TESTING from TPM 2.0 self tests
      tpm-dev-common: Reject too short writes

Arnd Bergmann (2):
      tpm: constify transmit data pointers
      tomoyo: fix timestamping for y2038

Casey Schaufler (1):
      Smack: Base support for overlayfs

Colin Ian King (1):
      tpm_tis: make array cmd_getticks static const to shrink object code size

Eric Biggers (1):
      MAINTAINERS: remove David Safford as maintainer for encrypted+trusted keys

James Morris (1):
      Merge tag 'v4.14-rc2' into next-general

Jarkko Sakkinen (4):
      tpm: migrate pubek_show to struct tpm_buf
      tpm: fix type of a local variable in tpm2_get_cc_attrs_tbl()
      tpm: fix type of a local variable in tpm2_map_command()
      tpm: fix type of a local variables in tpm_tis_spi.c

Jiandi An (1):
      tpm/tpm_crb: Use start method value from ACPI table directly

J?r?my Lefaure (1):
      tpm, tpm_tis: use ARRAY_SIZE() to define TPM_HID_USR_IDX

Mimi Zohar (1):
      MAINTAINERS: update the IMA, EVM, trusted-keys, encrypted-keys entries

Richard Guy Briggs (10):
      capabilities: factor out cap_bprm_set_creds privileged root
      capabilities: intuitive names for cap gain status
      capabilities: rename has_cap to has_fcap
      capabilities: use root_priveleged inline to clarify logic
      capabilities: use intuitive names for id changes
      capabilities: move audit log decision to function
      capabilities: remove a layer of conditional logic
      capabilities: invert logic for clarity
      capabilities: fix logic for effective root or real root
      capabilities: audit log other surprising conditions

Ruben Roy (1):
      tpm: fix duplicate inline declaration specifier

 MAINTAINERS                       |  13 +--
 drivers/char/tpm/tpm-dev-common.c |   6 ++
 drivers/char/tpm/tpm-sysfs.c      |  87 +++++++++--------
 drivers/char/tpm/tpm.h            |  15 +--
 drivers/char/tpm/tpm2-cmd.c       |  73 +++++---------
 drivers/char/tpm/tpm2-space.c     |   4 +-
 drivers/char/tpm/tpm_crb.c        |  59 ++++++------
 drivers/char/tpm/tpm_tis.c        |   5 +-
 drivers/char/tpm/tpm_tis_core.c   |   6 +-
 drivers/char/tpm/tpm_tis_core.h   |   4 +-
 drivers/char/tpm/tpm_tis_spi.c    |  73 ++++++++------
 security/commoncap.c              | 193 +++++++++++++++++++++++++-------------
 security/smack/smack_lsm.c        |  79 ++++++++++++++++
 security/tomoyo/audit.c           |   2 +-
 security/tomoyo/common.c          |   4 +-
 security/tomoyo/common.h          |   2 +-
 security/tomoyo/util.c            |  39 ++------
 17 files changed, 385 insertions(+), 279 deletions(-)
