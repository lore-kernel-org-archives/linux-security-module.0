From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 15:30:38 -0400
Subject: [PATCH 0/2] Convert trusted keys to find and use the default TPM chip
Message-ID: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The following patches build on top of the series of patches that
convert IMA to find and use the system's default TPM chip.

I have done some successful testing with trusted keys using publicly
available examples.

   Stefan

Stefan Berger (2):
  tpm: Implement public tpm_put_chip() to release reference to chip
  KEYS: trusted: Find tpm_chip and use it until module shutdown

 drivers/char/tpm/tpm-chip.c | 10 +++++++++
 include/linux/tpm.h         |  4 ++++
 security/keys/trusted.c     | 41 +++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
