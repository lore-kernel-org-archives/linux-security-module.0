Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5DE349AEA
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445947; cv=none; b=UZ9EEwFMZrdDXUV57LcsnYT8ALCvVo0M4IDcHEqjKjXYlwfkjlDz35s8AlRJXp2zlJFSN0N9+PvxRK4+K3vimj8Im9pT22uan/DBhE0syklVHHmzS0fivEdyZp7aM58sHhxtf62su2EzfbHkhL6Or8yrDo17qpC0GNnysWHeuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445947; c=relaxed/simple;
	bh=7wN7OuBkHYOSYg6Jfl1jOB6JXNBA9FAlsRUXFBO3i70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5jgKXLJDNzVTxFIMg0iOqjW4GTkjJ7yONO6R61NHLOSeCcJosPIZA/KYXH747M4RL77ZpD9UDEinof6rcoTKhxNKLAt2QtjzduLCpp5IB6pvd7Lm+Xt8cQmwtAton2e3egaSh1yxFmnsAvNA7HzIsA7iMP2fw0DuAozyfWH44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUViXsdH; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUViXsdH"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649dbff9727so168961d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 12:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445945; x=1772050745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MacgwvjKYKrNTPJUo6/WD4wLvSSrgLbQ+6nhfudTUEo=;
        b=OUViXsdHyeyyeTkwM+UoGpbYSwCzPg9lPMg8UfADegu71RdaZiPBlvXo/7sUM3+BPI
         Gf+GVnCziDMUlYI7QhVTGkrQi73M7N6Uo2xWRoyWD1kzTFZw3sh8L0LERKkd76NzgekN
         wyrhi6wfbvkHVUFyd1+/cyPZgS8uNK5z1/Cawx7fIY1LzQ6TgVLxABWz316mgKhYEuv2
         +ps/v86mmiBwCKCkyuP4+apEOwkxemLHup+Gx0/qbPYUT7U7w4f/HImL09IG/DYIm6rl
         T2qM9RIYvrGftaocAGfVIWrTQfeCRlKP9cSifb3T+4c66keqEhYlYehGnT6tK835CQpP
         6TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445945; x=1772050745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MacgwvjKYKrNTPJUo6/WD4wLvSSrgLbQ+6nhfudTUEo=;
        b=cTqAPxYvOML6urOOGQxHMHlswGslr1hmc3/CZe9eFbrIjvyc5h6/YgEBEjEwjLGFOz
         XhrWXzmDV+r6rcyc6Pl7Dp3eVc2pNEWijlGaBXdYCUCjzyYgXNM9HvX8DKx/RIwTj452
         pjNZ+qpktVT6GX+wfuwGDrRsFApp2vhSIkkalphTbXto/S66QvDvTmXn8ql+2IRU+BW/
         VuUnzgIfi3AMM22RcP90SOF1mPqUYHxoMgnD++anyCAqzxMvNR6abtFUTB4sSYML+pih
         3sf9DDEPdU3+yr+wD7jd0CVNm++LWVvVw6SadFfmXjNDLgByeBlT4y3xzMEKs2lhSd6P
         ZpiA==
X-Gm-Message-State: AOJu0Yyb4EkGDK8lvR1DDjY4tZZD8qzf9sHZQR0iRAaQ9NEaudK8m7/6
	X3BNV/yUfgf09Y+iAHswzVVN9Zd4VOgd5VUyrK50vKp3HStWBpKu/PyDlhZsMg==
X-Gm-Gg: AZuq6aKUOKqZztVadCXrcKOpGu4/wlhf2ku3HpqWY+zlVOXkytZDm21HEll1lq4HgqT
	oqSLJYiNkRHsJK24olSrku8RzuDKefjZT6inK2hlgqOeWk2YhI762TdMBBww1XoMSizkxmaYuYb
	krCI133M6ctVsjHKzowBydOGEUlcJdp4PORjdFf78x3hlxHNGyI6n/CRBxF+ChhScHs5aCm6gzH
	Zt9JoEpp/zz1tODap6/wWmbfd63l3I3EgPx1JaAaYInmRgsAyRWpo4cWeeDJjRisjxu/l3OZOuv
	3JAWbdxyXKmDT92286tMf21lCR4BN3Y5HiBPXumnyBfCoAHDAKuLHhiRNXtOrEubSmqd/E1acPI
	3N57EYLUGW4NWAP5E88z2Fs+sG9ZRBnDhCxAlP8x7GzczhsjY+uDB5Y7k8XL9HlFhNkZTwrzoUM
	gcARQBwuv3q/rBVXF/t4rH4p++iRB3H/jZobzMCxva2562YMewRovQyMuO2iakOtvBzus7UXbv
X-Received: by 2002:a05:690e:13c8:b0:649:b6d1:d589 with SMTP id 956f58d0204a3-64c21a41184mr12658255d50.19.1771445945286;
        Wed, 18 Feb 2026 12:19:05 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e936a7sm6249560d50.6.2026.02.18.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:19:05 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 1/2] landlock: Add path walk helper
Date: Wed, 18 Feb 2026 15:18:56 -0500
Message-ID: <20260218201857.1194667-2-utilityemal77@gmail.com>
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

Add a new helper function landlock_walk_path_up, which takes a pointer
to the current path in the walk, and returns an enum
landlock_walk_result corresponding to whether the current position in
the walk is a mountpoint, the real root, or neither.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c | 92 ++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e764470f588c..c6ff686c9cde 100644
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
+		/* Otherwise, keep walking up to the root. */
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
+		case LANDLOCK_WALK_CONTINUE:
+			continue;
 		}
+		break;
 	}
 	path_put(&walker_path);
 
-- 
2.51.0

