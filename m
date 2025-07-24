Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3132D5432
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=Sgxa9CX1YHBY0c8qwieC8Bpkzx3RCqi0WOzLloCvdVWHB4noWu5Yi+DZKUQglG6sFMnBuDyxldMgqAcI+3CkSsrF92+Rocr7MucpoQjEVrmYR/mPmq+gOxQuuInxDP193zlPQu3KjYsk7Dr9izeAc8790E9QJZUMCc4sIaWXJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=XTXMoP9lLoDVsCOuRal8Q7eoir6M05PsVfG4ekm8Abo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDX2zqodqmdVHtScpnwysy0bkTOX0HXPU8BppA74aNcTVuT/lEbk93wcTji6O+aIKjxuH+A7zp+kVFo7DsABTMSITBJ+Oeww70227YvOJy5r40Ej3m+0GUDxD2uCp6FyM4hnfBd8AibscSO0x//0AKGMIqFmkg7kT3xjJc5VzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=aMUvFtxA; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="aMUvFtxA"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05UXL8o1ADx/s9TETfV1PnJnajAEf5yIdVY23fe2RKI=;
	b=aMUvFtxAyFl8rSCv0Nidws61CIA/TAysMfKWZxNNjlI/nVzGHrZq4BpsgLhNpJNSsjEG2t
	qNs9VhH64QHXn6VhiWETnlt5dnAVGGDUEjHT5W2x0T58kxEZ/ZC2LOnWmJdjZgzq4xM1Op
	2u54TdckUVsckqW7lLCoLbMwx4itrCM=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 12/19] smack: restrict setxattr() SMACK64IPIN/IPOUT to sockets
Date: Thu, 24 Jul 2025 16:09:45 +0300
Message-ID: <94ce83e5caf3c322d778b5cb5d737f05da754359.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMACK64IPIN and SMACK64IPOUT xattrs apply
only to sockets. However, smack_inode_setxattr()
currently allows setting them on any filesystem
object, including regular files, FIFOs, and others.

These xattrs are even written to disk by the
underlying filesystem. E.g. you can

  # setfattr -n security.SMACK64IPIN -v foo /etc/passwd
  # # no error

and have SMACK64IPIN on disk.

This change restricts setting SMACK64IPIN/IPOUT
in smack_inode_setxattr() to socket inodes only.

Given that, the corresponding check in
smack_inode_setsecurity() may be omitted,
as it called after smack_inode_setxattr()
for SMACK64IPIN/IPOUT:

    fs/xattr.c:

    ...
    ` __vfs_setxattr_locked
      ` security_inode_setxattr
      ` __vfs_setxattr_noperm
        ` security_inode_setsecurity

Additionally, with this change the error code returned by setxattr()
for unsupported SMACK64IPIN/OUT xattrs
changes from -ENODATA [1]:

  # setfattr -n security.SMACK64IPIN -v foo /sys/kernel/debug/sleep_time
  setfattr: /sys/kernel/debug/sleep_time: No such attribute

back to -EOPNOTSUPP:

  # setfattr -n security.SMACK64IPIN -v foo /sys/kernel/debug/sleep_time
  setfattr: /sys/kernel/debug/sleep_time: Operation not supported

[1] 2025-07 andreev
commit ("smack: smack_inode_setsecurity:
         prevent setting SMACK64IPIN/OUT in other LSMs")
Link: https://lore.kernel.org/linux-security-module/a0d039a407a8164a2025847f5b00fd5f3c2e5def.1753356770.git.andreev@swemel.ru/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 Documentation/admin-guide/LSM/Smack.rst |  3 ++-
 security/smack/smack_lsm.c              | 16 +++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Smack.rst b/Documentation/admin-guide/LSM/Smack.rst
index c5ed775f2d10..ce8be25333a7 100644
--- a/Documentation/admin-guide/LSM/Smack.rst
+++ b/Documentation/admin-guide/LSM/Smack.rst
@@ -693,7 +693,8 @@ can only be set by privileged tasks, but any task can read them for their own
 sockets.
 
   SMACK64IPIN:
-	The Smack label of the task object. A privileged
+	The Smack label of incoming packets must have write access to the
+	Smack label, specified in the SMACK64IPIN attribute. A privileged
 	program that will enforce policy may set this to the star label.
 
   SMACK64IPOUT:
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 672be8b47821..a66fa2c16dc2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1415,7 +1415,14 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 			return -EINVAL;
 	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
-		;
+		/*
+		 * inode of socket file descriptor (sockfs inode) only
+		 */
+		if (inode->i_sb->s_magic != SOCKFS_MAGIC)
+			return -EOPNOTSUPP;
+
+		if (SOCKET_I(inode)->sk == NULL)
+			return -EOPNOTSUPP;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
 		task_label = true;
@@ -3015,14 +3022,9 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		return -ENODATA;
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
+	 * smack_inode_setxattr() has checked that inode is sockfs
 	 */
-	if (inode->i_sb->s_magic != SOCKFS_MAGIC)
-		return -ENODATA;
-
 	sock = SOCKET_I(inode);
-	if (sock->sk == NULL)
-		return -ENODATA;
-
 	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
-- 
2.43.0

