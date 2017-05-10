From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 10 May 2017 19:54:20 -0400
Subject: [PATCH v4 0/2]  Extend the vTPM proxy driver to pass locality
Message-ID: <1494460462-29022-1-git-send-email-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The purpose of this series of patches is to enable the passing of the locality
a command is executing in to a recipient, i.e., TPM emulator. To enable this we
introduce vendor-specific TPM commands for TPM 1.2 and TPM 2 that the driver
sends to the TPM emulator.

v3->v4:
  - addressed Jarkko's comments: largely a rewrite of the patches

v2->v3:
  - addressed Jarkko's comments

v1->v2:
  - fixed return value from function in patch 3/3

Stefan Berger (2):
  tpm: Refactor tpm_transmit pulling out tpm_transfer function
  tpm: vtpm_proxy: Implement request_locality function.

 drivers/char/tpm/tpm-interface.c  | 121 +++++++++++++++++++++++---------------
 drivers/char/tpm/tpm.h            |   1 +
 drivers/char/tpm/tpm_vtpm_proxy.c |  34 +++++++++++
 include/uapi/linux/vtpm_proxy.h   |   5 ++
 4 files changed, 113 insertions(+), 48 deletions(-)

-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
