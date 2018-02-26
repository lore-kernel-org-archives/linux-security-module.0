From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 26 Feb 2018 14:41:44 +0200
Subject: [GIT PULL] tpmdd fixes for 4.16
Message-ID: <20180226124144.GA8675@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi

Here is a batch of critical fixes for 4.16.

/Jarkko

The following changes since commit a02633e9b13dcb9b1a656b08f81bc8ba2d4d2294:

  Merge tag 'v4.16-rc2' into next-general (2018-02-21 08:21:41 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180226

for you to fetch changes up to 895fbcaba75da05f6337ffaf750778c3a8ee9158:

  tpm_tis: fix potential buffer overruns caused by bit glitches on the bus (2018-02-26 14:33:57 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux 4.16

----------------------------------------------------------------
Jeremy Boone (5):
      tpm: fix potential buffer overruns caused by bit glitches on the bus
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

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
