Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4862D5C9E
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362637; cv=none; b=ZWtkC3O+If2N9S4Jd6SFSa3CkSTzLCVEG1yBDjB75XyaSno4Ut5J1I1rW9asI/gEV63jU3WHNbpO6v3SbKKSYKUpyOH5OCvdSWi1W7FPwSMVUlPxczI3FIiCVXi3RlMbO7BwMJMCbTis8lwogA4SjnRbZdhgpHmczEJp7CiLi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362637; c=relaxed/simple;
	bh=1enbXgU+sAliIjS5kmxNQMvhfVGJp2CgUhn/XwYHHFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ7w+6iKPRrLSsV7TYPUBWOZcS5i+V4q53b4XtGMWgYdq2UbF09FsVVId8vAAl753EV38bDddqt4zRyY7Y4uGaBBcKoSywj89g++vUVQwTtxL+ypPna1q8UMI22Yea71zUvcRUo49MICxh4GYla8/wNOxkA66erk7FauyOySKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=VDXUbYYy; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="VDXUbYYy"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6LsmOhyTTqsH5EI+m+kfpb3obOQkEIxl5lxQr0gk/4=;
	b=VDXUbYYyXJZkhvYVVWy/a2+a8EnDVt6beyhcH4PxYv1Zy1Bw0HnAKexK+n1B3QV2gmFPK9
	fkVikniO41zXeYbsK9wE2l4WOb5NOFFTHjz2Isg/hprlOsXiMCoiRV4fz0VbtvUr4fZyyT
	SzASKi/hkQQ7uhDHZjniulpaW3HSf60=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 16/19] smack: smack_inode_notifysecctx(): reject invalid labels
Date: Thu, 24 Jul 2025 16:09:49 +0300
Message-ID: <36484909cb0b1097055b047da851346a1204e2e5.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exactly the same issue as described in [1,2].

    smack_inode_notifysecctx()
    ` smack_inode_setsecurity
      ` smk_import_entry

uses an unsuitable parsing
function: smk_import_entry(), which acquires only
that part from the beginning of the input
that looks like a label.

[1] 2025-06-17 andreev
commit 674e2b24791c ("smack: fix bug: setting task label
                      silently ignores input garbage")
Link: https://lore.kernel.org/linux-security-module/20250315015723.1357541-3-andreev@swemel.ru/

[2] 2025-07 andreev
commit ("smack: fix bug: setting label-containing xattrs
         silently ignores input garbage")
Link: https://lore.kernel.org/linux-security-module/ae1100894499a1f6ce8e783727635388b3ac3af8.1753356770.git.andreev@swemel.ru/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5175dfb3d448..9271cd54bc43 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5003,11 +5003,17 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+	const struct smack_known *skp;
 	/*
 	 * UDS inode has fixed label. Ignore nfs label.
 	 */
 	if (S_ISSOCK(inode->i_mode))
 		return 0;
+
+	skp = smk_import_label(ctx, ctxlen);
+	if (IS_ERR(skp))
+		return PTR_ERR(skp);
+
 	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
 				       ctxlen, 0);
 }
-- 
2.43.0

