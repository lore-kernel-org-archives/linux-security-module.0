Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD51F12E5
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341303; cv=none; b=cl/TVrd3y8M6nuJN+4YSM9OMzX5x6fBHSzrBG4wkLnoRbCXh3hJKnW4qL9KuKMXQOwlF4fAIJN/7eJo97Q/OtoOG3nIykzeoo0PGu7MQiuB6C7gwaqB0l63X/QPOTE7hPr2JrN6gIEF6S3ns+aakrwXis6+G1HHjZM+lRmoZKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341303; c=relaxed/simple;
	bh=s3V32RxTc9rjwEdIymNuOJwJkTxz3xJgXjeJ8V2zx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb3ScXmn77YVgwoQPGmiW+jfQSuC2OYV3eyZpzYc3rSWk/PRSDsuZwAoaQlwR2h43ri06q94SiQaoe+ulWl8xLedI1kua2aaXv9gmZAuTQjiGGRSf/xyr2rOvVzAh+GVr795j4xfvWAfUZ0NkIOtF9SCV7VB6fzOBE673LmzTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=F2Acy9Sp; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="F2Acy9Sp"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1hM5wFFz17kX;
	Fri, 31 Jan 2025 17:34:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341299;
	bh=WO2vAsxZVdDDoK6+XBTdTT+unawoC0QprK0aBSpqsk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2Acy9SplbTktfS6Obk+lbE1XOfnJN+cQT6vUMJ9qmF56SDhIDo+FT9ImLUmUFDUm
	 4LDdJlzTjfL9KLZeUjsVXVuY62st90Y6fVKe87+2EVfQ9vl71Qns7a4Ljzf0gXupjA
	 kC/ITpnrhYkkDPckEkg1sF3HUIjdsE/3OGc/aSHA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1hM0jBtzbTy;
	Fri, 31 Jan 2025 17:34:59 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Tyler Hicks <code@tyhicks.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 3/3] samples/landlock: Print domain ID
Date: Fri, 31 Jan 2025 17:34:47 +0100
Message-ID: <20250131163447.1140564-4-mic@digikod.net>
In-Reply-To: <20250131163447.1140564-1-mic@digikod.net>
References: <20250131163447.1140564-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

If the PIDFD_GET_INFO IOCTL command and the related
PIDFD_INFO_LANDLOCK_FIRST_DOMAIN flag are supported, print the newly
created domain before launching the sandboxed program.

Cc: Günther Noack <gnoack@google.com>
Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163447.1140564-4-mic@digikod.net
---
 samples/landlock/sandboxer.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 68a5f16bacd5..018bafaa470a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -15,15 +15,20 @@
 #include <linux/landlock.h>
 #include <linux/prctl.h>
 #include <linux/socket.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <stdbool.h>
+
+/* Avoids conflict with fcntl.h */
+#define _LINUX_FCNTL_H
+#include <linux/pidfd.h>
 
 #ifndef landlock_create_ruleset
 static inline int
@@ -53,6 +58,11 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 }
 #endif
 
+static inline int sys_pidfd_open(const pid_t pid, const unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
@@ -343,7 +353,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
 	char *const *cmd_argv;
-	int ruleset_fd, abi;
+	int ruleset_fd, abi, pidfd;
 	char *env_port_name, *env_force_log;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
@@ -510,6 +520,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		goto err_close_ruleset;
 	}
 
+	/* Opens our own pidfd before sandboxing, if supported. */
+	pidfd = sys_pidfd_open(getpid(), 0);
+
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
@@ -520,6 +533,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	}
 	close(ruleset_fd);
 
+	if (pidfd >= 0) {
+		struct pidfd_info info = {
+			.mask = PIDFD_INFO_LANDLOCK_FIRST_DOMAIN,
+		};
+
+		if (!ioctl(pidfd, PIDFD_GET_INFO, &info) &&
+		    (info.mask & PIDFD_INFO_LANDLOCK_FIRST_DOMAIN)) {
+			fprintf(stderr, "Entered the Landlock domain %llx.\n",
+				info.landlock_first_domain);
+		}
+	}
+
 	cmd_path = argv[1];
 	cmd_argv = argv + 1;
 	fprintf(stderr, "Executing the sandboxed command...\n");
-- 
2.48.1

