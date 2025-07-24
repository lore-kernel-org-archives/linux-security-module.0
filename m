Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4052D5C6B
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363214; cv=none; b=todLqxRN5P3jsuR9YGbK6Vv+UZ4BVlK1n2y/HdGyk0zy73+V9gmIPuAH1jIwGYWH1RBAZqBy0WXAtJNaVPubKRpreOZHC/1xuy/hAXv7CFFWpvUeKA+RT0wyzI6FEoJUn+UgQb6aSafC2sZ8PkJT0akBPaTLCWM3V05FkkGpu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363214; c=relaxed/simple;
	bh=Z0aFehqnkn/IRx6YFwa9K1TmfJEq1gkVqb1ojLacLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/EkW4qA8nk1k8lYPKWwvBaupLOA+uujvmALOnp0LeI4NkgfLdi00QPjds7Z/J62Sk1Ckxmi00frfX80dMGkFPUpl1dz54JoMVBelcOpGt5g5EOHQRIhEsMWMtNLxOhtYxgUx+5Q8pG4+ejnGbXnu6X8LuK7c2F4xcaiqFG+Efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=W+hZ6L9g; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="W+hZ6L9g"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrXgsJcMXOWmFZpWwi0USmu3kREI0JtaAsWz2x2CqaI=;
	b=W+hZ6L9ggbGuFGe7ioO7pwvua5FmgqBlC+JBUsi94CzTUJTNmwGL+GiuhGsewBxms7jpoR
	Ve96wKy8Om1mKaBUa4ji2V/29CI01n1EwrV1oqGsZ4KTynUViTJjHjduxScItCZIYUlc4W
	V4Kee5p60/rDtYNZ6rONREmxqYxZMb8=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 01/19] smack: fix bug: changing Smack xattrs requires cap_sys_admin
Date: Thu, 24 Jul 2025 16:09:34 +0300
Message-ID: <19c4b78c9b2840663b5d46417ee06181cfca8d06.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[1] introduced a new LSM hook, inode_xattr_skipcap.
This hook is intended to identify security xattrs
for which the LSM takes responsibility for access control.

However, the Smack implementation, smack_inode_xattr_skipcap(),
has never worked as intended. It mistakenly does not recognize
the security.SMACK64* xattrs it owns.

As a result, Smack does not inform the common security layer
(security/security.c) that Smack is responsible for
security.SMACK64* xattrs. Consequently, the generic access
control functions (cap_inode_removexattr, cap_inode_setxattr)
are invoked, and they require cap_sys_admin to be effective.

This change corrects smack_inode_xattr_skipcap(),
allowing Smack xattrs to skip cap_inode_*xattr() calls.

[1] 2024-05-02, Paul Moore
Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
Link: https://lore.kernel.org/linux-security-module/20240503005850.466144-2-paul@paul-moore.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index adf1c542d213..42fdac05d32d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1312,7 +1312,7 @@ static int smack_inode_getattr(const struct path *path)
  */
 static int smack_inode_xattr_skipcap(const char *name)
 {
-	if (strncmp(name, XATTR_SMACK_SUFFIX, strlen(XATTR_SMACK_SUFFIX)))
+	if (strncmp(name, XATTR_NAME_SMACK, sizeof(XATTR_NAME_SMACK) - 1))
 		return 0;
 
 	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
-- 
2.43.0

