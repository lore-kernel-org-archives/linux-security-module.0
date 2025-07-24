Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5012D77FE
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363214; cv=none; b=dJ4oMr3OgoECAZouIPYPNxO4wIzYkejcSLMj+CxAOpRpTZ3M1TzGOLl7CCk/0bNRcAzYCw9ZG0iCE1njkEwFYkLhDdp4Yf1poeo254QAb7MbjRbfNyiB6lgsmSAmT7jGRcI1SRp4KPTGKCR4KVAZJcYYYBErxEV98ju6UMF6Msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363214; c=relaxed/simple;
	bh=7S72GIVU1OwEfmUzd9uFTWd8Av7bKWCccnTdHISiYHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS/I9u+4ks+7tiCOSvgdDyQyPFywV+gLcL+LiRh1N6hT9DQOEYuVwvP7kWIwQ0zZbJX64WhkN383Jl4F5lg2+xr4xKcI2d3cIND8Pr/hkjUowZlPdjrQHMCG0YN62Yw/HMijYWWO5I0k+J+LZckWl1lKIVbzh2aGFq7zPvfDlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ahmeZbU1; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ahmeZbU1"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM3GlXX8SvuD7id+tyqoBdBEtOe2uXljYrI5nN2x4qc=;
	b=ahmeZbU1Ex0+pCx7YqiLEGw054Wmwyzfl+TDAFI5M0KEnGCJcMPP1UlFJrwNdsbJBwdE3g
	mJhC7SOuF3vjsPQCWVALh0xekIRdfLGcoZA1ClTgHoseqLopzzaKsC12Ev16z89hrg+KGR
	1XwXPp6SDbwTEYJyoM29vb3CkUl+Nac=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 04/19] smack: stop polling other LSMs & VFS to getxattr() unsupported SMACK64IPIN/OUT
Date: Thu, 24 Jul 2025 16:09:37 +0300
Message-ID: <f88923ca06d4b2790a92296a399ae56f1ae4a7e0.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

smack_inode_getsecurity() returns -EOPNOTSUPP
for the SMACK64IPIN and SMACK64IPOUT xattrs
if the inode is not a socket.

Since [1], the -EOPNOTSUPP return value
from the inode_getsecurity LSM hook
has been interpreted by security_inode_getsecurity()
as a signal to "continue polling other LSMs".

As a result, security_inode_getsecurity() queries
other LSMs for these Smack xattrs.

Furthermore, the VFS layer is also aware of the convention
and attempts to read SMACK64IPIN and SMACK64IPOUT from disk
via __vfs_getxattr() if all LSMs return -EOPNOTSUPP.

Looking for Smack propertу in these places is incorrect,
as Smack does own these xattrs - even if
they are irrelevant for a particular inode.

Returning -ENODATA (no such attribute) instead of
-EOPNOTSUPP is more appropriate, as it stops further
fallback to other LSMs and the filesystem.

This appears safe, since __vfs_getxattr() also returns
-ENODATA when the attribute does not exist.

[1] 2016-05-31 Casey Schaufler
commit 2885c1e3e0c2 ("LSM: Fix for security_inode_getsecurity
                      and -EOPNOTSUPP")
Link: https://lore.kernel.org/lkml/d8a4d26e-46c8-975d-d075-a3848130981c@schaufler-ca.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4ef6355c84c0..7bd47baac481 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1649,10 +1649,6 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 				   struct inode *inode, const char *name,
 				   void **buffer, bool alloc)
 {
-	struct socket_smack *ssp;
-	struct socket *sock;
-	struct super_block *sbp;
-	struct inode *ip = inode;
 	struct smack_known *isp;
 	struct inode_smack *ispp;
 	size_t label_len;
@@ -1666,27 +1662,29 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 			label = TRANS_TRUE;
 		else
 			label = "";
-	} else {
+	} else if (strcmp(name, XATTR_SMACK_IPIN) == 0 ||
+		   strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		/*
-		 * The rest of the Smack xattrs are only on sockets.
+		 * These Smack xattrs are only on sockets.
 		 */
-		sbp = ip->i_sb;
-		if (sbp->s_magic != SOCKFS_MAGIC)
-			return -EOPNOTSUPP;
+		const struct socket_smack *ssp;
+		const struct sock *sk;
 
-		sock = SOCKET_I(ip);
-		if (sock == NULL || sock->sk == NULL)
-			return -EOPNOTSUPP;
+		if (inode->i_sb->s_magic != SOCKFS_MAGIC)
+			return -ENODATA;
 
-		ssp = smack_sock(sock->sk);
+		sk = SOCKET_I(inode)->sk;
+		if (sk == NULL)
+			return -ENODATA;
+
+		ssp = smack_sock(sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
-		else if (strcmp(name, XATTR_SMACK_IPOUT) == 0)
-			isp = ssp->smk_out;
 		else
-			return -EOPNOTSUPP;
-	}
+			isp = ssp->smk_out;
+	} else
+		return -EOPNOTSUPP;
 
 	if (!label)
 		label = isp->smk_known;
-- 
2.43.0

