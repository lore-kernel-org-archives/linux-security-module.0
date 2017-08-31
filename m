From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Thu, 31 Aug 2017 19:18:55 +0200
Subject: [PATCH RESEND v2 0/3] tpm2-cmd: Improve self test execution
Message-ID: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The self test logic for TPM 2.0 was probably based on the implementation
for TPM 1.2, but did not correctly take into account some TPM 2.0 specifics.
This patch series fixes those issues.

v2:
- Moved implementation description from comment to commit message.

Alexander Steffen (3):
  tpm2-cmd: Trigger only missing self tests
  tpm2-cmd: Use dynamic delay to wait for self test result
  tpm2-cmd: React correctly to RC_TESTING from self tests

 drivers/char/tpm/tpm2-cmd.c | 69 +++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
