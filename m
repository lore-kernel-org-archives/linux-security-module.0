Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51E23B622
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140278; cv=none; b=JVu3MOhZ/CB/amnRvmZIk7I1PYNjkRAWfeXwsP+PgRs+2XzAzUu8menRc+d5SWcw2+kQlVHRJGSr3VT0crQSlOXBgpmK8bYNngDnRnR5pD8zDMPVWZrYKiRsOCCyK1tVCXBdjXQQjfeTbAWR3GU0IdHYuevqoiwru3NhGS6/v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140278; c=relaxed/simple;
	bh=UixOHxs80Kf+tYLuKKt9LadkCYF6HHkhv5JXvD5s0uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8GdGwD/xmS5eTY5pUBDVEBKRnzDus5/k5QpZRmbV9lY+gDaswmhUBRMFhE7ko2c9P4RY4a2qgP4K/Wz4KL1uQD0gvR6Xv61cXRbR+WEr55abB4o55omKcFBrISXdUC7grbeKRlYqBnAL1TBdirTkQarv7wkeuABlMIh3o119ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QZMnJBX0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QZMnJBX0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d45f5fde50so432957785a.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140276; x=1753745076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+Ol4Bn1f1VUTnar0XIBvx4KlRPVW1PlfX21PI6M1xI=;
        b=QZMnJBX0ddma54Zu76b6F0zv9AbMjmUeHg7zL1t5kESJ+JLp7P7s5gJocuhTgsXZEI
         x0SlxsJPA2DlC69hHNMHr6OfqStIiz0djPBCBzx8oSwJwFNXaAqQ2RCBchn2+umRwhBs
         TEdqkSiIm0htoCGvs2e2ydDjecmH4WGvxyDtpr0SasNS3pqc5tHXKz+7juhBXPSNnd7I
         k23cWQG8uDx/bA0GAgqrZr9BDlFoegrVfT8CEhvmvjP8qxnigD8b6KRzgyXh18eWdnj4
         mFCgk+dfPaP4Er3qMHAG5EhIAkvCrApKWFkooa4rnK859bqL7uNnH+3B3jG4L2zRgVEU
         i1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140276; x=1753745076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+Ol4Bn1f1VUTnar0XIBvx4KlRPVW1PlfX21PI6M1xI=;
        b=YMypEEwol+4k4znobzwbbfqg3o0VgMEezjUfAHAUt1hDZDzyjtYElm7bp5yVaOE/lj
         dQc+Qf/SsQ0HnqKbRfW/c2aw9S7ggiQ6GpvgYS3uLeYMsdrJfj5FVQ0Ey9FIrWyrrPsr
         HQWfTHAQzN8FgOxpohpcK9dtCOmesRRLcQPz86p6GBl/Ojw9aZ5HstdNbb9xZGId3rhw
         rO7/NAk5pE5UZ2PTXu4JGfVKnxeMPpY7S4ac9CaR4b8VAzuIf4hbhVdUQy+bfNvgOP0B
         Zvo2jjTdnjIQCKi4Cmp9m8G6eeqPzXZTlPksTFe+4YiVjDiaS+irJv4M2GJeJU3BC0Z5
         iQXA==
X-Gm-Message-State: AOJu0YxFWCmbiYDG2VscG/up0yT1wbBFpI5KWCVragazIw9n0KUN9K0t
	AiGU3864jcbphBDOXa54wAhKmPOWdH0EWW128pImnsMZshhdsCMgHzEvIhNWkTk2/vzZsSc3ZUH
	YeT0=
X-Gm-Gg: ASbGncv43zcuY6Tt9Bq/r6AyLJXrWt6neL2Rrptr7vhfthQ82HF1JFqqTfKsrV6pwEU
	jDRbeM/3+jeQToFiVNrLm13dNZLcMIBEQFXCuhlc84o3fkGae8Vo+t2/bsy+HxbJQzyzDHZVZ17
	ltVvkJwFX09Q6wqlgV5PiipYTD/CVZA3FD3IlLSs8giQks6lXuTqCs5p2McFgVq4khcZSnqTPpS
	n+zKKtJlQIno+CsX5x2lFXKnDBubaO7/Z/CRBgZ0QYvCJOCJyKOSgh4Y9P/ZaQDjVUSI0+pqb17
	Za4rdeV4JhQ9TFfx9lWnqleTYkOC3xrA7ZskUCcMwKW1V+cK0TC86nT1yTxB81SkF7TQD56GKl7
	JLezhLecoUV2gSiiqq7T0p4U8jGVcgqxqh1UWa24x5EQEGiLBHgbjkN1txlRBOGDFIek=
X-Google-Smtp-Source: AGHT+IF2vMeo2ybbnhrEnWvRrNcCLGlzINCAN8UFu1xRPYQVTYkUpylnJpZeesCObRAHv4ym88xxtg==
X-Received: by 2002:a05:620a:4050:b0:7dc:63f9:4b27 with SMTP id af79cd13be357-7e362b56dd0mr1405741885a.32.1753140275556;
        Mon, 21 Jul 2025 16:24:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356cbaf67sm463456785a.107.2025.07.21.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:35 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 33/34] lsm: consolidate all of the LSM framework initcalls
Date: Mon, 21 Jul 2025 19:21:36 -0400
Message-ID: <20250721232142.77224-69-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=paul@paul-moore.com; h=from:subject; bh=UixOHxs80Kf+tYLuKKt9LadkCYF6HHkhv5JXvD5s0uU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsv8m4dg85BXHVA4WDQFLKXqOQH23bvhbJJBc iEkcveCP9SJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L/AAKCRDqIPLalzeJ c/1SEACj4iZ9Qu0t9VldeEpWVFB3EDHwJeRutkafQpbwChl7ba99JaTm7WaZKwlNdTFYwW4ZNxz VzsfAg6hXQwvGPrNQkuTEZVbqEgcFeXL3A7Zu1/hJBf2LCDuaGRpTf5/pq35yrts5iNRr+myppF k5TM9QcBqA3wEyl3ehI/Y3XNJLIwrtrljV/KpRP3b0MvWcvPLCd3trxYcd7eFuL0H/sB6QXtoyP /jP6yVzklx4q9am4eWP8moPEgdH1JlDSzF38O6c31xxAnYGX+GUeMGKhp3i+auF0e9nT3q18Nbe 6iCfGgCRIiaMIMcHIrQo1ty1nPbv8e9yQl1pCab0TAnbjffDuuh0m5iATHoyxvtEjaCqKntNGsd mhZD7VqT3ZfyQXeQisbmI7Rw4BsGRsFFQSLJMLxoFAjapJUumSDOi/OnzIWjZRijGJe+ecgQYvV a1s4+zlkh6MhkUQdXI+b/BEuilGsr3GKO/enF2pXrBDIyWaOhuy44owSv6KIEFNMWw+GQb7oIO3 ovvnt0SGv2HI26/Ng07s4Jdy33TZBOhimZpeADNrIt6X6xGHkbtVigKtkkcdC/BpcX1wa8u3FS7 F3sBPSJSrBrKN4U0pr4K4hgd8NiZLHQRBR9YxI8qApFKlnUzNXdn+F1lXaNbVGifrK50l2uwrLE k/mlFrhgJjuPZuQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 68ee6c9de833..d15a0b0f4b14 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -408,7 +408,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -427,4 +427,3 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-core_initcall(securityfs_init);
diff --git a/security/lsm.h b/security/lsm.h
index 8dc267977ae0..436219260376 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
 int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 int lsm_task_alloc(struct task_struct *task);
 
+/* LSM framework initializers */
+int securityfs_init(void);
+int min_addr_init(void);
+
 #endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index ab739f9c2244..f178a9a2f9d4 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -482,7 +482,12 @@ int __init security_init(void)
  */
 static int __init security_initcall_pure(void)
 {
-	return lsm_initcall(pure);
+	int rc_adr, rc_lsm;
+
+	rc_adr = min_addr_init();
+	rc_lsm = lsm_initcall(pure);
+
+	return (rc_adr ? rc_adr : rc_lsm);
 }
 pure_initcall(security_initcall_pure);
 
@@ -500,7 +505,12 @@ early_initcall(security_initcall_early);
  */
 static int __init security_initcall_core(void)
 {
-	return lsm_initcall(core);
+	int rc_sfs, rc_lsm;
+
+	rc_sfs = securityfs_init();
+	rc_lsm = lsm_initcall(core);
+
+	return (rc_sfs ? rc_sfs : rc_lsm);
 }
 core_initcall(security_initcall_core);
 
diff --git a/security/min_addr.c b/security/min_addr.c
index df1bc643d886..40714bdeefbe 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -4,6 +4,8 @@
 #include <linux/security.h>
 #include <linux/sysctl.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
 	},
 };
 
-static int __init init_mmap_min_addr(void)
+int __init min_addr_init(void)
 {
 	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
 }
-pure_initcall(init_mmap_min_addr);
-- 
2.50.1

