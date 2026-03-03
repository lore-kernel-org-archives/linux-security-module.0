Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386D37DE98
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510767; cv=none; b=h3sx/msuCdsdt5cYiN2X6B4v50sJks2kNQwSZA/ZCs3sD3I7U0XmNf0qeqyiD339Z52SARKNdAFxPuxWkXl6kbDbbRt+R9zKjrUElh090GuMSr+RNF5DiimnS3l0hbNOZC6YtbalkMTPBvzQcCyEw+bissBpSmtUB0wB3xbEf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510767; c=relaxed/simple;
	bh=tSBOUiaRa0IhxqGYvK9zZkl+ovnji5iZs6od9pCSY/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWqR17jFVpJ5h/uECwUeJi0t4G9xKJAr22yQsZ5hnloco6Fz5oxHoCnHa9vnBUHnH4dl7Zqx+6Cvh8Z3nJ7xrwUXNN/katXk5eoWwabi2VwLXNfUWUbE7XD4LLOYUtDGgynFUFUXPAycjgyctWyQ9vv3mN+ZVY84ECugdcuNKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNK9hSe5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNK9hSe5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-793fdbb8d3aso62324387b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 20:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772510765; x=1773115565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wyxcc4qkHZUTyDR0v6kEJZc8+/OeT/R6Es1RR4/pm0=;
        b=MNK9hSe5IuT5IJhCk+LlEHONTsIEd5vXWU4Da7Wu/96/iXvkljvq1mRNuv207cXaJ9
         9fNkty+efuarOLLAD7spbONTd8PD64fZxU04p4fLBa4+kiwUyIC7XlmXK8CTh28uK+SX
         +wb1rcdtT8Y/Kl9wH/CsYT/VKKwBCWAyKgP+SSZ/NyPMf44rWswqqJgddw5tzMXmTC3j
         vyO5olNNhqUXYIo0dKZtGJNcr/nnNL0fqxRv3t/Id2nxDHL0doRP2r9xYPI/0fbMYIRE
         ZaDQZEssJZJyAepuMb/9x09J6Q5SlPueUj1N5OfkrL+kosw0fgiOEJ3dlru5DyJ3jQe2
         iwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772510765; x=1773115565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Wyxcc4qkHZUTyDR0v6kEJZc8+/OeT/R6Es1RR4/pm0=;
        b=FDg/O/7fAmTtEb0D8aZhrzCZqQcHRjwKfmNv8ou5/i7bAkWN3ZbVLZ+EldGv1tf/Ac
         uRN6Xq+imFsRA9bvnEpDHWz96p7vump6LY86yqfcWgI/LUfKSSXH+WIELhIVznJIIAP5
         3zehqMef9Ieo5LvTV9Wh9DodVctDB8VkBWRwcbcAzHknB/Xs81SrCOpno6dKo9RURFzR
         R0MUVQaKFH+EXCIVOESRfWxLTln840dOGPktzkwaaBNsvzXWrhIDurP3096ASBdWNt+Q
         tDB7lx7DhLKUVBx9QLV52UR491ayWYqFidoMYsljiPrPzL8lPCRduGNRbshgDuKuCGOx
         obAg==
X-Gm-Message-State: AOJu0Ywv8Q/VqtB2yrvJeO2P/fZfzE83/3p5OXo9royDWmIE1RELxVxG
	+cG+qQacAkjf+ug48Skfs0qgoCt5IDZXwc1MxJtxbmttngldPzUJnMIv4ilDjg==
X-Gm-Gg: ATEYQzzWzYHpPs5dtwNgQa5ZiORD9KPl3dz3S6rRNOad9wUhsRJrOJU9IE0TXt4CttX
	aVFR3AsHiMvZn77LynJgeuX+I3XA2C5UyEwFGlOfBqbwfKSlCZQom7ZK/qcZy6ZIm7lCZ54Jng2
	SyxOpvU9id31rISNzRlhtw+n2VX+o3M8daiuaRx7rk1wsXNoqzfXdhxBj7BtXVmlzvu6BGzkDF1
	6+fHI7fVVRwWm/PQxKSpYUTaZfJvKzhz+brtDlrsJcMGsB0lpoCXVCeLDT6Fe85fBkGKr/11jpf
	ezFd0g+OAtcxy4jYSwM+73xdU8zRRclWR1QqLWnPLa1mBcl/jjOPnilsv9YyTplsSxiPUu2HEMC
	zcAOXO0t+nEnmN6bBFLacVnhFBa1fI5TzI8SWaLF1Qty6eBkaVd5ci/TXfVUJk8g62uTKm7za7f
	/3/HzATPorGR5n/iAO/ZFU
X-Received: by 2002:a05:690c:6112:b0:798:5cdd:f1c9 with SMTP id 00721157ae682-7988549ebfbmr147108817b3.12.1772510764738;
        Mon, 02 Mar 2026 20:06:04 -0800 (PST)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798ac64fa32sm17460047b3.14.2026.03.02.20.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:06:04 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 1/2] landlock: Add path walk helper
Date: Mon,  2 Mar 2026 23:05:39 -0500
Message-ID: <20260303040540.3124770-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303040540.3124770-1-utilityemal77@gmail.com>
References: <20260303040540.3124770-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add path walk helper landlock_walk_path_up. This helper takes a pointer
to a struct path and walks the path upward towards the VFS root, and
returns an enum corresponding whether the current position in the walk
is an internal mountpoint, the real root, or neither.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c | 92 ++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e764470f588c..180ab149be74 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -317,6 +317,38 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
+/**
+ * enum landlock_walk_result - Result codes for landlock_walk_path_up()
+ * @LANDLOCK_WALK_CONTINUE: Path is now neither the real root nor an internal mount point.
+ * @LANDLOCK_WALK_STOP_REAL_ROOT: Path has reached the real VFS root.
+ * @LANDLOCK_WALK_INTERNAL: Path has reached an internal mount point.
+ */
+enum landlock_walk_result {
+	LANDLOCK_WALK_CONTINUE,
+	LANDLOCK_WALK_STOP_REAL_ROOT,
+	LANDLOCK_WALK_INTERNAL,
+};
+
+static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
+{
+	struct dentry *old;
+
+	while (path->dentry == path->mnt->mnt_root) {
+		if (!follow_up(path))
+			return LANDLOCK_WALK_STOP_REAL_ROOT;
+	}
+	old = path->dentry;
+	if (unlikely(IS_ROOT(old))) {
+		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
+			return LANDLOCK_WALK_INTERNAL;
+		path->dentry = dget(path->mnt->mnt_root);
+	} else {
+		path->dentry = dget_parent(old);
+	}
+	dput(old);
+	return LANDLOCK_WALK_CONTINUE;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -874,47 +906,27 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
-
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
-				/*
-				 * Stops and allows access when reaching disconnected root
-				 * directories that are part of internal filesystems (e.g. nsfs,
-				 * which is reachable through /proc/<pid>/ns/<namespace>).
-				 */
-				allowed_parent1 = true;
-				allowed_parent2 = true;
-				break;
-			}
-
-			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
-			 */
-			dput(walker_path.dentry);
-			walker_path.dentry = walker_path.mnt->mnt_root;
-			dget(walker_path.dentry);
-		} else {
-			struct dentry *const parent_dentry =
-				dget_parent(walker_path.dentry);
-
-			dput(walker_path.dentry);
-			walker_path.dentry = parent_dentry;
+		switch (landlock_walk_path_up(&walker_path)) {
+		/*
+		 * Stops and allows access when reaching disconnected root
+		 * directories that are part of internal filesystems (e.g. nsfs,
+		 * which is reachable through /proc/<pid>/ns/<namespace>).
+		 */
+		case LANDLOCK_WALK_INTERNAL:
+			allowed_parent1 = true;
+			allowed_parent2 = true;
+			break;
+		/*
+		 * Stops at the real root.  Denies access
+		 * because not all layers have granted access
+		 */
+		case LANDLOCK_WALK_STOP_REAL_ROOT:
+			break;
+		/* Otherwise, keep walking up to the root. */
+		case LANDLOCK_WALK_CONTINUE:
+			continue;
 		}
+		break;
 	}
 	path_put(&walker_path);
 
-- 
2.51.0

