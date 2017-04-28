From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri, 28 Apr 2017 09:02:15 -0400
Subject: [PATCH v2 0/3] Extend the vTPM proxy driver to pass locality to
	emulator
Message-ID: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The purpose of this series of patches is to enable the passing of the locality
a command is executing in to a TPM emulator. To enable this we introduce a new
flag for the device creation ioctl that requests that the locality be prepended
to every command. For applications to check which flags the driver supports, we
add a new ioctl that returns a bitmask of supported flags.

v1->v2:
  - fixed return value from function in patch 3/3


Stefan Berger (3):
  tpm: vtpm_proxy: Add ioctl to get supported flags
  tpm: vtpm_proxy: Implement request_locality
  tpm: vtpm_proxy: Add ioctl to request locality prepended to command

 drivers/char/tpm/tpm_vtpm_proxy.c | 53 +++++++++++++++++++++++++++++++++++----
 include/uapi/linux/vtpm_proxy.h   | 15 ++++++++++-
 2 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
