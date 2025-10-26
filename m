Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9D221F15
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511540; cv=none; b=Jwh68M4cZXQ6Clwy/E3+jjADX1Pqsu9VXwRrOjFUUMoS205kA1QKvmIdaI6K7wRziTQKQbPejaQHRpHBlgu90gPigKRLGTotZNk0wz+1juD9R8uR0lW0pv9/X/20oGnnzYqQX6oV2uA0m/8Eni1ofEvpc8ibEtNE1u8pU34eVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511540; c=relaxed/simple;
	bh=xcLIjSNUxWRbL0s1qDYH7tX73nt3D9hxlrq/YAmFDKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMOGK45ny9fPwoGwrncinWe9Q5RTRl1QB5bWBK0+brNAAiwA/aipUFUtDdC0oUmrfvKWxWRRi3/hvu6lqVq/oVAp1m+EPZ1hWx/mgh4IIf8hHqUD6ZgMTrXPtSX+EJQt8CX9PHdvmx62wuUXpNhwNPFxElFdqhbS4bMKVlK89j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AxCakoyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oinb64p/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AxCakoyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oinb64p/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 768471400242;
	Sun, 26 Oct 2025 16:45:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 26 Oct 2025 16:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761511537; x=
	1761597937; bh=XpoiK5avbN51fxFO7NFgVjz8Raza2Do+CJByjtBQD+E=; b=A
	xCakoyI1ukIsHzixAWw0jWtJIupTAfpLVxRv1Ay/UXyQ6BnZsnYCBGke1LeLPDLD
	eL5llxj+tVC9KDOaTvJuAhdENsfA/DAexxP8nM0QeOb/mGmvTGLJ2cymC9eVi2dz
	UI708nNQXYZbVbMsEFhbnMtOTEIlqp3Ue+Fcqq/2qpI4tJiFUtxz5dVqZo4sKMbJ
	RqZQJrrZsfJr85B1llfE1TgdI2A+FY/BXt/uBkGWna4BzAsEGmCDUp1/VP1zAsJz
	57rYXiTyFc+hIRNc501MknK28oi/6zfTQzhC7w2DZzISFGZQJ7yVwF598TudCvqm
	SbbW69P5vm94dCbkbKHsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761511537; x=1761597937; bh=X
	poiK5avbN51fxFO7NFgVjz8Raza2Do+CJByjtBQD+E=; b=oinb64p/df7S6+XQq
	Eg+miCZzov7NiphV5zZnjkQViGNtzoUyyolPPeEsWZMaPCWNaSxZCYIrtXV/f4yS
	SY/lIaUHN0IbgxOPJXdTIgivl6s/FZeaTnioLHO0vR6OAa4QVTEV8ZmQLK45iGUc
	9aj+04mZhEsSDQvla+7vt3o3dx7N/vPkvvgoE2PQnRwi7Lml9hGXwDAC+QQCOUFZ
	SeDHhvbS+rTMzzXikZVoLyY/UxoipqS781gj+kXEBYk8u8d7XQ/U+g2DpfaDCh03
	1mTuPeAEMqv0ab4SjobO0jBUuo68U+nU8Q4G0C7ndnz6Iqb3vU1zPp6QxRSERdHh
	lUtAg==
X-ME-Sender: <xms:cYj-aDvHA2_pyH8J3NlltTHfIDDmDwkcybIgYRpGnjcRA4HIri85JQ>
    <xme:cYj-aIIXcHVo2y68wBxPm-uud0iQrDzkk84hT3qpjkloS-80v4rBpHChnU1IXvpRp
    ZIqRmQ1u-i45Or7h8S-EMEYW_IAR9mJ3v6SdfKCLiScYjVb2Ki5luY>
X-ME-Received: <xmr:cYj-aAkpdGbkaX8GOG3oiJsUnhg2mTi2vouFUl6o4Zr8xgQh6nl9wlMVhneUvGSeKechzTyxuV1kmSgnuU5IWgphkNQXlKzyscl47J5QcQ0VRLuqcGwZLA4yVx1i0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cYj-aJL-jIJsBOUaANgsGBFvwfnhsD1Ze2s684wZmhnXaQTAPnrBUA>
    <xmx:cYj-aF5fzfNUFG0PdS4ywy7X31_V8-OCoGnk0eHCrsqBvUyG7Xipbw>
    <xmx:cYj-aN0t-E8Bk5DKlRfIRQ2PXiLnnnYTW-wAEImoNJhp739qQdfjxA>
    <xmx:cYj-aLeLpAEm3OmcOWBBdmjKhJyoqwMbrRl4UpTf_B6KAyqxw7LYIg>
    <xmx:cYj-aE3Q9lddjxOq_Cub_f_GQSRXP2l0DN2z7DJWAn2tvlYAumMLCYbA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:36 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 5/8] samples/landlock: Add quiet flag support to sandboxer
Date: Sun, 26 Oct 2025 20:44:20 +0000
Message-ID: <34414ea22720faab9cbf674f8e73ee1fe0562cfa.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
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

Changes since v2:
- Minor change to the above commit message.

Changes since v1:
- Added new environment variables to control which quiet access bits to
  set on the rule, and populate quiet_access_* from it.
- Added support for quieting net rules and scoped access.  Renamed patch
  title.
- Increment ABI version

 samples/landlock/sandboxer.c | 133 ++++++++++++++++++++++++++++++++---
 1 file changed, 124 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..2d8e3e94b77b 100644
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
 #define ENV_DELIMITER ":"
 
@@ -116,7 +121,7 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access)
+			       const __u64 allowed_access, bool quiet)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -166,7 +171,8 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath, 0)) {
+				      &path_beneath,
+				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -184,7 +190,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 }
 
 static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
-				const __u64 allowed_access)
+				const __u64 allowed_access, bool quiet)
 {
 	int ret = 1;
 	char *env_port_name, *env_port_name_next, *strport;
@@ -212,7 +218,8 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		}
 		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-				      &net_port, 0)) {
+				      &net_port,
+				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with port \"%llu\": %s\n",
 				net_port.port, strerror(errno));
@@ -299,7 +306,55 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
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
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -328,6 +383,20 @@ static const char help[] =
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
+	"  - \"b\" to quiet bind denials\n"
+	"  - \"c\" to quiet connect denials\n"
+	"In addition, " ENV_SCOPED_QUIET_ACCESS_NAME " can be set to quiet all denials for "
+	"scoped actions (defaults to none).\n"
+	"  - \"a\" to quiet abstract unix socket denials\n"
+	"  - \"s\" to quiet signal denials\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -357,7 +426,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
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
 
@@ -444,6 +518,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		/* Don't add quiet flags for ABI < 8 later on. */
+		quiet_supported = false;
+
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
@@ -490,6 +569,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -497,22 +595,39 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
+	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
+				false)) {
 		goto err_close_ruleset;
 	}
-	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
+	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
+				false)) {
 		goto err_close_ruleset;
 	}
+	/* Don't require this env to be present. */
+	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
+					true)) {
+			goto err_close_ruleset;
+		}
+	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
+				 LANDLOCK_ACCESS_NET_BIND_TCP, false)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP, false)) {
 		goto err_close_ruleset;
 	}
 
+	/* Don't require this env to be present. */
+	if (quiet_supported && getenv(ENV_NET_QUIET_NAME)) {
+		if (populate_ruleset_net(ENV_NET_QUIET_NAME, ruleset_fd, 0,
+					 true)) {
+			goto err_close_ruleset;
+		}
+	}
+
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
-- 
2.51.1
