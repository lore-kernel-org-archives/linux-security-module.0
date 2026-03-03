Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36387370D42
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560514; cv=none; b=HTC/UE8H5WyKojGv94NL9DvB+Tr0ap5VScJaUTa9KleZVTkyC1RxsnzsEN32yi16SV6MGdZ5Gwgla+WGxOOhM7rUhzOrFOBZdtGVoEz+Xod6VPbevjSev2hWQeRJ+vbCN5pu2Gz0nkZeVex1FA5fKLA5eK+mCzGL3QSdeSOc+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560514; c=relaxed/simple;
	bh=0EdBpirWhhbVPUsGcMTSg3msqVvqbN8FBWXSUEDjLqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2vezRzJrgOUyY6sPyvDKvN6Zerf90ACOJ4dQA0wcXNzXOskJbRJP+o5Lhs6yUXNgAD67w4NJw4SX1Ge9wMkJG81E8/SXeMn6pPxK/kJHkLxbNV1WrRNuE5ib+bGQLmKaszOuRU061/GPG38ZMv4N0YJDy41mXgduFkZihkdRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0h5+FecL; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0h5+FecL"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQNJg3yQLzq3L;
	Tue,  3 Mar 2026 18:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772559395;
	bh=fxKESBVV1TJ3PJF/ywxsJCPSYEK7y0GDXe3LfEsqeDg=;
	h=From:To:Cc:Subject:Date:From;
	b=0h5+FecLdyJs2OcJEISjFy+QA2g+WrNGrKEtO2r/WRgypUDc23fJuzRk7bC1Z8uWd
	 etKhOXWXjxzeFBYWF0ujABh3a0qFOpkZvIcBcQLroAoIYTyAhMUjoA1Jt9APewTdjU
	 B7BCLzLTF+9O3OUKxWaNXpAODk1orr3ZamQ9iZTE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fQNJg18ZZzvDv;
	Tue,  3 Mar 2026 18:36:35 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v1] landlock: Fix formatting
Date: Tue,  3 Mar 2026 18:36:31 +0100
Message-ID: <20260303173632.88040-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Auto-format with clang-format -i security/landlock/*.[ch]

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <kees@kernel.org>
Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.c  | 3 +--
 security/landlock/ruleset.c | 9 ++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index f5b78d4766cd..f0d83f43afa1 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -94,8 +94,7 @@ static struct landlock_details *get_current_details(void)
 	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
 	 * caller.
 	 */
-	details =
-		kzalloc_flex(*details, exe_path, path_size);
+	details = kzalloc_flex(*details, exe_path, path_size);
 	if (!details)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 319873586385..73018dc8d6c7 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -32,9 +32,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset =
-		kzalloc_flex(*new_ruleset, access_masks, num_layers,
-			     GFP_KERNEL_ACCOUNT);
+	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
+				   GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_ruleset->usage, 1);
@@ -559,8 +558,8 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (IS_ERR(new_dom))
 		return new_dom;
 
-	new_dom->hierarchy = kzalloc_obj(*new_dom->hierarchy,
-					 GFP_KERNEL_ACCOUNT);
+	new_dom->hierarchy =
+		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
 	if (!new_dom->hierarchy)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.53.0

