Return-Path: <SRS0=SHQt=5T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58525C2BA15
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1D2077D
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ugedal.com header.i=@ugedal.com header.b="JYtJwflt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDCRzm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:55:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46802 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCRzm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Apr 2020 13:55:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so7792050ljg.13
        for <linux-security-module@vger.kernel.org>; Fri, 03 Apr 2020 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPIH9Cepkvfx+qnRWFWOtOody6sfKssdMr1NGqEz4tY=;
        b=JYtJwfltQr8Gy7OcS6GPL1nxZiPr6yZsZVksURjdfhhaIOMAvowZok4L/vE6sJ1+KT
         ux3maGBK7iXLCNElB/EPonnQYhUDwD1FjJ86tQSvKoVL98kTwWToj4VlflIvYTKUKd/L
         f3tuRC18LMu25zYYrYN1dU84yP41jsHanLBa/5k/P9nxOV/rM/vPmEgo0IulFCcHhwWG
         /rN4xbDZ2Wk7p6qik4ctf/3NBqy4Z0ee5iUPBwltKmFKYIh8ZCvsOszFGnWyv8aamKTU
         kXD0uwh5+NQCLnwXLupvvY/Ed3v+zQlkBHRVCntRbvdtBCpmaoe7nAtUh1AwNqKr8WZx
         UQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPIH9Cepkvfx+qnRWFWOtOody6sfKssdMr1NGqEz4tY=;
        b=e7R2Xv4pP1Gjv/X47rXiOhqGVexkjPuV5A8KY15dYWcf8Rb1Y1dwXUjrGeU/+QIIIP
         u8Y5t51SS8Z/hi+QNFeZxnUQh8NbpdF7rKohmWZjKGi5gFyYITXApGap/mJ7fxcl+wFe
         blLP8+HykO3fbgvyK9cqHrWusSMmSFesTIOArk5RsXyT6TzVsNOWBc28xoMj8qjK1uPm
         JeBuL1aXrrktHwrul89Uqvm5yOdM1wyxuFVJ1ty2rF/xhlL9lwxkExHVIKrDcdSp50kw
         TvM41zmJqoqA54QbW+rjj9/LkwCz4qO4yltVq8LiMRkvVAGQb4v9IzMKaGIsL94JOzSO
         PQXA==
X-Gm-Message-State: AGi0PuYUb+Xe/Kj0kBTKO+wSqoc7az44Pc6quFZwkLsm9Ra4D74cCWYi
        +Hh+Q0Cfvj7U09a3iu8dajWdNA==
X-Google-Smtp-Source: APiQypLCS+GwPGR8/cw+HpaBaDNdQMQ2twj7URTyHCsJPzGMMY5IVfeNWB6r16JXEq/68SuRQcA+bA==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr5165463lji.250.1585936538737;
        Fri, 03 Apr 2020 10:55:38 -0700 (PDT)
Received: from xps13.lan (238.89-10-169.nextgentel.com. [89.10.169.238])
        by smtp.gmail.com with ESMTPSA id q20sm5267600ljj.66.2020.04.03.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:55:37 -0700 (PDT)
From:   Odin Ugedal <odin@ugedal.com>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        Harish.Kasiviswanathan@amd.com, guro@fb.com,
        amd-gfx@lists.freedesktop.org
Cc:     Odin Ugedal <odin@ugedal.com>
Subject: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
Date:   Fri,  3 Apr 2020 19:55:28 +0200
Message-Id: <20200403175528.225990-1-odin@ugedal.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Original cgroup v2 eBPF code for filtering device access made it
possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
filtering. Change 
commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
reverted this, making it required to set it to y.

Since the device filtering (and all the docs) for cgroup v2 is no longer
a "device controller" like it was in v1, someone might compile their
kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
filter will not be invoked, and all processes will be allowed access
to all devices, no matter what the eBPF filter says.

Signed-off-by: Odin Ugedal <odin@ugedal.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 include/linux/device_cgroup.h         | 14 +++++---------
 security/Makefile                     |  2 +-
 security/device_cgroup.c              | 19 ++++++++++++++++---
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4a3049841086..c24cad3c64ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1050,7 +1050,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);
 /* Check with device cgroup if @kfd device is accessible */
 static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 {
-#if defined(CONFIG_CGROUP_DEVICE)
+#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
 	struct drm_device *ddev = kfd->ddev;
 
 	return devcgroup_check_permission(DEVCG_DEV_CHAR, ddev->driver->major,
diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index fa35b52e0002..9a72214496e5 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/fs.h>
-#include <linux/bpf-cgroup.h>
 
 #define DEVCG_ACC_MKNOD 1
 #define DEVCG_ACC_READ  2
@@ -11,16 +10,10 @@
 #define DEVCG_DEV_CHAR  2
 #define DEVCG_DEV_ALL   4  /* this represents all devices */
 
-#ifdef CONFIG_CGROUP_DEVICE
-int devcgroup_check_permission(short type, u32 major, u32 minor,
-			       short access);
-#else
-static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
-					     short access)
-{ return 0; }
-#endif
 
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
+int devcgroup_check_permission(short type, u32 major, u32 minor,
+			       short access);
 static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 {
 	short type, access = 0;
@@ -61,6 +54,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t dev)
 }
 
 #else
+static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
+			       short access)
+{ return 0; }
 static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 { return 0; }
 static inline int devcgroup_inode_mknod(int mode, dev_t dev)
diff --git a/security/Makefile b/security/Makefile
index 22e73a3482bd..3baf435de541 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
-obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
+obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 
 # Object integrity file lists
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 7d0f8f7431ff..43ab0ad45c1b 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -15,6 +15,8 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 
+#ifdef CONFIG_CGROUP_DEVICE
+
 static DEFINE_MUTEX(devcgroup_mutex);
 
 enum devcg_behavior {
@@ -792,7 +794,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
 };
 
 /**
- * __devcgroup_check_permission - checks if an inode operation is permitted
+ * devcgroup_legacy_check_permission - checks if an inode operation is permitted
  * @dev_cgroup: the dev cgroup to be tested against
  * @type: device type
  * @major: device major number
@@ -801,7 +803,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
  *
  * returns 0 on success, -EPERM case the operation is not permitted
  */
-static int __devcgroup_check_permission(short type, u32 major, u32 minor,
+static int devcgroup_legacy_check_permission(short type, u32 major, u32 minor,
 					short access)
 {
 	struct dev_cgroup *dev_cgroup;
@@ -825,6 +827,10 @@ static int __devcgroup_check_permission(short type, u32 major, u32 minor,
 	return 0;
 }
 
+#endif /* CONFIG_CGROUP_DEVICE */
+
+#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
+
 int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
 {
 	int rc = BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
@@ -832,6 +838,13 @@ int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
 	if (rc)
 		return -EPERM;
 
-	return __devcgroup_check_permission(type, major, minor, access);
+	#ifdef CONFIG_CGROUP_DEVICE
+	return devcgroup_legacy_check_permission(type, major, minor, access);
+
+	#else /* CONFIG_CGROUP_DEVICE */
+	return 0;
+
+	#endif /* CONFIG_CGROUP_DEVICE */
 }
 EXPORT_SYMBOL(devcgroup_check_permission);
+#endif /* defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF) */
-- 
2.26.0

