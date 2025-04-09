Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02C27BF78
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224819; cv=none; b=ATAnMvLehS7TWAMDbjivA4byk+8WFGZ2nfg3rRvC6qVjGwdsfBD7Uouj3v7bFXZizSHUss1lsVsXEB7g1dsMRxPOT13nVEeGqi4isN3MmdLqTTo5mRN18KgWldX2AGnjEPdHThohhDP0Slbqk+JozhmwnE0EXDHzTmhQd+SzmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224819; c=relaxed/simple;
	bh=KFsasiNRn/1z1Ik/t9O+JrkG0wsuT47rh8tQ1XBoYQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfmgGOQuxFUcwoiQs7dArvrN0UOUrB6YzPx7Td6qtdvMG0BAUohaD7wQbZnJXfQV+edKclVN+dQCX2r12OWtjkdsji6cWQ7eML8RgYNI3/14LcdeCeQfk13T/BNfS8z6T5bdb6MGwND07Ig1kjp6PQmqJRMjy/goNdcYQF8gKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VXlg7xM0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VXlg7xM0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5b2472969so2977685a.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224816; x=1744829616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJLTaE+oUP17ucfbeTFIwhnNa4ZodMFgNyM712ECkWE=;
        b=VXlg7xM01Vu+YrOZskLaommm3NxcTerGhA4W+6s3kqQiqFNYs7DUjFZ9nDPhBGDCNY
         jsemECSvtopm8Q18DX6LC7vcoNFaToKasw5GTXnWf7h5NLYgyncqfB798AsQr/wdYrWe
         3Tb7uJ9Jqf4W03IuE3Cbdgc0Emk8pKwdAv+W/b+NHRx0YCtbSEFLYTqMsvilZNpuqslC
         518DUH1Dbwz3qN/xANaTBhl6+iiVOBkHqgwbVQr7kamVwiScxWQX9+DZlTbgH9l3R47e
         KYj9V/Jr8wt0UiDSNmw4lLBqJsLCTnT6DFoOkhfp+zXNKkgOZBgsFRpMVhXCi5bNH5HB
         wUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224816; x=1744829616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJLTaE+oUP17ucfbeTFIwhnNa4ZodMFgNyM712ECkWE=;
        b=pZg0v0+h7jMUcM8b5UbhfAkCwtp1erL4Dp2Bmr8cVIM+hT3nAx7ZLQFF+b2Gt1N1Wa
         227inDPrwwgxzyROhIXm71SNb/Zr2HydiEHf+1c2hCAfAacN88utUgT6tGIrBLtlGnmu
         jbZdgg8a7TIE/NdpLjlqpu8cUZr9/roVGaALpgWH7whlQfKMvo7xBzI6jyIm0/Qb3zMF
         otCZSAi6Ef5Z0+7L43VzX3CzxjgMkkgzEioEOzjC7I26OJ7jJbZuzrkF3SVEMXFLm6I3
         xYUhse7q67qAzsojFdWDa3Ub1z7j/oqgTANhn/nvrWouS7lokz1s02+nt+h7+zFzytlo
         3B2Q==
X-Gm-Message-State: AOJu0YybT0wU1sVfa5NIjDabTVKvA9de3YKsB/aNUvMq8v7OSZqpxSVy
	WZWMkGgqcbm2lVgvVSrBDRBxCbaAVuhgCHO2C+JQcmezvfgHqQvzys3NE+EHMQLqm7RlbSBt5ZI
	=
X-Gm-Gg: ASbGnctZlQy27fDhe73ViF6a67IqcvhCp0R0H1eCsT5DQ9S/adV7vtodonofB/565mR
	xUvRcV/3Q4suVjkhVoSab+OR8lD/tZplSxEO8dIH54IR40lbzZMsTRQBWE56SoI6Bgzb3SVIx95
	V4+c5cxa6GLNb4LNYTPKdrb3x7v+5EvuT5hmGeosxDD3mvh/upr0yif4Vg4C93+oaCgjf1xB/Xd
	iBb8qJFpXG5zZVLlpAtnOfDy5UHJUBGIMa+Cq7Q6hodPFayforuE2eX028+mpiylmE7ngtmjoHw
	6YGv0v6bsyvp2C0M7vMlql2UJudKW9ZP6Fyufo8AgstmgtunW7Px6JeVmzB9lskqVLIkP6bS2Sh
	6N4Yv0AbLOLlhwHu2AUPV
X-Google-Smtp-Source: AGHT+IF6i9jk79i1lnBhew3sLdVjuUfx72+rGLC417exG8vWsFKh1Rd+BiDQcc1wJzSrfHcR2QHGWA==
X-Received: by 2002:a05:620a:2b8a:b0:7c5:cd0f:5c09 with SMTP id af79cd13be357-7c79cbc9686mr738512885a.7.1744224816335;
        Wed, 09 Apr 2025 11:53:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea10697sm10501726d6.108.2025.04.09.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:35 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Wed,  9 Apr 2025 14:49:52 -0400
Message-ID: <20250409185019.238841-38-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=paul@paul-moore.com; h=from:subject; bh=KFsasiNRn/1z1Ik/t9O+JrkG0wsuT47rh8tQ1XBoYQg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGTR9i1qR9/T23mFgutPDw19iGyksSAWvO+/ 40+g2TwkquJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBkwAKCRDqIPLalzeJ c9pvD/4so58JVRFvuGUnYm+kwB48bg+toZDwKdoHi99nNO+yUiYKvQ6tEXgKIZiDB4fEIk5uZl2 ABre8tOp88aUOiTSVjZQ/FTXaIK2/0O5vOgn4XFpC/JIj+iQk0xKcL3lh3iHFA+773KQoFdesc+ oDb8Nf7r4Z09e0VtXJIK0cJzcthFba8HlRbUEYO3iQrzqHLMQhZcr3FHaDCAw9HgBhQV7EJV/6C 26vZi0HY3ALkxfPzUji779qkak0vWeQia1Mm9yNNDp9xxKqq9vuJmZ3MExP3G4Q+aZ3aB1aqqgZ 5y/zflwdH/oUTW6+vs0Wcdx816qGkQgHYmLyDHU2lGS8FRcArdzqPZHvTDbzi5t0dq75/0l9jgL pA7UkE4/vQKLnhfdOkvWtlLQXo3Rv7AiWHmlOnaPx730PLTMJc+ja7j1zvutaMq7R3bTYpnB7xe xH5MmRScCcCfTaG9lJvG7JfHBrPgro3nTs4MTSOki43YXZkZuXo/B7Nj76T3sGodxh9mqflwXzI P4Shpeq/1YsaNWF78rYxsMkC8FSSAtqQdRTmfia11K0RX2UBj86lDYLMO/5gD7jVPUdP8QFQKyx ZvKOqhBXR/nTDa3CdPsXenHKJTml0NSQjTTGQ42e1wjhB3KBUU8WzYqGi+lEnwKvxdDHvbFQJPy kR4VBpbLXYB9smg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM count and lsm_id list declarations out of a header that is
visible across the kernel and into a header that is limited to the LSM
framework.  This not only helps keep the include/linux headers smaller
and cleaner, it helps prevent misuse of these variables.

During the move, lsm_active_cnt was renamed to lsm_count for the sake
of brevity.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 8 +-------
 security/lsm_syscalls.c  | 8 +++++---
 security/security.c      | 3 +++
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..8aac21787a9f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..af343072199d 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_count;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index edf2f4140eaa..981ddb20f48e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
 static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *lsm_exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -211,12 +211,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..3fb0d77ae65c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
@@ -96,7 +98,7 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 		u32, flags)
 {
-	u32 total_size = lsm_active_cnt * sizeof(*ids);
+	u32 total_size = lsm_count * sizeof(*ids);
 	u32 usize;
 	int i;
 
@@ -112,9 +114,9 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 	if (usize < total_size)
 		return -E2BIG;
 
-	for (i = 0; i < lsm_active_cnt; i++)
+	for (i = 0; i < lsm_count; i++)
 		if (put_user(lsm_idlist[i]->id, ids++))
 			return -EFAULT;
 
-	return lsm_active_cnt;
+	return lsm_count;
 }
diff --git a/security/security.c b/security/security.c
index 8d370a4c5e74..a3e8dd640b39 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_count __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.49.0

