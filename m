Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E4215F79
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459505; cv=none; b=q0rOOQ181+LDcPDkWJ1SQgmoTVbNP9Jr1eZuwrDhfiKmSz+EiTuJwkHDGoS82La4BsZdO9gewdDniE/nBwP3qi9/4ov1rfNKsr5BhyIoW2gKOJJzP4uE+5I4ewXzemjIlLIeO/c+vVhvuLdv5gQbU/9PecfCd61erL6uDmuHqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459505; c=relaxed/simple;
	bh=OlNzPmf82Dwqvaf790xzC1Jbc4nAdjQWZ7qF2fGhVDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFp+2KBo1qPu7md4kKmrXashQ92ha/UHXSkDfjk1v/pDD6L0AUF5uWmXY/HJGyIZV8Gh8eUXB8jgbeQyxrAAMTAf8sTIJiObZ6RWXoO8QHGyU3GBc2HfkdPtcV7MCTs8NUPOY/nGjgkrgWo4bM/ijzfkkOmVe9roFPK66XC5VHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lHvSALqj; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lHvSALqj"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsm2X6szSwT;
	Sat,  8 Mar 2025 19:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459500;
	bh=W9mq3JNdoLiJcn0ZPxWDmdxmjmG0hkY/Wsw30p5Lvpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHvSALqjk/H/JTp3r9ONV4PHn0PeYQ5rbPGoZec0/LM5X+V8n5Od3mXSaBMcW+Rd6
	 UVv6dTAdYprkf+ysmv6NINzZ+GPaJj1KnhH8z7o9kjh1/ATvL0h8BI2wk7ahXicukS
	 VbwTHjYVT5YVRhFBAzAJwTjeC80/cnq/sgJ8Ps5k=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsl4HLbzjlG;
	Sat,  8 Mar 2025 19:44:59 +0100 (CET)
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 18/26] samples/landlock: Enable users to log sandbox denials
Date: Sat,  8 Mar 2025 19:44:14 +0100
Message-ID: <20250308184422.2159360-19-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

By default, denials from within the sandbox are not logged.  Indeed, the
sandboxer's security policy might not be fitted to the set of sandboxed
processes that could be spawned (e.g. from a shell).

For test purpose, parse the LL_FORCE_LOG environment variable to log
every sandbox denials, including after launching the initial sandboxed
program thanks to LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-19-mic@digikod.net
---

Changes since v5:
- Update with new flag.

Changes since v3:
- Extend error message, suggested by Francis Laniel.

Changes since v2:
- New patch.
---
 samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++++++++++---
 security/landlock/syscalls.c |  8 ++------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 07fab2ef534e..4e2854c6f9a3 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -295,7 +296,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 6
+#define LANDLOCK_ABI_LAST 7
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -322,6 +323,9 @@ static const char help[] =
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
 	"\n"
+	"A sandboxer should not log denied access requests to avoid spamming logs, "
+	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
@@ -340,7 +344,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	const char *cmd_path;
 	char *const *cmd_argv;
 	int ruleset_fd, abi;
-	char *env_port_name;
+	char *env_port_name, *env_force_log;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 
@@ -351,6 +355,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 	};
+	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+	int set_restrict_flags = 0;
 
 	if (argc < 2) {
 		fprintf(stderr, help, argv[0]);
@@ -422,6 +428,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
+		supported_restrict_flags &=
+			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+
+		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -456,6 +469,24 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
+	/* Enables optional logs. */
+	env_force_log = getenv(ENV_FORCE_LOG_NAME);
+	if (env_force_log) {
+		if (strcmp(env_force_log, "1") != 0) {
+			fprintf(stderr, "Unknown value for " ENV_FORCE_LOG_NAME
+					" (only \"1\" is handled)\n");
+			return 1;
+		}
+		if (!(supported_restrict_flags &
+		      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON)) {
+			fprintf(stderr,
+				"Audit logs not supported by current kernel\n");
+			return 1;
+		}
+		set_restrict_flags |= LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+		unsetenv(ENV_FORCE_LOG_NAME);
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
@@ -483,7 +514,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
 	}
-	if (landlock_restrict_self(ruleset_fd, 0)) {
+	if (landlock_restrict_self(ruleset_fd, set_restrict_flags)) {
 		perror("Failed to enforce ruleset");
 		goto err_close_ruleset;
 	}
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index e38b22075ca1..cae0a0fd08d8 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -495,12 +495,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	/* Translates "off" flag to boolean. */
 	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
 
-	/*
-	 * It is allowed to set %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with -1
-	 * as @ruleset_fd, but no other flag must be set.
-	 */
-	if (!(ruleset_fd == -1 &&
-	      flags == LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+	if (!(flags == LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF &&
+	      ruleset_fd == -1)) {
 		/* Gets and checks the ruleset. */
 		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
-- 
2.48.1

