Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B592BE64D
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=gJs5LBExPHqnfJ9Dz3H3P3oSNvjmTCd8Ugq+q7o/Jf2dW5WUXoLwUZZL44wStEvXPeGz2iKmtKKdt5DWmxG5lDT9uZ1GEXZSbcoZ+oyAwtURmvvSxbs2AYJVH2c4o3ysXmoYIDNof1xNBFWYUKOkgYUTozeQC3NxAV1epAw6Me0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=w4E+QWrAai2msFaJuIEW/6oW42gLm5AJaDvPW9yGYjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZvVFO1ViCCX0y/xPvYuZdvCYlD0iKp1J4lMPVNSb0Brya/5HevtcVPeRqpgKhPBroN3Y48hwlRaznRAvIhoVJ9OaixFbDzrnMfaBwj528Y035EE4l6VQryEFYmFofok2DOZpOs+/5XccFpp6sB4xPYEzRZWF0mpeRZYi31YuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=P1i8FO6X; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="P1i8FO6X"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi3OmYfykSCO/ABDzQlNaGGhmzMs95TK7LGDkDpc0F4=;
	b=P1i8FO6XZIps6MyDiyDQkkc1L0NpKj8vMhfmnjj2ZZjGjw6HCwhGdlvLv0PSHZzuv9A26y
	rIqu+89gjUlWXHs3s/kmEGVK9nS8yXDwr2+yKMi3fCsUlQM+nJF1ef+clnTMm8s7U+boBI
	MFNTx4L33fsAnW0CKlFw8qRLIcM6u3Y=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 06/19] smack: fix bug: getxattr() returns invalid SMACK64EXEC/MMAP
Date: Thu, 24 Jul 2025 16:09:39 +0300
Message-ID: <ba2af0356940d61d932af15d4b1a265a61e7d16c.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Smack inode_getsecurity hook, smack_inode_getsecurity(),
does not provide the values of the SMACK64EXEC and SMACK64MMAP
xattrs from the inode. Instead, it returns -EOPNOTSUPP
to signal that these xattrs are not handled.

Since [1], the -EOPNOTSUPP return value
from the inode_getsecurity LSM hook
has been interpreted by security_inode_getsecurity()
as a signal to "continue polling other LSMs".

As a result, security_inode_getsecurity() continues querying
other LSMs and eventually returns control to vfs_getxattr(),
which attempts to read these xattrs from disk
via __vfs_getxattr()

There are two issues here:

1) querying a Smack property from other LSMs
   is incorrect, as Smack does own these xattrs.

2) the on-disk xattrs may differ from the in-memory
   labels actually associated with the inode.

The SMACK64EXEC/MMAP xattr on disk may contain an invalid
label (e.g. foo/bar, see [2]), a forbidden one (*, @),
or even corrupted data.

Such values are treated somehow during inode instantiation
and may produce a valid Smack label or no label at all,
but, anyway, one that differs from the on-disk value

This change ensures that getxattr() returns the actual
in-memory label associated with the inode,
not the raw xattr from disk.

[1] 2016-05-31 Casey Schaufler
commit 2885c1e3e0c2 ("LSM: Fix for security_inode_getsecurity
                      and -EOPNOTSUPP")
Link: https://lore.kernel.org/lkml/d8a4d26e-46c8-975d-d075-a3848130981c@schaufler-ca.com/

[2] 2025-07 andreev
commit ("smack: fix bug: setting label-containing xattrs
         silently ignores input garbage")
Link: https://lore.kernel.org/linux-security-module/ae1100894499a1f6ce8e783727635388b3ac3af8.1753356770.git.andreev@swemel.ru/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7a27c554ac56..052404e2fda6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1649,17 +1649,20 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 				   struct inode *inode, const char *name,
 				   void **buffer, bool alloc)
 {
-	struct smack_known *isp;
-	struct inode_smack *ispp;
-	size_t label_len;
-	char *label = NULL;
+	const struct smack_known *skp;
+	const struct inode_smack * const isp = smack_inode(inode);
+	const char *value = NULL;
+	int value_len;
 
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
-		isp = smk_of_inode(inode);
+		skp = isp->smk_inode;
+	} else if (strcmp(name, XATTR_SMACK_EXEC) == 0) {
+		skp = isp->smk_task;
+	} else if (strcmp(name, XATTR_SMACK_MMAP) == 0) {
+		skp = isp->smk_mmap;
 	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
-		ispp = smack_inode(inode);
-		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
-			label = TRANS_TRUE;
+		if (isp->smk_flags & SMK_INODE_TRANSMUTE)
+			value = TRANS_TRUE;
 		else
 			return -ENODATA;
 	} else if (strcmp(name, XATTR_SMACK_IPIN) == 0 ||
@@ -1680,24 +1683,27 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 		ssp = smack_sock(sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
-			isp = ssp->smk_in;
+			skp = ssp->smk_in;
 		else
-			isp = ssp->smk_out;
+			skp = ssp->smk_out;
 	} else
 		return -EOPNOTSUPP;
 
-	if (!label)
-		label = isp->smk_known;
+	if (!value) {
+		if (!skp)
+			return -ENODATA;
+		value = skp->smk_known;
+	}
 
-	label_len = strlen(label);
+	value_len = strlen(value);
 
 	if (alloc) {
-		*buffer = kstrdup(label, GFP_KERNEL);
+		*buffer = kmemdup(value, value_len, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return label_len;
+	return value_len;
 }
 
 
-- 
2.43.0

