From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 07:06:14 -0400
Subject: [PATCH v5 0/5] Have IMA find and use a tpm_chip until system shutdown
Message-ID: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This series of patches converts IMA's usage of the tpm_chip to find a TPM
chip initially and use it until the machine is shut down. To do this we need
to introduce a kref for the tpm_chip that IMA and all other users of a
tpm_chip hold onto until they don't need the TPM chip anymore.

    Stefan

v4->v5:
  - repost with fixed changelog and posted to linux-security-module

v3->v4:
  - followed Jason's suggestions:
    - extended docs of tpm_find_get_ops()
    - calling new function tpm_default_chip()
    - new patch 3 that uses tpm_default_chip() in tpm_find_get_ops()

v2->v3:
  - renaming tpm_chip_find_get() to tpm_get_ops()
  - IMA does not lock access to ima_tpm_chip anymore
  - IMA does not have a reboot notifier to release the chip anymore

v1->v2:
  - use the kref of the device via get_device()/put_device()


Stefan Berger (5):
  tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
  tpm: Implement tpm_default_chip() to find a TPM chip
  tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
  ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

 drivers/char/tpm/tpm-chip.c         | 68 +++++++++++++++++++----------
 drivers/char/tpm/tpm-interface.c    | 14 +++---
 drivers/char/tpm/tpm.h              |  2 +-
 include/linux/tpm.h                 |  5 +++
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 +-
 security/integrity/ima/ima_init.c   | 16 +++----
 security/integrity/ima/ima_queue.c  |  4 +-
 8 files changed, 69 insertions(+), 46 deletions(-)

-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
