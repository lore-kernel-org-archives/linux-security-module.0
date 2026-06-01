Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886C29CE1
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272065; cv=none; b=XnPRRDKRdy8ZyJ2IPMSlcqsiOR3gn117u447eOjPV6zT/Rp7c1V6OFsmDrm9vb10QPcIrDNuW+5Ps2U9iKy3VueAV2ZCkP+yoTqWq4SkMtK3Kdn0H6jUzlAaqn4MW7p6xjxcj4rjokl9FE0m0ihD++/2Z8iDWe8SrOJLmWaW3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272065; c=relaxed/simple;
	bh=WltQVoKcP9w3hMd7RO1Jj33u0Y+fBtSDULbVla6nz2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrcRXxpl2BwAZG92+jipq5ZGtgkpLT7Li7mbGO5bzz29Ym79f3G+li/bUm0B0L/ncs3ojodK8rkvQB/wsQUsql1pkWCqbKDkqKyGoUHt7xp4OIjeueiuEEpxkuylKIm+kHBqAPLQ6yL2MJQmJRtAvG52BbP7rGLfoAe2whAcb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=0ZS6hjsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9V72yj9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="0ZS6hjsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9V72yj9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0F2C7A0081;
	Sun, 31 May 2026 20:01:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 31 May 2026 20:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272062; x=
	1780358462; bh=MfvHGaZhILL10HQY6ZlnCYENd+fnNnmfgaiCUiz9eQA=; b=0
	ZS6hjslBbAC6GIiV29C78xQqQoAtMW7I84Lky5ir3ckJvzs6zSo7W0ANcWuOuVMe
	pE7hBmGQUafxMFmYIXpefVH7ZPVtwI5kSAAvmLOCmYP7VeY9nQqaMc+NO7GMQlqG
	vRX1SWBQMFf2fgThZNF6om0691dn7Zv2PY086T5f42Y9fY1fmHbqAZgqvtkMaXaF
	TaPiMZztIKrIcOUJT5ICdTtiKX/PbTRWInhGgvxaLfRZrufxRnOuByFOxBl9pcWx
	AIgxTBV3UOSYI46RQLIDgNiU/zZhO+Uvn9jQW0MuAFZL87TZBhenNHHjufb8pryo
	k4cY9Pv0WPoonQpDDAdwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272062; x=1780358462; bh=M
	fvHGaZhILL10HQY6ZlnCYENd+fnNnmfgaiCUiz9eQA=; b=Y9V72yj9LhKzspiab
	97ceIZM8ocfDsxSK5uOXHNDYS9taU2Yx1XBWZjx53komvnRnhVNqzyndlEgcbwu/
	e45Y+pKlFELG0717+be3RAufdpGr5c2hI75WOGoLNShz64ZdxdNb1cHAkU3WAfZp
	/M+oxfP4KYp0e8EoXlMb9FuA2Plp5nog8RdM2uawXAVTrAlyRNXHUkdkOer/izWn
	3DQwtfvPWTe6W/JFOJwYkK4Qx5uQ/f19CSpk7NYMGv5A8ZWET5nkqqw53Ut+XiDp
	LXG1P3sg0+1LJ6u77No4dO0rZ7T39UytdcNlznPvAyAIXT+ORc4ajTnAI5w98vYq
	aO4NQ==
X-ME-Sender: <xms:vsscavgtkQ4wM2TzGa387x2pBO968-7uuVlDqRm54feVm3myjDqIKQ>
    <xme:vsscauRmixI5cj_IuY2dq6f6VQ2GL72lSCTTzb46cxf3K2EB7AbBxeXSnTWnmXWVJ
    C1WByS5MfpbI76bn6nNX76bpprkD82LsMgmXhEr1z0OISeOBrnA72Y>
X-ME-Received: <xmr:vsscahWDP6FdSpmR-3d0GUlgDZRz1ajdsZEwESHzYfpL8hWBBu3X_Y_FCYuYF00SXIE>
X-ME-Proxy-Cause: dmFkZTFaMgvtkU5cUMPK0yU98oDvWOzpAYeMhN6aMUXtU4L7MwcKncPHJaPl4+cGgu1JI0
    EJ65/ML7NvOlSUVJa8l5uXMdv/mUnguQOCcC2icc1ZXjjLsNzMkUCKyQlbEBicETnqmtP8
    V4/nafj+1tyqc2otrRysHo6IhIGGM5np390qdDh9LEaeKa/4Qws/BPAZKjy+dDxKryc9qg
    Q8A0sIEGZz09juiWINU35VdyeilGbBB5ZoHpZXLIhRHy2THMHvko/tD37PFkmt4QtvfETI
    tQU1e/n24xflYW4xXjnlT4AP+bCyLpkxJbnO5GERtfQL3ejxX6XVGxqiE+iMrJ8Aq/pSRe
    wDUM/LUmNx55zyXT526GGejsgZGLJhIsJW47iUZCBF7MQWzIjKp/Aw6fAjdXq9GO/b3zGJ
    yi8JUi9Oo1p3M1NUrwVqn19rZwK/tegE2Wg8hsa986BvxgGuatGelTtx+RoUqZSzAJkzvE
    c+n32j6eAJqttZcHcChsyh2T6zD2o1eVgU0n630oF7xlSiASfskFpKNM+6ESmb1NuZBHoM
    rgRbK+AtRIRzbsuQyGwn7pm3cygKz7yRCvWluo3HM+6qiicXkOyRk4c1fTqMf2zQLnmc8t
    dpyKxLXMLJY3qaL5AjCDhsSTKnryWqInuI9wBRB8d/GbFKixdBp2LbajZagw
X-ME-Proxy: <xmx:vsscaiQc21Nr0chsRAC1Ore6eNYfrJPg2tPomHCtNd4dY5x5WpIpPg>
    <xmx:vsscarkneAASsJ-H25uhPW91v0JXMweZaAfg4u5OF4O-NEopQQAXPg>
    <xmx:vsscao5_soVtToM6E9A0Q1gGC2qgokUCW6rid9Nxk-UKoFB8I1sHbw>
    <xmx:vsscahg_XHq0HNz-GOAl2G95vD2EqcvEfjQE2V4LYkfZO10P_5xmqg>
    <xmx:vsscam__Yxg2bHfNgepUkXZtztbaATnUXo3Lm6O9wFP_YZ0uIfFKrk2H>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:01:01 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 4/9] samples/landlock: Add quiet flag support to sandboxer
Date: Mon,  1 Jun 2026 01:00:38 +0100
Message-ID: <9a90a123beb481c5be345e0d169eb14295803678.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
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

 samples/landlock/sandboxer.c | 133 ++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 11 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 94e399e6b146..73a81ecd3696 100644
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
 
@@ -459,6 +537,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~(LANDLOCK_ACCESS_NET_BIND_UDP |
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+		/* Don't add quiet flags for ABI < 10 later on. */
+		quiet_supported = false;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -525,6 +605,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -532,30 +631,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
