Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1314DC77B73
	for <linux-security-module@archiver.kernel.org>; Thu, 25 May 2023 03:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEYDUA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 May 2023 23:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDT7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 May 2023 23:19:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39601E2
        for <linux-security-module@vger.kernel.org>; Wed, 24 May 2023 20:19:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75b0f2ce4b7so25427185a.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 May 2023 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684984795; x=1687576795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cap8Fel5H4s2ygpDdeoMiarQBoZS/MdP1FsLb/vya+A=;
        b=OBsNOilsD70ikYcJ4FCGlF6pWHrBUbhcP4SOtj7UARR/Ci9wKmb+ClV3i5caprrfJy
         cAvdojnhriAM0hwa9gpI5gI8OBkeE2RgZv5FQidKlQk7skITH+JSGlDC7UNPXhZbWE8u
         kEM0UjyKjTGLjFkktGo+ocbHIS/66yqkpqRuyIS/yKXjWY8dwCwyaARZliOsw7Af+dSw
         JZbfWFazsYMQYoUAooMaBCoS9iryeqB7eyd5j2jM4tt3zzfv8lKW6TM31HO3BPrNIYsn
         J9z4It79SG02wUECkPix5AOqDT9iMcFL8W7J+Uu/9VEg/6rpObgyUBJXRBAA6kptgh/C
         SJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684984795; x=1687576795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cap8Fel5H4s2ygpDdeoMiarQBoZS/MdP1FsLb/vya+A=;
        b=O/7p/jXj0AEq3jx0nYYqTwvic8vz8jSTi8SijrmR8lOQOq1fipSXQUV930MweqaHvo
         x5SQ41pYmBT4KEy/XDMIkSowjyRjo7t3Cf+JvtD1B/qO51/6pFZp8Xsvgj7br1j4kGUK
         x2pMA3LTu6mRXenqdqfjsZG9BlXwTunuWnYEC4n/ATjT7H8vzPm2XRYrl7XMuILoBbsu
         muBsAlRlXGWpfN7i/HnBe5SpQcyazUBI5dlQdGNXoJHS0Uh49DE9vAb0xupKcnaIPalm
         w1Rt2Qt8tNp2HrweutShpYo+ZBI9XgkldoHO5HaL2sV+vtWrqyKv3fhLtXHIQCW00wTz
         yT3g==
X-Gm-Message-State: AC+VfDx+Y0UTPX80Qe770VENdi3eyDZUVJsoa3IhEQX3PyE/TbsSMN/S
        iSntgbJWEX7CoJqT5cip7NIgfqAcx15b72CpLw==
X-Google-Smtp-Source: ACHHUZ56IQke9JtoPMb/baeOsPud62jS7cfMfSwWKcW/A/8akUTVf447hCE5HwawOiP4hKqx6i2xNQ==
X-Received: by 2002:a05:6214:1309:b0:623:71d0:95 with SMTP id pn9-20020a056214130900b0062371d00095mr107543qvb.42.1684984795141;
        Wed, 24 May 2023 20:19:55 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id pr2-20020a056214140200b006238d903f9bsm89451qvb.42.2023.05.24.20.19.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 20:19:54 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: fix a number of misspellings
Date:   Wed, 24 May 2023 23:19:53 -0400
Message-Id: <20230525031953.105125-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5951; i=paul@paul-moore.com; h=from:subject; bh=7SO3qhexMR1O0sA+m+PiXr3A0lVFugGw8N2ye6RCRYw=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkbtPQwHKtHC/JFFag2hawYdF9kWud/dRuWsZLG S3PF0eDQhSJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZG7T0AAKCRDqIPLalzeJ c2PoEACmAFoW63h8MZ8exH5+EtIoROSz6HdT3U/vVk2P+wWBWXEjisbQQ/oKtiiTknndSLbnLXp oDzrRtwwkgM8/tS63ZMfxjAjNWiqRgrivxzsyRcUifeSrqQ8p5QKKgcBwiRQHBNWBSKQRNc0kKP qrURLRAx2jpqSZ2sY/TalCSPeFNoCZUXsynOAhRu5tpkYKuq3BmNJs6Xi40GnljS9vYZQ9eWLfe 0pyhW19tK3MNlkXAGaqWJgAeZXALAphMUgvoDyqVZIIP69xq0az4qdLvyXxcWwEQGzUHx7OgQEI nTcfiYXlfd3IGweInei6i00WUhMTCfPBttVeB4c7tutfuB+n9tZWJ60SKT5n1wDAjNxMEjWLg5G syQzC+rlOUebxUlFv4psM2y9rOcna2Hy9+A7dZp5BjCDdZuBY+vd3+5BC9pt/M1sMPom36dPQV2 C/m1ZvJ3e1HFvMMV/4zZ7IIQtcpdRO5gQO5H8W9cves0YfPtAqGo0PRVx3rIvKShg/yKO+5CXkx xQ3xZsKMEtbsGSsX15fxIWDmUhd+nRved3BAgC0OE6B1NNS6O1285fJx88Jm6IjRHD7+2t6CJpl 9ayBmPrf8i5je28S94UaUgEytVeemIplHrrcN5QqRhXkuZJ0ODCpx/PRSB9GD6hVNFt59lphypK 9ibZw6bXgksqXuA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A random collection of spelling fixes for source files in the LSM
layer.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c     | 20 ++++++++++----------
 security/device_cgroup.c |  2 +-
 security/lsm_audit.c     |  2 +-
 security/security.c      |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0b3fc2f3afe7..ab5742ab4362 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -314,7 +314,7 @@ int cap_inode_need_killpriv(struct dentry *dentry)
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * Return: 0 if successful, -ve on error.
  */
@@ -522,7 +522,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * Return: On success, return the new size; on error, return < 0.
  */
@@ -630,7 +630,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
@@ -1133,7 +1133,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		break;
 
 	case LSM_SETID_FS:
-		/* juggle the capabilties to follow FSUID changes, unless
+		/* juggle the capabilities to follow FSUID changes, unless
 		 * otherwise suppressed
 		 *
 		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
@@ -1184,10 +1184,10 @@ static int cap_safe_nice(struct task_struct *p)
 }
 
 /**
- * cap_task_setscheduler - Detemine if scheduler policy change is permitted
+ * cap_task_setscheduler - Determine if scheduler policy change is permitted
  * @p: The task to affect
  *
- * Detemine if the requested scheduler policy change is permitted for the
+ * Determine if the requested scheduler policy change is permitted for the
  * specified task.
  *
  * Return: 0 if permission is granted, -ve if denied.
@@ -1198,11 +1198,11 @@ int cap_task_setscheduler(struct task_struct *p)
 }
 
 /**
- * cap_task_setioprio - Detemine if I/O priority change is permitted
+ * cap_task_setioprio - Determine if I/O priority change is permitted
  * @p: The task to affect
  * @ioprio: The I/O priority to set
  *
- * Detemine if the requested I/O priority change is permitted for the specified
+ * Determine if the requested I/O priority change is permitted for the specified
  * task.
  *
  * Return: 0 if permission is granted, -ve if denied.
@@ -1213,11 +1213,11 @@ int cap_task_setioprio(struct task_struct *p, int ioprio)
 }
 
 /**
- * cap_task_setnice - Detemine if task priority change is permitted
+ * cap_task_setnice - Determine if task priority change is permitted
  * @p: The task to affect
  * @nice: The nice value to set
  *
- * Detemine if the requested task priority change is permitted for the
+ * Determine if the requested task priority change is permitted for the
  * specified task.
  *
  * Return: 0 if permission is granted, -ve if denied.
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 7507d14eacc7..41fca6487ca3 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -421,7 +421,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
 		} else {
 			/*
 			 * new exception in the child will add more devices
-			 * that can be acessed, so it can't match any of
+			 * that can be accessed, so it can't match any of
 			 * parent's exceptions, even slightly
 			 */ 
 			match = match_exception_partial(&dev_cgroup->exceptions,
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 368e77ca43c4..849e832719e2 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -200,7 +200,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	char comm[sizeof(current->comm)];
 
 	/*
-	 * To keep stack sizes in check force programers to notice if they
+	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
 	 * as an example of how to deal with large data.
 	 */
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..ee4f1cc4902e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2491,7 +2491,7 @@ int security_inode_copy_up_xattr(const char *name)
 	/*
 	 * The implementation can return 0 (accept the xattr), 1 (discard the
 	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
-	 * any other error code incase of an error.
+	 * any other error code in case of an error.
 	 */
 	hlist_for_each_entry(hp,
 			     &security_hook_heads.inode_copy_up_xattr, list) {
@@ -4676,7 +4676,7 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
  * @subnet_prefix: subnet prefix of the port
  * @pkey: IB pkey
  *
- * Check permission to access a pkey when modifing a QP.
+ * Check permission to access a pkey when modifying a QP.
  *
  * Return: Returns 0 if permission is granted.
  */
-- 
2.40.1

