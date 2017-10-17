From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Tue, 17 Oct 2017 16:32:28 -0400
Subject: [PATCH v4 0/4] additional TPM performance improvements 
Message-ID: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

After further discussions with the TCG Device Driver working group (ddwg),
the following changes were made: 

* Check for burstcount at least once to confirm the TPM is ready to accept
the data. Similarly, query for the TPM Expect status as sanity check at
the end.

* Make the sleep for status check in the loop less than 5msec.

* Make the sleep in the loop while querying for burstcount less than
5msec.

Below is the list of patches along with the performance improvements
seen with a TPM 1.2 with an 8 byte burstcount for 1000 extends: 

Patch                                        |Improvement(time in sec)

tpm: ignore burstcount to improve tpm_tis    | ~41 - ~14
send() performance.

tpm: reduce polling delay in tpm_tis_core    | ~14 - ~9 

tpm: modify tpm_msleep() function to have    | ~9 - ~8
max range

Changelog v4:
* Include Jarkko's feedback on merging two patches reducing sleep
time during polling to TPM.
* Include Jarkko's feedback to clean up the burstcount change
patch and add comment for new #define.

Changelog v3:

* Include Jarkko's feedback to move wait_for_tpm_stat() from
tpm-interface.c to respective driver files tpm_tis_core.c and
xen-tpmfront.c.
* Remove use of module parameter ignore_burst_count and is
now alwaysed ignored in tpm tis send() operation.
* Reduce sleep() time during polling in wait_for_tpm_stat() from
5msec to 1msec for both recv() and send() operation. Version
2 of the patches  had it only for send() operation.

Changelog v2:

* Add module parameter to handle ignoring of burst count during
tpm tis send() operation.
* Add improvements over sleep time to reduce delays.

Nayna Jain (4):
  tpm: move wait_for_tpm_stat() to respective driver files
  tpm: ignore burstcount to improve tpm_tis send() performance
  tpm: reduce tpm polling delay in tpm_tis_core
  tpm: use tpm_msleep() value as max delay

 drivers/char/tpm/tpm-interface.c |  60 ---------------------
 drivers/char/tpm/tpm.h           |   6 +--
 drivers/char/tpm/tpm_tis_core.c  | 110 +++++++++++++++++++++++++++++----------
 drivers/char/tpm/xen-tpmfront.c  |  60 +++++++++++++++++++++
 4 files changed, 144 insertions(+), 92 deletions(-)

-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
