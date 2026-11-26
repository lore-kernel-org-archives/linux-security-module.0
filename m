Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697242;
	b=lQEYaGEjCIC1u3A1nIQXRHdNJxiAd5Rqf36+6uFGDoRiBiJyIAEOvg6psfocQj04vUiD
	 +H/gz0LhA8lixPgAl+0sW0QwUJ3mg0uO9nkGKCocBDKkpIiMj8hYBdIeSV5Uuc5/Ob6fg
	 XU7WrdNNWvPrPWXXvI5eOrPXWlsNT3AoyPhYBtVjW5aTrB8Qxp/tF6qR3DoqMdlY/ZAXV
	 pj77jJ9vAWK5Mm7TkZbZIH7D+iHusZKVIC3fUZs/xHg2R2//aZvt9M9QdUCCTInNLe5qw
	 KY24pJOMdB53L6HrQ97+2xP/dUY3ufi/VTjyl/ALW2N3GE0RP/852Al2UvkWvXtWCjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697242;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=9iC3EQ6PWUX1MlYo+EdDF9RRpiJ2TSYT4pJkMosVSGw=;
	b=HO35Z1ydPi/HAxWirMeWWCjA+vDy7NQxCvAGKzMYR0oQS4d3kSCk8IyTMunWqPy+4rU1
	 ZC8gcSw18eUj04XzAmp69F7RXFVyCObjx0hJujyHugnKC+bv1WAKi5ZwfhlIwUbbSVExN
	 wTWZPpw1YfeMV3WkK3o/OInJ5Dc/noT2GFmm/VJu7+uZZT1u8ooO7V8tfO37bWIqJXj4d
	 AfloX4ghh/JxlieeG9P6uf2JukYGa9W3vxEEVXzcSZnosCPF9ZP/wkIQvqtJR2SWu5tOA
	 aTFyIKiYzr0jhf19zKsmUSjpCBd8qAlxDozLQt91qhAn8+kecRvnJ7CNEYvIOltLmQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ho4xMvG4;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D01606A68E;
	Thu, 26 Nov 2026 12:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D01606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ho4xMvG4
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9iC3EQ6PWUX1MlYo+EdDF9RRpiJ2TSYT4pJkMosVSGw=;
	b=Ho4xMvG4iCOlvumRtiuat55uHulz3MfMvUxnd+olQLc8Xv8swLqCDgAl2S2Q0Nygywgsqp+PH
	qu2oWSF2nJoFlhlfTjZiIbgh5pQe+riinFWwhm71ENyT5/ZO42522Co0aC24SSeDhygBgU6Hh/9
	7Zt3oFTo7DuLwcSNenE9hzs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jZxBk313YzLlTW;
	Thu, 26 Nov 2026 20:46:54 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 0539E40578;
	Thu, 26 Nov 2026 20:47:19 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:17 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 6/8] lockdown: bound the status string with scnprintf
Date: Thu, 26 Nov 2026 21:13:13 +0800
Message-ID: <20261126131315.1256553-7-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261126131315.1256553-1-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100010.china.huawei.com (7.152.184.41)

Use scnprintf() instead of sprintf() when composing the lockdown status
string in lockdown_read().  The current set of levels fits well within the
status buffer, but sprintf() provides no protection if more or longer
labels are added later.  scnprintf() makes the buffer bounds explicit.

Store the level label strings in named arrays and point the matching
lockdown_reasons[] entries at them.  Their sizes are compile-time
constants, so the status buffer itself can be sized for the string it
holds: all three level labels with their trailing spaces, the
brackets around the active one, and the terminating NUL.  Whichever
level is active, the string has the same length.  The label sizeof()
values include their own NULs, so only three more bytes are needed.

Suggested-by: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/lockdown.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 84efd533fe5a..239dbcdbabb4 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -14,13 +14,28 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+static const char lockdown_label_none[] = "none";
+static const char lockdown_label_integrity[] = "integrity";
+static const char lockdown_label_confidentiality[] = "confidentiality";
+
+/*
+ * The size of the lockdown status string: all three level labels
+ * with their trailing spaces, the brackets around the active one,
+ * and the terminating NUL.  Whichever level is active, the string
+ * has the same length.  The label sizeof() values include their
+ * own NULs, so only three more bytes are needed.
+ */
+#define LOCKDOWN_STATUS_LEN	(sizeof(lockdown_label_none) +		\
+				 sizeof(lockdown_label_integrity) +	\
+				 sizeof(lockdown_label_confidentiality) + 3)
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook, used for the denial message and the
  * securityfs status file.
  */
 static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
-	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_NONE] = lockdown_label_none,
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
@@ -41,7 +56,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
 	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
 	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
-	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_INTEGRITY_MAX] = lockdown_label_integrity,
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
@@ -50,7 +65,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_TRACEFS] = "use of tracefs",
 	[LOCKDOWN_XMON_RW] = "xmon read and write access",
 	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
-	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
+	[LOCKDOWN_CONFIDENTIALITY_MAX] = lockdown_label_confidentiality,
 };
 
 static enum lockdown_reason kernel_locked_down;
@@ -134,7 +149,7 @@ static int __init lockdown_lsm_init(void)
 static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			     loff_t *ppos)
 {
-	char temp[80] = "";
+	char temp[LOCKDOWN_STATUS_LEN] = "";
 	int i, offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
@@ -144,9 +159,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			const char *label = lockdown_reasons[level];
 
 			if (kernel_locked_down == level)
-				offset += sprintf(temp+offset, "[%s] ", label);
+				offset += scnprintf(temp + offset,
+						    sizeof(temp) - offset,
+						    "[%s] ", label);
 			else
-				offset += sprintf(temp+offset, "%s ", label);
+				offset += scnprintf(temp + offset,
+						    sizeof(temp) - offset,
+						    "%s ", label);
 		}
 	}
 
-- 
2.18.0.huawei.25

