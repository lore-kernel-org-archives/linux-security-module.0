Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E33655CC
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019552; cv=none; b=HnfTy94YZOBE+CgJwBLlnSTBvApT9ox1bTII/hrr049DVlAQSVOm150vM7ehCAc0Jy6hiw910fAfjgmXreIam9DnlfbIIZBVrRaZnuWEVYEGvTX3ObVb8AZfkQX6l5+SoAAy5Qw3KZt6UwGapOmJHnDFqv8zh31espdqAP5JTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019552; c=relaxed/simple;
	bh=HcvlPGbYYcSSgeroOH8OD8abpGKj69jG2s+1OyCtyk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3KwvjrVOhUKhJAFmHlNCYxz9JRi53dW+9Iqo7XIkmQNAfTmJV+Gp8uTIZ0D/Z8WMAd+wK1tbW/mjPJpCvaHwl81wQkV0T5B9zWnztRUKF2snFCbZHz2fUA8OO7NtP9mJuEXKeVetyGbOvWMQby6F4eOggXDo73TnCzj3wm8qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+ynRDnA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+ynRDnA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bb0d18c7f9so128091697b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019549; x=1780624349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk/ZE84jlVrlpz2dVoRSRY/S4Vc2qlm/+zWMZXovefE=;
        b=S+ynRDnAqLrT1MxbTWZTSatc6p3wmadezJQDlz0lu9HgH5G2i5LSBOTG3MeYgn5984
         9xOIxwPbkfAIwUMQPsGpckng7SnUXvXesayN1ENVWFRm40wEbYEhOdIGnkcx9MD3yRG+
         XJ/qaHdiusR5skZqobVN+wmv0DXBUBTHPpkcvhIvdR8/aavt4MOmlaEvYGm+aN0WpI3O
         M7bAKKub5cbIIwaiUz/mkFbdQ+SNw1Ynuhpk8nKBBwFgyzd7VoqhyJjythjysbIruFrw
         b/inNrqUTQAXgpkXVmaqJ6quU+tX5l9s/yuQsa5o7AVRzBUOYcqngXFEkj+evvnkyhQA
         tMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019549; x=1780624349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kk/ZE84jlVrlpz2dVoRSRY/S4Vc2qlm/+zWMZXovefE=;
        b=SHi3YRwPktuAlGnVC2KACpJyyXZBb4CiznY5HhM1L+TjGyMT+MnKXXaHsQnBCKtO4E
         UpI0qtl/CSZjABnXuy7Pwyx781PtCLiuEZUjxBsbaW75Svuflet4sk+xSDTB/cdTXBDY
         UoQqcx3XhENIlidOljFtkTR/qK+3xNVsYE+56xSihSKGpoKyYiJdduukrbZUn3GvNzsr
         Ak+88E/Tyx99u6Fw1RLF9Xxy0naBWemkTX9D+GOOAqTjJMzoWNWMur9BeMHwqoL8uzsw
         30Y5utufkoqyE3YMpHfsgH+f1WcIF9vRD31D144j1HATgaBQg7m2YldHBCUL/fwgugsO
         8AqA==
X-Forwarded-Encrypted: i=1; AFNElJ+Fbyz3eHJ32Bj9pZUoS82Fx4m7T+anl4jm5dloFUTvZoAQr+P0ZYWzbxm6/wrpvKP/IgzUHeU277qGE0xkdoczPNzITis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOg1S5NqLYIwvXZudNdiT07rb2XW+f4K1cYNwX6tXidpA2JVCY
	inb6mRVmftVIR86NagBOxCPXXYhNsCF2X5libzzpKIynhd0+Fd7tmqB4
X-Gm-Gg: Acq92OHhnn3mi4GQKbQUGlyr4P1Prj3C+kWHm7NH3wb5q37fAtYvuwOinA0MG0Y750C
	jWUlYDexLZ602uYHNa8WhJ/mJOxEG5PeYbuYjuHBHoeOFC2fdqyzHWDCGJ109u4Axlf+9pZ+b2i
	/OTvkyULdO83gqziVSbMgk8ogIjpLwiUxB4HuTfTskowMZAHY48EtEGoKF02suUPI5Dthg6uY6n
	Mag5pJDyBW1G9ZQVWgLEFU8z6bDZanJuL2ZBeftXKIV3ITeLFy0YmnOLZaU4jZ7VTwL4ZEs9Eoo
	iAmBpKR2EviPcio0a6qcTrQ0jBV+vFHArr2RiJQEUq21FzpNPlnt8L7zKvPROAHfbmQ7emYuXYA
	qP7MLJ0MzKNDPM+Vz9AkEwFL9RgTuybkkYQXDMgFUiHaTBP0GPPmrzIBNWyBaRubBd6rwTesB9R
	68gVpWnMJNTja5PtmMNvtMhWHcfQMWoYWjwp5pxLRZ0rCgXN1CpJVIRPXuxX6tSFENMIfcG6ib2
	uk+i6/nEfU=
X-Received: by 2002:a05:690c:630d:b0:7c7:5111:5ee1 with SMTP id 00721157ae682-7de4a9c0854mr6994677b3.26.1780019548631;
        Thu, 28 May 2026 18:52:28 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:28 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 03/10] landlock: Use landlock_walk_path_up() in collect_domain_accesses()
Date: Thu, 28 May 2026 21:52:02 -0400
Message-ID: <20260529015210.500291-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded loop with landlock_walk_path_up() and change the
function signature from (mnt_root, dir) to a single struct path.  The
caller's mount point and starting dentry are now both carried in @path,
which keeps the traversal logic consistent with
is_access_to_paths_allowed().

No functional change intended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reworded commit message.
      * Changed collect_domain_accesses() to take a single struct path *
        instead of separate mnt_root/dir parameters, simplifying the
        interface and matching is_access_to_paths_allowed().
      * Tightened the disconnected-directory stop condition to require
        !d_unhashed(walker_path.dentry) when comparing against the mount
        root, so disconnected bind-mount roots are not mistaken for the
        real mount root.

 security/landlock/fs.c | 82 ++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8fb0aa59e180..6552351e0b9c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1032,48 +1032,51 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
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
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
-				    const struct dentry *const mnt_root,
-				    struct dentry *dir,
-				    struct layer_masks *layer_masks_dom)
+static bool
+collect_domain_accesses(const struct landlock_ruleset *const domain,
+			const struct path *const path,
+			struct layer_masks *layer_masks_dom)
 {
 	bool ret = false;
+	struct path walker_path;
 
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
+	if (WARN_ON_ONCE(!domain || !path || !path->dentry || !path->mnt ||
+			 !layer_masks_dom))
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
 					   layer_masks_dom)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1084,17 +1087,19 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
 		}
 
 		/*
-		 * Stops at the mount point or the filesystem root for a disconnected
-		 * directory.
+		 * Stops at the mount point or the filesystem root for a
+		 * disconnected directory.
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
 
@@ -1160,7 +1165,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	struct dentry *old_parent;
+	struct path old_parent_path;
 	struct layer_masks layer_masks_parent1 = {}, layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
@@ -1214,18 +1219,19 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
+	allow_parent1 = collect_domain_accesses(subject->domain,
+						&old_parent_path,
 						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent2 = collect_domain_accesses(subject->domain, new_dir,
 						&layer_masks_parent2);
 	if (allow_parent1 && allow_parent2)
 		return 0;
@@ -1244,7 +1250,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		return 0;
 
 	if (request1.access) {
-		request1.audit.u.path.dentry = old_parent;
+		request1.audit.u.path.dentry = old_parent_path.dentry;
 		landlock_log_denial(subject, &request1);
 	}
 	if (request2.access) {
-- 
2.53.0

