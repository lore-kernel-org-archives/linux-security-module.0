Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782F1A01D4
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614014; cv=none; b=lMT/2Jfyp8XQYFT5LaInpFExtH3tTKMi5Uk/GsWf/oenUluUbAl2tg5jwiaKl4OlQO5MANbeqLZv6DAfwSAGLOI4fNYzNaF0aPgx6Dz4r7jO7oGcaUYJkD77VM8R/gdPGifjeiDRxobHgGw30gD6pkMZM0DutOZCmb0Ev+et0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614014; c=relaxed/simple;
	bh=gKRPBSv5tRdn0WhX8XTWlq6SJW7sHsXoiZHnw6l3YeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrvV5zXHiLLw+gxXfF7rpQKP9gE846wNWMlLHibmMc6+Ehl941lkpwgZaDTvQJEARj93ZsIkgmy553Y/3H36GtxEHjCQeR4LMsrsMDlWZjumHJXZ7RJ28ecLHUVzXx3lAPkChpCxJ7WLZLy6GAjVGXIIjir2zDSRwqIyAGN7VZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=d85gjLzQ; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="d85gjLzQ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwb27ngzMZV;
	Tue, 22 Oct 2024 18:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613423;
	bh=KiJAI6pzo/lR1j3ha++zSLq7VEjNzvmIBz7wSSyQs+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d85gjLzQ0Yh9evyPoI84SlDBOBY24w/2YvFinONBukFG9wcckRuUv2a63QyteCogX
	 je+JU/UDduA4izmDb5d6bl4AT81L9hzvuz4iPyuhSPBuKifqTrhwEkjqM2+Wye6H2f
	 S7Xgx1fOfRNz3a7AZ1ULRVIlDlboGLvaTLSa5i9c=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwZ35zvzn8l;
	Tue, 22 Oct 2024 18:10:22 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 03/14] landlock: Factor out check_access_path()
Date: Tue, 22 Oct 2024 18:09:58 +0200
Message-ID: <20241022161009.982584-4-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Merge check_access_path() into current_check_access_path() and make
hook_path_mknod() use it.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-4-mic@digikod.net
---

Changes since v1:
* Rebased on the TCP patch series.
* Remove inlining removal which was merged.
---
 security/landlock/fs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index dd9a7297ea4e..698a623a8184 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -907,28 +907,22 @@ static bool is_access_to_paths_allowed(
 	return allowed_parent1 && allowed_parent2;
 }
 
-static int check_access_path(const struct landlock_ruleset *const domain,
-			     const struct path *const path,
-			     access_mask_t access_request)
-{
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
-
-	access_request = landlock_init_layer_masks(
-		domain, access_request, &layer_masks, LANDLOCK_KEY_INODE);
-	if (is_access_to_paths_allowed(domain, path, access_request,
-				       &layer_masks, NULL, 0, NULL, NULL))
-		return 0;
-	return -EACCES;
-}
-
 static int current_check_access_path(const struct path *const path,
-				     const access_mask_t access_request)
+				     access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, path, access_request);
+
+	access_request = landlock_init_layer_masks(
+		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
+	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
+				       NULL, 0, NULL, NULL))
+		return 0;
+
+	return -EACCES;
 }
 
 static access_mask_t get_mode_access(const umode_t mode)
@@ -1413,11 +1407,7 @@ static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	const struct landlock_ruleset *const dom = get_current_fs_domain();
-
-	if (!dom)
-		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return current_check_access_path(dir, get_mode_access(mode));
 }
 
 static int hook_path_symlink(const struct path *const dir,
-- 
2.47.0

