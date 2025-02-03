Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159919938D;
	Mon,  3 Feb 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608188; cv=none; b=SDMmGS15bmPyIfvxSvCRFQuzb+xhdv1y6KSl9OBW63GetkKq5QESoacmXNgh9P5J+ZRAzclF9Iw0exqNqXguddLXsXl0OE41IlUt+l1cutewOhCtMD9O13vIsQZJxFXSMQAfQAafCYDtIqaNYRCUEFeJyeVRrek6BzwkcxFRgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608188; c=relaxed/simple;
	bh=ZV4vYEbQIpjD72/RY85S+Dgnqd0a77LyHi+94XZNKi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzCukXwhd6Ry+FmBKDVDvbgpPNCLUacDvIGMJkQx8kWD3eB+GOVFVdvscmXCV1oiGTI7jtaV78SZTWF8/3OvL4NInd1Et9i1inJiGlsXFDQrBlYb0sNQgv0KrCBtfzdpcfT3Jm7+op/tEThpHA0KoJqBSohLxYVDnDIoACOBELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bNj80hcA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bNj80hcA"
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09A19205493C;
	Mon,  3 Feb 2025 10:43:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09A19205493C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738608185;
	bh=KbbzVWtcOJ7Gt1QLNcb0WLEL7b64gQxfibl1JZ8EMTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNj80hcAhiATBlbzHimaIioftHHv3CwJh7ZMwrB+kcXp6Oy2x/dt0hf/677kesmU2
	 NnHosZZl8RgyT32j/3taEM3mkTC11LVrBx+2fz8IRL3fDTzf3oVkTYrfZQT6xHxQQw
	 0/rWVXvWmkNUtTEvZWc/q5tt2g8wyQtcgw8p/uiM=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	inux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 6/7] ima: make the kexec extra memory configurable
Date: Mon,  3 Feb 2025 10:42:55 -0800
Message-Id: <20250203184256.61285-7-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203184256.61285-1-chenste@linux.microsoft.com>
References: <20250203184256.61285-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra memory allocated for carrying the IMA measurement list across
kexec is hard-coded as half a PAGE.  Make it configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added during
kexec soft reboot.  Ensure the default value of the option is set such
that extra half a page of memory for additional measurements is allocated
for the additional measurements.

Update ima_add_kexec_buffer() function to allocate memory based on the
Kconfig option value, rather than the currently hard-coded one.

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     | 10 ++++++++++
 security/integrity/ima/ima_kexec.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..54b145ae6096 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int "Extra memory for IMA measurements added during kexec soft reboot"
+	depends on IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value, an extra half a page of memory for those
+	  additional measurements will be allocated.
+
 endif
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d5f004cfeaec..c9c916f69ca7 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -128,22 +128,26 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
-
+	unsigned long extra_size;
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added during kexec.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
+		extra_size = PAGE_SIZE / 2;
+	else
+		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
+	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
+
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
-					   PAGE_SIZE / 2, PAGE_SIZE);
+		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
 		pr_err("Binary measurement list too large.\n");
-- 
2.25.1

