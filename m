From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Fri, 23 Jun 2017 15:41:55 +0200
Subject: [PATCH 0/2] Update PCR read code
Message-ID: <20170623134157.30399-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch set updates tpm2_pcr_read(), to build the PCR read command
buffer with tpm_buf functions, which offer protection against buffer
overflow.

It also removes duplicate code in tpm2_do_selftest(), and replaces it with
a call to tpm2_pcr_read().

The previous version of the patches can be found at the URLs:

https://sourceforge.net/p/tpmdd/mailman/message/35905413/
https://sourceforge.net/p/tpmdd/mailman/message/35905415/

The version number has not been incremented from 3 to 4, since this
is considered as a new patch set, not providing the same functionality
of the set the patches were originally part of.

Changelog

- PCR code changes are applied directly to tpm2_pcr_read()
- removed tpm2_pcr_read_in structure
- modified size of digest array in tpm2_pcr_read_out structure

Roberto Sassu (2):
  tpm: use tpm_buf functions in tpm2_pcr_read()
  tpm: use tpm2_pcr_read() in tpm2_do_selftest()

 drivers/char/tpm/tpm2-cmd.c | 89 +++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 59 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
