From: tomas.winkler@intel.com (Tomas Winkler)
Date: Mon,  5 Mar 2018 22:20:12 +0200
Subject: [PATCH 1/6] tpm: sort objects in the Makefile
In-Reply-To: <20180305202017.24008-1-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
Message-ID: <20180305202017.24008-2-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make the tpm Makefile a bit more in order by putting
objects in one column and group together tpm2 modules

Prefer tpm-objs += instead of tpm-y += notation.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index acd758381c58..2fc0e9a73cd6 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -3,9 +3,17 @@
 # Makefile for the kernel tpm device drivers.
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
-tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
-	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
-         tpm2-space.o
+tpm-objs := tpm-interface.o
+tpm-objs += tpm-dev.o
+tpm-objs += tpm-chip.o
+tpm-objs += tpm-dev-common.o
+tpm-objs += tpmrm-dev.o
+tpm-objs += tpm-sysfs.o
+tpm-objs += tpm1_eventlog.o
+tpm-objs += tpm2-cmd.o
+tpm-objs += tpm2-space.o
+tpm-objs += tpm2_eventlog.o
+
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
