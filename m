From: tomas.winkler@intel.com (Tomas Winkler)
Date: Wed, 14 Feb 2018 15:43:17 +0200
Subject: [PATCH 0/2 v3] tpm: fix locality and power saving handling
Message-ID: <20180214134319.4400-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Devices that support locality has failed to transmit due to
reserved order of locality request and cmdReady/goIdle handshake.
The cmdReady/goIdle should be performed on the requested locality.

The first patch corrects the locality and power-save order,
adds required polling for completion of goIdle and locality relinquish.

The second patch removes cmdRead/goIdle handshake from runtime_pm as it's
rather a part of TPM2 protocol  then true device power management,
and on device it's no longer optional.

Tomas Winkler (2):
  tpm: cmd_ready command can be issued only after granting locality
  tpm: separate cmd_ready/go_idle from runtime_pm

 drivers/char/tpm/tpm-interface.c |  28 +++++--
 drivers/char/tpm/tpm_crb.c       | 157 +++++++++++++++++++++++----------------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   4 +-
 4 files changed, 122 insertions(+), 71 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
