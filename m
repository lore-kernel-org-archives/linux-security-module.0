Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CF2D4B7F
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=XoNGRIzBF1Lw0rQ+GgazIQm439BPlvZR5/m+qF5BCciA3FxNcsCqX/PbiWevew/venDnUKjvOdQmSbrLg9fWStitsV76EDl7xMnOGEr+uNxQXxTRLh4JiVj5KebPDIbFZzGPAcp4UvTafJkG+sj/fl4l3PFoKk0m+0qy3G1NSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=/OIHc13IayAjdk4tsOsc5S9rlc1kp1tHAm6aoj591/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PN6Ik2YjegMZ+lthABF3lldHGuXupefqkj7h56NuF47Ca2Bfp1Fjh49ucO6X4pWEHZ2+S/oHRgZ5+JH6IlhcvxadS8NTTJTzLDuCEjnzq+W2eyoOOsPDiNIX0dKUArW4AmcLtSVvMn6w19dGuoMqg5BaB/CnDrEpv+/s4+wrR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=pQPIVRj1; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="pQPIVRj1"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skIkhH1NKxeiIAV7iO9xLr+DahEScv+8+BgeCQlij2k=;
	b=pQPIVRj1kOlATWkuS9Z+0LDxOL8YV4nWSFphXSA2bTMBIm7DEhYnh0VLyIlqj/nwAPrVJ2
	mH4uSLtmEb9XKqTpVPZE2C47/zPjW9uLac+bA6Cwnok5QWMjkaudxf+geJZBp6uliua9Bo
	qQD2ssjY7iPubh7f+3WpYZsHZKYrxQY=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 10/19] smack: fix bug: smack_inode_setsecurity() imports alien xattrs as labels
Date: Thu, 24 Jul 2025 16:09:43 +0300
Message-ID: <994ee5c88dd704741d45f71792924730444cb943.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, smack_inode_setsecurity() calls smk_import_entry()
to import the xattr value as a label before checking whether
the xattr is actually a Smack xattr.

For example, attempting to set security.foo=bar on a socket
fails as expected, but the value 'bar' is still imported
into Smack as a label.

This change ensures that the xattr is recognized
as a Smack xattr before importing its value.

2008-02-04 Casey Schaufler
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7108696083d8..6f74be82ae45 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2991,6 +2991,14 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 		return 0;
 	}
 
+	if (!(strcmp(name, XATTR_SMACK_SUFFIX) == 0 ||
+	      strcmp(name, XATTR_SMACK_EXEC) == 0 ||
+	      strcmp(name, XATTR_SMACK_MMAP) == 0 ||
+	      strcmp(name, XATTR_SMACK_IPIN) == 0 ||
+	      strcmp(name, XATTR_SMACK_IPOUT) == 0
+	))
+		return -EOPNOTSUPP;
+
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
@@ -3004,10 +3012,6 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (strcmp(name, XATTR_SMACK_EXEC) == 0 ||
 	    strcmp(name, XATTR_SMACK_MMAP) == 0)
 		return -ENODATA;
-
-	if (!(strcmp(name, XATTR_SMACK_IPIN) == 0 ||
-	      strcmp(name, XATTR_SMACK_IPOUT) == 0))
-		return -EOPNOTSUPP;
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
 	 */
-- 
2.43.0

