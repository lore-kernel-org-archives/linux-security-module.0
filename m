Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B233CDB482
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Oct 2023 12:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjJRMUr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Oct 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJRMUq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Oct 2023 08:20:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62710F
        for <linux-security-module@vger.kernel.org>; Wed, 18 Oct 2023 05:20:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso23040955ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Oct 2023 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697631642; x=1698236442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo5moLBTUoQHfJoA1LKj3zHr6PsF4ViCLevZ9oHJwHI=;
        b=en8S0J2wxvLdAfpsybKy7ObQt33HTqQwxrmECeRWk0wwlY4s0Rw8G0AR2TLN9lJQnE
         mb/HHWYYZntj/0hn70tOxfyW83W8dQc5tLp8Pr2CEnuDCKNx6itxBnMRZ54VrioXEo+B
         74j+/3XewH4xR6Oc+bYGicwT1ShPFg6jlj0Do7P31ZHxjaOeV1BpAYcAPtIh78ZnVAdO
         7DtGaMTOGAxO5YSVae0SdvTv87dgNAKl5Ye/UmDHSW6AlH7z7I8DLTDFDpgGjWsqpxwH
         u4RdruVbSMBz/GdIx3BeehGA9LXMcK/eAic4TwPX0YOBK3DXdtnpDLeVBmLN+2pgv7cI
         vjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631642; x=1698236442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo5moLBTUoQHfJoA1LKj3zHr6PsF4ViCLevZ9oHJwHI=;
        b=EAD/l8fQKIAtaOTKwYpWzgoR3M+1zBAuf8TgAkcwa6oa0xzsYofzJfi725N6y0zmBr
         iv0tVpJBmgtvh6GovDvdf4fZcejnX/OVykzuCSRkAoHH9iBGFSJvCO/gPbq83DmGPPBc
         MnxOHtTlhg81+Mx2tbuKFX7JYbZiMT6HyDwFA9NOnw4K/exXM89zCdfUe91zYNlrguGU
         lpBRTeLYmo3nml3gA3YxaHD2Snn1qAoGO/dMhvgglsLmVmcOZ9pGQ5NQr1xQShgED+xS
         TTOdhty9vUwayH8YFzyxH2P+8Tx+LNp0uvctSrwusOvF2SeHZXBkAXzNw3tNgZPCzN49
         gclQ==
X-Gm-Message-State: AOJu0YxyKO8UCW59ZBSfHCj2tlcoeJZ82ehc280Lo+nd7u6hgdunrPpW
        5pTFZzFNf00BHoKdwuUJHcBm5A==
X-Google-Smtp-Source: AGHT+IH/dlKFdhiooDIWatgta3krCMDtgHat6P4/L4sS4r83UzhM2vfKuOjiKSjj/CajnMd/EpKlEQ==
X-Received: by 2002:a17:902:d3c4:b0:1ca:64f:35ff with SMTP id w4-20020a170902d3c400b001ca064f35ffmr5185792plb.48.1697631641870;
        Wed, 18 Oct 2023 05:20:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001c9b384731esm3383452pli.270.2023.10.18.05.20.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Oct 2023 05:20:41 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     serge@hallyn.com, jmorris@namei.org, peterz@infradead.org,
        cuiyunhui@bytedance.com, chris.hyser@oracle.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] capabilities: add a option PR_SET_CAPS for sys_prctl
Date:   Wed, 18 Oct 2023 20:20:06 +0800
Message-Id: <20231018122006.24899-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

By infecting the container process, the already running container is
cloned, which means that each process of the container forks
independently. But the process in the container lacks some permissions
that cannot be completed.

For a container that is already running, we cannot modify the
configuration and restart it to complete the permission elevation.
Since capset() can only complete the setting of a subset of the
capabilities of the process, it cannot meet the requirements for
raising permissions. So an option is added to prctl() to complete it.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 include/linux/capability.h |  1 +
 include/uapi/linux/prctl.h |  1 +
 kernel/capability.c        | 82 +++++++++++++++++++++++++++-----------
 security/commoncap.c       |  7 ++++
 4 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index ecce0f43c73a..b656c40b281c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -211,6 +211,7 @@ extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
+extern int _capset(cap_user_header_t header, const cap_user_data_t data, bool prctl);
 #else
 static inline bool has_capability(struct task_struct *t, int cap)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 82cb4210ba50..9a8dae2be801 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -246,6 +246,7 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+#define PR_SET_CAPS			63
 /* Clone and personalize thread */
 #define PR_PERSONALIZED_CLONE		1000
 /* Isolation eventfd & epollfd during fork */
diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..968edd8b3564 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -201,25 +201,29 @@ SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
 	return ret;
 }
 
-/**
- * sys_capset - set capabilities for a process or (*) a group of processes
- * @header: pointer to struct that contains capability version and
- *	target pid data
- * @data: pointer to struct that contains the effective, permitted,
- *	and inheritable capabilities
- *
- * Set capabilities for the current process only.  The ability to any other
- * process(es) has been deprecated and removed.
- *
- * The restrictions on setting capabilities are specified as:
- *
- * I: any raised capabilities must be a subset of the old permitted
- * P: any raised capabilities must be a subset of the old permitted
- * E: must be set to a subset of new permitted
- *
- * Returns 0 on success and < 0 on error.
- */
-SYSCALL_DEFINE2(capset, cap_user_header_t, header, const cap_user_data_t, data)
+static int __capset(struct cred *new,
+	       const struct cred *old,
+	       const kernel_cap_t *effective,
+	       const kernel_cap_t *inheritable,
+	       const kernel_cap_t *permitted)
+{
+	new->cap_effective   = *effective;
+	new->cap_inheritable = *inheritable;
+	new->cap_permitted   = *permitted;
+
+	/*
+	 * Mask off ambient bits that are no longer both permitted and
+	 * inheritable.
+	 */
+	new->cap_ambient = cap_intersect(new->cap_ambient,
+					 cap_intersect(*permitted,
+						       *inheritable));
+	if (WARN_ON(!cap_ambient_invariant_ok(new)))
+		return -EINVAL;
+	return 0;
+}
+
+int _capset(cap_user_header_t header, const cap_user_data_t data, bool prctl)
 {
 	struct __user_cap_data_struct kdata[_KERNEL_CAPABILITY_U32S];
 	unsigned i, tocopy, copybytes;
@@ -266,11 +270,17 @@ SYSCALL_DEFINE2(capset, cap_user_header_t, header, const cap_user_data_t, data)
 	if (!new)
 		return -ENOMEM;
 
-	ret = security_capset(new, current_cred(),
-			      &effective, &inheritable, &permitted);
-	if (ret < 0)
-		goto error;
-
+	if (!prctl) {
+		ret = security_capset(new, current_cred(),
+				&effective, &inheritable, &permitted);
+		if (ret < 0)
+			goto error;
+	} else {
+		ret = __capset(new, current_cred(),
+				 &effective, &inheritable, &permitted);
+		if (ret < 0)
+			goto error;
+	}
 	audit_log_capset(new, current_cred());
 
 	return commit_creds(new);
@@ -279,6 +289,30 @@ SYSCALL_DEFINE2(capset, cap_user_header_t, header, const cap_user_data_t, data)
 	abort_creds(new);
 	return ret;
 }
+EXPORT_SYMBOL(_capset);
+
+/**
+ * sys_capset - set capabilities for a process or (*) a group of processes
+ * @header: pointer to struct that contains capability version and
+ *	target pid data
+ * @data: pointer to struct that contains the effective, permitted,
+ *	and inheritable capabilities
+ *
+ * Set capabilities for the current process only.  The ability to any other
+ * process(es) has been deprecated and removed.
+ *
+ * The restrictions on setting capabilities are specified as:
+ *
+ * I: any raised capabilities must be a subset of the old permitted
+ * P: any raised capabilities must be a subset of the old permitted
+ * E: must be set to a subset of new permitted
+ *
+ * Returns 0 on success and < 0 on error.
+ */
+SYSCALL_DEFINE2(capset, cap_user_header_t, header, const cap_user_data_t, data)
+{
+	return _capset(header, data, false);
+}
 
 /**
  * has_ns_capability - Does a task have a capability in a specific user ns
diff --git a/security/commoncap.c b/security/commoncap.c
index 482807dec118..dd7f058e7d03 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1266,6 +1266,13 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
 		return commit_creds(new);
 
+	case PR_SET_CAPS:
+		if (unlikely(!access_ok((void __user *)arg2, sizeof(cap_user_header_t))))
+			return -EFAULT;
+		if (unlikely(!access_ok((void __user *)arg3, sizeof(cap_user_data_t))))
+			return -EFAULT;
+		return _capset((cap_user_header_t)arg2, (cap_user_data_t)arg3, true);
+
 	case PR_CAP_AMBIENT:
 		if (arg2 == PR_CAP_AMBIENT_CLEAR_ALL) {
 			if (arg3 | arg4 | arg5)
-- 
2.20.1

