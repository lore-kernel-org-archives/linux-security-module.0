From: jmorris@namei.org (James Morris)
Date: Tue, 27 Feb 2018 10:48:41 +1100 (AEDT)
Subject: [GIT PULL] TPM: Bug fixes
Message-ID: <alpine.LRH.2.21.1802271046100.9820@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these bugfixes for TPM, from Jeremy Boone, via Jarkko 
Sakkinen.


The following changes since commit 4c3579f6cadd5eb8250a36e789e6df66f660237a:

  Merge tag 'edac_fixes_for_4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2018-02-26 10:19:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc4

for you to fetch changes up to 3be23274755ee85771270a23af7691dc9b3a95db:

  tpm: fix potential buffer overruns caused by bit glitches on the bus (2018-02-26 15:43:46 -0800)

----------------------------------------------------------------
Jeremy Boone (5):
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
      tpm: fix potential buffer overruns caused by bit glitches on the bus

 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 drivers/char/tpm/tpm-interface.c     | 4 ++++
 drivers/char/tpm/tpm2-cmd.c          | 4 ++++
 drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 8 ++++++--
 drivers/char/tpm/tpm_tis_core.c      | 5 +++--
 6 files changed, 22 insertions(+), 8 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
