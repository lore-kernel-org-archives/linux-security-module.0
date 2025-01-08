Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BF2054E1
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351075; cv=none; b=CvX9/H0a/Y8P0u1Hfc5kdkBtvzbbLZ11SB30PuT1JwsUywdNYgvS0uLcRklfDhwreTaRoWzS+drPHHOqmqdRCO2Nhk1nzky1bh8xz0IZr3t0bLz+wCakekqM8cQOQh/eyUnTiC0fyoWCdxs5Zg/xn16SBjRfhYn/AMk6NRF5ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351075; c=relaxed/simple;
	bh=gr04gmEEgm3mYJS/FkFRKYILFVc7EQJ9YfJe6y01BrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHpCnZ0XgAK2Idw1F2dDd7dLul3Ddi7ejtrRDXGys1hMFPMf9qclioR6wXfUQPY1GZGf2+hogcOOViBF+Cuh8gPtL2QgtLePvigM1eO26VQckDSeuY+e6L6iaHU7pLFd4CNwYYFeQL9LHtMbzsSaR1lpv5D8x5yUOaoB41gpyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ngm0imtV; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ngm0imtV"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfd2k2nzCjN;
	Wed,  8 Jan 2025 16:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351065;
	bh=vYwh4DC0IRpFCSYDmtTUOVM5Ik78zG1VxJIN9X5plHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngm0imtVY1ebrW1n+uP0tClXWfpeHRmzTZxGKGwtoGdMVv0hAvKHKgiwzw0zOBn29
	 17DwbAeZOHGivGe2YaZCdlJjhB++Rpb0cWxrdyS7mt7HPKEWIax+TXDWEdkY/7sR1k
	 kebTljqiFyCXds2XojGkB7PY1xfhronMPD21uuDA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfc4C0wzHsP;
	Wed,  8 Jan 2025 16:44:24 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 26/30] landlock: Export and rename landlock_get_inode_object()
Date: Wed,  8 Jan 2025 16:43:34 +0100
Message-ID: <20250108154338.1129069-27-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This will be used by security/landlock/audit.c in a following commit.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-27-mic@digikod.net
---

Changes since v3:
- New patch.
---
 security/landlock/fs.c | 22 ++++++++++++----------
 security/landlock/fs.h |  2 ++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6404961ecbc7..4b718b669ebe 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -74,13 +74,14 @@ static void release_inode(struct landlock_object *const object)
 	spin_unlock(&object->lock);
 	/*
 	 * Because object->underobj was not NULL, hook_sb_delete() and
-	 * get_inode_object() guarantee that it is safe to reset
+	 * landlock_get_inode_object() guarantee that it is safe to reset
 	 * landlock_inode(inode)->object while it is not NULL.  It is therefore
 	 * not necessary to lock inode->i_lock.
 	 */
 	rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 	/*
-	 * Now, new rules can safely be tied to @inode with get_inode_object().
+	 * Now, new rules can safely be tied to @inode with
+	 * landlock_get_inode_object().
 	 */
 
 	iput(inode);
@@ -259,7 +260,7 @@ update_request(struct landlock_request *const request,
 
 /* Ruleset management */
 
-static struct landlock_object *get_inode_object(struct inode *const inode)
+struct landlock_object *landlock_get_inode_object(struct inode *const inode)
 {
 	struct landlock_object *object, *new_object;
 	struct landlock_inode_security *inode_sec = landlock_inode(inode);
@@ -291,7 +292,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 		return new_object;
 
 	/*
-	 * Protects against concurrent calls to get_inode_object() or
+	 * Protects against concurrent calls to landlock_get_inode_object() or
 	 * hook_sb_delete().
 	 */
 	spin_lock(&inode->i_lock);
@@ -347,7 +348,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	/* Transforms relative access rights to absolute ones. */
 	access_rights |= LANDLOCK_MASK_ACCESS_FS &
 			 ~landlock_get_fs_access_mask(ruleset, 0);
-	id.key.object = get_inode_object(d_backing_inode(path->dentry));
+	id.key.object =
+		landlock_get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
@@ -1288,7 +1290,7 @@ static void hook_sb_delete(struct super_block *const sb)
 
 		/*
 		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * from landlock_get_inode_object()).
 		 */
 		spin_lock(&inode->i_lock);
 		/*
@@ -1327,16 +1329,16 @@ static void hook_sb_delete(struct super_block *const sb)
 
 			/*
 			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
+			 * release_inode() and landlock_get_inode_object()
+			 * guarantee that it is safe to reset
 			 * landlock_inode(inode)->object while it is not NULL.
 			 * It is therefore not necessary to lock inode->i_lock.
 			 */
 			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 			/*
 			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
+			 * originally set up by landlock_get_inode_object() and
+			 * the __iget() reference that we just set in this loop
 			 * walk.  Therefore the following call to iput() will
 			 * not sleep nor drop the inode because there is now at
 			 * least two references to it.
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 9f52c9b37898..3e428fa51cec 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -109,4 +109,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_hierarchy);
 
+struct landlock_object *landlock_get_inode_object(struct inode *const inode);
+
 #endif /* _SECURITY_LANDLOCK_FS_H */
-- 
2.47.1

