From: jmorris@namei.org (James Morris)
Date: Sun, 8 Apr 2018 09:37:53 +1000 (AEST)
Subject: [GIT PULL][SECURITY] TPM updates for v4.17
Message-ID: <alpine.LRH.2.21.1804080935130.1486@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these changes for TPM, via Jarkko:

"This release contains only bug fixes. There are no new major features 
added."

The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to ed807f6aaf787b83885a571268c5d803068f60a6:

  Merge tag 'tpmdd-next-20180323' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-03-24 07:48:26 +1100)

----------------------------------------------------------------
Chris Chiu (1):
      tpm: self test failure should not cause suspend to fail

James Bottomley (2):
      tpm: add retry logic
      tpm: fix intermittent failure with self tests

James Morris (1):
      Merge tag 'tpmdd-next-20180323' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Tomas Winkler (3):
      tpm: cmd_ready command can be issued only after granting locality
      tpm_crb: use __le64 annotated variable for response buffer address
      tpm2: add longer timeouts for creation commands.

Winkler, Tomas (2):
      tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
      tpm: fix buffer type in tpm_transmit_cmd

 drivers/char/tpm/tpm-interface.c | 158 +++++++++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  32 +++++---
 drivers/char/tpm/tpm2-cmd.c      |  62 ++++++---------
 drivers/char/tpm/tpm_crb.c       | 113 +++++++++++++++++++---------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 6 files changed, 250 insertions(+), 121 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
