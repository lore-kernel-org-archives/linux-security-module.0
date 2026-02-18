Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A262FC881
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445950; cv=none; b=OUJAL4sXo2mapeHE3sF3xBteIuJhh75QKbZTOJE8Pqb9icIjn8I3wAtcZ5ufWeyaQOpC0RD+RbYxaVc9f5bA0cDSuHM+kkPeaMpd43QYzEIZNKcbRDUmI5+W5lgS9Iado+cddEqtQ93+55gArNneo/e2yl/PhM9MRs3v8PQYFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445950; c=relaxed/simple;
	bh=pLKxkZy5zNy6RFWYsynPORLyBh2yVbtAtB+pKNSREH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTi28TLS/SZHJZ9Z8XWdMfS2IvifxKIXXWQ5n82KzI5y7jMwPP/fQZPZtJ8v0znP7N29zYUrK4hZd09AvfG0t9bSsLcPDZTqcqwD1ORUbEoOuVpbvizwWg7XrvhBUDW2lz8Wv0OkIOV3CHxOijTSaNIDNTTuyvWvlODyiYADPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzsnyLS0; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzsnyLS0"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649278a69c5so249457d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445948; x=1772050748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4inZGsnaBOg0R9ze/+RmZ41FU8rNZ6Tg07KoCMlDDxA=;
        b=OzsnyLS0WjO//cSrdobnUo1ShW7KqzQMBcxLkqD0Ax8kKuzwMW4HQHySFCUXjM1mZn
         cyYag0SKOtHws6Grsl4DVarFGCDjeXioAf30WYc1C8htM20wx+BiVYLE3S/fzRHOTLry
         wXJqOqyMBGsxR79yKZFTviPeDi6YKtw3TDwHUIKNo3j2p6EPL15ftOD4HNibdpdXE0x6
         KHxs8pInoSoFlGb/U/QTnZA4jxlCRdzq+PHdUl599sEzH3pDZHws8HQSV5zuBPKnyuVz
         M+ZiE753fY7O2LVMcYiwXf+EGYssV5A76WlCnmKQA48w76UNciR3kBxPEVPWJj/m2zm7
         J+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445948; x=1772050748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4inZGsnaBOg0R9ze/+RmZ41FU8rNZ6Tg07KoCMlDDxA=;
        b=q4rRkZfD2gAR4cXQzj6g0Q1lTPQ0Zud1WUp1bFvLbmtvgYSPkEZysAboUYzUXJn5xC
         DlTNSDxZsfaoOGt+Hr29IjCF2th9agm7y4vm2RbWZJVRZtLjZPO//OwpeSNKWbwVwHDA
         wETf6l/EnloAhQKygGKZNJuyVMI7k2QCC1Y0k/9B6st+cLlFZiI44MKgvWQ/HCHPUiSC
         dOjZpRSOmZf77RaclEGuaXGtnQZDiV6/GVznqe0PmVJ0UQhjv9NEyXT4SrwNj63i1Nc8
         TqhttFqGBFWEg8uquIkfXDp/DXQMmDxoBuB6zyrQhsAuxDs3Y/hf20bad8Oim8uTGQGN
         5NEg==
X-Gm-Message-State: AOJu0YxYP2vtPkB3lPajeVRIwTGB++IfNw2Q3LCYDnFM+CKigaGkriOX
	MO1i+c1AaEPg3h0NutHHnmoq7HNSWkyhIgK/8PXATL4jVYSLax5Qey6bqwpmbA==
X-Gm-Gg: AZuq6aKgOe6JlZf8JNcpT1GNpOGi5z8jE6lpIxZVrRC0OfwQSHf1wagoRXmMIKnKGvJ
	SieZdTuB8QdbGF44BrG4P7Q9p3Xvn46t7VGzec2QuGl5G7paLyJCnbeH6Q0GJefG1DAvQMzfGN2
	ysfdBY7qI1mtIWSXEzbmK7faqpFnuHphVA7xQ4gV6shuI/Pec+t9/bSqzwcrhSpDBWbtvfqjvJL
	qNEZ+OiEip4o8kDKz6+iz4Tacjlmgjsh8/nkAwaft89nyE8NnDMZGrmwS35HmvH083tKP6GoeMW
	xQeQ//P2BKBpiN0zcEMyTcYbY9JuhI/Z+KELygEiZufCqlhqtc5lncWvCJXMy+xysUbYBGI+AYV
	/NoRDWzgHjznSJiVX/R4N7g1tPsKzBIMwUls76rFPMUOJCUj2i+ZFyJApg0xrSyoYmHjBRjwRTW
	3E9IpjElDa1QExRTaR2d7K4G+8qxSwaCThqkAFBNscmCYIdbXkE+9yNGhr+P3v5XVqeiaXcBbX
X-Received: by 2002:a53:add1:0:b0:649:b943:2cc3 with SMTP id 956f58d0204a3-64c14ac2b75mr12000640d50.15.1771445947578;
        Wed, 18 Feb 2026 12:19:07 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e936a7sm6249560d50.6.2026.02.18.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:19:07 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 2/2] landlock: Remove collect_domain_accesses
Date: Wed, 18 Feb 2026 15:18:57 -0500
Message-ID: <20260218201857.1194667-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218201857.1194667-1-utilityemal77@gmail.com>
References: <20260218201857.1194667-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove collect_domain_accesses and replace with inline logic using the
new path walk helper in the check_current_refer_path.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c | 128 +++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 82 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c6ff686c9cde..efc65dc41c0d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1013,77 +1013,6 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 				  LANDLOCK_ACCESS_FS_REMOVE_FILE;
 }
 
-/**
- * collect_domain_accesses - Walk through a file path and collect accesses
- *
- * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
- * @dir: Directory to start the walk from.
- * @layer_masks_dom: Where to store the collected accesses.
- *
- * This helper is useful to begin a path walk from the @dir directory to a
- * @mnt_root directory used as a mount point.  This mount point is the common
- * ancestor between the source and the destination of a renamed and linked
- * file.  While walking from @dir to @mnt_root, we record all the domain's
- * allowed accesses in @layer_masks_dom.
- *
- * Because of disconnected directories, this walk may not reach @mnt_dir.  In
- * this case, the walk will continue to @mnt_dir after this call.
- *
- * This is similar to is_access_to_paths_allowed() but much simpler because it
- * only handles walking on the same mount point and only checks one set of
- * accesses.
- *
- * Returns:
- * - true if all the domain access rights are allowed for @dir;
- * - false if the walk reached @mnt_root.
- */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
-				    const struct dentry *const mnt_root,
-				    struct dentry *dir,
-				    struct layer_access_masks *layer_masks_dom)
-{
-	bool ret = false;
-
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
-		return true;
-	if (is_nouser_or_private(dir))
-		return true;
-
-	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-				       layer_masks_dom, LANDLOCK_KEY_INODE))
-		return true;
-
-	dget(dir);
-	while (true) {
-		struct dentry *parent_dentry;
-
-		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir),
-					   layer_masks_dom)) {
-			/*
-			 * Stops when all handled accesses are allowed by at
-			 * least one rule in each layer.
-			 */
-			ret = true;
-			break;
-		}
-
-		/*
-		 * Stops at the mount point or the filesystem root for a disconnected
-		 * directory.
-		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
-			break;
-
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
-	}
-	dput(dir);
-	return ret;
-}
-
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1147,7 +1076,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	struct dentry *old_parent;
+	struct path old_parent_path;
 	struct layer_access_masks layer_masks_parent1 = {},
 				  layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
@@ -1202,20 +1131,55 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
+	 * OPEN_TREE_CLONE).  We do not need to path_get(old_parent_path) because
 	 * we keep a reference to old_dentry.
 	 */
-	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
-						      old_dentry->d_parent;
+	old_parent_path.mnt = mnt_dir.mnt;
+	old_parent_path.dentry = unlikely(old_dentry == mnt_dir.dentry) ?
+					 old_dentry :
+					 old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
-						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
-						&layer_masks_parent2);
+	allow_parent1 = false;
+	allow_parent2 = false;
+	for (size_t i = 0; i < 2; i++) {
+		const struct path *const parent_path = i ? new_dir :
+							   &old_parent_path;
+		struct layer_access_masks *const layer_masks =
+			i ? &layer_masks_parent2 : &layer_masks_parent1;
+		bool *const allow_parent = i ? &allow_parent2 : &allow_parent1;
+
+		if (is_nouser_or_private(parent_path->dentry) ||
+		    !landlock_init_layer_masks(
+			    subject->domain, LANDLOCK_MASK_ACCESS_FS,
+			    layer_masks, LANDLOCK_KEY_INODE)) {
+			*allow_parent = true;
+			continue;
+		}
 
+		{
+			struct path walker = *parent_path;
+
+			path_get(&walker);
+			do {
+				/* Gets all layers allowing all domain accesses. */
+				if (landlock_unmask_layers(
+					    find_rule(subject->domain,
+						      walker.dentry),
+					    layer_masks)) {
+					/*
+					 * Stops when all handled accesses are
+					 * allowed by at least one rule in each
+					 * layer.
+					 */
+					*allow_parent = true;
+					break;
+				}
+			} while (landlock_walk_path_up(&walker) ==
+				 LANDLOCK_WALK_CONTINUE);
+			path_put(&walker);
+		}
+	}
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
@@ -1233,7 +1197,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		return 0;
 
 	if (request1.access) {
-		request1.audit.u.path.dentry = old_parent;
+		request1.audit.u.path.dentry = old_parent_path.dentry;
 		landlock_log_denial(subject, &request1);
 	}
 	if (request2.access) {
-- 
2.51.0

