Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5722D7809
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363214; cv=none; b=EhxXzFhYZpGRFoU/9xmKICBDaoPVdgIXK6hDGlbk2Dvky7G9wRFR8yM/V70QZCKjvKfc2d8mLd8mN/QTanKEjdos1QC9JLKR2P6DcNsS0cjL+ijSRrnbFteyxq4kf6NrYKewduuA5S2pYvyvfbNeVRRk3EWBdUfBiVqSZopqeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363214; c=relaxed/simple;
	bh=YBRNdzBBaalNDedErB2Pvdilkhg4anx/I4uPYH3l/rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj4YwSJr4m1rByzAVE+MLFA59pDoKGSt3PYLSbLHyURSsGoBlnFRaoxaSNZsRwXr7SRoi8H+rWgxstQSDVfxh9zbjSoNaHude7aLIqHerLhmPXjU5JSC4KKf9QGbjiWyKVA2gPO2QR5HKvGNFNPUszbNrcXsq1yE6Lznr5/XDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=qKVCOE9i; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="qKVCOE9i"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjP25Nqq3CWnL6MxlfLOLcK6Lg5WaMT3SGVgHs1Wy1I=;
	b=qKVCOE9i1PcHx5os81iZp+zixydaMyHJKuskSNit0+TrqRBVjhGMmkN0+/xHskrDfCx/UO
	RQi+/xHV6VaEE+P6MKlDxaFsuJP/RynIl1CnDZ6r/y3ZWHzQKkgIyuLwluKXZjRCzSoXrp
	NR8OmOEBVAN4ocvfwbFMT4hh84bb5Lg=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 02/19] smack: fix bug: changing Smack xattrs requires cap_mac_override
Date: Thu, 24 Jul 2025 16:09:35 +0300
Message-ID: <3dfea9d9c6474c08bdc883c124a887ea8206742a.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xattr-changing hooks (smack_inode_setxattr,
smack_inode_removexattr) treat Smack xattrs
(security.SMACK64*) like any other xattrs,
but additionally require the subject process
to possess cap_mac_admin.

These hooks treat "any other xattr" as if it is
just labeled data, so changing a Smack xattr,
like changing any other xattr,
requires the subject process to either possess
cap_mac_override or have a rule allowing it
to write to the object.

A curious effect arises here: the rule 'foo bar w'
allows subject 'foo' to relabel object 'bar'
to any label 8-O - clearly not what the rules
are designed for.

According to the Smack documentation [1,2],
possessing cap_mac_admin is necessary and sufficient
to change Smack xattrs (security.SMACK64*).

Treating Smack xattrs as labeled data
appears to be incorrect.

This change excludes the "labeled data check" for
Smack xattrs from the aforementioned hooks, making
cap_mac_admin sufficient to change Smack xattrs.

(2008-02-04 Casey Schaufler)
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

[1] Documentation/admin-guide/LSM/Smack.rst

[2] 2012-06-05 Casey Schaufler
commit 1880eff77e7a ("Smack: onlycap limits on CAP_MAC_ADMIN")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 105 +++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 42fdac05d32d..5a159a2653a6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -175,7 +175,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 #endif
 
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
-static int smk_bu_inode(struct inode *inode, int mode, int rc)
+static int smk_bu_inode(const struct inode * const inode, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *isp = smack_inode(inode);
@@ -1343,65 +1343,67 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 				struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags)
 {
-	struct smk_audit_info ad;
-	struct smack_known *skp;
-	int check_priv = 0;
 	int check_import = 0;
 	int check_star = 0;
-	int rc = 0;
-	umode_t const i_mode = d_backing_inode(dentry)->i_mode;
+	struct inode * const inode = d_backing_inode(dentry);
+	umode_t const i_mode = inode->i_mode;
 
 	/*
 	 * Check label validity here so import won't fail in post_setxattr
 	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
 		/*
-		 * UDS inode has fixed label
+		 * inode of socket file descriptor (sockfs inode) and
+		 * UDS inode have fixed label
 		 */
-		if (S_ISSOCK(i_mode)) {
-			rc = -EINVAL;
-		} else {
-			check_priv = 1;
-			check_import = 1;
-		}
+		if (S_ISSOCK(i_mode))
+			return -EINVAL;
+		check_import = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
-		check_priv = 1;
 		check_import = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
-		check_priv = 1;
 		check_import = 1;
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
-		check_priv = 1;
 		if (!S_ISDIR(i_mode) ||
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
-			rc = -EINVAL;
+			return -EINVAL;
+	} else {
+		/*
+		 * treat other xattrs as labeled data
+		 */
+		struct smk_audit_info ad;
+
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+		smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+
+		return smk_bu_inode(inode, MAY_WRITE,
+		       smk_curacc(smk_of_inode(inode), MAY_WRITE, &ad));
 	}
 
-	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
-		rc = -EPERM;
+	if (!smack_privileged(CAP_MAC_ADMIN))
+		return -EPERM;
 
-	if (rc == 0 && check_import) {
-		skp = size ? smk_import_entry(value, size) : NULL;
+	if (check_import) {
+		const struct smack_known *skp;
+
+		if (size == 0)
+			return -EINVAL;
+
+		skp = smk_import_entry(value, size);
 		if (IS_ERR(skp))
-			rc = PTR_ERR(skp);
-		else if (skp == NULL || (check_star &&
-		    (skp == &smack_known_star || skp == &smack_known_web)))
-			rc = -EINVAL;
+			return PTR_ERR(skp);
+
+		if (check_star &&
+		    (skp == &smack_known_star ||
+		     skp == &smack_known_web))
+			return -EINVAL;
 	}
 
-	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
-	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
-
-	if (rc == 0) {
-		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
-	}
-
-	return rc;
+	return 0;
 }
 
 /**
@@ -1452,6 +1454,9 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
  */
 static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 {
+	/*
+	 * treat all xattrs as labeled data
+	 */
 	struct smk_audit_info ad;
 	int rc;
 
@@ -1476,9 +1481,8 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 static int smack_inode_removexattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, const char *name)
 {
-	struct inode_smack *isp;
-	struct smk_audit_info ad;
-	int rc = 0;
+	const struct inode * const inode = d_backing_inode(dentry);
+	struct inode_smack * const isp = smack_inode(inode);
 
 	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
 	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
@@ -1487,21 +1491,20 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0 ||
 	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
 		if (!smack_privileged(CAP_MAC_ADMIN))
-			rc = -EPERM;
+			return -EPERM;
+	} else {
+		/*
+		 * treat other xattrs as labeled data
+		 */
+		struct smk_audit_info ad;
+
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+		smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+
+		return smk_bu_inode(inode, MAY_WRITE,
+		       smk_curacc(isp->smk_inode, MAY_WRITE, &ad));
 	}
 
-	if (rc != 0)
-		return rc;
-
-	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
-	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
-
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
-	if (rc != 0)
-		return rc;
-
-	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1509,7 +1512,7 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	 *	XATTR_NAME_SMACK if S_ISSOCK (UDS inode has fixed label)
 	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
-		if (!S_ISSOCK(d_backing_inode(dentry)->i_mode)) {
+		if (!S_ISSOCK(inode->i_mode)) {
 			struct super_block *sbp = dentry->d_sb;
 			struct superblock_smack *sbsp = smack_superblock(sbp);
 
-- 
2.43.0

