Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35792EB5D4
	for <linux-security-module@vger.kernel.org>; Thu, 26 Jun 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956917; cv=none; b=P5HEmVBWJXFUApOngwIMmHNrHTr1+2ytbfMh5wv9wuaBS5sdUokoVJudarjpnFCty8p/k9cEVdyYBwgU1CJFHg03H/iUG9uw5pn8VMNwrOeJAmUchqSY3JXZbTwXkY4FDm18hTLVRLWJH7I3fvlZ9yE0G/Y67eK93tLwte9rn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956917; c=relaxed/simple;
	bh=4GWXCKByTb/CaJGyK310EHu+IYJFBB62hB6QPtTfJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6s++IPnyZ0s8/uxhAEYmUJ5hsbh3md9OGmVoM/VBH8jbq2n585Yq+QTWtCd5ggODwnFQj6ji7wQFaRnYNw9USIRx6ayPybSYJPsL6oOGcexYC+mC1XUuUUZDR9gc5bSTLLzzw0e0CwQDDBuNBaey6hGyCLI3ens232WTJ1UFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=M1i6OCpo; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="M1i6OCpo"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750956470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEEWm9gpVfrBIBEaXBvPX656pJybA962VuadeKej2oU=;
	b=M1i6OCpoX7zb3MKj2Q68kEP/ebdFn6AiMmd1yIHTkJ9rgUIVHgDtRKQcCM6TirFsflR95B
	wqbOScwR1W00csKz3caMtAQiwGR6Ysupa3/WUr0hWu2zW02bYPEkdJcDezgfJp9GerC+PH
	hCai/bUDa+pHckQefu/U3ckv/fHrQ9c=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] smack: fix kernel-doc warnings for smk_import_valid_label()
Date: Thu, 26 Jun 2025 19:47:29 +0300
Message-ID: <20250626164741.1028245-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506251712.x5SJiNlh-lkp@intel.com/
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_access.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index a289cb6672bd..09167be79122 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -642,9 +642,11 @@ struct smack_known *smk_import_entry(const char *string, int len)
 
 /**
  * smk_import_valid_label - import a label, return the list entry
- * @label a text string that is a valid Smack label, not null-terminated
+ * @label: a text string that is a valid Smack label, not null-terminated
+ * @label_len: the length of the text string in the @label
+ * @gfp: the GFP mask used for allocating memory for the @label text string copy
  *
- * Returns: see description of smk_import_entry()
+ * Return: see description of smk_import_entry()
  */
 struct smack_known *
 smk_import_valid_label(const char *label, int label_len, gfp_t gfp)
-- 
2.43.0

