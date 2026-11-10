Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315361;
	b=sPu2caBAD54va5FbYUIr8UQwUHushFS1wQKL7L7ry1D89sFfYm56oOC4brxYm/jvVkvG
	 nEz5j3pF4RXwTvIXozC3aF55pAK+CWHTa9FHOU5i6OB5635prz4pprTkmK5uItDeCAg31
	 dienN7JVWjLUMHzWH31rMB2cH7qAioE4Qj1aIbJxptNgfeZeqSBFa5gCYCbI8EsETC3kY
	 UCsXS+NNqn4r8FPokiXb84yuxa2nfKGA5O4LXqZW4wbuhSlE64FlmsmXUkLpBEEJXRf28
	 R8Uzk57jfx5CJPo3bsBA3EMokVsXCsh8Dza0uwelBZwAIvHEdz51dD6evk2zpce+cWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315361;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Gm+8tToVxO37l40qhkGEFIY1RUf+AkCz+n5M8aC9Rww=;
	b=lhxTesSMImMsphbw1RToQjt3XSIG98WdF16p0kJ4r5uDPPYdGwc8/kprFYBk98hOmoKT
	 TJc3rlfOCeIZF9gNscK2dDAIhVLiNRL7XthgAvkOMqt4bz2iOr+wTICjRSiYc2ICME537
	 lMg1vXzT4vrhusp7iFK9u+Ba+OlJaZZrqDfo9Pm3+Uq12ZAOtEj88SzUmE3pwDEZKACGf
	 Y7scTFjWdYZmqbsetM2X/R8Q53yviY1TH7h1dZAP7u0oTWIMQp8P5+sglle47cLvT/oGS
	 ZVzie8zvcndVzNTFaTS7EFRVHvWsV1WS7z4W9gjpVzHwCP9Crw2aYmCy+Er0trJChEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gvDCp8bc;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB560A380F;
	Tue, 10 Nov 2026 12:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FAB560A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gvDCp8bc
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Gm+8tToVxO37l40qhkGEFIY1RUf+AkCz+n5M8aC9Rww=;
	b=gvDCp8bcgfOutE/NN5spoGdTmstDuYWqPSbI8e4LMnwbPyABybzBFU3RPAtAPaY8PYxCNmfQg
	eceGKC03RJlYwG4VyeIVKDf+OOQZI+dpQAE9CvxCEBPHgpDTadwQo1RetI+tYwbv8eVs6q+lLrx
	Wz1VzgiZXR/XiQk5DsCBF5A=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jP68G1FnZz1cynl;
	Tue, 10 Nov 2026 20:55:42 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FD794058E;
	Tue, 10 Nov 2026 20:55:57 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:55 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 6/8] lockdown: bound the status string with scnprintf
Date: Tue, 10 Nov 2026 21:28:16 +0800
Message-ID: <20261110132818.2231593-7-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261110132818.2231593-1-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

Use scnprintf() instead of sprintf() when composing the lockdown status
string in lockdown_read().  The current set of levels fits well within the
80 byte buffer, but sprintf() provides no protection if more or longer
labels are added later.  scnprintf() makes the buffer bounds explicit.

Store the level label strings in named arrays and point the matching
lockdown_reasons[] entries at them.  Their sizes are compile-time
constants, so a BUILD_BUG_ON() can verify that the status buffer is large
enough for all level labels, their trailing spaces, and the brackets
around the active one.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/lockdown.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 84efd533fe5a..26cac7628a48 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -14,13 +14,17 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+static const char lockdown_label_none[] = "none";
+static const char lockdown_label_integrity[] = "integrity";
+static const char lockdown_label_confidentiality[] = "confidentiality";
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
@@ -41,7 +45,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
 	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
 	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
-	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_INTEGRITY_MAX] = lockdown_label_integrity,
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
@@ -50,7 +54,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_TRACEFS] = "use of tracefs",
 	[LOCKDOWN_XMON_RW] = "xmon read and write access",
 	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
-	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
+	[LOCKDOWN_CONFIDENTIALITY_MAX] = lockdown_label_confidentiality,
 };
 
 static enum lockdown_reason kernel_locked_down;
@@ -137,6 +141,16 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 	char temp[80] = "";
 	int i, offset = 0;
 
+	/*
+	 * Size the buffer for the worst case: the active level is
+	 * confidentiality, with brackets and trailing spaces, plus the
+	 * terminating NUL.  The label sizeof() values include their own
+	 * NULs, so only three more bytes are needed.
+	 */
+	BUILD_BUG_ON(sizeof(temp) < sizeof(lockdown_label_none) +
+				    sizeof(lockdown_label_integrity) +
+				    sizeof(lockdown_label_confidentiality) + 3);
+
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
 		enum lockdown_reason level = lockdown_levels[i];
 
@@ -144,9 +158,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
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

