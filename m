Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5213E638E
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187116; cv=none; b=oF8L8ASTx8Wrhv/KldcQyS7+60yFT3XT2/+vQ/PmhgMEC46hHa6fX1dVVf/LfvAz4f6SzMZhqmIrYcQsbbJ2u4YHqHo3JUsNy3o6JdhKLPz2d0kN6R2ttxGeeC5bcIsvEW/x+lWQ7L/6rqcaqZ/cL+DfZpqPAwS2Mi2L/qUwUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187116; c=relaxed/simple;
	bh=G9P3Gm9X6VHormYF4PiT6UNlB1syHT2Cmg6ZgiMV8f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsUFWxfTThPKmOHifdoCaAP+paY9PAu85V00OtPPndPx/Ow+aROKWRt5/6jOhj5Y8zycg45CXtXA0wbMjhcP8eU3qBsIu75JA10G4dyaHpbIP7E8TlQF8XxGr8oK6OVNTFIDNR48EmCXF/Y2kg7UaB+jVTp2WCBMMA/X8F5yTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5i2LVCP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5i2LVCP"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso2353006a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187114; x=1785791914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/e05uQAC/MWsadOTV5ro3O8ihJOAfbb/VcbPjWI2HCQ=;
        b=K5i2LVCPZ2XO0tLyO2XD47rgx0M4ImH26RaBaZQxJwdu/ZHkKNROtznlKrEwtxkYTD
         3LVzx7vY85nIRbe/5q2ZfVFDQsgmPzsONIcCkVr3JjSK+4Lkr2EW9X+p2fQQRIrM9s7D
         l3iTBFKdFQ1ZgRR/r4X3+BpqaUfIR4Dc7SH0ZgSUs4hUKxxbL2x5AodQuV7229UNzqF4
         yVG6gbAZ/tJG3a8vx2L8ZH+QW/O+0OIG4PpzxUBgwfeb7BsZh0g8UwgLzibEgX5s4+kK
         y/awZOH5+zRb40DUdy+y3jaFoSSbKfL1mSvBrvajcZTw+OMsfOriKsReWaNH6ZLFIBQf
         LAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187114; x=1785791914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/e05uQAC/MWsadOTV5ro3O8ihJOAfbb/VcbPjWI2HCQ=;
        b=n5f/iTsseq7GjjDkl9gTF5NpuxbuEN4Zzn2P4w1tcRXENAZLY8agwqXe6yDIK5MgnM
         a00FiEdIab2ayG/AmkuPgxBjopFwFHufhRoT5SRRj7bhdrmBWh5Eo7OSWoUhRPZzD1F+
         rUYx/whrIXGiKQJf5CLmlmX5kt0t1BNbmTqcQCmPBPOpiaa0fesdFs3fylNkgP83r7Lo
         vH+HW5PPKoea0FVrRxbWbBC2SmmDmxXmEIqYR7hHTbR8djo91XEvoDDkmuqykUCk9xFo
         eFH9ye0/KanzgzLZxyUQqrzTLDjDK5p3R+RAQDvIdGSOtp3846dnnLPQvy/HqYAz2Mjc
         k+KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp84fhArkkDS8Vw6PtSC5kCImEpt7otFQhPdw2+wAMf//FpT4h4fyblO2HgPVQ3zW9kzwA8kJ5FtjFwOwUILiKUtAYn/CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYkLKL8nUYjskSRUak0MLU0v5MRVlcjNQeEo1mwwDZGwcdA3K
	KQfr858Z/fiYPNwGkOAhAbNMFcdIf6BbDg8RWhVLT3Z3NV2QGM9L7Fg=
X-Gm-Gg: AR+sD134bm9J0zxy090h7q7DDTxMYZ6KD6aunBjyUhNuWXyWTwGwHkDHltp+EmCIjs3
	PRDFUWH+JiXEeMOZ8Q0SK7bzXAuOKzHJCt3T61ZPGVr5KFTUIxCtgeR2rYn87De4nClDVbaq4pH
	lYTquKRkb6h4d1quCV8sOHcw9u23tJPqIFg7Vn97YlCcnX5r/UqfwtsDqcoa605JFXipFIQxG2S
	d6u5hTt49APO3PtxJWYegLm5DRKY0w6dSwyeKYbcGPkrV4qBxv3xAoPBCUhDodvauzC/BaZYXA7
	aHF3D5UbGWXDlFBx1Ba1qhbwkcft/MTTxp/U5d7MWwSUGfJjYoAyqh6gcC3InjD4o0fQHtIZe6w
	kqLtwWG/A3kM+A7tCuu7CGFHU+VHtQxd958meyEPThbvZOkNfQoYGIwyqrVWvzhgMYMDObrGWOb
	gsabcyaNe9vp4sGcmXnbxJemeC6KCpS9eO19L6eGfmx4fR+dLyUil66ulseITfBVBrVYR0EwSyF
	sNGZLNqtgTk4s30UlnC9ok=
X-Received: by 2002:a05:6a21:497:b0:3c3:96dd:9ecc with SMTP id adf61e73a8af0-3c6c8046134mr1094107637.57.1785187114177;
        Mon, 27 Jul 2026 14:18:34 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.59.84.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314e17a6f5fsm7916699eec.31.2026.07.27.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:18:33 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 1/2] treewide: Add a flag to detect the Apple T2 chip
Date: Mon, 27 Jul 2026 17:18:02 -0400
Message-ID: <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag to detect Apple T2 chips on Intel Macs.
Cache the result to avoid repeated checks. That will
be used in upcoming patches.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/kernel/quirks.c                      | 37 ++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |  5 +++
 .../platform_certs/keyring_handler.h          |  8 ----
 security/integrity/platform_certs/load_uefi.c | 38 ++++---------------
 4 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a92f18db9610..6651e5d4d106 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -664,8 +664,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+bool has_apple_t2_chip;
+EXPORT_SYMBOL(has_apple_t2_chip);
+
+static const char * const __initconst apple_t2_models[] = {
+	"MacBookPro15,1",
+	"MacBookPro15,2",
+	"MacBookPro15,3",
+	"MacBookPro15,4",
+	"MacBookPro16,1",
+	"MacBookPro16,2",
+	"MacBookPro16,3",
+	"MacBookPro16,4",
+	"MacBookAir8,1",
+	"MacBookAir8,2",
+	"MacBookAir9,1",
+	"Macmini8,1",
+	"MacPro7,1",
+	"iMac20,1",
+	"iMac20,2",
+	"iMacPro1,1",
+};
+
 void __init early_platform_quirks(void)
 {
 	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
 			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
+
+	if (x86_apple_machine) {
+		const char *product_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+		int i;
+
+		if (!product_name)
+			return;
+
+		for (i = 0; i < ARRAY_SIZE(apple_t2_models); i++) {
+			if (!strcmp(product_name, apple_t2_models[i])) {
+				has_apple_t2_chip = true;
+				break;
+			}
+		}
+	}
 }
diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..47b27dceab18 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -6,8 +6,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * has_apple_t2_chip - whether the machine has the Apple T2 chip
+ */
+extern bool has_apple_t2_chip;
 #else
 #define x86_apple_machine false
+#define has_apple_t2_chip false
 #endif
 
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index f92895cc50f6..a355f4400179 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -45,11 +45,3 @@ efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_ty
 efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type);
 
 #endif
-
-#ifndef UEFI_QUIRK_SKIP_CERT
-#define UEFI_QUIRK_SKIP_CERT(vendor, product) \
-		 .matches = { \
-			DMI_MATCH(DMI_BOARD_VENDOR, vendor), \
-			DMI_MATCH(DMI_PRODUCT_NAME, product), \
-		},
-#endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d6948446c3..b4096d4c828d 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -3,42 +3,16 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
-#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
 #include <linux/ima.h>
+#include <linux/platform_data/x86/apple.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
 #include "keyring_handler.h"
 
-/*
- * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
- * certificates causes occurrence of a page fault in Apple's firmware and
- * a crash disabling EFI runtime services. The following quirk skips reading
- * these variables.
- */
-static const struct dmi_system_id uefi_skip_cert[] = {
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir9,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "Macmini8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacPro7,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMacPro1,1") },
-	{ }
-};
-
 /*
  * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
  * it does.
@@ -165,10 +139,14 @@ static int __init load_uefi_certs(void)
 	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
 	efi_status_t status;
 	int rc = 0;
-	const struct dmi_system_id *dmi_id;
 
-	dmi_id = dmi_first_match(uefi_skip_cert);
-	if (dmi_id) {
+	/*
+	 * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
+	 * certificates causes occurrence of a page fault in Apple's firmware and
+	 * a crash disabling EFI runtime services. The following quirk skips reading
+	 * these variables.
+	 */
+	if (has_apple_t2_chip) {
 		pr_err("Reading UEFI Secure Boot Certs is not supported on T2 Macs.\n");
 		return false;
 	}
-- 
2.43.0

