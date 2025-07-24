Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A92D5419
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=QCNBZt9lhpvdj6DNL1hQWx6VEremvFzL3hYz1tT0eZfpZKz4hpj6jQuHX+jyjRlLPRd8SisJfF/O+0usRyvKWbDSXTsmasZwE26lYgUdT9fgrfm3l7asDXFHnnBLAryOVXEoWafV+dqM0+B0hqME1zb5MEvFGzaFANuOen4YtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=vWjBzb4s0yuEkOn1tDGPPQB0CvT5TouAtgZASY6IAxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAWVwnup4rK5nRQMw0VrRjkDuO2flcP5n9fB63jRD6n4csf+U5RYX05GULWT4x4tHY6REmyQQwUkvX/8tsOIi4XTyA4/0vN36k9Fma0fuf3i3aAkp8oZrZXWrGbYLyizbWtEbhEpMTxwyIP5jHIAVpNzfjhGo94RKcJ944ByuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=XKCBXVte; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="XKCBXVte"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFg82fKn0ZDDjUPcUjdZL1UpItuGZcfB/qqD5z6BcVo=;
	b=XKCBXVtep11iRQFpQZXXuk/+ecyi6PaQLLxdvcehhLwjG1v4frrpHoadXuMptCOcLHfyQq
	oCIA6Drjiz38SNLj+osXHIbdP3rbcvVXlwG77/RuWM/YPlXtxDNwlOK54XfxlwRxlr8xSJ
	49EtQjkP70GmL59+uodXWOOUy9Iat30=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 09/19] smack: smack_inode_setsecurity: prevent setting SMACK64IPIN/OUT in other LSMs
Date: Thu, 24 Jul 2025 16:09:42 +0300
Message-ID: <a0d039a407a8164a2025847f5b00fd5f3c2e5def.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smack_inode_setsecurity() equally returns -EOPNOTSUPP
either the inode does not come from socket (sockfs
inode) or the xattr is a security.NOT-SMACK-XATTR

This did make no difference until [1]. Since [1]
-EOPNOTSUPP is reserved by security_inode_setsecurity()
as a signal to "continue polling other LSMs".

When xattr is SMACK64IPIN or SMACK64IPOUT and inode
is not from socket then return code is -EOPNOTSUPP,
and the security_inode_setsecurity() proceeds to query
other LSMs and attempts to store the xattr there.

Passing a Smack property to other LSMs is incorrect,
as Smack owns these xattrs.

This change returns -ENODATA if inode does not come
from sockfs and the xattr is SMACK64IPIN/OUT.
This causes change from

  # setfattr -n security.SMACK64IPIN -v foo /sys/kernel/debug/sleep_time
  setfattr: /sys/kernel/debug/sleep_time: Operation not supported

to

  # setfattr -n security.SMACK64IPIN -v foo /sys/kernel/debug/sleep_time
  setfattr: /sys/kernel/debug/sleep_time: No such attribute

not ideal, but it makes sense and prevents fallback to other LSMs.

[1] 2016-05-31 Casey Schaufler
commit 2885c1e3e0c2 ("LSM: Fix for security_inode_getsecurity
                      and -EOPNOTSUPP")
Link: https://lore.kernel.org/lkml/d8a4d26e-46c8-975d-d075-a3848130981c@schaufler-ca.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 00d4b5bf1056..7108696083d8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3004,21 +3004,25 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
 	    strcmp(name, XATTR_SMACK_MMAP) == 0)
 		return -ENODATA;
+
+	if (!(strcmp(name, XATTR_SMACK_IPIN) == 0 ||
+	      strcmp(name, XATTR_SMACK_IPOUT) == 0))
+		return -EOPNOTSUPP;
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
 	 */
 	if (inode->i_sb->s_magic != SOCKFS_MAGIC)
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	sock = SOCKET_I(inode);
-	if (sock == NULL || sock->sk == NULL)
-		return -EOPNOTSUPP;
+	if (sock->sk == NULL)
+		return -ENODATA;
 
 	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
-	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0) {
+	else {
 		ssp->smk_out = skp;
 		if (sock->sk->sk_family == PF_INET) {
 			rc = smack_netlbl_add(sock->sk);
@@ -3027,8 +3031,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 					"Smack: \"%s\" netlbl error %d.\n",
 					__func__, -rc);
 		}
-	} else
-		return -EOPNOTSUPP;
+	}
 
 #ifdef SMACK_IPV6_PORT_LABELING
 	if (sock->sk->sk_family == PF_INET6)
-- 
2.43.0

