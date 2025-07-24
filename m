Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5392D63FB
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362638; cv=none; b=HCJpn/Qkwn+Pq78EOAZc47Oh2QSIy+EF3cyLVKuwUwq5VQMcPzEfgEtHd/eGEwuwIhaVlxSqnQppc4iqRDFj/a1IED6kNDg54o+4K3LOt8ycvl9NAN9ETxx3YobCg5eJn6912LP4L1b4Z5SHa3ppD5LB1WRbEk+H969AJqFz3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362638; c=relaxed/simple;
	bh=tgo+3ap1rSBNIVGMkVDLq23az9WqBLhJcaUqCeR5O5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEAOvbq7/iVDJmKQoqyXvo3Q7KTnfvT7ceo4XQitnjd1YqHCuCvIe0wnh6YyIfsEeGswywwqvS7agqSLjD+rx72jROtK1lCwYRT0ZYNV4TZjtbklfZG2c7RdSLcY7rf8kvLATaRfl/U9HeNvjqbmjWzdme9Apy+3lV+5ANlhD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=qd9K5JwF; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="qd9K5JwF"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUQdc7pwAPqPyY22TWhAgepwM/+tgMQIE7vUmSS2wxc=;
	b=qd9K5JwFgXhmk+6DXKHM0kQyJMN8XI3L85yvWOYQsVrr8234dZ2ws+omH45YAfO4OOfK6g
	CfUOm4noHm0QXJ4ELaARKNW1ef7aexMUJIQnvivcQ/KiZm81gdksHuLzOybuCb//d9OhOh
	FV2HA6TqzSX6GsOBfesWktPItDPa7qQ=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 19/19] smack: deduplicate strcmp(name, XATTR_{,NAME_}SMACK*)
Date: Thu, 24 Jul 2025 16:09:52 +0300
Message-ID: <ec5d22f8450b3adbf056eecc0b02d0b3c8abfdb5.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 170 ++++++++++++++++++++++++-------------
 1 file changed, 109 insertions(+), 61 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6c529de00584..81c0f69202ea 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -96,6 +96,49 @@ static int match_opt_prefix(char *s, int l, char **arg)
 	return Opt_error;
 }
 
+enum smack_xa {
+	SMK_XA_OBJECT,    // security.SMACK64
+	SMK_XA_IPIN,      // security.SMACK64IPIN
+	SMK_XA_IPOUT,     // security.SMACK64IPOUT
+	SMK_XA_EXEC,      // security.SMACK64EXEC
+	SMK_XA_MMAP,      // security.SMACK64MMAP
+	SMK_XA_TRANSMUTE, // security.SMACK64TRANSMUTE
+};
+
+static const char * const
+smk_xa_suffix[] = {
+	[SMK_XA_OBJECT]    = "",
+	[SMK_XA_IPIN]      = "IPIN",
+	[SMK_XA_IPOUT]     = "IPOUT",
+	[SMK_XA_EXEC]      = "EXEC",
+	[SMK_XA_MMAP]      = "MMAP",
+	[SMK_XA_TRANSMUTE] = "TRANSMUTE",
+};
+
+static int
+smk_xa_suffix_to_id(const char *suffix)
+{
+	return match_string(smk_xa_suffix, ARRAY_SIZE(smk_xa_suffix), suffix);
+}
+
+static int
+smk_xa_name_to_id(const char *name)
+{
+	if (strncmp(name, XATTR_NAME_SMACK, sizeof(XATTR_NAME_SMACK) - 1))
+		return -EINVAL;
+
+	return smk_xa_suffix_to_id(name + (sizeof(XATTR_NAME_SMACK) - 1));
+}
+
+static int
+smk_xa_secname_to_id(const char *name)
+{
+	if (strncmp(name, XATTR_SMACK_SUFFIX, sizeof(XATTR_SMACK_SUFFIX) - 1))
+		return -EINVAL;
+
+	return smk_xa_suffix_to_id(name + (sizeof(XATTR_SMACK_SUFFIX) - 1));
+}
+
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static char *smk_bu_mess[] = {
 	"Bringup Error",	/* Unused */
@@ -1355,18 +1398,7 @@ static int smack_inode_getattr(const struct path *path)
  */
 static int smack_inode_xattr_skipcap(const char *name)
 {
-	if (strncmp(name, XATTR_NAME_SMACK, sizeof(XATTR_NAME_SMACK) - 1))
-		return 0;
-
-	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0)
-		return 1;
-
-	return 0;
+	return (smk_xa_name_to_id(name) >= 0);
 }
 
 /*
@@ -1406,15 +1438,17 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	struct inode * const inode = d_backing_inode(dentry);
 	umode_t const i_mode = inode->i_mode;
 
-	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
+	switch (smk_xa_name_to_id(name)) {
+	case SMK_XA_OBJECT:
 		/*
 		 * inode of socket file descriptor (sockfs inode) and
 		 * UDS inode have fixed label
 		 */
 		if (S_ISSOCK(i_mode))
 			return -EOPNOTSUPP;
-	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
-		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
+		break;
+	case SMK_XA_IPIN:
+	case SMK_XA_IPOUT:
 		/*
 		 * inode of socket file descriptor (sockfs inode) only
 		 */
@@ -1423,19 +1457,22 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 
 		if (SOCKET_I(inode)->sk == NULL)
 			return -EOPNOTSUPP;
-	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
-		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
+		break;
+	case SMK_XA_EXEC:
+	case SMK_XA_MMAP:
 		if (!S_ISREG(i_mode))
 			return -EOPNOTSUPP;
 		task_label = true;
-	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
+		break;
+	case SMK_XA_TRANSMUTE:
 		if (!S_ISDIR(i_mode))
 			return -EOPNOTSUPP;
 		if (size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			return -EINVAL;
 		label_inside = false;
-	} else {
+		break;
+	default: {
 		/*
 		 * treat other xattrs as labeled data
 		 */
@@ -1447,6 +1484,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		return smk_bu_inode(inode, MAY_WRITE,
 		       smk_curacc(smk_of_inode(inode), MAY_WRITE, &ad));
 	}
+	}
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
@@ -1487,17 +1525,21 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 	struct smack_known **skpp = NULL;
 	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
-	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
+	switch (smk_xa_name_to_id(name)) {
+	case SMK_XA_TRANSMUTE:
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
 		return;
+	case SMK_XA_OBJECT:
+		skpp = &isp->smk_inode;
+		break;
+	case SMK_XA_EXEC:
+		skpp = &isp->smk_task;
+		break;
+	case SMK_XA_MMAP:
+		skpp = &isp->smk_mmap;
+		break;
 	}
 
-	if (strcmp(name, XATTR_NAME_SMACK) == 0)
-		skpp = &isp->smk_inode;
-	else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
-		skpp = &isp->smk_task;
-	else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0)
-		skpp = &isp->smk_mmap;
 	/*
 	 * Label has been imported by smack_inode_setxattr, just find it
 	 */
@@ -1545,16 +1587,9 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 {
 	const struct inode * const inode = d_backing_inode(dentry);
 	struct inode_smack * const isp = smack_inode(inode);
+	int const xa_id = smk_xa_name_to_id(name);
 
-	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
-		if (!smack_privileged(CAP_MAC_ADMIN))
-			return -EPERM;
-	} else {
+	if (xa_id < 0) {
 		/*
 		 * treat other xattrs as labeled data
 		 */
@@ -1567,25 +1602,34 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 		       smk_curacc(isp->smk_inode, MAY_WRITE, &ad));
 	}
 
+	if (!smack_privileged(CAP_MAC_ADMIN))
+		return -EPERM;
+
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
 	 *	XATTR_NAME_SMACKIPOUT
 	 *	XATTR_NAME_SMACK if S_ISSOCK (UDS inode has fixed label)
 	 */
-	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
+	switch (xa_id) {
+	case SMK_XA_OBJECT:
 		if (!S_ISSOCK(inode->i_mode)) {
 			struct super_block *sbp = dentry->d_sb;
 			struct superblock_smack *sbsp = smack_superblock(sbp);
 
 			isp->smk_inode = sbsp->smk_default;
 		}
-	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
+		break;
+	case SMK_XA_EXEC:
 		isp->smk_task = NULL;
-	else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0)
+		break;
+	case SMK_XA_MMAP:
 		isp->smk_mmap = NULL;
-	else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0)
+		break;
+	case SMK_XA_TRANSMUTE:
 		isp->smk_flags &= ~SMK_INODE_TRANSMUTE;
+		break;
+	}
 
 	return 0;
 }
@@ -1676,20 +1720,26 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 	const struct inode_smack * const isp = smack_inode(inode);
 	const char *value = NULL;
 	int value_len;
+	int const xa_id = smk_xa_secname_to_id(name);
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
+	switch (xa_id) {
+	case SMK_XA_OBJECT:
 		skp = isp->smk_inode;
-	} else if (strcmp(name, XATTR_SMACK_EXEC) == 0) {
+		break;
+	case SMK_XA_EXEC:
 		skp = isp->smk_task;
-	} else if (strcmp(name, XATTR_SMACK_MMAP) == 0) {
+		break;
+	case SMK_XA_MMAP:
 		skp = isp->smk_mmap;
-	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		break;
+	case SMK_XA_TRANSMUTE:
 		if (isp->smk_flags & SMK_INODE_TRANSMUTE)
 			value = TRANS_TRUE;
 		else
 			return -ENODATA;
-	} else if (strcmp(name, XATTR_SMACK_IPIN) == 0 ||
-		   strcmp(name, XATTR_SMACK_IPOUT) == 0) {
+		break;
+	case SMK_XA_IPIN:
+	case SMK_XA_IPOUT: {
 		/*
 		 * These Smack xattrs are only on sockets.
 		 */
@@ -1705,12 +1755,15 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 
 		ssp = smack_sock(sk);
 
-		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
+		if (xa_id == SMK_XA_IPIN)
 			skp = ssp->smk_in;
 		else
 			skp = ssp->smk_out;
-	} else
+		break;
+	}
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	if (!value) {
 		if (!skp)
@@ -2986,28 +3039,23 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
+	int const xa_id = smk_xa_secname_to_id(name);
 
-	if (!(strcmp(name, XATTR_SMACK_SUFFIX) == 0 ||
-	      strcmp(name, XATTR_SMACK_TRANSMUTE) == 0 ||
-	      strcmp(name, XATTR_SMACK_EXEC) == 0 ||
-	      strcmp(name, XATTR_SMACK_MMAP) == 0 ||
-	      strcmp(name, XATTR_SMACK_IPIN) == 0 ||
-	      strcmp(name, XATTR_SMACK_IPOUT) == 0
-	))
+	if (xa_id < 0)
 		return -EOPNOTSUPP;
 
-	if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+	switch (xa_id) {
+	case SMK_XA_TRANSMUTE:
 		nsp->smk_flags |= SMK_INODE_TRANSMUTE;
 		return 0;
-	}
-
-	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
-	    strcmp(name, XATTR_SMACK_MMAP) == 0)
+	case SMK_XA_EXEC:
+	case SMK_XA_MMAP:
 		return -ENODATA;
+	}
 
 	skp = smk_find_label(value, size);
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
+	if (xa_id == SMK_XA_OBJECT) {
 		nsp->smk_inode = skp;
 		nsp->smk_flags |= SMK_INODE_INSTANT;
 		return 0;
@@ -3020,7 +3068,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	sock = SOCKET_I(inode);
 	ssp = smack_sock(sock->sk);
 
-	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
+	if (xa_id == SMK_XA_IPIN)
 		ssp->smk_in = skp;
 	else {
 		ssp->smk_out = skp;
-- 
2.43.0

