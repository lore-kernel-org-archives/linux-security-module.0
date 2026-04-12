Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BF1A9FA4
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022353; cv=none; b=L8eBwVve9RO3Ys3RRFk8Unh00dR7krPE1edmrYPFpLYxfA2+0Z8Sc3rmOF56TybzOXaKDaxPxqG2LyrgyAHCtgbqq52DcMy1zF4mK3L5dR8gCiFWUVucRh8TvebiBXiQItm/c+Eo/srHq8rJoyNPLGrxQyJlsSMfRUyq8re19Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022353; c=relaxed/simple;
	bh=oTcR4CCr8Ocq8t7qP/Oqx/qCDuG7oxO3x20lTSDDTLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niK6qbCxj6MHM35gEduvSPqKikrV7TzKGo3QuIELU/p39HfHrgt992l4j8uooM/jqqq9MFbKHvrdiR/xVkLXUhgq3CJ2jlW4PF4MhhJyL2f9EBv8YiMIPvVe9w2eEaU0K6AcoB8B2utEJyQGm5xzir0lghbux3vvEaoH7GZoDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3fGjrsJ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3fGjrsJ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79885f4a8ffso35176137b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022351; x=1776627151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wiA/RsoYoY172m6Ory17tQ0n/z36I2wypoPAvXCQLg=;
        b=R3fGjrsJTy6B/lNNfP5u6/GMJ7K0Nr+/dXDtD3EbNZhTx+/Hmehk+D5Y+KQH5p8sjL
         lAjzFWX7RsmiLpxqKC4D4owmGCyoRby/M0J5uy+ANoW5MpHfg20Wq2u2VMJfyLg33dKI
         aQqShbe1Yus1DNFZBCsY31mPGFKQ42g1YMs8WbMLIk4+PJy4tnPoG/eHwQ/Qo6jfUcmU
         +UAjGSnd5OgCSUtAZLDpG8ZxmRkgyL45C5rn34ZmWMo9ws8yfuQLgYTi6+QKqFD/BoqD
         yN1Xppobl9ahLzLdwvITi0Qgmo9uqRP8bOyVjCIk8664qXjgNqGPX7KDK2+aADMjjJgW
         ZBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022351; x=1776627151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wiA/RsoYoY172m6Ory17tQ0n/z36I2wypoPAvXCQLg=;
        b=h1EC2Q4qw18akn4c0dMl2HLwtId3E/vN1wSIFZI9W3gsIJ41XY3V8xfjfxQ49yYv6r
         P5xvbeYcD0TMlW9Z8/SRZ4fczrEPXLcnpl1gsQuVGY+kflinBDQ3cR/JmfQ5YZv+Mm3n
         SIT2eHX5Id2M1vF/tRNBK3SnEBfy35atuyE99clZETnKnQlbTax8s6VTsBsMrb2bL8kd
         8bHfwNVRAJLBY42mT15WLBj/1oaP9occOrURcK7p26pKZ0NN8h9nm+1BSNIMYQ9p+3j4
         6G2jVbphJJTaPFiljPncmxY7xHPvSJWiluKHQRyNiLAsUT/aWCFnezLI13uyuc6iPvbb
         m+VQ==
X-Forwarded-Encrypted: i=1; AFNElJ8248TTEu6kL4QflL7PFEOD+dYqSDSZTdxXdnD4u9F/cwV82DnmiJ0/vquWBFbpt8WlUVP72zmT+/omRlCTCK6WMb2Axkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXlq3k4lqSEr+XadVOziv/bclKDbu7skOW464CgBTI1xa4STn
	xSoQRTbWTXdItATAHx1X0p28JY6N7ZfbmGVeUH4blVEiqTqe4ZUBIHNB
X-Gm-Gg: AeBDieunOU0HsjQEIYdM4ZoQy3ntpwjY5+C8u3M6COY3NV664rutGA+5DvL2VOhtCiz
	LqDPJXo3/7VQM5Q5//xzxa6zroW9V/D0rfDYyZUv3YVl5wDt8dLv5c97SJEoDrwLNW7IZuC/QWZ
	Pra48kEa89WMPAj/0/ZNE2HJQ7pQAaHJ22AhHlYyl62eZI13mw2vu/5Z6QJ/TfWgCc1MGC8VLvk
	Zm6APf89xDkkAwZWdB31Q0zagQE5nuGgyCdRTZJjljO32FTbQpCh+ciCqoiArPtnxhIy+XEX2E/
	jHsdVk2mZopDojWvXKifJ2yHauuo6ZvX4XZ9qikbqknvsvy2BDPjizKZgsLONwB+1vMyWyICzIK
	1aKQSQ9vS/aLAvOGIt+EGKgdnWKwrA7f1Dy6nFclqL/FsSAJHCyUSNasBa+xzf0OSr4Ti6S0olp
	h83UPUXxlobWtQE0MJ59nXqxyd7EOOPDpk/+/j7pZvQ/yu/JRQulGsQRu88nj8MzA8mw7m63nV
X-Received: by 2002:a05:690c:110:b0:7a2:1f26:3d5f with SMTP id 00721157ae682-7af71281b8emr117019907b3.28.1776022350881;
        Sun, 12 Apr 2026 12:32:30 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 03/10] landlock: Use landlock_walk_path_up for collect_domain_accesses
Date: Sun, 12 Apr 2026 15:31:54 -0400
Message-ID: <20260412193214.87072-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use common path walk helper for collect_domain_accesses. This
extends the new centralized traversal logic to the current_check_refer
path code flow, and maintains consistency with the is_access_to_paths
allowed traversal while allowing reuse of traversal semantics.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * New patch split out from the v6 core NO_INHERIT implementation.

 security/landlock/fs.c | 75 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b31bd2980e5c..7ec26c671f91 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1036,49 +1036,52 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * collect_domain_accesses - Walk through a file path and collect accesses
  *
  * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
- * @dir: Directory to start the walk from.
+ * @path: Path to start the walk from and whose mount root is the last
+ *     directory to check.
  * @layer_masks_dom: Where to store the collected accesses.
  *
- * This helper is useful to begin a path walk from the @dir directory to a
- * @mnt_root directory used as a mount point.  This mount point is the common
- * ancestor between the source and the destination of a renamed and linked
- * file.  While walking from @dir to @mnt_root, we record all the domain's
- * allowed accesses in @layer_masks_dom.
+ * This helper is useful to begin a path walk from @path to the mount root
+ * directory used as a mount point.  This mount point is the common ancestor
+ * between the source and the destination of a renamed and linked file.  While
+ * walking from @path to that mount root, we record all the domain's allowed
+ * accesses in @layer_masks_dom.
  *
- * Because of disconnected directories, this walk may not reach @mnt_dir.  In
- * this case, the walk will continue to @mnt_dir after this call.
+ * Because of disconnected directories, this walk may not reach that mount
+ * root.  In this case, the walk will continue to the mount root after this
+ * call.
  *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
  * accesses.
  *
- * Return: True if all the domain access rights are allowed for @dir, false if
- * the walk reached @mnt_root.
+ * Return: True if all the domain access rights are allowed for @path, false if
+ * the walk reached the mount root.
  */
 static bool
 collect_domain_accesses(const struct landlock_ruleset *const domain,
-			const struct dentry *const mnt_root, struct dentry *dir,
+			const struct path *const path,
 			struct layer_access_masks *layer_masks_dom,
 			struct collected_rule_flags *const rule_flags)
 {
 	bool ret = false;
+	struct path walker_path;
 
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
+	if (WARN_ON_ONCE(!domain || !path || !path->dentry ||
+			 !path->mnt || !layer_masks_dom))
 		return true;
-	if (is_nouser_or_private(dir))
+	if (is_nouser_or_private(path->dentry))
 		return true;
 
 	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 				       layer_masks_dom, LANDLOCK_KEY_INODE))
 		return true;
 
-	dget(dir);
+	walker_path = *path;
+	path_get(&walker_path);
 	while (true) {
-		struct dentry *parent_dentry;
-
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir),
+		if (landlock_unmask_layers(find_rule(domain,
+						     walker_path.dentry),
 					   layer_masks_dom, rule_flags)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1092,14 +1095,16 @@ collect_domain_accesses(const struct landlock_ruleset *const domain,
 		 * Stops at the mount point or the filesystem root for a disconnected
 		 * directory.
 		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
+		if ((walker_path.dentry == path->mnt->mnt_root &&
+		     walker_path.mnt == path->mnt) ||
+		    unlikely(IS_ROOT(walker_path.dentry)))
 			break;
 
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
+		if (WARN_ON_ONCE(landlock_walk_path_up(&walker_path) !=
+				 LANDLOCK_WALK_CONTINUE))
+			break;
 	}
-	dput(dir);
+	path_put(&walker_path);
 	return ret;
 }
 
@@ -1165,7 +1170,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	struct dentry *old_parent;
+	struct path old_parent_path;
 	struct layer_access_masks layer_masks_parent1 = {},
 				  layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
@@ -1223,19 +1228,19 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
-	 * we keep a reference to old_dentry.
+	 * OPEN_TREE_CLONE).  We do not need to call path_get(&old_parent_path)
+	 * because we keep a reference to old_dentry.
 	 */
-	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
-						      old_dentry->d_parent;
+	old_parent_path.mnt = mnt_dir.mnt;
+	old_parent_path.dentry = (old_dentry == mnt_dir.dentry) ?
+					 old_dentry :
+					 old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
-						&layer_masks_parent1,
-						&rule_flags_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent1 = collect_domain_accesses(
+		subject->domain, &old_parent_path,
+		&layer_masks_parent1, &rule_flags_parent1);
+	allow_parent2 = collect_domain_accesses(subject->domain, new_dir,
 						&layer_masks_parent2,
 						&rule_flags_parent2);
 	if (allow_parent1 && allow_parent2)
@@ -1256,7 +1261,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		return 0;
 
 	if (request1.access) {
-		request1.audit.u.path.dentry = old_parent;
+		request1.audit.u.path.dentry = old_parent_path.dentry;
 		request1.rule_flags = rule_flags_parent1;
 		landlock_log_denial(subject, &request1);
 	}
-- 
2.53.0

