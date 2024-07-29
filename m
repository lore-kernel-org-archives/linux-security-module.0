Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3612FB37
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290232; cv=none; b=dpM42hX1BgICpsYD0XuB1t+NsiOb+UvSdoEx7RY2zoP9Fu9UkklJeu5GH2TXCkCDEJ6LGDSp18WauLJi02E4tfCo2XVD1vF4kKZXuL1BaALG9UhqANIFbiWqhdzUALWGzIw/YC9Dkr1iz28L0xJ1QZOgvcQMZFH8nws15elHvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290232; c=relaxed/simple;
	bh=iH9JN0f+WDqtRDY3wcckNWg1IkWqtsue+Ko0CGss4jo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=raDoVmlFq7A0bLvON8XdoT9WtyXHqhZrb0FeswPGTIVLYpvqPlfamIetdMu95FT5C5I8dIOlSPQ7McrKjyeT2vXbjt3STsNTGM7PFfznbp1ck4QYVYGgllBouMwnVx4da4IsY9A1F27DQNGpgDsiHXwi1QNS6Ask4wmUIVtQ2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6t5MAsz; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6t5MAsz"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db15b4243dso2431365b6e.0
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722290229; x=1722895029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb9fhV5JLVc+diVIqmLWU9/wx5C9Dk4zEfBjkPflYco=;
        b=Q6t5MAszLtnBX890W21AlFCN8NQVBhd7e6Dex0Cu4xAR4JCAD5klxVH2xvnr3tIUKC
         T6ncs7vIILqpyiF9gxeLa7eGij3g/W8RxSMuF5djfY3d4pQ7XueJRSQUcJ0XD/f3ufRI
         cG7Oec+iG6zWJYa6Yyr61y8H6DPC1kIVsXfT2V1CT2Y+tLp5X139ihH+B6C3JEdScRcN
         XvFOkSBrlwWkk7IpDwmIyT9phXevzsod9oeqqkgIDgTaaTA7LZBvuoZbV1NLX9idM3zI
         k9BmtmOPcxdCo+02RsYkzGwDNFM6CqD03p9TQ7gEwkTznFbYdUCNQ+x1mQxoxmzLhZaC
         iHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290229; x=1722895029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb9fhV5JLVc+diVIqmLWU9/wx5C9Dk4zEfBjkPflYco=;
        b=F+d5pS8SIc7zHcCbzz10TpYrFCu3OO9+nTV15UDMgQTGVoti/ToEtXIzEcMx+ZA8+t
         QK5R4sJI+CFYsNn2KhrKhfbswSN0cMiO6YaZ8OvWI5LS03gO19ff7i+3D7WWRhjIjT21
         reROUyg/a/cKEbqTxMddv48xrW8lzisrOokHF4ETc4Uzj6LSHcpSjZTLSV6YB3HQL2ED
         J4VzyTuLyqYcb7jmVaTAfWJbR2o9gIb/JhWROLA0xUzhRJQ/1SUEBxeXQT2hIhSHzpm5
         L2JtBUoHGOyCCPtR0Ba4V9d1gbUutI5dzKD47dRkN8M4guNCQ4qpp0LsO6F7Af6EAujb
         Eicw==
X-Gm-Message-State: AOJu0YyLb0pUFkOB9ePrcxO8eSk0IBUdiFoG7CuCQewR/1kqnfA0qtwu
	9xW22b9ksycRQIZAv4Xl4YAON3h8iBlKCx+VaLzvco8Dh3IOJslqDaaiGJ5j8OPNfMwwoQW4aeI
	=
X-Google-Smtp-Source: AGHT+IE3huZOPQWk7s2qeHnK36YN0uu8MHvElhmOxb3Kwo+DP4ylehY8i0gTPFvBNMTW0Qis9qhSIA==
X-Received: by 2002:a05:6358:c620:b0:1aa:d121:d1cb with SMTP id e5c5f4694b2df-1adc0694b39mr881837755d.18.1722290229080;
        Mon, 29 Jul 2024 14:57:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac19c5sm57286786d6.112.2024.07.29.14.57.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:57:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: cleanup lsm_hooks.h
Date: Mon, 29 Jul 2024 17:57:03 -0400
Message-ID: <20240729215702.318099-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4934; i=paul@paul-moore.com; h=from:subject; bh=iH9JN0f+WDqtRDY3wcckNWg1IkWqtsue+Ko0CGss4jo=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmqBAu67i8D3uiOyRka1I9BvypJVEokIDhiwH8l DI06U3xzVCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZqgQLgAKCRDqIPLalzeJ cwAqEACQeYH8n5whHcirV1+M5e4sBTFSfOn1n8r1Pm+pRtkF6rvEeKGuFn5MKLKbV49wK1tx1Ve dxPtIExvLGLHsZSo1ZkXBEuLki2N6Mxy5nLMj+tgGqsHZKuOTMN3uPBDe3W3QgCkwLCMtDuyoM3 //FRfTl4LD/13ozglj9//iZsM/NE351XuwQjagSrRfFF6F73S/GU7KO6dephn0iYBxxlYTGDUuk AGIsQNk1xsQEE6LIDlRVvcouUFxZiPPlXQV/C8zzbHCb+uJ4xXt+4tNU6ZlfVkew7cN8GtKtDn1 Vxwmu47oqgocL5rMaMhj2aj67v6+fqRUN+I90za6vAq3Ujhk8QRC7CeY629iYQ3P86vyelHQg8O 77EH7VhQCpWvcR8if4/7l3O+7Ge/TpInNwscL3a9oOiLWNAuGrZt8xlI9zZB2fqgbEh3RT2FHt4 L3hV+VJQmzfGlZCoQaUYpzpM9zSyqNR+6sG9aG8kJE9WHatajFAxrUO+G4oKbeINA5jtGyepSED QZ6QG/WI866z083o3WwdkrAl/0svPNKZtiIPHsu+Xuzl9LWDX0D1cL8DN/Ge4qw9pBiAcy4u70z C4mfmk/neApoBCQnMDr43ZZKAZOvjwYB6i18GCGhM/qWmKDwrv97x8FAEiETnF2XvITD94dHWTV 332DQspGmyDEiqg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Some cleanup and style corrections for lsm_hooks.h.

 * Drop the lsm_inode_alloc() extern declaration, it is not needed.
 * Relocate lsm_get_xattr_slot() and extern variables in the file to
   improve grouping of related objects.
 * Don't use tabs to needlessly align structure fields.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 82 +++++++++++++++++++--------------------
 security/security.c       |  2 +-
 2 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 845457f0eeb7..f0dd453b39d5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -79,8 +79,8 @@ struct lsm_static_calls_table {
  * Contains the information that identifies the LSM.
  */
 struct lsm_id {
-	const char	*name;
-	u64		id;
+	const char *name;
+	u64 id;
 };
 
 /*
@@ -93,48 +93,30 @@ struct lsm_id {
  * @lsm: The name of the lsm that owns this hook.
  */
 struct security_hook_list {
-	struct lsm_static_call	*scalls;
-	union security_list_options	hook;
-	const struct lsm_id		*lsmid;
+	struct lsm_static_call *scalls;
+	union security_list_options hook;
+	const struct lsm_id *lsmid;
 } __randomize_layout;
 
 /*
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
-	int	lbs_cred;
-	int	lbs_file;
-	int	lbs_ib;
-	int	lbs_inode;
-	int	lbs_sock;
-	int	lbs_superblock;
-	int	lbs_ipc;
-	int	lbs_key;
-	int	lbs_msg_msg;
-	int	lbs_perf_event;
-	int	lbs_task;
-	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
-	int	lbs_tun_dev;
+	int lbs_cred;
+	int lbs_file;
+	int lbs_ib;
+	int lbs_inode;
+	int lbs_sock;
+	int lbs_superblock;
+	int lbs_ipc;
+	int lbs_key;
+	int lbs_msg_msg;
+	int lbs_perf_event;
+	int lbs_task;
+	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
+	int lbs_tun_dev;
 };
 
-/**
- * lsm_get_xattr_slot - Return the next available slot and increment the index
- * @xattrs: array storing LSM-provided xattrs
- * @xattr_count: number of already stored xattrs (updated)
- *
- * Retrieve the first available slot in the @xattrs array to fill with an xattr,
- * and increment @xattr_count.
- *
- * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
- */
-static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
-					       int *xattr_count)
-{
-	if (unlikely(!xattrs))
-		return NULL;
-	return &xattrs[(*xattr_count)++];
-}
-
 /*
  * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
  * LSM hooks (in include/linux/lsm_hook_defs.h).
@@ -153,8 +135,6 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 		.hook = { .NAME = HOOK }		\
 	}
 
-extern char *lsm_names;
-
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid);
 
@@ -176,9 +156,6 @@ struct lsm_info {
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
 };
 
-extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
-extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
-
 #define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(".lsm_info.init")			\
@@ -189,7 +166,28 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
-extern int lsm_inode_alloc(struct inode *inode);
+/* DO NOT tamper with these variables outside of the LSM framework */
+extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
+extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
+
+/**
+ * lsm_get_xattr_slot - Return the next available slot and increment the index
+ * @xattrs: array storing LSM-provided xattrs
+ * @xattr_count: number of already stored xattrs (updated)
+ *
+ * Retrieve the first available slot in the @xattrs array to fill with an xattr,
+ * and increment @xattr_count.
+ *
+ * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
+ */
+static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
+					       int *xattr_count)
+{
+	if (unlikely(!xattrs))
+		return NULL;
+	return &xattrs[(*xattr_count)++];
+}
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 780b84f5d09c..7ac6765f9260 100644
--- a/security/security.c
+++ b/security/security.c
@@ -764,7 +764,7 @@ static int lsm_file_alloc(struct file *file)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_inode_alloc(struct inode *inode)
+static int lsm_inode_alloc(struct inode *inode)
 {
 	if (!lsm_inode_cache) {
 		inode->i_security = NULL;
-- 
2.45.2

