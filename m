Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDB2D5419
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362637; cv=none; b=hsKXQFfFykJQOTV8BU4IVIgYArJtxRBnFtXUxXpTE5wehfobqyY1+Kq7ph1Y6zLcXyE5zIdWG9I5P+Cqu2CMJ8UfqaGVFMXtuMz/SEsTgeW+DfvtcZHU9qMlLhrBswPPbVkheiadZSVPN97CjZAaR3pBt2s8Z1ke+5UIzeGq17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362637; c=relaxed/simple;
	bh=sWQ8hhrjpP+b1FsAsMxRtgaDZ//UuoPrDj8iF2Dx5kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7u5lGtgrFHQN/J+A3EpPolcMdYKgFGK8zZmVf8WTk2xscSeUVaVj6Ts+frQVHmqfJtWtW0d1K3CbZrDrmwcojDB3csbI4ahDaZfmoHWOTo12aHnetWl4wX7qpJrYxzvOlLH5Pwr5OEfmxBHzZnoL8t26MC2oPTvWMu9veHoKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=NQKZGLb/; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="NQKZGLb/"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wG+CBYPw6NVUWRKkKSqR+DUjB0vrEI0+MaarvpanI60=;
	b=NQKZGLb/R7PLBXbfcCO6fT95nDPZygVPjNfWjCyHoo3L3Lp9n+BMgWztrN4WOMsto4yyqW
	UJF1WnDxiFZJJKQYfaF570/gnU0JpAPqs+WTz4MRJ2OkfkoiORcwoB6Agf3BRNrS0SrAS6
	c5tEyI3drw/IwTKrn10w8FM0V1KsFIY=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 17/19] smack: smack_inode_post_setxattr(): find label instead of import
Date: Thu, 24 Jul 2025 16:09:50 +0300
Message-ID: <0209daf47e936d0e2b5ca6f89cbece6756b1318f.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Efforts were made in [1]
to ensure that smk_import_entry() can not fail
when called by smack_inode_post_setxattr():
label is imported in advance by smack_inode_setxattr().

However,

  - smk_import_entry() can still fail
    due to memory allocation

  - its use is misleading here,
    as no actual import is needed

Using smk_find_entry() instead of smk_import_entry()
should be sufficient for smack_inode_post_setxattr().

However, smk_find_entry() takes a \0-terminated string,
while we have a (non-\0-terminated string, length) tuple.

To resolve this, I added smk_find_label_rcu(),
which accepts such a tuple and
is otherwise identical to smk_find_entry().
It is now used in smack_inode_post_setxattr().

smack_inode_post_setxattr() can no longer fail.

[1] 2009-04-16 etienne.basset
commit defc433ba3bc ("Smack: check for SMACK xattr validity
                      in smack_inode_setxattr")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack.h        |  2 ++
 security/smack/smack_access.c | 22 ++++++++++++++++++++--
 security/smack/smack_lsm.c    | 26 ++++++++++++--------------
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 759343a6bbae..9abb11947fe9 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -294,6 +294,8 @@ struct smack_known *smk_import_valid_label(const char *label, int label_len,
 					   gfp_t gfp);
 void smk_insert_entry(struct smack_known *skp);
 struct smack_known *smk_find_entry(const char *);
+struct smack_known *smk_find_label_rcu(const char *string, size_t string_len);
+struct smack_known *smk_find_label(const char *string, size_t string_len);
 bool smack_privileged(int cap);
 bool smack_privileged_cred(int cap, const struct cred *cred);
 void smk_destroy_label_list(struct list_head *list);
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 09167be79122..390dc9642f9b 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -427,21 +427,39 @@ void smk_insert_entry(struct smack_known *skp)
  * matches the passed string or NULL if not found.
  */
 struct smack_known *smk_find_entry(const char *string)
+{
+	return smk_find_label_rcu(string, strlen(string));
+}
+
+struct smack_known *
+smk_find_label_rcu(const char *string, size_t string_len)
 {
 	unsigned int hash;
 	struct hlist_head *head;
 	struct smack_known *skp;
 
-	hash = full_name_hash(NULL, string, strlen(string));
+	hash = full_name_hash(NULL, string, string_len);
 	head = &smack_known_hash[hash & (SMACK_HASH_SLOTS - 1)];
 
 	hlist_for_each_entry_rcu(skp, head, smk_hashed)
-		if (strcmp(skp->smk_known, string) == 0)
+		if (strlen(skp->smk_known) == string_len &&
+		   strncmp(skp->smk_known, string, string_len) == 0)
 			return skp;
 
 	return NULL;
 }
 
+struct smack_known *
+smk_find_label(const char *string, size_t string_len)
+{
+	struct smack_known *skp;
+
+	rcu_read_lock();
+	skp = smk_find_label_rcu(string, string_len);
+	rcu_read_unlock();
+	return skp;
+}
+
 /**
  * smk_parse_label_len - calculate the length of the starting segment
  *                       in the string that constitutes a valid smack label
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9271cd54bc43..5d3d72162444 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1484,7 +1484,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
-	struct smack_known *skp;
+	struct smack_known **skpp = NULL;
 	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
@@ -1492,19 +1492,17 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
-		skp = smk_import_entry(value, size);
-		if (!IS_ERR(skp))
-			isp->smk_inode = skp;
-	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0) {
-		skp = smk_import_entry(value, size);
-		if (!IS_ERR(skp))
-			isp->smk_task = skp;
-	} else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
-		skp = smk_import_entry(value, size);
-		if (!IS_ERR(skp))
-			isp->smk_mmap = skp;
-	}
+	if (strcmp(name, XATTR_NAME_SMACK) == 0)
+		skpp = &isp->smk_inode;
+	else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
+		skpp = &isp->smk_task;
+	else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0)
+		skpp = &isp->smk_mmap;
+	/*
+	 * Label has been imported by smack_inode_setxattr, just find it
+	 */
+	if (skpp)
+		*skpp = smk_find_label(value, size);
 
 	return;
 }
-- 
2.43.0

