Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C827470
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036080; cv=none; b=JjJQzv2WvO5JrmOjOCg/8nTh9ieoTvWZYyHiy52EuNFuQInUkVkYkl5flagzz5fJf9S8eSzhGyLheV0zklo2H5FY0nr1rEr1ckwVUo6vfFOLDs4WEzsQvVm6bTjEfK9cCwAM5sDCue3zZ+KsSuLePLnQlOMMs3pRIlcLoYmn1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036080; c=relaxed/simple;
	bh=/cvsIg0QsgXOZLHeyUT29F7ueRlzDbA6vWmU9mLXNz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNA7am48A7Hd0q4PXPectTuBbl/fttnwtoqp06AGGSPavlhfjL2N3SwnpFjpLVwgpaFf4hTtmA4pz+O+YcvEQcy9qrsNdWWDXY2baTsBi2z9qEO2vBniwU62s1NRQcx3f3RC+onBINtU30mzbGMnEwa7mv8S8bTVZ5xVN26VIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=HMmQWqQ1; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="HMmQWqQ1"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvWAoYG+VskRbDCPNqSiy9QQMmUOimybNFviRsaxBfk=;
	b=HMmQWqQ1CkytJYnxr0I08npgMSNNATjSMIpgFx1O/XuCf3PkFCJcPwKes1OmreG1M77Uo8
	1XV5dKInrzne0vdpUJxRIpYULfSenRRrUyuFcd9oh420PLFOvN6gS0akw212bFLd4jVagn
	MKkyrOp4g1IoRLQKGx7eFEOFb+7caNA=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 3/5] smack: deduplicate xattr setting in smack_inode_init_security()
Date: Mon, 16 Jun 2025 04:07:30 +0300
Message-ID: <20250616010745.800386-4-andreev@swemel.ru>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 54 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2d3186e50c62..2b46a2867226 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,6 +981,24 @@ smk_rule_transmutes(struct smack_known *subject,
 	return (may > 0) && (may & MAY_TRANSMUTE);
 }
 
+static int
+xattr_dupval(struct xattr *xattrs, int *xattr_count,
+	     const char *name, const void *value, unsigned int vallen)
+{
+	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+
+	if (!xattr)
+		return 0;
+
+	xattr->value = kmemdup(value, vallen, GFP_NOFS);
+	if (!xattr->value)
+		return -ENOMEM;
+
+	xattr->value_len = vallen;
+	xattr->name = name;
+	return 0;
+}
+
 /**
  * smack_inode_init_security - copy out the smack from an inode
  * @inode: the newly created inode
@@ -998,7 +1016,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	bool trans_cred;
 	bool trans_rule;
 
@@ -1017,8 +1034,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	 * Mark the inode as changed.
 	 */
 	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
-		struct xattr *xattr_transmute;
-
 		/*
 		 * The caller of smack_dentry_create_files_as()
 		 * should have overridden the current cred, so the
@@ -1030,35 +1045,22 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 
 		if (S_ISDIR(inode->i_mode)) {
 			issp->smk_flags |= SMK_INODE_TRANSMUTE;
-			xattr_transmute = lsm_get_xattr_slot(xattrs,
-							     xattr_count);
-			if (xattr_transmute) {
-				xattr_transmute->value = kmemdup(TRANS_TRUE,
-								 TRANS_TRUE_SIZE,
-								 GFP_NOFS);
-				if (!xattr_transmute->value)
-					return -ENOMEM;
 
-				xattr_transmute->value_len = TRANS_TRUE_SIZE;
-				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
-			}
+			if (xattr_dupval(xattrs, xattr_count,
+				XATTR_SMACK_TRANSMUTE,
+				TRANS_TRUE,
+				TRANS_TRUE_SIZE
+			))
+				return -ENOMEM;
 		}
 	}
 
 	issp->smk_flags |= SMK_INODE_INSTANT;
 
-	if (xattr) {
-		const char *inode_label = issp->smk_inode->smk_known;
-
-		xattr->value = kstrdup(inode_label, GFP_NOFS);
-		if (!xattr->value)
-			return -ENOMEM;
-
-		xattr->value_len = strlen(inode_label);
-		xattr->name = XATTR_SMACK_SUFFIX;
-	}
-
-	return 0;
+	return xattr_dupval(xattrs, xattr_count,
+			    XATTR_SMACK_SUFFIX,
+			    issp->smk_inode->smk_known,
+		     strlen(issp->smk_inode->smk_known));
 }
 
 /**
-- 
2.43.0

