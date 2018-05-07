From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Mon,  7 May 2018 12:07:31 -0400
Subject: [PATCH v3 0/2] tpm: improving granularity in poll sleep times 
Message-ID: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing TPM polling code sleeps in each loop iteration for time in
msecs ranging from 1 msecs to 5 msecs. However, many of the TPM commands
complete much faster, resulting in unnecessary delays.

This set of patches identifies such iterations and optimizes the sleep
time. The first patch replaces TPM_POLL_SLEEP with TPM_TIMEOUT_POLL and
moves it from tpm_tis_core.c to tpm.h as an enum with value 1 msecs. The
second patch further reduces the TPM poll sleep time in get_burstcount()
and wait_for_tpm_stat() in tpm_tis_core.c by calling usleep_range()
directly.

The change is only in the polling time, and the maximum timeout is still
maintained the same. Thus, it should not affect the overall existing
behavior.

Changelog:

v3:
 
tpm: reduce poll sleep time in tpm_transmit()
* added testing platform information
* updated patch description for more clarity on reasoning

tpm: reduce polling time to usecs for even finer granularity
* added testing platform information
* added Jarkko's and Mimi's Reviewed-by
 
v2:

tpm: reduce poll sleep time in tpm_transmit()
* merged previously defined two patches into this. 
* updated patch description as per Jarkko's feedback

tpm: reduce polling time to usecs for even finer granularity
* directly use usleep_range with finer granularity less than 1msec

Nayna Jain (2):
  tpm: reduce poll sleep time in tpm_transmit()
  tpm: reduce polling time to usecs for even finer granularity

 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  5 ++++-
 drivers/char/tpm/tpm_tis_core.c  | 11 +++--------
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
