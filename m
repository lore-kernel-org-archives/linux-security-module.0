Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51346BF
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931766; cv=none; b=tfc49atKC6sWez8TZHLO28hMN6FI3/LY912k85tF3QdXtYqsBYVqmwhzQ/j1DeXiEvsQI0gnKCMDw0oBYZUJu6ixhRL4Lfbb2FrHei270dto3JqTruI8SkRsKlsH9IoNpIAc8DeWlcj/NUYXuHCoZx2iPUWKF+n5PPL7JcBpnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931766; c=relaxed/simple;
	bh=WIVSOhGOOtpGgDSHk6RYjp5aIkP18mmEOdk6Dxo4pTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnuhUHT9HpN9RT4/SVMhkOnm4c+U20zr73yUahYe0uzeRs7F+zk2j3khofjTDf8zVec+2LWL7wp4A51L5SpvF7FwLylMmyzzNUjp8aNxilkevt4Wa3+ovl10okGLBVbL60jAhfbJC+JnQbiE6M1ADgoUBxpWq7cuRuRhHuPe4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KhcOnK2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfFZpWKJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KhcOnK2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfFZpWKJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A8891400134;
	Sun, 23 Nov 2025 16:02:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 16:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931763; x=
	1764018163; bh=4PxQ/P+wGcLp1AXonApdf1mg6r3B1jpZX4fXk1iPsh4=; b=K
	hcOnK2XWYQmkaKSV35OQ3lSKQPTzsYiZgMffZy9IJCaw/BGIcdHhLBS5QUw2wra5
	9sT/JxUQtCu3xGgJ4G47ns3VkrAbIKuoE/zvjXGg2X9H0rVLKf+KkevGGxsV5+5u
	QZOgrVuBKJaaC79jYOoI9DgfA7CZPpDGoebZREGh/eSXDxOfYnQ1vzJKHc/p4dLC
	hdsHUtbWtYsn10JOoWefSAk4kjuVwHpdCEy6mgi5Bc5QeoLIckHhdRolY/Qc6jMw
	slgaPll2x098SL3S0ETcb7ulFQJwc2oAK9tM2VHUV/oRLfF+ZqXt/IrshS1Y6xdw
	RRk1Nad0PRf0zW65PBlaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931763; x=1764018163; bh=4
	PxQ/P+wGcLp1AXonApdf1mg6r3B1jpZX4fXk1iPsh4=; b=QfFZpWKJlnXDIkJXM
	BA3/oZQiqZdkTPrE+iZPQpQYPGuvBa8l5lwM8HW2wOS+cAl8ntW0SplBRC/OuW6N
	zH5jnB/7X8X4zO66poeqiHcsXYA0Dcv4VN+7GItvfCViJXtNbjL8RgE9wqcL1WlG
	JF6neWB1kZWvTecHC2rgp7+nl+lcBZBxK4qlP6t9KBYdothGq358vqdso+rjcJU+
	v8t7SA9jizMqpxoiyyz2UC+8b+Vboq6l/oaXlF72/Gn1HN8Vcuy2Sfx2lkLqM5Dx
	EmgTlcXFOFFV5VImFXXwAZj2pbwDHUmqkoor7WXYwiWzUHhRWmewcI6Fz8NRXRsI
	Vv8pQ==
X-ME-Sender: <xms:c3YjaQlxfiA5yWrua0V1xR_l4mDYrHzcZH5hKk00X94j1vLGmME8gg>
    <xme:c3YjaSE7fnC5HOsI6lwwyYb5rlxltHRURrEw2FrkCvv6rWx3bl8KIaxGUIA_Ir5F1
    TTF6Frx3QcOOTeSJ--E2FVhQQUfRqJ0HIXwW6CIXx-_0g6x5fyt2VrT>
X-ME-Received: <xmr:c3YjaQ6vjlquyWeMys2GZ8a1erjTjguucnduucjo-rzV0wyjFcQHWGslGKMpeBo2V0a->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c3YjaSmLntNkNV3F9FuKPjWaKExVlVdrQ7wn5cHWRpyopUETubB2mA>
    <xmx:c3YjadrqCKt5ISbSu_mSsO_bPyGlg2fLQVnLlOWtcTR0D2jJ8naJnA>
    <xmx:c3YjaZs6EbWuvx497GcwiMqDrXmgtQVnjpEbF7msCa8iZQyTRozYrg>
    <xmx:c3YjaaGRu3fPCCVYYkU6iNhSkXEE6zdH9Q6xWp8ZFjWGOgIfIy0FFw>
    <xmx:c3YjaRWCa9TJx3zTXYJNuADB-LikDG95uRYzCJeNGg5f1qSdjaCTO48Q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:42 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 05/10] samples/landlock: Add quiet flag support to sandboxer
Date: Sun, 23 Nov 2025 20:57:41 +0000
Message-ID: <15e506d97093a06fc710d68df07c9543b8e8d636.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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

Changes in v3:
- Minor change to the above commit message.

Changes in v2:
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
2.52.0
