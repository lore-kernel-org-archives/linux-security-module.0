Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC1F0E3D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341115; cv=none; b=qDup19IfNaaRVoAE9Eivo5p74ZGfZlQA9CqsjqWXJp+FuPWnt9CBQv+0BxKVxQYomprhtz+eEpZw/xq1+oO4HNdT7GVAyM1j6aqXSnROIuU5R3ZV9XumvQSKArPR0ucPX37IPxzMiGWDaTWnRBved4Hd/s+T7yR8P6cElgv7CG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341115; c=relaxed/simple;
	bh=A26ZOrJVLM/ALFTBTEvXF9cK3l4HaNnZ05FKd13zv8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flTIq6h1SKlsaR6gFVx/NRYWOOA7cUsiNdDtrvu2lz+TUfKL85Y3pkrq5VoW2esueEBBuzrfz85xfoHMihJT2wOADHkj43IkztvfV4VMz7uiPgi96YFFby5s5kxF3SD1NDDyJO3r+gWFj8oIpucrdt1ADv6PheCPv3EP8PH/BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1EwGbTab; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1EwGbTab"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cm0D7PzTfR;
	Fri, 31 Jan 2025 17:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341111;
	bh=1+xbB1Pvv54Nk/5dfBskGxnxy664v0IUVrVciyNh5fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1EwGbTab0UfLeET/rQEGI11T3k+s70vnBcOCmUAec5GeDpIkH5EfVRYAz3sL7j5Nv
	 vh2wYCDE37GLXw7EzWHf51HocARAXe8nwbDk4CLEMl6VmGXJnMrrVkphpWawaTiBkl
	 LdD5+OtHTiro4IJAFBC0CY6Cgt1iOopTFY7NSWyw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1ck6XStzbQd;
	Fri, 31 Jan 2025 17:31:50 +0100 (CET)
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
Subject: [PATCH v5 19/24] samples/landlock: Enable users to log sandbox denials
Date: Fri, 31 Jan 2025 17:30:54 +0100
Message-ID: <20250131163059.1139617-20-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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
program thanks to LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-20-mic@digikod.net
---

Changes since v3:
- Extend error message, suggested by Francis Laniel.

Changes since v2:
- New patch.
---
 samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 07fab2ef534e..68a5f16bacd5 100644
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
+	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC;
+	int set_restrict_flags = 0;
 
 	if (argc < 2) {
 		fprintf(stderr, help, argv[0]);
@@ -422,6 +428,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC for ABI < 7 */
+		supported_restrict_flags &=
+			~LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC;
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
+		      LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC)) {
+			fprintf(stderr,
+				"Audit logs not supported by current kernel\n");
+			return 1;
+		}
+		set_restrict_flags |= LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC;
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
-- 
2.48.1

