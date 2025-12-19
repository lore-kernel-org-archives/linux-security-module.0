Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAE126C17
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154219; cv=none; b=oF2omPstDSJaICMQXwcHOW0gtlEvXcWOzolWm4PTAk7wz3oT8/+KBERZhYDXMJuKuDxhL8rajVAfQpShfrbpy/rm9mhvGrKLrh7DyyJYRnd3IaNKx+yLIjqLuHRV6oMHgQm4ZZKVIdoxMNwAbC3NPaZur56NvJtgTCo4Au38mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154219; c=relaxed/simple;
	bh=/FRgpTIXBRaiRfwijWeDX3b7uIdClwbAW1PQCMcHYvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lO0+RUPiuWDyWjSQp0bIIfYptMsKDHeRTcOCDcY0oYP8npXK0bMG0x6a4r3XKkiYgdNZN/xVXBugI6yTJpKSAueSJpZ/uqBwvviqpLL3XXVPU/dTKhAQK4yUVKLI7RexztzgXZRFwoVJ4O1I7E6XCHcqqBgS3k1v/mip37c2ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cpMysYHK; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cpMysYHK"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXqWx2M7ZzDXL;
	Fri, 19 Dec 2025 15:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766154205;
	bh=wz2dYOWi+30riafQROs3VXSO4UJQHyIoghqK6kqc48c=;
	h=From:To:Cc:Subject:Date:From;
	b=cpMysYHKz4oMJxEZCJbSR5Gc6E7TkQvTjTnxzaU8g2H60rXuame7UHubIQu5n7CMp
	 Q+8C3lUDcmR1EVeSLVcnQGRY+QkWz6a7GKpLjPzYzi8TQiWHJehO99EEU7IZSNkG9L
	 e5InTsstyDICCUodH06SHaJ62wT8n3ecFtTqHKl8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXqWw6Sw4z9tD;
	Fri, 19 Dec 2025 15:23:24 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v1] landlock: Optimize stack usage when !CONFIG_AUDIT
Date: Fri, 19 Dec 2025 15:22:59 +0100
Message-ID: <20251219142302.744917-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Until now, each landlock_request struct were allocated on the stack, even
if not really used, because is_access_to_paths_allowed() unconditionally
modified the passed references.  Even if the changed landlock_request
variables are not used, the compiler is not smart enough to detect this
case.

To avoid this issue, explicitly disable the related code when
CONFIG_AUDIT is not set, which enables elision of log_request_parent*
and associated caller's stack variables thanks to dead code elimination.
This makes it possible to reduce the stack frame by 192 bytes for the
path_link and path_rename hooks, and by 96 bytes for most other
filesystem hooks.

Here is a summary of scripts/checkstack.pl before and after this change
when CONFIG_AUDIT is disabled:

  Function                       Old size   New size   Diff
  ----------------------------------------------------------
  current_check_refer_path       384        208        -176
  current_check_access_path      192        112        -80
  hook_file_open                 208        128        -80
  is_access_to_paths_allowed     240        224        -16

Also, add extra pointer checks to be more future-proof.

Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fe794875ad46..722f950307f6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -939,7 +939,12 @@ static bool is_access_to_paths_allowed(
 	}
 	path_put(&walker_path);
 
-	if (!allowed_parent1) {
+	/*
+	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
+	 * associated caller's stack variables thanks to dead code elimination.
+	 */
+#ifdef CONFIG_AUDIT
+	if (!allowed_parent1 && log_request_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent1->audit.u.path = *path;
@@ -949,7 +954,7 @@ static bool is_access_to_paths_allowed(
 			ARRAY_SIZE(*layer_masks_parent1);
 	}
 
-	if (!allowed_parent2) {
+	if (!allowed_parent2 && log_request_parent2) {
 		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent2->audit.u.path = *path;
@@ -958,6 +963,8 @@ static bool is_access_to_paths_allowed(
 		log_request_parent2->layer_masks_size =
 			ARRAY_SIZE(*layer_masks_parent2);
 	}
+#endif /* CONFIG_AUDIT */
+
 	return allowed_parent1 && allowed_parent2;
 }
 
-- 
2.52.0

