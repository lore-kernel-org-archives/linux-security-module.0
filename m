Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9723EAB2
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843696; cv=none; b=QmGiqdSBDNhjVPxYXEOPj5dWGdJ3VBz8M+Mz+8ld5TullItd2S0GemLLCur2iAAoI+co5JG0MJaQY8KN0pXJ21CYov0XPRR1SYAGqq7qiE54QMXZInk73elMQ0t536vEE3SW1k4VCJ2FiK6P47A/arFQw1MZlao07MfS3H6a7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843696; c=relaxed/simple;
	bh=koQY6aqEnT/+mqjQa/rc/jJhAAIZDEbdk/dy9ojjNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYIUL1ZL2+l+jk76mSZczzrZnWtFj3hjJdOM7GI16QKVFX1RYXZ+LQfBUrZqtJTd6Won2/r+3zZIWn7iryZ+/GP9hwsJ/O83LprxddKIAoKNnDqvTiZELBbkol1srvWkuHWUAlxvc3dyD9OCvxIYvE91X9A2KiYX2ySvReAcibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=j1Shgedu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7cVWaEg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="j1Shgedu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7cVWaEg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB6A3140004C;
	Tue, 26 May 2026 21:01:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 21:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843693; x=
	1779930093; bh=OhIgX5/ZgypuS3xabM3k5zvS62hHfs+2R28GhI+/v9U=; b=j
	1ShgeduAnpJD/rw+7YPZgKBtJ5AdL+mEUCvXFTWw5UN76xZtQFon++NRO9mZIgcr
	OlgthbN+smmw1S9O2UZfXt8rNyNzlrXsAW1xYuCXjaVrvDV/b00WBzxDMER5aK+N
	kOb3dgqxoWaerZTjXHzFPE+f+Eh38xKin19rUh9kfyPUcbRU3xwvF86UhoWFK/Ai
	lQvC/t0DBZMcOvH0PWIsfz/FOjpIDZQ0oIOUSkeZ0wd/YgXkR24Do1CLtB7tZeX2
	G+Ll0CMQMVHb8Ih5Fk9nmu0x8ZrdZ0NXdLtfYp86pG791LM9c699zWpGE2vBD8km
	/DDnveAZF0sZafjxHahgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843693; x=1779930093; bh=O
	hIgX5/ZgypuS3xabM3k5zvS62hHfs+2R28GhI+/v9U=; b=Z7cVWaEgjNgFHqP/V
	yLBhcSVLZ595uft2EMg9hoB/4YCdjDAWy3MOXvfFKfdhYCov/slyugmDy97mASe5
	g+onBLhUYFWP2cURk51T7Vu18kgzQaXyN14yxCbSLkT9ilcu5OGO7FBfac5aUrwr
	1x8Ed2d3MXlARfle+T+wtzt66n8rnPLiNQIkpJzvvrBwCgikuOYm1BcyJXPevLwl
	ROz3xMi8O+bwcq/XTrDmrPWeXHfEoxUD8tq1gqOL3/QFl7t6+lX8WtdSvKXH4484
	o6Whc/MM8qXaP+3jxmo6k4/Trc3641pfwXgzRXBTHIRGc8DDdcXVTbN3dF0zQpgP
	efLfw==
X-ME-Sender: <xms:bUIWaqln3XjimYyAw0nPoZ5p_yr7c7WWdEGiBOoW3doUMo0ytvFltg>
    <xme:bUIWakH9AH4NiGQKTindMIYtPfxbJBjtjXom2-bS6-aNMlaZOn56CawQ4XgY8_Ag-
    lq8-IaTfUkT6GOm4YG2DKjz0pWzD6S4-HcUKbNHjuQil77EwXpUjgI>
X-ME-Received: <xmr:bUIWaq4WJEuzsYpTo_w_0yW9MF0fFS-ShsK49O6zcxlUB0ujX0vyhkLJD_U5p1KjWRA>
X-ME-Proxy-Cause: dmFkZTFUre9sXwItw/D32/LRha63U+D2MMre5R4tNoZC3GZT1kninLOZYHQGUdW/3lBBAr
    rH7WEN1NA0Icq7iWzjSibRmCazO7v8ipojfNsqLogvqpKcgpSkktdCK74u1Yx2bEapFKlN
    S0WIZUEX4JR1fUCKvttN8BxAYAt7dVO6aFHlXili/G3YRmDCCBAzY7r9QgnkuQv0FMn/dy
    NAgD25l8Vnwfwc1HnabyZvWY5OmQC4xgsVYFabzy+Dg3mXYfFbgr+O2AYzjg4pZKiA5CQC
    cooAMlaj6Mhx9kTeOxwXV/N6k5f1c0HpAIGUHCT4okSDNym5kyoKxbD0WxnwKa6hKew0MT
    mgyGjrZ/bh+uL6P6kVuN1bAVkDGv+PMisa58Ts/FdhCKcwJLgB0muIF4gO3T8XGpUanSZG
    cgjcujYy4z8pTvSnoxzZSibbM+CSrayQX2fdOzMMCKJPrJrbua+FaenQozltvOlUSBw9S4
    56iQ6V3NBCYfJX77d+q6XSLdKlL30iob6kWSz9IzY4uKbDSK3mNMk7sG9MzkLJcsRLdJK4
    0HW41R54bA+04D169GLJfHlNtHXri5hZgKF5eCGoodmR0K6CGm9dfykWo4v2FNz3maQFv1
    O4gBKWyK4R39Bx03GoQ0tEB+pPO/OEm34QcTmwpR006YBJnKO1ZsxUIHZX9g
X-ME-Proxy: <xmx:bUIWaklq1cWWq9qaN9ZQmAZFoAWE43XFO1tpLQjrnTlgDhYFMNYXLg>
    <xmx:bUIWanqrXIrt4vB2jLAcLdIjKy4w73pez7Vz8j_LgQ0oxkuqYgA8lg>
    <xmx:bUIWarv-SV4f1is91GHfucw_q9zGeB-1TKebGeMuc8LyDkf2L_juxQ>
    <xmx:bUIWakHTmxIXAFiZossNyaXiIUQXCwrszRrx-DawMDWUSPKKE8goiQ>
    <xmx:bUIWamRG9l7E9CD3dZNlmVB7iwQqQ0iTgou3EEA_8CHx2pn7ZBZeSPSL>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:32 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 4/9] samples/landlock: Add quiet flag support to sandboxer
Date: Wed, 27 May 2026 02:01:14 +0100
Message-ID: <7d5ad9631a51df6c2b857ff9c0122ff8ed491b7d.1779843375.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779843375.git.m@maowtm.org>
References: <cover.1779843375.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds ability to set which access bits to quiet via LL_*_QUIET_ACCESS (FS,
NET or SCOPED), and attach quiet flags to individual objects via
LL_*_QUIET for FS and NET.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v9:
- Add udp connect / bind quiet flag support

Changes in v8:
- Rebase on top of mic/next
- populate_ruleset_net() already does not require the env var to be
  present, so remove redundant comment and check above
  populate_ruleset_net(ENV_NET_QUIET_NAME, ...).

Changes in v6:
- Make populate_ruleset_{fs,net} take a flags argument instead of a bool
  quiet (suggested by Justin Suess)
- Fix if braces style

Changes in v3:
- Minor change to the above commit message.

Changes in v2:
- Added new environment variables to control which quiet access bits to
  set on the rule, and populate quiet_access_* from it.
- Added support for quieting net rules and scoped access.  Renamed patch
  title.
- Increment ABI version

 samples/landlock/sandboxer.c | 134 ++++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 11 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 94e399e6b146..74ee53afed6a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,9 +58,14 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_FS_QUIET_NAME "LL_FS_QUIET"
+#define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_NET_QUIET_NAME "LL_NET_QUIET"
+#define ENV_NET_QUIET_ACCESS_NAME "LL_NET_QUIET_ACCESS"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_SCOPED_QUIET_ACCESS_NAME "LL_SCOPED_QUIET_ACCESS"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_UDP_BIND_NAME "LL_UDP_BIND"
 #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
@@ -119,7 +124,7 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access)
+			       const __u64 allowed_access, __u32 flags)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -169,7 +174,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath, 0)) {
+				      &path_beneath, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -187,7 +192,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 }
 
 static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
-				const __u64 allowed_access)
+				const __u64 allowed_access, __u32 flags)
 {
 	int ret = 1;
 	char *env_port_name, *env_port_name_next, *strport;
@@ -215,7 +220,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		}
 		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-				      &net_port, 0)) {
+				      &net_port, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with port \"%llu\": %s\n",
 				net_port.port, strerror(errno));
@@ -303,6 +308,58 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
+static int add_quiet_access(__u64 *const quiet_access,
+			    const __u64 handled_access,
+			    const char *const env_var, const bool default_all)
+{
+	char *env_quiet_access, *env_quiet_access_next, *str_access;
+
+	if (default_all)
+		*quiet_access = handled_access;
+	else
+		*quiet_access = 0;
+
+	env_quiet_access = getenv(env_var);
+	if (!env_quiet_access)
+		return 0;
+
+	env_quiet_access = strdup(env_quiet_access);
+	env_quiet_access_next = env_quiet_access;
+	unsetenv(env_var);
+	*quiet_access = 0;
+
+	while ((str_access = strsep(&env_quiet_access_next, ENV_DELIMITER))) {
+		if (strcmp(str_access, "") == 0)
+			continue;
+		else if (strcmp(str_access, "r") == 0)
+			*quiet_access |= ACCESS_FS_ROUGHLY_READ;
+		else if (strcmp(str_access, "w") == 0)
+			*quiet_access |= ACCESS_FS_ROUGHLY_WRITE;
+		else if (strcmp(str_access, "b") == 0)
+			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_TCP;
+		else if (strcmp(str_access, "c") == 0)
+			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_TCP;
+		else if (strcmp(str_access, "ub") == 0)
+			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_UDP;
+		else if (strcmp(str_access, "uc") == 0)
+			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+		else if (strcmp(str_access, "a") == 0)
+			*quiet_access |= LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+		else if (strcmp(str_access, "s") == 0)
+			*quiet_access |= LANDLOCK_SCOPE_SIGNAL;
+		else {
+			fprintf(stderr, "Unknown quiet access \"%s\"\n",
+				str_access);
+			free(env_quiet_access);
+			return -1;
+		}
+	}
+
+	free(env_quiet_access);
+	*quiet_access &= handled_access;
+	return 0;
+}
+
 #define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
@@ -336,6 +393,22 @@ static const char help[] =
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
+	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_FS_QUIET_ACCESS_NAME " and " ENV_NET_QUIET_ACCESS_NAME " can be used to specify "
+	"which accesses should be quieted (defaults to all):\n"
+	"* " ENV_FS_QUIET_ACCESS_NAME ": file system accesses to quiet\n"
+	"  - \"r\" to quiet all file/dir read accesses\n"
+	"  - \"w\" to quiet all file/dir write accesses\n"
+	"* " ENV_NET_QUIET_ACCESS_NAME ": network accesses to quiet\n"
+	"  - \"b\" to quiet tcp bind denials\n"
+	"  - \"c\" to quiet tcp connect denials\n"
+	"  - \"ub\" to quiet udp bind denials\n"
+	"  - \"uc\" to quiet udp connect / send denials\n"
+	"In addition, " ENV_SCOPED_QUIET_ACCESS_NAME " can be set to quiet all denials for "
+	"scoped actions (defaults to none).\n"
+	"  - \"a\" to quiet abstract unix socket denials\n"
+	"  - \"s\" to quiet signal denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -368,7 +441,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
+		.quiet_access_fs = 0,
+		.quiet_access_net = 0,
+		.quiet_scoped = 0,
 	};
+
+	bool quiet_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -459,6 +537,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~(LANDLOCK_ACCESS_NET_BIND_UDP |
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+		__attribute__((fallthrough));
+		/* Don't add quiet flags for ABI < 10 later on. */
+		quiet_supported = false;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -525,6 +606,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		unsetenv(ENV_FORCE_LOG_NAME);
 	}
 
+	/*
+	 * Add quiet for fs/net handled access bits.  Doing this alone has no
+	 * effect unless we later add quiet rules per FS_QUIET/NET_QUIET.
+	 */
+	if (quiet_supported) {
+		if (add_quiet_access(&ruleset_attr.quiet_access_fs,
+				     ruleset_attr.handled_access_fs,
+				     ENV_FS_QUIET_ACCESS_NAME, true))
+			return 1;
+		if (add_quiet_access(&ruleset_attr.quiet_access_net,
+				     ruleset_attr.handled_access_net,
+				     ENV_NET_QUIET_ACCESS_NAME, true))
+			return 1;
+		if (add_quiet_access(&ruleset_attr.quiet_scoped,
+				     ruleset_attr.scoped,
+				     ENV_SCOPED_QUIET_ACCESS_NAME, false))
+			return 1;
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
@@ -532,30 +632,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
+	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro, 0))
 		goto err_close_ruleset;
-	}
-	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
+	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw, 0))
 		goto err_close_ruleset;
+
+	/* Don't require this env to be present. */
+	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
+					LANDLOCK_ADD_RULE_QUIET))
+			goto err_close_ruleset;
 	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
+				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
+				 LANDLOCK_ACCESS_NET_BIND_UDP, 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)) {
+				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, 0)) {
 		goto err_close_ruleset;
 	}
 
+	if (quiet_supported) {
+		if (populate_ruleset_net(ENV_NET_QUIET_NAME, ruleset_fd, 0,
+					 LANDLOCK_ADD_RULE_QUIET)) {
+			goto err_close_ruleset;
+		}
+	}
+
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
-- 
2.54.0
