Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AB155A59;
	Thu, 23 Jan 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660645; cv=none; b=IcTNbUfEy9pPL+IzDBAG6yvAKZtJWGv3rfq/4SIoUqQ2ZdUVJSGOGw/5YO06Z6q+cHT2uGovMgLF//BLL3gjQhajJSIuGd5vWZ3RMI4KAmK6bybonqty+uanywL4E8n8KSejJ+PTqSwocdy4piSJaZ2Jp17yqCO5JgLH+UCXtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660645; c=relaxed/simple;
	bh=YrbUHWW0CJBpyVARuH6o0eg0y1OnUAOfs/tFnr3kIxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=quqge+PFGQ3QfVnhowb7VszyVOsKYx6Q2Vvby+rNWI1kdgphOYniW0Jc8wL8NmLnRsboMgaehu04b6IojYQRMplFycPCeKK6Or5XC9ossVJwkpzBfswsfwuUo3Vx9t2CTdOT2ZkaL0GPNP7aUbVDqii30bZNJQUYDTDZH5GwfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmmQzBus; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmmQzBus"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb94cceso16087445ad.2;
        Thu, 23 Jan 2025 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737660643; x=1738265443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gP/FqXglMXSORu3+CDhnW0Rfk6GFBQeacISqvXFUjM=;
        b=LmmQzBusLHuEqD3rImqJewXN97nrrgv3ov9S2W+zL7eL/PkeegB5LrYEOfQXJKevoR
         Xd8deJsSjZ2pOWgainFZGGRo2Azl8pb80d/GPHppX1BXLtcHAz/70D1p7KNxh2F4R18V
         a9fpBrPJto0dBAcsTvJR3M8cFA5ItONxBaUyw/ljQhA/21o7pMdTmt6Oj7iGwze5X2mi
         2AgSB++7tTeCDNyIseEaasayHWPkG6qT8KrDWrqm/nyb0EpAefRa8xPcK7M9D801lW4y
         C0CwDufZckmF8OzDeKoRhs7bZIe/61d9Xv3nB2Bljg/5fJ7Vi0JJ/gOYQ8Ue7iLylb4j
         ExIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660643; x=1738265443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gP/FqXglMXSORu3+CDhnW0Rfk6GFBQeacISqvXFUjM=;
        b=hDTdmUmLv4+qKD/kNhG+kGsnRPhsEc5Dutpbd+laGisrUF7jIVh461/3iATJQSewjl
         /FqHdE/5F2V0qobo2/OcIKE555ZkAiDPfTVgtSUuQ1CqIkeIYkcls8Xu6NlVMPUnoO7R
         XU9tEbVPimCanE3pd28dh3r5B3DlJNUib9eAEHUY3a8A1g05VUx25h2cjfkiXxGT3xxG
         vVKkngk7oxZPVf3uhIW4AT+crWQCQGocOuJSCldg5vLCPj+STG3LpMrzyDCuOMELISSo
         Fkl/b6lICm8CRZQ5zW4W37UY/0tq+F/2Y8FNQrRXkdLATXc91Y75DuFfjCc8cFjRyPul
         1u8A==
X-Forwarded-Encrypted: i=1; AJvYcCVHFEwtAWDxQXB2IQ7oKe9Jf/ERtWtbWPiHv4WAJUd5Cgiv+xXENawrnfURbmVAUHllZZ0CpDFDjJErYTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZmcHFNvCQJyKoDTCdmNzrcASRgeK65/nCUx6GdhdlJ9f+7a8
	LrNrofOyb2zImR/C6xWO4SA84J4Auo+28MgxlQm7qaXQBTUi6dgp
X-Gm-Gg: ASbGnct3YHynosMKH6D2YJoLy6uJLDABDKZ/Z81WgBPnbVOLvyIYh9/l1jMaP8T2bYU
	ZvWQ4bInQ4PtkMlyk0PpS8BfsnTqk/uE9y0315a+Mx0EHBYwHk3hz2mDKLjHsiH4KFgy2smyJAr
	7fYOvIgchEM2hoEuooPLjVj9yRR3AhFbFYoLNwTX4YnmmD4gRQkc6Ox1KBrbyYKy8465/0OUyzp
	sg0GuZSuX52MJRhG9NPYB5aO0Px7rwzBuBEWKXnUOFBepv7KlEKc5c/WD1RfOtHLb0TrswgSRTM
	9w==
X-Google-Smtp-Source: AGHT+IHnT3DA0HP2hGmeOkxrGX9PxodWiH2ocKSC2+wJ5l0bQXJLYR2XrUUwbMNHQcSF3mEhSoc/ig==
X-Received: by 2002:a17:902:eccb:b0:219:e4b0:4286 with SMTP id d9443c01a7336-21c3558fc4dmr411446095ad.29.1737660642745;
        Thu, 23 Jan 2025 11:30:42 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21da3ea3b14sm2742115ad.60.2025.01.23.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:30:42 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] apparmor: fix typos and spelling errors
Date: Fri, 24 Jan 2025 00:51:00 +0530
Message-Id: <20250123192058.2558-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix typos and spelling errors in apparmor module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers. 

Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

 security/apparmor/apparmorfs.c | 6 +++---
 security/apparmor/domain.c     | 4 ++--
 security/apparmor/label.c      | 2 +-
 security/apparmor/lsm.c        | 2 +-
 security/apparmor/policy.c     | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2c0185ebc900..0c2f248d31bf 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -43,7 +43,7 @@
  * The interface is split into two main components based on their function
  * a securityfs component:
  *   used for static files that are always available, and which allows
- *   userspace to specificy the location of the security filesystem.
+ *   userspace to specify the location of the security filesystem.
  *
  *   fns and data are prefixed with
  *      aa_sfs_
@@ -204,7 +204,7 @@ static struct file_system_type aafs_ops = {
 /**
  * __aafs_setup_d_inode - basic inode setup for apparmorfs
  * @dir: parent directory for the dentry
- * @dentry: dentry we are seting the inode up for
+ * @dentry: dentry we are setting the inode up for
  * @mode: permissions the file should have
  * @data: data to store on inode.i_private, available in open()
  * @link: if symlink, symlink target string
@@ -2244,7 +2244,7 @@ static void *p_next(struct seq_file *f, void *p, loff_t *pos)
 /**
  * p_stop - stop depth first traversal
  * @f: seq_file we are filling
- * @p: the last profile writen
+ * @p: the last profile written
  *
  * Release all locking done by p_start/p_next on namespace tree
  */
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 5939bd9a9b9b..d959931eac28 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -755,7 +755,7 @@ static int profile_onexec(const struct cred *subj_cred,
 		/* change_profile on exec already granted */
 		/*
 		 * NOTE: Domain transitions from unconfined are allowed
-		 * even when no_new_privs is set because this aways results
+		 * even when no_new_privs is set because this always results
 		 * in a further reduction of permissions.
 		 */
 		return 0;
@@ -926,7 +926,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 *
 	 * NOTE: Domain transitions from unconfined and to stacked
 	 * subsets are allowed even when no_new_privs is set because this
-	 * aways results in a further reduction of permissions.
+	 * always results in a further reduction of permissions.
 	 */
 	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
 	    !unconfined(label) &&
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 91483ecacc16..8bcff51becb8 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1456,7 +1456,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
 
 /*
  * cached label name is present and visible
- * @label->hname only exists if label is namespace hierachical
+ * @label->hname only exists if label is namespace hierarchical
  */
 static inline bool use_label_hname(struct aa_ns *ns, struct aa_label *label,
 				   int flags)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1edc12862a7d..04bf5d2f6e00 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2006,7 +2006,7 @@ static int __init alloc_buffers(void)
 	 * two should be enough, with more CPUs it is possible that more
 	 * buffers will be used simultaneously. The preallocated pool may grow.
 	 * This preallocation has also the side-effect that AppArmor will be
-	 * disabled early at boot if aa_g_path_max is extremly high.
+	 * disabled early at boot if aa_g_path_max is extremely high.
 	 */
 	if (num_online_cpus() > 1)
 		num = 4 + RESERVE_COUNT;
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index d0244fab0653..5cec3efc4794 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -463,7 +463,7 @@ static struct aa_policy *__lookup_parent(struct aa_ns *ns,
 }
 
 /**
- * __create_missing_ancestors - create place holders for missing ancestores
+ * __create_missing_ancestors - create place holders for missing ancestors
  * @ns: namespace to lookup profile in (NOT NULL)
  * @hname: hierarchical profile name to find parent of (NOT NULL)
  * @gfp: type of allocation.
@@ -1068,7 +1068,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 		goto out;
 
 	/* ensure that profiles are all for the same ns
-	 * TODO: update locking to remove this constaint. All profiles in
+	 * TODO: update locking to remove this constraint. All profiles in
 	 *       the load set must succeed as a set or the load will
 	 *       fail. Sort ent list and take ns locks in hierarchy order
 	 */
-- 
2.39.5

