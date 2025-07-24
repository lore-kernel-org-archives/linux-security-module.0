Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0C2D541C
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=YfGOAUJDs3YEvsn2F/I2WSnGegxOI3SWb3mjdb/8/Tu+NlJcH5f5BvVOiGHcfpesVgqSXMaxAHflTJgnAUblDaxzkQPMI6jdycnGMhPGpYBrhMi2sG6jRzCFOJ2pGLcZlrh+EFaXAspFnYUVEHpkLw8ePDLExtk3RdMeaJB9nBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=/tJO0L6mpuW6h9/1qgw1iJNUfSMrCrTFhpR1+5++VNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC49GkJjry6Ho9WT+M5jLx/Fe9n85IXRzexk8CM2o4FkLBXI6HfiXb2/90c1/eBGFGm8qwwBVDu+Pwusg0dZVif1vdgT3BtRtE3rNoMFwJIGzcNB6W5N+WSFqrsY0Ffpn5zsHJCn3VxZNwwJtqKp0ULsmjEY/+keCg6/qCjVz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ur8rd4c5; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ur8rd4c5"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9R3JJyimrIE2MMqTk5tXmLGCnU/W+BhAoCx3a6hkv8=;
	b=ur8rd4c5f7BAFrx7vsKkAiy3NYrfcKeMfoJqD9HD69AXbVGiH7uZu7kWrZ4yKwMBGf966y
	Jw2XNlvbLxF43qXywsGPa53fnE+utxHvmelHWvDqMFfxVpDoyfknF0O+g7r3rNDjJRXjrL
	U3+qK0Ozd23v0Itv7IPyBKSJdey9Pgo=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 08/19] smack: smack_inode_setsecurity: prevent setting SMACK64EXEC/MMAP in other LSMs
Date: Thu, 24 Jul 2025 16:09:41 +0300
Message-ID: <e453fc199b8fd061a57d450abff1e5d353e1869d.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smack_inode_setsecurity() does not support setting
the SMACK64EXEC and SMACK64MMAP xattrs, and returns
-EOPNOTSUPP if an attempt is made to set them.

However, since [1], the -EOPNOTSUPP return value
from the inode_setsecurity LSM hook
has been interpreted by security_inode_setsecurity()
as a signal to "continue polling other LSMs".

As a result, security_inode_setsecurity() proceeds
to query other LSMs and attempts to store the
SMACK64EXEC/MMAP xattrs there.

Passing a Smack property to other LSMs is incorrect,
as Smack owns these xattrs.

Returning -ENODATA instead of -EOPNOTSUPP is not ideal,
but it makes sense and prevents fallback to other LSMs.

[1] 2016-05-31 Casey Schaufler
commit 2885c1e3e0c2 ("LSM: Fix for security_inode_getsecurity
                      and -EOPNOTSUPP")
Link: https://lore.kernel.org/lkml/d8a4d26e-46c8-975d-d075-a3848130981c@schaufler-ca.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 39e2e7b5bc3c..00d4b5bf1056 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3000,6 +3000,10 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		nsp->smk_flags |= SMK_INODE_INSTANT;
 		return 0;
 	}
+
+	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
+	    strcmp(name, XATTR_SMACK_MMAP) == 0)
+		return -ENODATA;
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
 	 */
-- 
2.43.0

