Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756B1FE477
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351041; cv=none; b=jViZsQFcQCZ/yOnUdcYXWJ+wBIGRG4kRPEUzx2D+rE7RPsASR1z0VqL5cV7tKWWgsgzFBC6uWcN5uAWHpKRo/W1lPHYt2ZkTAAIv0QiBrTVfzfmSBGBRXZmAXPVBg4NSvj8uGgW6Yb6cjfJMjSw9u8u+vi3+vR4qUL0Ylt8hhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351041; c=relaxed/simple;
	bh=jkCx7VwBn7yzSOYAV94ez6PoPUBt3wBsN+EoH9D7sJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM0kyHRk3oNY/nePzgi1sCYqf5dB+SNG4N+DnH2b3S1YR7/g7X+Y9F9dPYDCCQdjahc8HyHA8XoGNVcSVmgp5RPjFr2BEx9fvSQ9rQ/vqQJ6LhuT0ydIFKjQKy2u9suuG4kVn1wFWlDlVj/t38GuGcw3NuqsmbfGtAOcyEoJvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xPiY44Rh; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xPiY44Rh"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsdy6QSpzBLL;
	Wed,  8 Jan 2025 16:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351030;
	bh=wog4Z8sglJxp2TnTzlne7/LQuXSQ6DLXgDWqI6IW4kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xPiY44Rh2sAv6WNSrqIoNSJ8vP/a10im8yyioqOPazXDCMOxs6Kim3/hV379hPJLB
	 toojExmoLDOIYQbHQrHVS8B2QXgqJGx16N0dGRuTTlNDgrVB+KsMPHATmVmoVSn186
	 iaF0fobzVu/aJsNFvSLCstTcnxIKDxSoNOYxa268=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsdy0LzZzJyj;
	Wed,  8 Jan 2025 16:43:50 +0100 (CET)
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
Subject: [PATCH v4 03/30] landlock: Factor out check_access_path()
Date: Wed,  8 Jan 2025 16:43:11 +0100
Message-ID: <20250108154338.1129069-4-mic@digikod.net>
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

Merge check_access_path() into current_check_access_path() and make
hook_path_mknod() use it.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-4-mic@digikod.net
---

Changes since v1:
- Rebased on the TCP patch series.
- Remove inlining removal which was merged.
---
 security/landlock/fs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175..d911c924843f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -908,28 +908,22 @@ static bool is_access_to_paths_allowed(
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
@@ -1414,11 +1408,7 @@ static int hook_path_mknod(const struct path *const dir,
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
2.47.1

