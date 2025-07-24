Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593F2D5412
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=dXU/wVrGIXPIzRVlThMTQSvBDoCXFDrYNcZTE1EzAh97HlOJ+CfdRQaveLm96dkFpXBhlJvD2+XsL7p12jWs6X5Uu2hUf9iVdo/GrUw+FFdk4F+q0Q9m/Fr9XRPSk5dADMIzcHGIB8YUvYotxLZYZN5yN4imHv/PZ9iujdNonE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=shFyCXFyYKvP52biuR1enfSiq1R79U7PbGOhFprfL9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLmXabe0TqimdFJ1kaze1+Ll/d1ONXtvvA3vUceszCwCpiVaaK3nJIloBkAWYEBg7b4yhDGR2cx5HMv/PCDEvnqUnByH+eDhXLz5WMrEjZVHsyqUJZ0FagFoud3FnHmMnK3ciRC8GCMJCBxxxBAdB5no6+GAm8n4sds0mjIe9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=aGLojPv6; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="aGLojPv6"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EQWsx7gMfVWl9uZgVN4izYN///Pk01ciB35/DNjDVw=;
	b=aGLojPv62JkzEjuZV/svIOXpu0KeD2xilpaVjS9/ZjPnoQSQUaRsgTryHzZJmXDv96g0ZV
	UKOtt7LFVCxJ26JkRGVJzQ76F601uNXApbYSD9xQjahaCtwiCf+Vf2rDEHRe6stNWFwt3s
	4kfvNoiwNCj62xi9Riq3AG4ygUMVTQU=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 07/19] smack: deduplicate task label validation
Date: Thu, 24 Jul 2025 16:09:40 +0300
Message-ID: <6dcbc66cfd327fcd0563f6afda53d76f2c6d043f.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The part of the description of smk_task_invalid_label()
("Smack prohibits ... explicitly.")
was taken verbatim from the commit message of:

2013-12-16 Casey Schaufler
commit 19760ad03cc6 ("Smack: Prevent the * and @ labels
                      from being used in SMACK64EXEC")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 47 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 052404e2fda6..39e2e7b5bc3c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1369,6 +1369,21 @@ static int smack_inode_xattr_skipcap(const char *name)
 	return 0;
 }
 
+/*
+ * Smack prohibits processes from using the star ("*") and web ("@") labels
+ * because we don't want files with those labels getting created implicitly.
+ * All setting of those labels should be done explicitly.
+ *
+ * Comparing smack_known's assumes label has been imported. Until only builtin
+ * labels are prohibited, just imported label is not eligible for rejection.
+ */
+static bool
+smk_task_invalid_label(const struct smack_known * const skp)
+{
+	return skp == &smack_known_web ||
+	       skp == &smack_known_star;
+}
+
 /**
  * smack_inode_setxattr - Smack check for setting xattrs
  * @idmap: idmap of the mount
@@ -1387,7 +1402,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 				const void *value, size_t size, int flags)
 {
 	bool label_inside = true;
-	int check_star = 0;
+	bool task_label = false;
 	struct inode * const inode = d_backing_inode(dentry);
 	umode_t const i_mode = inode->i_mode;
 
@@ -1403,7 +1418,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
-		check_star = 1;
+		task_label = true;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		if (!S_ISDIR(i_mode) ||
 		    size != TRANS_TRUE_SIZE ||
@@ -1436,10 +1451,10 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		if (IS_ERR(skp))
 			return PTR_ERR(skp);
 
-		if (check_star &&
-		    (skp == &smack_known_star ||
-		     skp == &smack_known_web))
-			return -EINVAL;
+		if (task_label) {
+			if (smk_task_invalid_label(skp))
+				return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -3726,14 +3741,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		 * Don't let the exec or mmap label be "*" or "@".
 		 */
 		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
-		if (IS_ERR(skp) || skp == &smack_known_star ||
-		    skp == &smack_known_web)
+		if (IS_ERR(skp) || smk_task_invalid_label(skp))
 			skp = NULL;
 		isp->smk_task = skp;
 
 		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
-		if (IS_ERR(skp) || skp == &smack_known_star ||
-		    skp == &smack_known_web)
+		if (IS_ERR(skp) || smk_task_invalid_label(skp))
 			skp = NULL;
 		isp->smk_mmap = skp;
 
@@ -3830,17 +3843,6 @@ static int do_setattr(unsigned int attr, void *value, size_t size)
 	 */
 	if (smk_parse_label(value, size))
 		return -EINVAL;
-	/*
-	 * No process is ever allowed the web ("@") label
-	 * and the star ("*") label.
-	 */
-	if (size == 1 /* '@', '*' */) {
-		const char c = *(const char *)value;
-
-		if (c == *smack_known_web.smk_known ||
-		    c == *smack_known_star.smk_known)
-			return -EPERM;
-	}
 
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		const struct smack_known_list_elem *sklep;
@@ -3860,6 +3862,9 @@ static int do_setattr(unsigned int attr, void *value, size_t size)
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
 
+	if (smk_task_invalid_label(skp))
+		return -EPERM;
+
 	new = prepare_creds();
 	if (new == NULL)
 		return -ENOMEM;
-- 
2.43.0

