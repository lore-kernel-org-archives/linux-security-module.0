Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB12D541E
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362633; cv=none; b=QSAZADAeDTAocR3WQB7BlcS0Kxps4KSzzPJeb7vIeu0xZ4sBDDQhxq+3801Iz3PD6Oqer7l1tIc4/b6SALAc0WPeHn4G7L68fwCV20zMDYDHQ1SpUrF1ydhs5L07PjUzpA+XZeOpQlQBYktil9AAjzSIsEn53FDXqZyISmlD9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362633; c=relaxed/simple;
	bh=hlWdOzi5wzaLWjpUOQ3Eahe+iFYLiZCAV8O8I0bP0Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq2Jq3y6syX+gcQMxvxXKcU3Fmi1mVOdz9JEpQd2GnRWkrvVs9I/c/ku5oZHhVSoRIu53GhhXHj9swwUktWVbguqwKkRCjLhQ2i3aXMKzsCPTS5bSSIg4KRMdnZM+jjmbgmbp3bVVLJxTacDuLY7MI7m+HXyicLVrID392Dx6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jrLh1V4s; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jrLh1V4s"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fq3VOJ1dJreCiLx0hahE6thxJnrKBL5E3rFCrZ8p+W4=;
	b=jrLh1V4sD1q6kt9MctPdn3CdSqj2+bUuNnBdLDjjXoZHu1+vOuY1+tyW1O+0K98/R4DEi6
	QTdo0Vo4YKU5TaZoOu2rhfQ3M3jLnYbpEW1h43n+VWNYEVRu6Bc4WzbQE4/9OP0rrR6+Kn
	NQZFPdf9mDQV5M2vg2AE3TZaz9BKrkQ=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 11/19] smack: fix bug: smack_inode_setsecurity() false EINVAL for alien xattrs
Date: Thu, 24 Jul 2025 16:09:44 +0300
Message-ID: <9e89e63e2d419aba71b11100ababb36affce9da0.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, smack_inode_setsecurity() checks
the validity of the xattr value before checking
whether the xattr is actually a Smack xattr.

This was correct when only one LSM
could be active in the system.
Since [1] this is no longer incorrect.

When Smack mistakenly EINVALidates a non-Smack xattr,
Smack may prevent owner LSM from seeing the xattr.

The change ensures that the xattr is recognized
as a Smack xattr before looking into the value.

[1] 2015-05-02 Casey Schaufler
Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6f74be82ae45..672be8b47821 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2979,6 +2979,15 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	struct socket *sock;
 	int rc = 0;
 
+	if (!(strcmp(name, XATTR_SMACK_SUFFIX) == 0 ||
+	      strcmp(name, XATTR_SMACK_TRANSMUTE) == 0 ||
+	      strcmp(name, XATTR_SMACK_EXEC) == 0 ||
+	      strcmp(name, XATTR_SMACK_MMAP) == 0 ||
+	      strcmp(name, XATTR_SMACK_IPIN) == 0 ||
+	      strcmp(name, XATTR_SMACK_IPOUT) == 0
+	))
+		return -EOPNOTSUPP;
+
 	if (value == NULL || size > SMK_LONGLABEL || size == 0)
 		return -EINVAL;
 
@@ -2991,14 +3000,6 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		return 0;
 	}
 
-	if (!(strcmp(name, XATTR_SMACK_SUFFIX) == 0 ||
-	      strcmp(name, XATTR_SMACK_EXEC) == 0 ||
-	      strcmp(name, XATTR_SMACK_MMAP) == 0 ||
-	      strcmp(name, XATTR_SMACK_IPIN) == 0 ||
-	      strcmp(name, XATTR_SMACK_IPOUT) == 0
-	))
-		return -EOPNOTSUPP;
-
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
-- 
2.43.0

