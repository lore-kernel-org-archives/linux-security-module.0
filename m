From: tomas.winkler@intel.com (Tomas Winkler)
Date: Fri, 21 Sep 2018 16:57:59 +0300
Subject: [PATCH v4 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Message-ID: <20180921135820.20549-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch series provides initial separation of tpm 1.x and tpm 2.x
commands, in foresight that the tpm 1.x chips will eventually phase out
and can be compiled out for modern systems.
 A new file is added tpm1-cmd.c that contains tpm 1.x specific commands.
In addition, tpm 1.x commands are now implemented using tpm_buf
structure and instead of tpm_cmd_t construct. The latter is now removed.

Note: my tpm 1.x HW availability is limited hence some more testing is needed.

This series also contains two trivial cleanups and addition of new
commands by TCG spec 1.36, now supported on new Intet's platforms.


Tomas Winkler (21):
  tpm2: add new tpm2 commands according to TCG 1.36
  tpm: sort objects in the Makefile
  tpm: factor out tpm 1.x duration calculation to tpm1-cmd.c
  tpm: add tpm_calc_ordinal_duration() wrapper
  tpm: factor out tpm_get_timeouts()
  tpm: move tpm1_pcr_extend to tpm1-cmd.c
  tpm: move tpm_getcap to tpm1-cmd.c
  tpm: factor out tpm1_get_random into tpm1-cmd.c
  tpm: move tpm 1.x selftest code from tpm-interface.c tpm1-cmd.c
  tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
  tpm: factor out tpm_startup function
  tpm: move pcr extend code to tpm2-cmd.c
  tpm: add tpm_auto_startup() into tpm-interface.c
  tpm: tpm-interface.c drop unused macros
  tpm: tpm-space.c remove unneeded semicolon
  tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure
  tpm1: implement tpm1_pcr_read_dev() using tpm_buf structure
  tmp1: rename tpm1_pcr_read_dev to tpm1_pcr_read().
  tpm1: reimplement SAVESTATE using tpm_buf
  tpm1: reimplement tpm1_continue_selftest() using tpm_buf
  tpm: use u32 instead of int for PCR index

 drivers/char/tpm/Makefile            |  16 +-
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-chip.c          |  11 +-
 drivers/char/tpm/tpm-interface.c     | 841 +++--------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  52 +--
 drivers/char/tpm/tpm.h               |  98 ++--
 drivers/char/tpm/tpm1-cmd.c          | 781 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c          | 339 +++++++-------
 drivers/char/tpm/tpm2-space.c        |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
 drivers/char/tpm/tpm_tis_core.c      |  10 +-
 include/linux/tpm.h                  |  11 +-
 security/integrity/ima/ima_crypto.c  |   5 +-
 13 files changed, 1117 insertions(+), 1061 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c

-- 
2.14.4
