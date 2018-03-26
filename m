From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 26 Mar 2018 15:14:02 +0300
Subject: [PATCH v4 0/4] Migrate all TPM 2.0 commands to use struct tpm_buf
Message-ID: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order to make struct tpm_buf the first class object for constructing TPM
commands, this patch set migrates all TPM 2.0 commands to use it. Eventually,
tpm_transmit_cmd() can take simply struct tpm_buf as its argument and this
interface can be exported to be used by the kernel keyring and potentially
other subsystems.

The ultimate goal of this work is to make constructing TPM commands inside
the kernel simple and robust.

v4:
* Fixed invalid return value from tpm2_probe(). TPM return codes are
  ignored on purpose as we only care about the tag.
* Removed James' fix for the self test as it was separately applied.

v3:
* Fixed error handling in tpm2_get_random()

v2:
* Fixed author information in the commit that fixes the self-test issue,
  removed '\n' from the log message and added the missing tested-by.
  (James: sincere apologies about this)
* Removed the redundant "out of memory" log message from tpm2_shutdown().
* tpm_buf_destroy() was called before using the response data in
  tpm2_probe().
* Added missing tpm_buf_destroy() to tpm2_get_random().

Jarkko Sakkinen (4):
  tpm: migrate tpm2_shutdown() to use struct tpm_buf
  tpm: migrate tpm2_probe() to use struct tpm_buf
  tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
  tpm: migrate tpm2_get_random() to use struct tpm_buf

 drivers/char/tpm/tpm.h      |  19 ++--
 drivers/char/tpm/tpm2-cmd.c | 242 +++++++++++++++++---------------------------
 2 files changed, 105 insertions(+), 156 deletions(-)

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
