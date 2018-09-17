From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Mon, 17 Sep 2018 11:38:17 +0200
Subject: [PATCH v2,
	RESEND 0/3] tpm: retrieve digest size of unknown algorithms from TPM
Message-ID: <20180917093820.20500-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Resending to maintainer with correct mailing lists in CC.

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
  tpm: rename and export tpm2_digest and tpm2_algorithms
  tpm: modify tpm_pcr_read() definition to pass TPM hash algorithms
  tpm: retrieve digest size of unknown algorithms with PCR read

 drivers/char/tpm/tpm-interface.c    | 24 ++++++++----
 drivers/char/tpm/tpm.h              | 18 ++-------
 drivers/char/tpm/tpm2-cmd.c         | 78 +++++++++++++++++++++++++------------
 include/linux/tpm.h                 | 30 +++++++++++++-
 include/linux/tpm_eventlog.h        |  9 +----
 security/integrity/ima/ima_crypto.c | 10 ++---
 6 files changed, 109 insertions(+), 60 deletions(-)

-- 
2.14.1
