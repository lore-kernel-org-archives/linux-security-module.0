Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9792D543D
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=lXnyhhFJurj3XWC3iAOAwpkz73QOEnRrlt0u0jrk2Rhs//x5ZHiy4gLMCgLk2mu+g5coDAkX1GkHszvst1RpgkPjnA9QXGTyQQQVkCUnZ8SGKzogFcI7q8uIhlv0EOzvVhb/Wz0PvY4nsxU3QvyEMSbJ1fQCiYHSAGvowtHkO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=Av0yxjzhFwBvLV/HGjZEGbQbA/cOAU8vKGNmkrSy9Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5NLXsdcL2zsJakO+jmnVo769vkMcm0sL+o1rKz+29WAUMHDsU7OrZ2Fmxh97Jx9PjEppL3R90A5M/6F4q2OfoQEMw01HAjmEBPBrXXyXTDpxTGT8/bPkmhdCje0Wjbynkrm7tAUMrxQzfGAVLHZQSxEC+vhP6LUyiAdJyVTQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Jc6rDJa9; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Jc6rDJa9"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr1RGMeRgy9xyVGtkplYQ5jqlo8GkNgKxRwpyemd3RY=;
	b=Jc6rDJa9xB+jxw+eAfs1m4SR7zG85gYMKx46dByo7Oeu9wrwp7bOnPx6Lrj7d1/EjeU9YZ
	AzZShkxVaNsfU2ta+oS52i3s3EcHj8X38MD/zkcOav8hRZF5m0Wrj0X0WMTNvlbIPEus/T
	y++ZgaeWSk8VYM5/AqtMX+5kmDbzFnk=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 13/19] smack: restrict setxattr() SMACK64EXEC/MMAP to regular files
Date: Thu, 24 Jul 2025 16:09:46 +0300
Message-ID: <dcd7ab960d9ed3fee8936cbc2f130b3b5128dfe2.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMACK64EXEC and SMACK64MMAP xattrs apply
only to regular files. However, setxattr() currently
allows setting them on any filesystem object,
including FIFOs, device nodes, and others. E.g.

   root# setfattr  -n security.SMACK64EXEC -v foo /dev/null
   root# getfattr -hn security.SMACK64EXEC        /dev/null
   # file: dev/null
   security.SMACK64EXEC="foo"

This change restricts setting SMACK64EXEC and
SMACK64MMAP to regular files only.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a66fa2c16dc2..6712fa047722 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1425,6 +1425,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 			return -EOPNOTSUPP;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
+		if (!S_ISREG(i_mode))
+			return -EOPNOTSUPP;
 		task_label = true;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		if (!S_ISDIR(i_mode) ||
@@ -3754,15 +3756,17 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		/*
 		 * Don't let the exec or mmap label be "*" or "@".
 		 */
-		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
-		if (IS_ERR(skp) || smk_task_invalid_label(skp))
-			skp = NULL;
-		isp->smk_task = skp;
+		if (S_ISREG(inode->i_mode)) {
+			skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
+			if (IS_ERR(skp) || smk_task_invalid_label(skp))
+				skp = NULL;
+			isp->smk_task = skp;
 
-		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
-		if (IS_ERR(skp) || smk_task_invalid_label(skp))
-			skp = NULL;
-		isp->smk_mmap = skp;
+			skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
+			if (IS_ERR(skp) || smk_task_invalid_label(skp))
+				skp = NULL;
+			isp->smk_mmap = skp;
+		}
 
 		dput(dp);
 		break;
-- 
2.43.0

