Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68F1A9FA4
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022351; cv=none; b=DjU4UgUMW7BUrLCpQ8f59gfbv3FirnL5t8iDDEGCR12gPhB21E59QPLJBbsb65VzrnPwisFh4gJaMz/77G3+LkK29XclMsFOqs9oPCUeJTAD1oVy12I8KRnH9+7/Wz0R86uFeEQKcJux6n+FIx5iOZqhQQhDh9WVZZu+/pgcLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022351; c=relaxed/simple;
	bh=X7DDQVd91J+XcvQeljj+klmIHhI9od8LSHmNwdVP/cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYmQKsJ4l1+BRvcWKLHFfmv4zc/uhvmJJz/MggZGz4MgWawPVRool4/pPuDbikAVLRwzm3qCXW7w/NADar6PfivsKZ6Y6FaMasbGCsXMYDpNlEoY5MHSly49EYygo344l1K0ZBZuNcNaqrDXxIsp18Ibu/g5CGI/r6pVkrMMN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7YLgHJe; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7YLgHJe"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7a17bc5745eso34531777b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022349; x=1776627149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0W8leJz6aprQbODedHRoDCJJbhEDZcqlo9BvqfZxj0=;
        b=H7YLgHJes1ieZ3WAk3t4DJfA6vXInJO++f5ymsPxtpzwq4EIMfHoc6z5iAk4c+gSge
         h2NrtqeKFz29NKqtU2W158JEI7Et53K4lFNw0iPQ/EbBFuQuYnNnXORzWjZDodh23SQh
         Hm8otc4xOO5Bc6hJqRsPvCwEgA2wHSASFPxT85GFCzBo8GmBc+I+O9wLI7VjESgvt49H
         oHTMD2W2puQbFMKlvEeQGpoY6boXw2rrP1Nu2nViLsFL+Dizwk+ic3hyIncGocKRqtGi
         MWdO5jtxFI+60XRlnlUbXwyLZ8L8ykjw+fnFQmlozLflTMVGCLtO7pRrrXK9LYnRp6qM
         d4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022349; x=1776627149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0W8leJz6aprQbODedHRoDCJJbhEDZcqlo9BvqfZxj0=;
        b=ZdylnebFboge0PaGKjUZ5Apu/EtK2bhibc06T8Q05Zd5Yc6Zn1GqkdIvKV5l6j32KP
         7V7Enu03apcIuX9FKgKIrQ4GBixlYLfqu2aKkApuFfP8rl4VRReVLXVPVWIWXi2XDnqq
         oDuGX7c0eSBG88m07GNaZn1zCjepFba2tbYx9o+wDDVqsXfACvDjDDKUBo3bfBTz3nlS
         1AkzddODMg2bvG/bnnhQOzNyjnEKIrOVExI7sKZKJBJqwOh5oi4fwil4H22u26MvVr2o
         hcp3qcP/ceZ3A6DUmze1sWLos3OIDWNcaj7jaCLHsOrbm5sAFDTNXUKDPm8DU09c9c/j
         Qz+w==
X-Forwarded-Encrypted: i=1; AFNElJ/biS2bk1BrFiy3kJ+4/KnM3ZFzWbSy7cLzMoD72yGsdm+ct9YR22c8hBbE3YIeniLsJKFR/+ywFpTr0wC8BTETPmc3P/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Vhj+SeI2Nai7RPX1nnHHGzQEQoj/Y0k1W3W+tz1JKH5eIcxq
	54S7YwlyFU6XsJJCmob3LcmHLVH3Q9HavOHB2EC5mXC8Q9Vq+jSpHK/1lseiyg==
X-Gm-Gg: AeBDiet1eT2cPzE+Suvsd6Q6JZfB3qn7ygrt4JHC7KQYI5+Dnup6QGDJeIPQeoI4ndU
	QZuLc98FWbpn0WvAZj7mV4Az0nEJQOqvkZteWgB4V+B2AmalpECvK4DOFncrq0heFgvqGHcqDZX
	nbP1JJwWsGTVZmI8IEeQjKzzjU0D2a66iPHbhmoZajEkC5IqDkplwFAmYITI3a6a9xJ4cftz6hJ
	iZX0sSh7K0VWb8F00OBCzD9d85gT5x+SouKJe9KBkHwkbW2pUk0Ne5TUXkgdj9/tDkk2gWq4gNU
	a5AD3CQiMHJ86G1+QsWknpeQ/b2IQ5/FrWDInfN4KDg0P1mQUXwHIacK18iQI5qI38oODbBb01b
	JkF7Yh6ki2+nYwKSdUDA347NpM1YaHJrRmeHelQZHYJG3Nze0cjDd0bEmiOaxfxG3jAqppF9aU/
	yaXizWy9vVuGlEUCUKV0GSo/RzQX57dqN0vDlPR10KLveQcDOxAyCCW7d8/4Ic9mDLqhJMZn6x
X-Received: by 2002:a05:690c:e3e8:b0:7b2:9347:7baa with SMTP id 00721157ae682-7b293478b9cmr23527157b3.53.1776022349209;
        Sun, 12 Apr 2026 12:32:29 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:28 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 02/10] landlock: Use landlock_walk_path_up for is_access_to_paths_allowed
Date: Sun, 12 Apr 2026 15:31:53 -0400
Message-ID: <20260412193214.87072-3-utilityemal77@gmail.com>
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

Use common path walk helper for is_access_to_paths_allowed. This
maintains consistency with the existing implementation, and removes the
backward goto jump.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * New patch split out from the v6 core NO_INHERIT implementation.

 security/landlock/fs.c | 60 ++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 644637a8c0b5..b31bd2980e5c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -923,47 +923,27 @@ static bool is_access_to_paths_allowed(
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
2.53.0

