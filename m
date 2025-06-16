Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED32D023
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036083; cv=none; b=rQHOvj+JqZSHEvgDohkWZX65NQc+Tt23/6u0JjRkRFY9R2F8Y4OCtOWowBLNoQ+aGRrfQuHmfAxetq8+VILMa/cf3OjJNHMY/8MChmJfpEetPOXxo7wKdw6BrHBZWUkRl5c/FyU6m5dNNUKa5PtpWvjczgC/tQw1rDSGtn+TSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036083; c=relaxed/simple;
	bh=H5LCpxeVZVKp97f/X5ltzHs546eZeGHlYuWVuwUZfgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDXBjpOv8EB7S51U5/zw5ycMBnI3GVdSVjTZ/oy3oF0aTkW919LZoTHiTetkkzy1DG9nggu9OAwMRSJKX0k7fBYF3VHbzK1aHnWrNyDveizsQmuu+4nasEzJvWJtDptCZJID1ux1qYBAstUUmwSFdGnOkmal//rC2PigyH4Rr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=WZs9Xket; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="WZs9Xket"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw8dzEpyRjzUuT4BsCGQ9CIXN/akF3/fQIDPmq/u4mQ=;
	b=WZs9XketUXV0HjVKX6ezDnz0vHOFRpiPSdNpUobp90zIBXAIzQ8tLBdTR8UBCtZPyy6NOt
	nnRoIgPxIoDhGE06DxcVsQy2+Efp9x0zPHvmNyn6I2m+RURjXLFbLspXiDyXOVvXLYsu/3
	bRMDMXDvdg7mxFyWaHnRDw2jU1MBu4M=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
Date: Mon, 16 Jun 2025 04:07:32 +0300
Message-ID: <20250616010745.800386-6-andreev@swemel.ru>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to [1], the label of a UNIX domain socket (UDS)
file (i.e., the filesystem object representing the socket)
is not supposed to participate in Smack security.

To achieve this, [1] labels UDS files with "*"
in smack_d_instantiate().

Before [2], smack_d_instantiate() was responsible
for initializing Smack security for all inodes,
except ones under /proc

[2] imposed the sole responsibility for initializing
inode security for newly created filesystem objects
on smack_inode_init_security().

However, smack_inode_init_security() lacks some logic
present in smack_d_instantiate().
In particular, it does not label UDS files with "*".

This patch adds the missing labeling of UDS files
with "*" to smack_inode_init_security().

Labeling UDS files with "*" in smack_d_instantiate()
still works for stale UDS files that already exist on
disk. Stale UDS files are useless, but I keep labeling
them for consistency and maybe to make easier for user
to delete them.

Compared to [1], this version introduces the following
improvements:

  * UDS file label is held inside inode only
    and not saved to xattrs.

  * relabeling UDS files (setxattr, removexattr, etc.)
    is blocked.

[1] 2010-11-24 Casey Schaufler
commit b4e0d5f0791b ("Smack: UDS revision")

[2] 2023-11-16 roberto.sassu
Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-5-roberto.sassu@huaweicloud.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 Documentation/admin-guide/LSM/Smack.rst |  5 +++
 security/smack/smack_lsm.c              | 58 +++++++++++++++++++------
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Smack.rst b/Documentation/admin-guide/LSM/Smack.rst
index 6d44f4fdbf59..1b554b5bf98e 100644
--- a/Documentation/admin-guide/LSM/Smack.rst
+++ b/Documentation/admin-guide/LSM/Smack.rst
@@ -696,6 +696,11 @@ sockets.
 	A privileged program may set this to match the label of another
 	task with which it hopes to communicate.
 
+UNIX domain socket (UDS) with a BSD address functions both as a file in a
+filesystem and as a socket. As a file, it carries the SMACK64 attribute. This
+attribute is not involved in Smack security enforcement and is immutably
+assigned the label "*".
+
 Smack Netlabel Exceptions
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fb23254c8a54..1b41ae053966 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	bool trans_cred;
 	bool trans_rule;
 
+	/*
+	 * UNIX domain sockets use lower level socket data. Let
+	 * UDS inode have fixed * label to keep smack_inode_permission() calm
+	 * when called from unix_find_bsd()
+	 */
+	if (S_ISSOCK(inode->i_mode)) {
+		/* forced label, no need to save to xattrs */
+		issp->smk_inode = &smack_known_star;
+		goto instant_inode;
+	}
 	/*
 	 * If equal, transmuting already occurred in
 	 * smack_dentry_create_files_as(). No need to check again.
@@ -1057,14 +1067,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		}
 	}
 
-	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
-	if (rc)
-		return rc;
-
-	return xattr_dupval(xattrs, xattr_count,
+	if (rc == 0)
+		if (xattr_dupval(xattrs, xattr_count,
 			    XATTR_SMACK_SUFFIX,
 			    issp->smk_inode->smk_known,
-		     strlen(issp->smk_inode->smk_known));
+		     strlen(issp->smk_inode->smk_known)
+		))
+			rc = -ENOMEM;
+instant_inode:
+	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
+	return rc;
 }
 
 /**
@@ -1338,13 +1350,23 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	int check_import = 0;
 	int check_star = 0;
 	int rc = 0;
+	umode_t const i_mode = d_backing_inode(dentry)->i_mode;
 
 	/*
 	 * Check label validity here so import won't fail in post_setxattr
 	 */
-	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
+	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
+		/*
+		 * UDS inode has fixed label
+		 */
+		if (S_ISSOCK(i_mode)) {
+			rc = -EINVAL;
+		} else {
+			check_priv = 1;
+			check_import = 1;
+		}
+	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
+		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
 		check_priv = 1;
 		check_import = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
@@ -1354,7 +1376,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		if (!S_ISDIR(i_mode) ||
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
@@ -1485,12 +1507,15 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
 	 *	XATTR_NAME_SMACKIPOUT
+	 *	XATTR_NAME_SMACK if S_ISSOCK (UDS inode has fixed label)
 	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
-		struct super_block *sbp = dentry->d_sb;
-		struct superblock_smack *sbsp = smack_superblock(sbp);
+		if (!S_ISSOCK(d_backing_inode(dentry)->i_mode)) {
+			struct super_block *sbp = dentry->d_sb;
+			struct superblock_smack *sbsp = smack_superblock(sbp);
 
-		isp->smk_inode = sbsp->smk_default;
+			isp->smk_inode = sbsp->smk_default;
+		}
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
 		isp->smk_task = NULL;
 	else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0)
@@ -3608,7 +3633,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		 */
 
 		/*
-		 * UNIX domain sockets use lower level socket data.
+		 * UDS inode has fixed label (*)
 		 */
 		if (S_ISSOCK(inode->i_mode)) {
 			final = &smack_known_star;
@@ -4879,6 +4904,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+	/*
+	 * UDS inode has fixed label. Ignore nfs label.
+	 */
+	if (S_ISSOCK(inode->i_mode))
+		return 0;
 	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
 				       ctxlen, 0);
 }
-- 
2.43.0

