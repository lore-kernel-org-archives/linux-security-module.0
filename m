Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B512FB37
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290330; cv=none; b=rTPOf+ZyCP5+rz8hMziTgwVLbdMO9m46mHjBSUWj1Ta+JeRCuqBj30B1+izvz9SUOUclPxJBGFKk6/jOAVj4ONGe6+vU23ZK4LByLHhwsA468vxSqDXej46Wqxq2tBbuYQiLzH5TENE9UwvyU2zDXm4jZ00uaxz43tKDxngeFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290330; c=relaxed/simple;
	bh=7BFvgcGjVqum3vQTgwiHjqpZrH7kKbAZc/8wehcV0Rw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nbnyUdsj+d8Kq7mIVlyJ8qW1AbsbuwQdjg9QqOEQBmnv7vMGxwpklj75nihXU3ZyCjqlNZOZ8W1HuJ23k9JpNrQdM6DEYI4VhHz/eU5xV9TrIgTYt62J6dObWFDaTLc0YvdhSeqdMv8sxk0JLS1poKbEVT3C8KAmG0bEkFN+Eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YOzjka0+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOzjka0+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d0dc869bso285003085a.2
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722290327; x=1722895127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3iYBEMid67Mzpea60KXjhaxJYwaoNt058ly9sJZZT8=;
        b=YOzjka0+78UECBidOsaAh11a6bsIJRWBDAjDimWsyj8LMVyecqZJwpoleJ2b+rbQht
         VjW3hmAqOdh+AeauNhdtipqrQx6lMVAxTiJvJTBuP88tfnuv2rvlO+dflyDi6XlIWZdi
         B9czPgckvhJMBH8amR/ZKpTRseyd6RLNUUmptHfTNy4IqcH+lBd2Z/3fbEa+OVqcdEQ3
         dZRLDOQbnkUjbnONpATplmljP5PxiTb9XX165EUgLipSWJk/AwnLJ6RnkyQxPXsACZvl
         HgytIQ5MjGjBRxR3cbW0vdjG/rhmlC/5rqoiSsDa6p1vqyrYwJqLVBkTOIOddrXn+EnI
         1shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290327; x=1722895127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3iYBEMid67Mzpea60KXjhaxJYwaoNt058ly9sJZZT8=;
        b=d7Ideeow91N6GaeKzOydCT49aYurf57xRQ3z00NyNlQ7FslH1q4olimmzTTedjiZSu
         mzxOQxYI64PjbTPLWydN2wzL0ws5LS736Ds/wXOxzu76x+9ZqT2EKClgFnXNk1h6eHEy
         0MAqQm87Ic1qHZEFaNK5HPoL4lBSGoHeSb01i1LXyBcVDUTk5WB2pmBfkiCB5ILUp3Vb
         UvBV1d8JYOwnW8afZXfjRnMxr7B5H+Fq6RWKsNlKrgWtGrI+yPTtEf7VmPHQt0Sw75gf
         IRBUfxC3ptQ2h328RS+Zo5Kub826MhCgTGJucQ6jA8kGFgfQd9miYEF4uUf3BnMTBDez
         sz9g==
X-Gm-Message-State: AOJu0Yykc2S0qJTzAaTadQpqU7eGOXgVtq7U812OlUt4DQP3rBrV51Ka
	wkZ6sBhvnB3IUEf787MvSp4EgccJE1Nq2z2YLT9FPQVhG8NPAbs9QNV4Ft+d/aJ7nLFiH8g99ZU
	=
X-Google-Smtp-Source: AGHT+IHnd9V0wRm1F8Q7MNNXuzoB5C80nJ3aG8K0zKi5SmcEMoVNxZ/QJ9zuDNvyfyo5ovqP3Hxiww==
X-Received: by 2002:a05:620a:269a:b0:79d:7ae3:4560 with SMTP id af79cd13be357-7a1e52e8affmr1325880185a.55.1722290327409;
        Mon, 29 Jul 2024 14:58:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm576691985a.82.2024.07.29.14.58.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:58:47 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: add the inode_free_security_rcu() LSM implementation hook
Date: Mon, 29 Jul 2024 17:58:41 -0400
Message-ID: <20240729215840.319398-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7642; i=paul@paul-moore.com; h=from:subject; bh=7BFvgcGjVqum3vQTgwiHjqpZrH7kKbAZc/8wehcV0Rw=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmqBCQATc7PO3sOL0bbhs5G/rz+bOuikzIuAadu wTHLUVc7ViJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZqgQkAAKCRDqIPLalzeJ c+OCD/wOdKz+D2o6OfdQwQdfyDNHOK+b2IJZfdyMC7NN8DRkllCszUCubj89l8+L8E/ARYS+8vY lnN6ATYYVBFAw9Xop0XA4wqWlnAF+6F6uJ2HjpKLqMWe7p7yQBNDKadN2Pzw011ljczcS7BJywZ BNowxpN3WWlxlFEb89EQNJPytwkNnSpotLC12Bm1X/SOo/3HGuPWIFFkcBtPA21dDLdQgIjgqEy CFSI309HfdtfcmZ1OEguAyI2dsDANaff6SPC98YamOAIInCXXD3xtEqsEwsOqHiRMUUKR09gFa7 WimcptBeQObjWPL6MUX40wPZPo77+PqkeB8B+5j319pmC1Avo6vw2cXxl06/db5nyrtsD4ibrZm 6Wt2A7PicL4Sd8zQtPqNEvH+c9EENFlW9OKHWbkCIV60tpdr1pDq11fi7jyFE1R1xrDMo/Zl4Ti //7JtbCzY+nE00iXDi6e05mhNFRkPft6S88ApDGDQwSJJYWz5X5MXeF3DUI6mxKavMQGnCA8biS ZrnnMJxDt7dtp8wafP8ayOVbTeRBa++sq73tHNhlYS82rUjLmF8zmsu6wIQ4EMrwWpir5tuw6y1 MgkAUGI4vgok/kZEhtKsVpA7vacST3Au5JcuYLCJn9MoapieezPJdB6+7p3XF9R5mJ1n6FoJip+ ZKfe3bPlI9wUp7A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework has an existing inode_free_security() hook which
is used by LSMs that manage state associated with an inode, but
due to the use of RCU to protect the inode, special care must be
taken to ensure that the LSMs do not fully release the inode state
until it is safe from a RCU perspective.

This patch implements a new inode_free_security_rcu() implementation
hook which is called when it is safe to free the LSM's internal inode
state.  Unfortunately, this new hook does not have access to the inode
itself as it may already be released, so the existing
inode_free_security() hook is retained for those LSMs which require
access to the inode.

Cc: stable@vger.kernel.org
Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h     |  1 +
 security/integrity/ima/ima.h      |  2 +-
 security/integrity/ima/ima_iint.c | 20 ++++++++-----------
 security/integrity/ima/ima_main.c |  2 +-
 security/landlock/fs.c            |  9 ++++++---
 security/security.c               | 32 +++++++++++++++----------------
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8fd87f823d3a..40d2299f684f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3e568126cd48..f093dc679084 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
-void ima_inode_free(struct inode *inode);
+void ima_inode_free_rcu(void *inode_security);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e23412a2c56b..00b249101f98 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 }
 
 /**
- * ima_inode_free - Called on inode free
- * @inode: Pointer to the inode
+ * ima_inode_free_rcu - Called to free an inode via a RCU callback
+ * @inode_security: The inode->i_security pointer
  *
- * Free the iint associated with an inode.
+ * Free the IMA data associated with an inode.
  */
-void ima_inode_free(struct inode *inode)
+void ima_inode_free_rcu(void *inode_security)
 {
-	struct ima_iint_cache *iint;
+	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
 
-	if (!IS_IMA(inode))
-		return;
-
-	iint = ima_iint_find(inode);
-	ima_inode_set_iint(inode, NULL);
-
-	ima_iint_free(iint);
+	/* *iint_p should be NULL if !IS_IMA(inode) */
+	if (*iint_p)
+		ima_iint_free(*iint_p);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..5b3394864b21 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
-	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
+	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
 static const struct lsm_id ima_lsmid = {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 22d8b7c28074..8b6c9d2facad 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 /* Inode hooks */
 
-static void hook_inode_free_security(struct inode *const inode)
+static void hook_inode_free_security_rcu(void *inode_security)
 {
+	struct landlock_inode_security *inode_sec;
+
 	/*
 	 * All inodes must already have been untied from their object by
 	 * release_inode() or hook_sb_delete().
 	 */
-	WARN_ON_ONCE(landlock_inode(inode)->object);
+	inode_sec = inode_security + landlock_blob_sizes.lbs_inode;
+	WARN_ON_ONCE(inode_sec->object);
 }
 
 /* Super-block hooks */
@@ -1628,7 +1631,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
+	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/security.c b/security/security.c
index b52e81ac5526..72086c8ba89e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
 
 static void inode_free_by_rcu(struct rcu_head *head)
 {
-	/*
-	 * The rcu head is at the start of the inode blob
-	 */
+	/* The rcu head is at the start of the inode blob */
+	call_void_hook(inode_free_security_rcu, head);
 	kmem_cache_free(lsm_inode_cache, head);
 }
 
@@ -1606,23 +1605,24 @@ static void inode_free_by_rcu(struct rcu_head *head)
  * security_inode_free() - Free an inode's LSM blob
  * @inode: the inode
  *
- * Deallocate the inode security structure and set @inode->i_security to NULL.
+ * Release any LSM resources associated with @inode, although due to the
+ * inode's RCU protections it is possible that the resources will not be
+ * fully released until after the current RCU grace period has elapsed.
+ *
+ * It is important for LSMs to note that despite being present in a call to
+ * security_inode_free(), @inode may still be referenced in a VFS path walk
+ * and calls to security_inode_permission() may be made during, or after,
+ * a call to security_inode_free().  For this reason the inode->i_security
+ * field is released via a call_rcu() callback and any LSMs which need to
+ * retain inode state for use in security_inode_permission() should only
+ * release that state in the inode_free_security_rcu() LSM hook callback.
  */
 void security_inode_free(struct inode *inode)
 {
 	call_void_hook(inode_free_security, inode);
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to security_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
-			 inode_free_by_rcu);
+	if (!inode->i_security)
+		return;
+	call_rcu((struct rcu_head *)inode->i_security, inode_free_by_rcu);
 }
 
 /**
-- 
2.45.2

