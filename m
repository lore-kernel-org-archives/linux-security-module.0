Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30D25A627
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071421; cv=none; b=d9X5qpiLxSvJZG4SphRCpZEIsWCFYiAzxa2+uU2eRi0vRAagB+98zAT/F6OYWZ+KBXkvi9sDloAkgp6yVqUa9nB9Ce9cKNh3uikBY4RhHFQ5/yXgkyofhdn2YxacsdECEetOT4d5SpyKKwzb3nAiTuVB7Z50ZiomCgzWPA7Umhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071421; c=relaxed/simple;
	bh=hNrv0hCr8yjDh83tC20QzcG/CIlBatkxaXHq+vF5fZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV6HL/iUawmWrg6CKO4bQZXWtXI2Bgfio5T+Uy7alW/sbvmQlZlK9y7vVylAAZxgQZlXsPdAbraucBLi5WGvoXR3a9s8TdvOyQ9aUBXdzWIyJZRraUnlIlrRc0b2Bdq0R4RqfLAsaY7kW/DdK5dM3QltfhwFMA0qRs6nRi3Wgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=L9ZUTXWd; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="L9ZUTXWd"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737070876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pb/MNHvhvFXBbhTWO7zGURzWNjB4hwzKQfEEZrk0CrU=;
	b=L9ZUTXWdbB5GYVuJzAINkOW4o/FMSL4EDz6ike1lrooxKYYjUKND3yOGkDYMsPV3Ikimgu
	E9ysC/O+84SUwY1et8LK+HnsbVk2xgOiWYldo8AGfv9VQxeHbwuLzrA3aJjcn9C/U3iKR8
	2G7N/UqyYgDpic27+7cXQLPTsT7splg=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] smack: Revert "smackfs: Added check catlen"
Date: Fri, 17 Jan 2025 02:40:33 +0300
Message-ID: <20250116234043.2904723-2-andreev@swemel.ru>
In-Reply-To: <20250116234043.2904723-1-andreev@swemel.ru>
References: <20250116234043.2904723-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ccfd889acb06eab10b98deb4b5eef0ec74157ea0

The indicated commit
* does not describe the problem that change tries to solve
* has programming issues
* introduces a bug: forever clears NETLBL_SECATTR_MLS_CAT
         in (struct smack_known *)skp->smk_netlabel.flags

Reverting the commit to reapproach original problem

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smackfs.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 357188f764ce..ef34b0bac603 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -812,7 +812,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
-	struct netlbl_lsm_catmap *old_cat, *new_cat = NULL;
+	struct netlbl_lsm_catmap *old_cat;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -899,19 +899,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 		smack_catset_bit(cat, mapcatset);
 	}
-	ncats.flags = 0;
-	if (catlen == 0) {
-		ncats.attr.mls.cat = NULL;
-		ncats.attr.mls.lvl = maplevel;
-		new_cat = netlbl_catmap_alloc(GFP_ATOMIC);
-		if (new_cat)
-			new_cat->next = ncats.attr.mls.cat;
-		ncats.attr.mls.cat = new_cat;
-		skp->smk_netlabel.flags &= ~(1U << 3);
-		rc = 0;
-	} else {
-		rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
-	}
+
+	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
-- 
2.43.0

