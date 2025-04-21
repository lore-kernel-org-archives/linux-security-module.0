Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7A1FC3;
	Mon, 21 Apr 2025 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745194147; cv=none; b=E+mJqWmgbaUmr1EsmucqHQ801XAPMEAFNi3NqGtRMGzbEZbbBHmq1CcPiVcMl9eH4CCNniCVqMjbROd2qAf+ka050Fn6+1qhMZ6Vh97i4z2HeKovuaG6LuQmQrUKz92S81e7f4curRQ8wXlooTivOMa5aHtoiBY1Bs+xBwS2chQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745194147; c=relaxed/simple;
	bh=73r5FMCoous/Yv7eGdB0ylag+M+nG1yEkQkhm2rpO24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NVL7arHZS0JxZTzW83p+gbe2eWE5kEB/m4UiosCz6JD0scq/HnKVwDH62JoEjygsbotog7tEhWfC8YzUwJSbjeLgIIMxm1MIgXcAK7ZIqMCfQmFWSG2Jg5azoSY/OH1w9tPjnDgCyxLLtqVblHCI7hRJJc0PNOJXu7ViQQAURXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0wwbIdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0wwbIdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA970C4CEE2;
	Mon, 21 Apr 2025 00:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745194145;
	bh=73r5FMCoous/Yv7eGdB0ylag+M+nG1yEkQkhm2rpO24=;
	h=From:To:Cc:Subject:Date:From;
	b=c0wwbIdD2eYVcQ6h0+OsN0X8w5wM8JBJ3euIsCEqFqhjNU8msMulS4kPBt7fqVYXU
	 RVgWWcJImlzNOsGjB66yKj8eV/1YuH1DEu8X7qE8MkF5hPajOqLaWyGn0cgpwAKj5e
	 dfueWAN3TeF/IWJPQF8CV79WK1tZGN3NwXVcSTq+6r/pZMQP6C20T7hi7pemic2kO5
	 0sQ4LTmcI93v8hWUoA3kde/iZZWiPaHBQ7Hn+5QXpk8WGdM+dY+hbF3qU1G6cbNunM
	 x/a0U/twMnNFr75k9ZxHMQsiAdRuH+6t1azVgOWtt6y2yNMjbIVf0tMIHFNWczDxYh
	 lLael80Atb5Lw==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] landlock: Work around randstruct unnamed static initializer support
Date: Sun, 20 Apr 2025 17:08:59 -0700
Message-Id: <20250421000854.work.572-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923; i=kees@kernel.org; h=from:subject:message-id; bh=73r5FMCoous/Yv7eGdB0ylag+M+nG1yEkQkhm2rpO24=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmsPbOfGkyVlrxSeH/qgi9rd92/pvxC/IuL5qXNs1+s5 Z2trxSt0FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRHB9Ghu6r7xV2X1HaasK/ 6XrjP4dc1VyZ65vEnpbdSivt/Z9dc5zhn5mjrIf9j/O8PVpZk+zevAqemJtR6BL6+Zx9pv27/de 2cgAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Unnamed static initializers aren't supported by the randstruct GCC
plugin. Quoting the plugin, "set up a bogus anonymous struct field
designed to error out on unnamed struct initializers as gcc provides
no other way to detect such code". That is exactly what happens
with the landlock code, so adjust the static initializers for structs
lsm_ioctlop_audit and landlock_request that contain a randomized structure
(struct path) to use named variables, which avoids the intentional
GCC crashes:

security/landlock/fs.c: In function 'hook_file_ioctl_common':
security/landlock/fs.c:1745:61: internal compiler error: in count_type_elements, at expr.cc:7092
 1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
      |                                                             ^

security/landlock/fs.c: In function 'log_fs_change_topology_path':
security/landlock/fs.c:1379:65: internal compiler error: in count_type_elements, at expr.cc:7092
 1379 |         landlock_log_denial(subject, &(struct landlock_request) {
      |                                                                 ^

We went 8 years before tripping over this! With this patch landed,
we can enable COMPILE_TEST builds with the randstruct GCC plugin again.

Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Closes: https://lore.kernel.org/lkml/Z_PRaKx7q70MKgCA@gallifrey/
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/
Reported-by: WangYuli <wangyuli@uniontech.com>
Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: "Günther Noack" <gnoack@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <linux-security-module@vger.kernel.org>
---
 security/landlock/fs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..b2818afb0503 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1376,14 +1376,14 @@ static void
 log_fs_change_topology_path(const struct landlock_cred_security *const subject,
 			    size_t handle_layer, const struct path *const path)
 {
-	landlock_log_denial(subject, &(struct landlock_request) {
+	struct landlock_request request = {
 		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
-		.audit = {
-			.type = LSM_AUDIT_DATA_PATH,
-			.u.path = *path,
-		},
+		.audit.type = LSM_AUDIT_DATA_PATH,
 		.layer_plus_one = handle_layer + 1,
-	});
+	};
+	request.audit.u.path = *path;
+
+	landlock_log_denial(subject, &request);
 }
 
 static void log_fs_change_topology_dentry(
@@ -1720,6 +1720,7 @@ static int hook_file_truncate(struct file *const file)
 static int hook_file_ioctl_common(const struct file *const file,
 				  const unsigned int cmd, const bool is_compat)
 {
+	struct lsm_ioctlop_audit audit_log;
 	access_mask_t allowed_access = landlock_file(file)->allowed_access;
 
 	/*
@@ -1738,14 +1739,13 @@ static int hook_file_ioctl_common(const struct file *const file,
 				  is_masked_device_ioctl(cmd))
 		return 0;
 
+	audit_log.path = file->f_path;
+	audit_log.cmd = cmd;
 	landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
 		.type = LANDLOCK_REQUEST_FS_ACCESS,
 		.audit = {
 			.type = LSM_AUDIT_DATA_IOCTL_OP,
-			.u.op = &(struct lsm_ioctlop_audit) {
-				.path = file->f_path,
-				.cmd = cmd,
-			},
+			.u.op = &audit_log,
 		},
 		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
 		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-- 
2.34.1

