Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853C2D5C8B
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362636; cv=none; b=bu3gP21c7ehVtY7RmLBds2Mzb+qYokXGuXg8xvTVh+nMlEAzDE3k15dA6uKxIn6YT1t0jyebkZLctzz2MKgbgxXWVqu7j2u1ELa1LHFT+HLgYMwcOrIC9uIp+w3iucTNJMALSL4R/1QOL3RJhIvbj3Y4O45ic7HdOy47DXC7JRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362636; c=relaxed/simple;
	bh=phpOXvDteKgcYLKTYsWYq37bHa60bX2fSDWMOARigog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G22yWw8Leesuks6WAQdxzQKkl2jLj4NXV3F7xoWxeWqdDm5BxKt/jnXf52KpFa05o4Sr9Jnn2wV8epOGB5FpQcbSxu5Bcbf1IEBFBYqMu8qgQKzEbp1tCK12kEbrXe8fpiT8SDPKkhwKXBn1yccCzEn6s1Jk7GgFMGocLmqQQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=TJCvsgDa; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="TJCvsgDa"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGx4t6Gv0VvWTRRGSGDv1tMppzb5BT5bl7V3l6oQCOQ=;
	b=TJCvsgDa+xEmbS93mmt6N+SWkjUYYxclsSolnZ+emtkroZpFpsTYGVui/xgvin2q+jYDg2
	4IIVROJz2bn2DOTQ3NEIcxURxWXyMoH8Zp8JyTBmn44VXPyDflX4gn76UK8GD/ZnZRbrPD
	pCrIPhKtVfyk+5hhvchMy7yZKfKzmhY=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 15/19] smack: smack_inode_setsecurity(): skip checks for SMACK64TRANSMUTE
Date: Thu, 24 Jul 2025 16:09:48 +0300
Message-ID: <043271cc65e4d5d76f3fc2579263f14337af11f8.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like smack_inode_post_setxattr(), smack_inode_setsecurity()
is called after smack_inode_setxattr()
for the SMACK64TRANSMUTE xattr:

    fs/xattr.c:

    ...
    ` __vfs_setxattr_locked
      ` security_inode_setxattr
      ` __vfs_setxattr_noperm
        |
        ` security_inode_post_setxattr
        |    ^
        |     }- one of them is called
        |    v
        ` security_inode_setsecurity

Like smack_inode_post_setxattr(), smack_inode_setsecurity()
does not need to check
the applicability of the SMACK64TRANSMUTE or its value,
as they have already been checked by smack_inode_setxattr()

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 113371887b4d..5175dfb3d448 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3002,10 +3002,6 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		return -EINVAL;
 
 	if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
-		if (!S_ISDIR(inode->i_mode) || size != TRANS_TRUE_SIZE ||
-		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
-			return -EINVAL;
-
 		nsp->smk_flags |= SMK_INODE_TRANSMUTE;
 		return 0;
 	}
-- 
2.43.0

