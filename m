Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926683BBA0F
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455144; cv=none; b=ZEXk3C++tYO7MQPYx2lzGczWrZvJdW3gWim+AFkly29HUCXcwgpJ4COzW+eWRbFFhA6xUdxVfuKfXTQN8j12wbjxTcYeM5YsYroT1anmYd2Q8sZi2M7xXmScVZFcjBiyVVXy6w1XUaN8nKOIx74mHLbdK8rdOpd/aUPcgg1ulL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455144; c=relaxed/simple;
	bh=VCpbyUPqORWyRLbwhm51+hqDWgsTGfpZM/vWOJo7WrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1ptg7sBSAqpFvh4xmRSKmdrCpTAlabZMCBnCOlPX8ImZY9pCuOckPcIJrn8SjTF0tlsF6he8M3g7taMZvwPJriBYiD2eCOrwWcO0BWveZ5Z82b2NpkZOCXQDmIAtw9DbjSG4UtMa67jgDubF7IcvnRbfCeH4TrSAU7e2cwECLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noSrTpEb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noSrTpEb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0006ea8eso2585851cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455139; x=1786059939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEsXNuooCRONAZouOvL/f+bUqt1A8msd7lPJJsnoW38=;
        b=noSrTpEbWaCZGx6bD4hO39KX2W9uzVQrgCYkivUx8SINCF2uxcGY4J4B6ollvVEVnG
         rJWrGCdmliHbtBQZdBmX4yilNIkW6Uuuk61ggcdzUIeP7tXpUsxMc+B8HIqSQZHbWS/0
         a3kLlnNILyntHGY9+pcbETmvyf1kGxT6qnTUWlYMJYp8vgoNCygxJtZ0cQvozrcXTsNs
         MuUKCY1eis8QLcYXYeO2WsriuCKpv/C4xmsBA9mFBs6o47VN5NaHKnzxt+PE/Kt4o+j9
         J/mZcjNenUnqIIN/pHotfZQ72gdOfgtIvjqW0Ngt/kJi7656bI1v27C4lJCBM5D5gEY1
         ZCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455139; x=1786059939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEsXNuooCRONAZouOvL/f+bUqt1A8msd7lPJJsnoW38=;
        b=DVm4MSCShX4mtb6A1Lc4J91xvNvXFra4Kerj/5Mn1cwfvDDgKHHLb8RiR8BN21XckU
         HSIBRb1PmodWpldcgsGplbrE3YR4vDa8UKnqM1kAHZAHAqUaKTeO1p7aZajTk4Dps+ac
         csg11YitnxLf52SCdG9Pm94gSmXtCZTl6c9wWNosWPNm+KpyQ06DCUIu+UCa8pIGa+6E
         C65gSr9PkY91lCDUnN7VZ+Zp7Ovehsj6/aJXW2jfsmoBJ2ziLy60V0a7qJKsfpMRExYh
         L4p+IkMfLTo0rgFszXExwJF7bfb+gu4Irtcs8pLRRo2hJ/wzUtJ7IB/FIzK3DDfcuj0v
         Go2A==
X-Forwarded-Encrypted: i=1; AHgh+RqReTAzdo8DxBBCb2w+eIvcjNueU6pD5DkqnzV88lPH6d3kQds4Ihy1cmyApvvY/3jPsE/zQ83zid1LhrhU+r5H1yeOnd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStdYSpY3PyD//hy8/wV6IL9YkTRg5OAHWsfzTkIo4YQmLkAZI
	O31D6OLbzjehHg9lIsQzqhJJlqS0F+LODGnKgLvxKrC1vXj55pS7igRX
X-Gm-Gg: AR+sD101GPwtFvuqaz0xDqKPt8g0bZXQ3jWLFKVDM9l5mWqLLiYBp5Ki2mXYYSy/6aK
	GMxI1i3BqRYO9x4PQu1PNbCfMZYfXEYMXhNxj8zy9BULrY32BfA8DdEqnMeAHBXYXL7q6tVBSUd
	QaOozAGs69gRjjeuFZZYH5yXRryX1tneycNqjVAx2zRQjUnTY/DKZ0p+OkQHcNrjSlBzRK2CRPv
	mH7VhU1Lh/4aDHwtwL1xObuvJHexPuTelXsupYRv8s5qPpJ0tGwCE8dmhZN2eSQnJC9ThliZxNG
	5gyLKDqmDyLh0B8+pNfcqca3o0aDGRyoH4fHrawYzS1qzzLqSTynTkwp+vKRKrn/3YaZA+GnhSA
	7vYy/4Nk6f2wTM9M/39JrWIloPZtfiPIr0KOXygHtBCkqw3b6oFlgTs61MYJv5Zp8zx5kCZbfN8
	NImc8mpUlk4zntqf3gFPhviVAslYEASdK5OvHsx7aOlhbihWlOiU6CpxPN41kExMPq/kzWgviY2
	C//+6C9wfhRL3/SCbFmR3axb2nuXDmPK04U9NPuZMLjjFfN4xTu/17hn6KItAM=
X-Received: by 2002:ac8:5e4d:0:b0:51a:8c86:bd44 with SMTP id d75a77b69052e-52b386be26emr48728101cf.65.1785455139426;
        Thu, 30 Jul 2026 16:45:39 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:38 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v6 bpf-next 1/4] security: introduce struct lsm_xattrs
Date: Thu, 30 Jul 2026 19:45:30 -0400
Message-ID: <20260730234533.1912709-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730234533.1912709-1-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
programs atomically label new inodes, rework how inode_init_security
xattrs are managed.

inode_init_security receives the LSM xattr array and its count as
separate parameters. For better compatibility with the bpf verifier,
update inode_init_security and its callers to consolidate these
parameters into a single context object: struct lsm_xattrs.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/evm.h               |  9 +++++----
 include/linux/lsm_hook_defs.h     |  4 ++--
 include/linux/lsm_hooks.h         | 16 +++++++---------
 include/linux/security.h          |  5 +++++
 security/integrity/evm/evm_main.c |  8 +++++---
 security/security.c               | 24 ++++++++++++------------
 security/selinux/hooks.c          |  4 ++--
 security/smack/smack_lsm.c        | 27 ++++++++++++---------------
 8 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 913f4573b203..528f360f3308 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,6 +12,8 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
+struct lsm_xattrs;
+
 #ifdef CONFIG_EVM
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
@@ -21,8 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count);
+			    const struct qstr *qstr,
+			    struct lsm_xattrs *xattrs);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
-					  struct xattr *xattrs,
-					  int *xattr_count)
+					  struct lsm_xattrs *xattrs)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..5b2de7865ce8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
+	 struct inode *dir, const struct qstr *qstr,
+	 struct lsm_xattrs *xattrs)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..7afe06a8d4c6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -200,20 +200,18 @@ extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
  * lsm_get_xattr_slot - Return the next available slot and increment the index
- * @xattrs: array storing LSM-provided xattrs
- * @xattr_count: number of already stored xattrs (updated)
+ * @ctx: xattr state shared by inode_init_security hooks
  *
- * Retrieve the first available slot in the @xattrs array to fill with an xattr,
- * and increment @xattr_count.
+ * Retrieve the first available slot in the @ctx->xattrs array to fill with an
+ * xattr, and increment @ctx->xattr_count.
  *
- * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
+ * Return: The slot to fill in @ctx->xattrs if non-NULL, NULL otherwise.
  */
-static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
-					       int *xattr_count)
+static inline struct xattr *lsm_get_xattr_slot(struct lsm_xattrs *ctx)
 {
-	if (unlikely(!xattrs))
+	if (unlikely(!ctx || !ctx->xattrs))
 		return NULL;
-	return &xattrs[(*xattr_count)++];
+	return &ctx->xattrs[ctx->xattr_count++];
 }
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..0be590c40689 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,11 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+struct lsm_xattrs {
+	struct xattr *xattrs;
+	unsigned int xattr_count;
+};
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a..b7158fc63543 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
  * evm_inode_init_security - initializes security.evm HMAC value
  */
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count)
+			    const struct qstr *qstr,
+			    struct lsm_xattrs *lsm_xattrs)
 {
 	struct evm_xattr *xattr_data;
 	struct xattr *xattr, *evm_xattr;
+	struct xattr *xattrs;
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	xattrs = lsm_xattrs ? lsm_xattrs->xattrs : NULL;
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1087,7 +1089,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!evm_protected_xattrs)
 		return 0;
 
-	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	evm_xattr = lsm_get_xattr_slot(lsm_xattrs);
 	/*
 	 * Array terminator (xattr name = NULL) must be the first non-filled
 	 * xattr slot.
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..2ad7f09c1a61 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1333,8 +1333,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const initxattrs initxattrs, void *fs_data)
 {
 	struct lsm_static_call *scall;
-	struct xattr *new_xattrs = NULL;
-	int ret = -EOPNOTSUPP, xattr_count = 0;
+	struct lsm_xattrs xattrs = {};
+	int ret = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1344,15 +1344,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 
 	if (initxattrs) {
 		/* Allocate +1 as terminator. */
-		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
-				     sizeof(*new_xattrs), GFP_NOFS);
-		if (!new_xattrs)
+		xattrs.xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
+					sizeof(*xattrs.xattrs), GFP_NOFS);
+		if (!xattrs.xattrs)
 			return -ENOMEM;
 	}
 
 	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
+							  &xattrs);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 		/*
@@ -1364,14 +1364,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
-	if (!xattr_count)
+	if (!xattrs.xattr_count)
 		goto out;
 
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	ret = initxattrs(inode, xattrs.xattrs, fs_data);
 out:
-	for (; xattr_count > 0; xattr_count--)
-		kfree(new_xattrs[xattr_count - 1].value);
-	kfree(new_xattrs);
+	for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
+		kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
+	kfree(xattrs.xattrs);
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d6945edae7a..21544c775c17 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2962,7 +2962,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       struct xattr *xattrs, int *xattr_count)
+				       struct lsm_xattrs *xattrs)
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
@@ -2992,7 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	xattr = lsm_get_xattr_slot(xattrs);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..4501078430ca 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,10 +981,10 @@ smk_rule_transmutes(struct smack_known *subject,
 }
 
 static int
-xattr_dupval(struct xattr *xattrs, int *xattr_count,
+xattr_dupval(struct lsm_xattrs *xattrs,
 	     const char *name, const void *value, unsigned int vallen)
 {
-	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr * const xattr = lsm_get_xattr_slot(xattrs);
 
 	if (!xattr)
 		return 0;
@@ -1003,14 +1003,13 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @xattrs: where to put the attributes
- * @xattr_count: current number of LSM-provided xattrs (updated)
+ * @xattrs: where to put attributes and update count
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
-				     struct xattr *xattrs, int *xattr_count)
+				     struct lsm_xattrs *xattrs)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
@@ -1057,21 +1056,19 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (S_ISDIR(inode->i_mode)) {
 			transflag = SMK_INODE_TRANSMUTE;
 
-			if (xattr_dupval(xattrs, xattr_count,
-				XATTR_SMACK_TRANSMUTE,
-				TRANS_TRUE,
-				TRANS_TRUE_SIZE
-			))
+			if (xattr_dupval(xattrs,
+					 XATTR_SMACK_TRANSMUTE,
+					 TRANS_TRUE,
+					 TRANS_TRUE_SIZE))
 				rc = -ENOMEM;
 		}
 	}
 
 	if (rc == 0)
-		if (xattr_dupval(xattrs, xattr_count,
-			    XATTR_SMACK_SUFFIX,
-			    issp->smk_inode->smk_known,
-		     strlen(issp->smk_inode->smk_known)
-		))
+		if (xattr_dupval(xattrs,
+				 XATTR_SMACK_SUFFIX,
+				 issp->smk_inode->smk_known,
+				 strlen(issp->smk_inode->smk_known)))
 			rc = -ENOMEM;
 instant_inode:
 	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
-- 
2.53.0

