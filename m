From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Mon, 25 Sep 2017 13:19:47 +0200
Subject: [PATCH 0/3] tpm: retrieve digest size of unknown algorithms from TPM
Message-ID: <20170925111950.21511-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch set derives from a larger patch set which modifies the TPM
driver API in order to extend a PCR with multiple digests. It can be
retrieved at the URL:

https://sourceforge.net/p/tpmdd/mailman/message/35905412/


The TPM driver currently relies on the crypto subsystem to determine the
digest size of supported TPM algorithms. In the future, TPM vendors might
implement new algorithms in their chips, and those algorithms might not
be supported by the crypto subsystem.

Usually, vendors provide patches for the new hardware, and likely
the crypto subsystem will be updated before the new algorithm is
introduced. However, old kernels might be updated later, after patches
are included in the mainline kernel. This would leave the opportunity
for attackers to misuse PCRs, as PCR banks with an unknown algorithm
are not extended.

This patch set provides a long term solution for this issue. If a TPM
algorithm is not known by the crypto subsystem, the TPM driver retrieves
the digest size from the TPM with a PCR read. All the PCR banks are
extended, even if the algorithm is not yet supported by the crypto
subsystem.

Roberto Sassu (3):
  tpm: move PCR read code to static function tpm2_pcr_read_common()
  tpm: retrieve digest size of unknown algorithms with PCR read
  tpm: add the crypto algorithm identifier to active_bank_info

 drivers/char/tpm/tpm-interface.c |  4 +-
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 91 +++++++++++++++++++++++++++++-----------
 include/linux/tpm.h              |  6 +++
 4 files changed, 76 insertions(+), 27 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
