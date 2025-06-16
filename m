Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FA2D023
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036080; cv=none; b=anwUespymykkgYVqmyexOuRilSyEcGhI2M41ap2F5+xxZFqSiTp07FmNfLYf6VxJ6H6hYi+ezgZ8nz3ljHyilgPeEcVT79BhHGfszsSzLZA/LCxzU5LwOjqDKNB/W1eIEEbPVoqwkvRj8/w+6v6fOEov7RKydwZ60YECMwbe7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036080; c=relaxed/simple;
	bh=HTkcxDMfsnKAs8iRrJbLTwacmSFBGt7cZ4T/HYn0GKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC2utJNbJucoOFl+zd2Pgj8iX0ONxlz11EuOu20T34WwqpCBsnUNA+QAlc0GF6mOf0ls6Vre/6WeRwGPe6QDjER5/VcSCuGOARFc3WYuJKOlzXZCf0w9X98ImZmLTywpygKIve3eqWvPGvBJB1Ptn7IJlLsQhyYk3dWn5Yg8Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=gu9cuSI+; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="gu9cuSI+"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E62HNADoTuk0uVVbZDVTFeVJ9kKluwYd72V5dwRp2qw=;
	b=gu9cuSI+91tnSlp1sxTNHxQwd1fewod8oOcbCgjmapdxQAfyGmRXd/MFZR+MXRLp1AgXcV
	Ni62hSAkqPoOAlXEzCAjNwxU5StbKe8FUXSpSsz2Cd6khNWMQIBrLl4BNGi/emTAvTWLTQ
	ignyb5bYmZ527oDQHpn/WmtFMrknRR0=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 2/5] smack: fix bug: SMACK64TRANSMUTE set on non-directory
Date: Mon, 16 Jun 2025 04:07:29 +0300
Message-ID: <20250616010745.800386-3-andreev@swemel.ru>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a new file system object is created
and the conditions for label transmutation are met,
the SMACK64TRANSMUTE extended attribute is set
on the object regardless of its type:
file, pipe, socket, symlink, or directory.

However,
SMACK64TRANSMUTE may only be set on directories.

This bug is a combined effect of the commits [1] and [2]
which both transfer functionality
from smack_d_instantiate() to smack_inode_init_security(),
but only in part.

Commit [1] set blank  SMACK64TRANSMUTE on improper object types.
Commit [2] set "TRUE" SMACK64TRANSMUTE on improper object types.

[1] 2023-06-10,
Fixes: baed456a6a2f ("smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()")
Link: https://lore.kernel.org/linux-security-module/20230610075738.3273764-3-roberto.sassu@huaweicloud.com/

[2] 2023-11-16,
Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-5-roberto.sassu@huaweicloud.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a7292d286f7c..2d3186e50c62 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1028,18 +1028,20 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (!trans_cred)
 			issp->smk_inode = dsp;
 
-		issp->smk_flags |= SMK_INODE_TRANSMUTE;
-		xattr_transmute = lsm_get_xattr_slot(xattrs,
-						     xattr_count);
-		if (xattr_transmute) {
-			xattr_transmute->value = kmemdup(TRANS_TRUE,
-							 TRANS_TRUE_SIZE,
-							 GFP_NOFS);
-			if (!xattr_transmute->value)
-				return -ENOMEM;
+		if (S_ISDIR(inode->i_mode)) {
+			issp->smk_flags |= SMK_INODE_TRANSMUTE;
+			xattr_transmute = lsm_get_xattr_slot(xattrs,
+							     xattr_count);
+			if (xattr_transmute) {
+				xattr_transmute->value = kmemdup(TRANS_TRUE,
+								 TRANS_TRUE_SIZE,
+								 GFP_NOFS);
+				if (!xattr_transmute->value)
+					return -ENOMEM;
 
-			xattr_transmute->value_len = TRANS_TRUE_SIZE;
-			xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
+				xattr_transmute->value_len = TRANS_TRUE_SIZE;
+				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
+			}
 		}
 	}
 
-- 
2.43.0

