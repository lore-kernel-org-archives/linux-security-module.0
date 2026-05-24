Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1832142B
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662285; cv=none; b=phmBS4JMY9809nCAJexf3iyOOEI8KIQ9SORJ7oPLNC2HyXrvCz+nMEjSicurIqN2QrcpvvmWxC/e0Op4o4Fh4QUjUO5H1pn3FUjUOzV+4oeU/sCLAwCXqrfZXoMW7ipqXRrF/FuPDtsYeAFri1EzQJ7RxTPYyERZBy0G/9U4KT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662285; c=relaxed/simple;
	bh=W0zSf4BM4+gqfONoLnGO6n3//pe3oqTDfgm1Xp6ssi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHjwgfayxQ7PAPBxWbxaQ1s55JD43RVlutYEPU8xXqOfuZHObUzy8dRDEstTczcSAU6oGIVlGRyvBVIySop88+sjo4OVYRzmkblcn6XiEXk9zYWMy48Euf/7As5ob5OJg9ohhxso71y7By+OXAP8vOttsTfpjc8I2BB+ETSzSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=gvt1g9r2; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="gvt1g9r2"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1779662275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUFI5oNY7/29pOScLRBeoxaxr3U4nhbDKpZjPfhOqic=;
	b=gvt1g9r2Oh+tNL8SOcYTFBfd/b79h51VirudFH1pVrYbPpRrZ5Pj6N73ow2LXeK4YJ+uhA
	zUyWim4zklNoI5ig74jwGXrZKi6brTdDbEWGD1UU64C4nY3x+wtqeqGxoBBwoXlVT8zObf
	tk6VELBRRGxybPkMh32owhJtq6BieTM=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] smack: deduplicate smackfs/{direct,mapped} file_operations
Date: Mon, 25 May 2026 01:37:48 +0300
Message-ID: <20260524223749.50874-2-andreev@swemel.ru>
In-Reply-To: <20260524223749.50874-1-andreev@swemel.ru>
References: <20260524223749.50874-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file_operations for smackfs/direct and smackfs/mapped are
identical up to a textual replacement of "direct" with "mapped"

This patch combines two instances of file_operations into one,
handling both files.

Fixes: f7112e6c9abf ("Smack: allow for significantly longer Smack labels v4")
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack.h   |   5 +-
 security/smack/smackfs.c | 135 ++++++++++++---------------------------
 2 files changed, 43 insertions(+), 97 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 9b9eb262fe33..6febc2ecdfe8 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -317,8 +317,9 @@ int smack_populate_secattr(struct smack_known *skp);
  * Shared data.
  */
 extern int smack_enabled __initdata;
-extern int smack_cipso_direct;
-extern int smack_cipso_mapped;
+extern int smack_cipso_auto_level[2];
+#define smack_cipso_direct (+smack_cipso_auto_level[0])
+#define smack_cipso_mapped (+smack_cipso_auto_level[1])
 extern struct smack_known *smack_net_ambient;
 extern struct smack_known *smack_syslog_label;
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f60d5469043e..946405645d5a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -83,18 +83,27 @@ static DEFINE_MUTEX(smk_net6addr_lock);
 struct smack_known *smack_net_ambient;
 
 /*
- * This is the level in a CIPSO header that indicates a
+ * Sensitivity levels for automatically created CIPSO labels.
+ * See smack_access.c`smack_populate_secattr()
+ *
+ * [0] "direct" labeling, label length < SMK_CIPSOLEN(24):
  * smack label is contained directly in the category set.
  * It can be reset via smackfs/direct
- */
-int smack_cipso_direct = SMACK_CIPSO_DIRECT_DEFAULT;
-
-/*
- * This is the level in a CIPSO header that indicates a
+ *
+ * [1] "mapped" labeling, label length >= SMK_CIPSOLEN(24):
  * secid is contained directly in the category set.
  * It can be reset via smackfs/mapped
  */
-int smack_cipso_mapped = SMACK_CIPSO_MAPPED_DEFAULT;
+int smack_cipso_auto_level[2] = {
+	SMACK_CIPSO_DIRECT_DEFAULT,
+	SMACK_CIPSO_MAPPED_DEFAULT,
+};
+
+static int
+smk_cipso_auto_level_idx(const struct file *file)
+{
+	return (file_inode(file)->i_ino != SMK_DIRECT);
+}
 
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 /*
@@ -1621,15 +1630,15 @@ static const struct file_operations smk_doi_ops = {
 };
 
 /**
- * smk_read_direct - read() for /smack/direct
- * @filp: file pointer, not actually used
+ * smk_read_cipso_auto_level - read() for smackfs/direct and smackfs/mapped
+ * @filp: file pointer
  * @buf: where to put the result
  * @count: maximum to send along
  * @ppos: where to start
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_direct(struct file *filp, char __user *buf,
+static ssize_t smk_read_cipso_auto_level(struct file *filp, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
 	char temp[80];
@@ -1638,26 +1647,28 @@ static ssize_t smk_read_direct(struct file *filp, char __user *buf,
 	if (*ppos != 0)
 		return 0;
 
-	sprintf(temp, "%d", smack_cipso_direct);
+	sprintf(temp, "%d", smack_cipso_auto_level[
+			      smk_cipso_auto_level_idx(filp)]);
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
 	return rc;
 }
 
 /**
- * smk_write_direct - write() for /smack/direct
- * @file: file pointer, not actually used
+ * smk_write_cipso_auto_level - write() for smackfs/direct and smackfs/mapped
+ * @filp: file pointer
  * @buf: where to get the data from
  * @count: bytes sent
  * @ppos: where to start
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t smk_write_direct(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t
+smk_write_cipso_auto_level(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *ppos)
 {
 	struct smack_known *skp;
-	int i, ret;
+	int i, ret, idx, old_lvl;
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
@@ -1669,94 +1680,28 @@ static ssize_t smk_write_direct(struct file *file, const char __user *buf,
 	/*
 	 * Don't do anything if the value hasn't actually changed.
 	 * If it is changing reset the level on entries that were
-	 * set up to be direct when they were created.
+	 * set up to be "auto" level when they were created.
 	 */
-	if (smack_cipso_direct != i) {
+	idx = smk_cipso_auto_level_idx(filp);
+	old_lvl = smack_cipso_auto_level[idx];
+
+	if (old_lvl != i) {
 		mutex_lock(&smack_known_lock);
 		list_for_each_entry_rcu(skp, &smack_known_list, list)
 			if (skp->smk_netlabel.attr.mls.lvl ==
-			    smack_cipso_direct)
+			    old_lvl)
 				skp->smk_netlabel.attr.mls.lvl = i;
-		smack_cipso_direct = i;
+		smack_cipso_auto_level[idx] = i;
 		mutex_unlock(&smack_known_lock);
 	}
 
 	return count;
 }
 
-static const struct file_operations smk_direct_ops = {
-	.read		= smk_read_direct,
-	.write		= smk_write_direct,
-	.llseek		= default_llseek,
-};
-
-/**
- * smk_read_mapped - read() for /smack/mapped
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
- *
- * Returns number of bytes read or error code, as appropriate
- */
-static ssize_t smk_read_mapped(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
-{
-	char temp[80];
-	ssize_t rc;
-
-	if (*ppos != 0)
-		return 0;
-
-	sprintf(temp, "%d", smack_cipso_mapped);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
-
-	return rc;
-}
-
-/**
- * smk_write_mapped - write() for /smack/mapped
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
- *
- * Returns number of bytes written or error code, as appropriate
- */
-static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct smack_known *skp;
-	int i, ret;
-
-	if (!smack_privileged(CAP_MAC_ADMIN))
-		return -EPERM;
-
-	ret = kstrtos32_from_user(buf, count, 10, &i);
-	if (unlikely(ret))
-		return ret;
-
-	/*
-	 * Don't do anything if the value hasn't actually changed.
-	 * If it is changing reset the level on entries that were
-	 * set up to be mapped when they were created.
-	 */
-	if (smack_cipso_mapped != i) {
-		mutex_lock(&smack_known_lock);
-		list_for_each_entry_rcu(skp, &smack_known_list, list)
-			if (skp->smk_netlabel.attr.mls.lvl ==
-			    smack_cipso_mapped)
-				skp->smk_netlabel.attr.mls.lvl = i;
-		smack_cipso_mapped = i;
-		mutex_unlock(&smack_known_lock);
-	}
-
-	return count;
-}
-
-static const struct file_operations smk_mapped_ops = {
-	.read		= smk_read_mapped,
-	.write		= smk_write_mapped,
+static const struct file_operations
+smk_cipso_auto_level_ops = {
+	.read		= smk_read_cipso_auto_level,
+	.write		= smk_write_cipso_auto_level,
 	.llseek		= default_llseek,
 };
 
@@ -2851,7 +2796,7 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SMK_DOI] = {
 			"doi", &smk_doi_ops, S_IRUGO|S_IWUSR},
 		[SMK_DIRECT] = {
-			"direct", &smk_direct_ops, S_IRUGO|S_IWUSR},
+			"direct", &smk_cipso_auto_level_ops, 0644},
 		[SMK_AMBIENT] = {
 			"ambient", &smk_ambient_ops, S_IRUGO|S_IWUSR},
 		[SMK_NET4ADDR] = {
@@ -2867,7 +2812,7 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SMK_ACCESSES] = {
 			"access", &smk_access_ops, S_IRUGO|S_IWUGO},
 		[SMK_MAPPED] = {
-			"mapped", &smk_mapped_ops, S_IRUGO|S_IWUSR},
+			"mapped", &smk_cipso_auto_level_ops, 0644},
 		[SMK_LOAD2] = {
 			"load2", &smk_load2_ops, S_IRUGO|S_IWUSR},
 		[SMK_LOAD_SELF2] = {
-- 
2.47.3

