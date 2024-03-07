Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0061DFF7
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822357; cv=none; b=UBX7DyA7i5+GagzixWqrpexljtUv91RMt3nj0dQGtKY1ifrIYlvU0GQhO4BM+d3WLbn7r4nYYuj5e1Tc3xCE6qIa1uyLedAjAoKAcAIMLCWhU5spwbq04x5eip5sgfMwXmasaxQAeLVKZSLTUOvKRhXgc613IKSOYB/Znw1NADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822357; c=relaxed/simple;
	bh=+dE/Mzf4X3lkhNqdDIXT9zhURf55ZrucbCbcO2MJxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCCKlyLf9GnNUQzitwU2qBk8s/U5BY9HFReIyta0KDjZZpVprlAy1zysiaCB/cWnXiaTQEvxoA8wOEoJU+h/gFhYjFas1dTGb4SV9OeQ/aGymS4caQnFc5B4NZ6HSG3zbhgn3XPs51lSMC8QPeZmqXtugpw5zVVc4EJGpPjiaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qm860GOx; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qm860GOx"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrBkw3WXqzDyc;
	Thu,  7 Mar 2024 15:39:04 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrBkv4dWqzMpnPj;
	Thu,  7 Mar 2024 15:39:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709822344;
	bh=+dE/Mzf4X3lkhNqdDIXT9zhURf55ZrucbCbcO2MJxd4=;
	h=From:To:Cc:Subject:Date:From;
	b=qm860GOxjCckdUCqSPUFyab0YnGgtn5fs72ykYciR/0zQeHNKEDOhMOBNE31TUV2U
	 yUTQFF21a6HxlBvDdnmFObWM88n9uZ1RELuIq5kvuxTyIWJtKOLrlt6cSFXdTLYnFO
	 SlK8MFM2RGYK53Dynx24oLMB3VnHCPdukNJJ3eno=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] samples/landlock: Don't error out if a file path cannot be opened
Date: Thu,  7 Mar 2024 15:38:49 +0100
Message-ID: <20240307143849.1517218-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Instead of creating a hard error and aborting the sandbox creation,
accept file path not usable in the LL_FS_RO and LL_FS_RW environment
variables but only print a warning.  This makes it easier to test, for
instance with LL_FS_RO="${PATH}:/usr/lib:/lib"

Print that we are going to execute the command in the sandbox before
doing so.

Rename "launch" to "execute".

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 samples/landlock/sandboxer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index d7323e5526be..22e8c35103ce 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Simple Landlock sandbox manager able to launch a process restricted by a
+ * Simple Landlock sandbox manager able to execute a process restricted by a
  * user-defined filesystem access control policy.
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
@@ -121,9 +121,11 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (path_beneath.parent_fd < 0) {
 			fprintf(stderr, "Failed to open \"%s\": %s\n",
 				path_list[i], strerror(errno));
-			goto out_free_name;
+			continue;
 		}
 		if (fstat(path_beneath.parent_fd, &statbuf)) {
+			fprintf(stderr, "Failed to stat \"%s\": %s\n",
+				path_list[i], strerror(errno));
 			close(path_beneath.parent_fd);
 			goto out_free_name;
 		}
@@ -229,7 +231,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
 			ENV_TCP_CONNECT_NAME, argv[0]);
 		fprintf(stderr,
-			"Launch a command in a restricted environment.\n\n");
+			"Execute a command in a restricted environment.\n\n");
 		fprintf(stderr,
 			"Environment variables containing paths and ports "
 			"each separated by a colon:\n");
@@ -250,7 +252,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			ENV_TCP_CONNECT_NAME);
 		fprintf(stderr,
 			"\nexample:\n"
-			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
+			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
@@ -390,6 +392,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 
 	cmd_path = argv[1];
 	cmd_argv = argv + 1;
+	fprintf(stderr, "Executing the sandboxed command...\n");
 	execvpe(cmd_path, cmd_argv, envp);
 	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
 		strerror(errno));
-- 
2.44.0

