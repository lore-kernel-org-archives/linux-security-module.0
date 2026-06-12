Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04328E0
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228958; cv=none; b=j864XZDS5caZfIu2i23URAK+UTDFVbiH7/o2ADT3C0TLzzG0QP/QtDwUEEKQ1hau8Tf1vjSUJKsXNJiRh+hRFmQknA/hhYI5lffvBZSK05MkfEsA9SnB91tMWMmJji5iAtzwiWcaH8YoDUKrKFGAJwUGYFmQyuPRm0DOQ0uJ3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228958; c=relaxed/simple;
	bh=64bjon/EiE/GSW/lEOKPEG0rVTbvD3BIRtlHlFG93fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFOJI+mbIBSCNcVI4UAh084icSY8vSGg/wCK4VVpQFgCKrKoo0KrgnfZ6T5ns4wnUWLdOAnfN9VOOJuzPv/GO4W3GcaowM1uGE7xvA6HuTLBCVPo3PCqD/drw47JQEy4TvSolQ/yjsWO0QWwQ4o/1MWEtQOF/7vixX5jyVa+bXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=L+suxnvV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KjFP/EQe; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="L+suxnvV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjFP/EQe"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 547661D00130;
	Thu, 11 Jun 2026 21:49:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 11 Jun 2026 21:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781228956; x=
	1781315356; bh=5+fBskpVMNLsQg60PFGNLwiQhJ621OqbBihqwCQw9AY=; b=L
	+suxnvVZPtK2sg9OsoJcIw6DaZ7V1Z1G9vJi9kQSscMTSspUMh08trwwIo3VKfCp
	CHOr3kTWzaqwIH1Y470l2F7sPFQiKmdyiZM6fAX8eiZNKa9QkC07cJXGXDLCFoDA
	8WHS7R0VHb9Vt5UQ7HG3t3NZRoDaaF10huST+RyieSBUTRLtIYnVjZoYxH6sc2Tp
	qCr5aBshOrGQubInE2p4hjksD7gkK5kdqMIFXwFZUZTQPDW8h6h6mJ3B0i28iECD
	f9mjWCKcR18esd+gVLnAOPvlcirCfF6i6+F74FBPlrJloWI4IqoD3aIiIBb0UJ3M
	r6QK1D25o2M8low3nTBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781228956; x=1781315356; bh=5
	+fBskpVMNLsQg60PFGNLwiQhJ621OqbBihqwCQw9AY=; b=KjFP/EQeGwT5rOryh
	j2Qqo2lSAY1Mo+QeuJRRRmFMRMIbq1QtgwnV4e7eDJfA9GE0MR3hzLtWcYypZUs1
	RGjrOF7b3H6NKdwvZldehHzBB9RLvMytGZ9BRMM5ypq/MFvWuz0qNYvGStUTU4jL
	3CRSQF/zrl8ePzeiUjI6RotYZDr9BbAYZPC789jXiRvczW+ur4XqpWYLMeXKmZwf
	bZ0srIXCrKLFXEyPYrAXaDUiDH9U34ki38BXR90iFVOqclDpyna13sQuk9mWScIS
	Nazn9qeVEkg6JT2i4jn26CN6vgRUXgPvER8bNPUgfVbHHGy/ficUkuXmKXWgoK4X
	q+OJA==
X-ME-Sender: <xms:m2UratS-o5WTYrljGCEtsREcYGFd2y6nx9JLDTxCYGG4s7gUMDz4rA>
    <xme:m2UrapC8aJbNCnSo8qs2yX9KOHnP3dZVEjaWfFY13Z-u3EN2gc_4Y-Ergih9g_Fra
    8YfFKvHv_8L6GP65GvjXeGRcDIm30zY40wU9R0sxcIo7aUMI8-sFGc>
X-ME-Received: <xmr:m2UralGFBcS2RypHMBCW1TpkBiMB6Zcx_wEzZUuYxazMiKsjF1CJHSKki_mZVsYGFMaNCm6pOHuCYLMZnMRCU-9UqHzva7H_jO6ykwtLXqRLlAE5I7rWDXdRZXg>
X-ME-Proxy-Cause: dmFkZTErrYj+6BPPVz1/IV8jcji/YbJf7tNmbzKUklDVBw37Mo5r82nPd5buxFHV4OrxKd
    +00SDQV9sSVg4R4yvs2QLHos0drG5qYNr6GNhg9D8ngYxfJUcCtRRhPXhE6kz5yGXnYKMY
    oJHiB0gAaPzyeGZH5d5BTyheBut4xCTujqDHaTful/fQaUhKYSKVr/XYUjihn5pTjMkS8X
    sKVE+fTH1iGH2FWO/9EBeuJFKXH3xovFqufQzUi7llGvIp9TU54IXL348v2qQAgPhg5ZW1
    SUBEtCpHKVb2aYxBd3Ta7zLOiViueqFsE4VHkel083qbKxQFVcQ42U+V55ljlncHcKp7eG
    nvveNfYBLqk6fNoxtesXRDpatI4KMdCxuOW2c1pmo3pvq+lKT1iaXQC5qDI4fcIs8MD+Mh
    kIJYBgSSxeEhrhdut+LLOr69e1oOhE8MjyBCArAHwCQ6v/BghvzEgZCuOteuFZDlo7UY/4
    IYZPaXfRYLjZRj/BaX913lGoRj6s4n44JzxRNDorMLNxUy+k/WJ0yaayUYGJATTjzRQeOK
    GIhDQh4WfkgXpC6qXNIxAmknTXLeMbULolh9Hr7XO/pShzMAjMdN5Vq9vPTq3Kqa8kxYah
    hPv7RGH5tIqTqpOb24ENnTqGF9qwZxaWI3l7cg0Jq0gq7MOMAJbBH/mOF5cQ
X-ME-Proxy: <xmx:m2UrarD3ex-uHzAuXLH8s4-rKQUgSxyG8iDRVLitHjJaxtYmayd6oA>
    <xmx:m2UralVqRQZYB0w3nQpyZxscGN6GPR5vxVKTgo3FFFCLOzuHYDB9WQ>
    <xmx:m2UravoDwBdaZwqQkfftThfklRcq_6J8rm6cqFtMGTpY1Q5ybeHcFA>
    <xmx:m2UrahSppoqKjhZaVPBbVoBvL4E-4hHcNWoFnyJNoFdcCtAnSjuvaA>
    <xmx:nGUrarvJtreWhDo1onFeRFQRhm6ZiyyNoC4UrEtn4qC5oRtS58EhR0co>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:14 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 4/9] samples/landlock: Add quiet flag support to sandboxer
Date: Fri, 12 Jun 2026 02:48:50 +0100
Message-ID: <59b94997565032bc9870044f021214a2ed6df213.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
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

Assisted-by: GitHub-Copilot:claude-opus-4.8 copilot-reviepickw
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v11:
- Error if quiet flags not supported by current kernel but quiet envs provided
- Fix comment
- Refactor env vars in sandboxer: LL_{FS,NET,SCOPED}_QUIET_ACCESS are
  merged into one LL_QUIET_ACCESS, and used more sensible names.

Changes in v10:
- Remove stray __attribute__((fallthrough)); (Thanks Justin for
  spotting)

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

 samples/landlock/sandboxer.c | 138 ++++++++++++++++++++++++++++++++---
 1 file changed, 127 insertions(+), 11 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f44db2857bbf..f18228ccf66a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,9 +58,12 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_FS_QUIET_NAME "LL_FS_QUIET"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_NET_QUIET_NAME "LL_NET_QUIET"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_QUIET_ACCESS_NAME "LL_QUIET_ACCESS"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_UDP_BIND_NAME "LL_UDP_BIND"
 #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
@@ -119,7 +122,7 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access)
+			       const __u64 allowed_access, __u32 flags)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -169,7 +172,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath, 0)) {
+				      &path_beneath, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -187,7 +190,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 }
 
 static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
-				const __u64 allowed_access)
+				const __u64 allowed_access, __u32 flags)
 {
 	int ret = 1;
 	char *env_port_name, *env_port_name_next, *strport;
@@ -215,7 +218,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		}
 		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-				      &net_port, 0)) {
+				      &net_port, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with port \"%llu\": %s\n",
 				net_port.port, strerror(errno));
@@ -303,6 +306,69 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
+/*
+ * Parses ENV_QUIET_ACCESS_NAME and sets the quiet_access_fs,
+ * quiet_access_net and quiet_scoped masks of @ruleset_attr accordingly.
+ */
+static int add_quiet_access(const char *const env_var,
+			    struct landlock_ruleset_attr *const ruleset_attr)
+{
+	char *env_quiet_access, *env_quiet_access_next, *str_access;
+
+	env_quiet_access = getenv(env_var);
+	if (!env_quiet_access)
+		return 0;
+
+	env_quiet_access = strdup(env_quiet_access);
+	env_quiet_access_next = env_quiet_access;
+	unsetenv(env_var);
+
+	while ((str_access = strsep(&env_quiet_access_next, ENV_DELIMITER))) {
+		if (strcmp(str_access, "") == 0)
+			continue;
+		else if (strcmp(str_access, "all") == 0) {
+			ruleset_attr->quiet_access_fs =
+				ruleset_attr->handled_access_fs;
+			ruleset_attr->quiet_access_net =
+				ruleset_attr->handled_access_net;
+			ruleset_attr->quiet_scoped = ruleset_attr->scoped;
+		} else if (strcmp(str_access, "read") == 0)
+			ruleset_attr->quiet_access_fs |= ACCESS_FS_ROUGHLY_READ;
+		else if (strcmp(str_access, "write") == 0)
+			ruleset_attr->quiet_access_fs |=
+				ACCESS_FS_ROUGHLY_WRITE;
+		else if (strcmp(str_access, "tcp_bind") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_BIND_TCP;
+		else if (strcmp(str_access, "tcp_connect") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_CONNECT_TCP;
+		else if (strcmp(str_access, "udp_bind") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_BIND_UDP;
+		else if (strcmp(str_access, "udp_connect") == 0)
+			ruleset_attr->quiet_access_net |=
+				LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+		else if (strcmp(str_access, "abstract_unix_socket") == 0)
+			ruleset_attr->quiet_scoped |=
+				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+		else if (strcmp(str_access, "signal") == 0)
+			ruleset_attr->quiet_scoped |= LANDLOCK_SCOPE_SIGNAL;
+		else {
+			fprintf(stderr, "Unknown quiet access \"%s\"\n",
+				str_access);
+			free(env_quiet_access);
+			return -1;
+		}
+	}
+
+	free(env_quiet_access);
+	ruleset_attr->quiet_access_fs &= ruleset_attr->handled_access_fs;
+	ruleset_attr->quiet_access_net &= ruleset_attr->handled_access_net;
+	ruleset_attr->quiet_scoped &= ruleset_attr->scoped;
+	return 0;
+}
+
 #define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
@@ -337,6 +403,19 @@ static const char help[] =
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
+	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_QUIET_ACCESS_NAME " can be used to specify which accesses should be quieted "
+	"(required when " ENV_FS_QUIET_NAME " or " ENV_NET_QUIET_NAME " is set):\n"
+	"  - \"all\" to quiet all of the accesses below\n"
+	"  - \"read\" to quiet all file/dir read accesses\n"
+	"  - \"write\" to quiet all file/dir write accesses\n"
+	"  - \"tcp_bind\" to quiet tcp bind denials\n"
+	"  - \"tcp_connect\" to quiet tcp connect denials\n"
+	"  - \"udp_bind\" to quiet udp bind denials\n"
+	"  - \"udp_connect\" to quiet udp connect / send denials\n"
+	"  - \"abstract_unix_socket\" to quiet abstract unix socket denials\n"
+	"  - \"signal\" to quiet signal denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -369,7 +448,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
+		.quiet_access_fs = 0,
+		.quiet_access_net = 0,
+		.quiet_scoped = 0,
 	};
+	bool quiet_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -460,6 +543,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~(LANDLOCK_ACCESS_NET_BIND_UDP |
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+		/* Removes quiet flags for ABI < 10 later on. */
+		quiet_supported = false;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -526,6 +611,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		unsetenv(ENV_FORCE_LOG_NAME);
 	}
 
+	/* Set the quiet access masks. */
+	if (quiet_supported) {
+		if ((getenv(ENV_FS_QUIET_NAME) || getenv(ENV_NET_QUIET_NAME)) &&
+		    !getenv(ENV_QUIET_ACCESS_NAME)) {
+			fprintf(stderr,
+				"%s must be set (e.g. to \"all\") when %s or %s is used\n",
+				ENV_QUIET_ACCESS_NAME, ENV_FS_QUIET_NAME,
+				ENV_NET_QUIET_NAME);
+			return 1;
+		}
+		if (add_quiet_access(ENV_QUIET_ACCESS_NAME, &ruleset_attr))
+			return 1;
+	} else if (getenv(ENV_FS_QUIET_NAME) || getenv(ENV_NET_QUIET_NAME) ||
+		   getenv(ENV_QUIET_ACCESS_NAME)) {
+		fprintf(stderr,
+			"Quiet flags not supported by current kernel\n");
+		return 1;
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
@@ -533,30 +637,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
