Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38E17BA5
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036079; cv=none; b=LyY+9uYcX1CvO0ZWcPgQdGG2Toyx3ZXfCh6IvdkyJV667zJm1/c+9g8nObJ1iBWf6JCxGMn7Z5TbBa/6jPcpjEwzsM7+OBvz1BiSUaquN/+Yd7qKviFS41xbPafl8xola/YtPMsd9HhX0zcqA+DX2yVL5soIDttYXTio3jrT8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036079; c=relaxed/simple;
	bh=YloaAoC9CCCfflV2KOmr28Xox4UYKY3bnArjfIGgd2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm2qaAD4YxjIoFSdyH6BTkFtGATOHq8trZ62TqxWhTXcWh6p8Xulcft/yfxgmwWFp3dSyBrRhBtpP5GdWNe07GojMwzk/3UL12sYzxBCb4kjd8ybk6EQkojpdQ2UKLE3OrEX4dBbOCyXcjckW39v8FpWCe0m9oN05C9M+z+zwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=C1zyIuPT; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="C1zyIuPT"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OBsOxMN6rbKqkXZq4pqVEbVQPTBXxBqUDI09I3iWlg=;
	b=C1zyIuPT8R0cEVXKG17xl2swOIU+RmuRBowNpUACfcb/dDMQDMKSstF55ev2jlAXNuvSPb
	6emfomLpiuwyQs+2O9HTN4zk3I+sGZ6575FGN/LigPHXXRJrvUlO1CULLSO7WuwNlwQ6qH
	WnNLdfn2gRW1Dg8CgiImsb54V+TUQp0=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 4/5] smack: always "instantiate" inode in smack_inode_init_security()
Date: Mon, 16 Jun 2025 04:07:31 +0300
Message-ID: <20250616010745.800386-5-andreev@swemel.ru>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If memory allocation for the SMACK64TRANSMUTE
xattr value fails in smack_inode_init_security(),
the SMK_INODE_INSTANT flag is not set in
(struct inode_smack *issp)->smk_flags,
leaving the inode as not "instantiated".

It does not matter if fs frees the inode
after failed smack_inode_init_security() call,
but there is no guarantee for this.

To be safe, mark the inode as "instantiated",
even if allocation of xattr values fails.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---

I have found one execution path
that does not explicitly free inode after
failed security_inode_init_security() call:

    fs/f2fs/recovery.c`recover_data()
    `fs/f2fs/recovery.c`recover_dentry(entry->inode,)
     `...
      `security_inode_init_security(,,,f2fs_initxattrs,)

and some pathes with unclear decision.
May they be affected or not, it is safer
to always "instantiate" inode.

 security/smack/smack_lsm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2b46a2867226..fb23254c8a54 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1016,6 +1016,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
+	int rc = 0;
+	int transflag = 0;
 	bool trans_cred;
 	bool trans_rule;
 
@@ -1044,18 +1046,20 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 			issp->smk_inode = dsp;
 
 		if (S_ISDIR(inode->i_mode)) {
-			issp->smk_flags |= SMK_INODE_TRANSMUTE;
+			transflag = SMK_INODE_TRANSMUTE;
 
 			if (xattr_dupval(xattrs, xattr_count,
 				XATTR_SMACK_TRANSMUTE,
 				TRANS_TRUE,
 				TRANS_TRUE_SIZE
 			))
-				return -ENOMEM;
+				rc = -ENOMEM;
 		}
 	}
 
-	issp->smk_flags |= SMK_INODE_INSTANT;
+	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
+	if (rc)
+		return rc;
 
 	return xattr_dupval(xattrs, xattr_count,
 			    XATTR_SMACK_SUFFIX,
-- 
2.43.0

