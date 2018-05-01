From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  1 May 2018 09:48:17 -0400
Subject: [PATCH 0/6] firmware: kernel signature verification 
Message-ID: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Allow LSMs and IMA to differentiate between different methods of
firmware loading (eg. direct loading, sysfs fallback) and to
differentiate/coordinate between signature verification methods (eg.
regdb, IMA-appraisal).

In addition, the last two patches address the pre-allocated buffer.  The
first of these patches doesn't differentiate between reading the
firmware first into kernel memory and verifying the kernel signature,
versus reading the firmware directly into a pre-allocated buffer.

The last patch, which is posted as an RFC, questions whether the device
can access the pre-allocated buffer before the kernel signature has been
verified.

Mimi Zohar (6):
  firmware: permit LSMs and IMA to fail firmware sysfs fallback loading
  ima: prevent sysfs fallback firmware loading
  firmware: differentiate between signed regulatory.db and other
    firmware
  ima: coordinate with signed regulatory.db
  ima: verify kernel firmware signatures when using a preallocated
    buffer
  ima: prevent loading firmware into a pre-allocated buffer

 drivers/base/firmware_loader/fallback.c |  7 +++++++
 drivers/base/firmware_loader/main.c     |  5 +++++
 include/linux/fs.h                      |  2 ++
 security/integrity/ima/ima_main.c       | 29 +++++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
