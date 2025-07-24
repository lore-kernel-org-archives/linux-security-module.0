Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4122D5C92
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362637; cv=none; b=NkDtwxd9pRK7OxuqJMF9WDtFgEsSrQaNbTgnqXAgCO2k9vrVsQHyVfA/S3IGyrk2jM5ereBWTIdGxh+AYMytq2s1LU9xotcLDybjBFKTzX8HOMen15pM4aRAo1f3E/GGCNrtHr0ZoFeplfdYphe8Kj40hh2vGHRu1JYd1/sVQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362637; c=relaxed/simple;
	bh=y83/msWZ7Ksmr9uI615mCw0FZI2msaADr4qQVf0Ecdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeFz0UFjBblfLODtGvjg8xKCrmox5xwpJd4ffdW9uBtekqwbwYT5I3peGhxCI605wY98qapM9YImWUr5CAmTecOTkZfC+DtxfDn/bQwSeMUSwmZa7glq5RHoJhMeDiUHTrXbjrXUj20X9ILQ6/b/Iuu66imG+Aa/5ziRyCOowpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=FAw6Z70j; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="FAw6Z70j"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYvH/LFrG+OUKse2QwPi9wnz1Fh2sZzWPhHtC0W6JBg=;
	b=FAw6Z70jsKkY1l1rvSVifPWOC6kR3UPATHiMeQw69tCTRiSL1t0KDMCW5vDvY4i7SUU+WI
	JQdXUb9VHqHnSOcpaB0/WWxynP4J6P5eaFXF+0l5zcnLX5yDjdeKzbF4emrdZhTq3w7KMK
	1NXB43m9E+Y/4WoKUZ/vOhxSUS5aVpg=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 18/19] smack: smack_inode_setsecurity(): find label instead of import
Date: Thu, 24 Jul 2025 16:09:51 +0300
Message-ID: <f3d6e8f0206cf84c5f1993c0985951413068d163.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smack_inode_setsecurity() is called
for label-containing xattrs either
after smack_inode_setxattr():

    fs/xattr.c:

    ...
    ` __vfs_setxattr_locked
      ` security_inode_setxattr
      ` __vfs_setxattr_noperm
        ` security_inode_setsecurity
or
    ...
    ` smack_inode_notifysecctx
      ` smack_inode_setsecurity

In both cases - via security_inode_setxattr()
or smack_inode_notifysecctx() -
the label is imported in advance.

There is no need to validate and import
the input value again; looking it up is sufficient.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5d3d72162444..6c529de00584 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2996,17 +2996,16 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	))
 		return -EOPNOTSUPP;
 
-	if (value == NULL || size > SMK_LONGLABEL || size == 0)
-		return -EINVAL;
-
 	if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
 		nsp->smk_flags |= SMK_INODE_TRANSMUTE;
 		return 0;
 	}
 
-	skp = smk_import_entry(value, size);
-	if (IS_ERR(skp))
-		return PTR_ERR(skp);
+	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
+	    strcmp(name, XATTR_SMACK_MMAP) == 0)
+		return -ENODATA;
+
+	skp = smk_find_label(value, size);
 
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		nsp->smk_inode = skp;
@@ -3014,9 +3013,6 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		return 0;
 	}
 
-	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
-	    strcmp(name, XATTR_SMACK_MMAP) == 0)
-		return -ENODATA;
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
 	 * smack_inode_setxattr() has checked that inode is sockfs
-- 
2.43.0

