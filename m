From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 20 Jun 2017 11:38:01 +0200
Subject: [PATCH 0/2] Clean up TPM 1.2 EK sysfs code
Message-ID: <20170620093804.23803-1-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch set cleans up clutter and cruft from EK sysfs code and fixes
a kernel memory leak.

Jarkko Sakkinen (2):
  tpm: fix a kernel memory leak in tpm-sysfs.c
  tpm: migrate pubek_show to struct tpm_buf

 drivers/char/tpm/tpm-sysfs.c | 86 ++++++++++++++++++++++++--------------------
 drivers/char/tpm/tpm.h       | 13 -------
 2 files changed, 48 insertions(+), 51 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
