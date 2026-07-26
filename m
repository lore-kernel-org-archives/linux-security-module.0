Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44EE3CA49D
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082499; cv=none; b=ZqkxwjcOOOUjAh5exOVM4ASa12uzjUusitlYoPYaZUKAfzyaAPrjZIoXBqUBLosoc1clNa8VfEc0NIkOZ6RZQCqK7ChraQ1k9JjUEyJl8/q1TxNARqGmXsVwNYOpYVJnk0ZRHsSH7tfHvFajcrq3J9qE5+xfk3p2WVJZ3L4+AY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082499; c=relaxed/simple;
	bh=I+7B4yWEAsH/wvXP1t3+HfXX46rNzk0KDim6+yz+L4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9xdDwbj+fw3UlgvdNM4pKIkMAWp4Fa3s4P3copeYHXaoNqxjEBBYKFLWvyNrOK+/ubdi4B6t8iPZ+OkbGqBaMwKfQJDYNlNed8n+8X3zh67YN0rfOIy3bEHoFpUyJ9H6eMyeIQPQ/NqtUjt2cRkbxcdm3sdf3Ei5EooKNlQUko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=L2Cx7JKQ; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="L2Cx7JKQ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rd23hjYzhhM;
	Sun, 26 Jul 2026 18:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082470;
	bh=+W12fPHzLb4Ds+TT5wLwe+CWPP/0jEFpAfEqkcbPLKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2Cx7JKQGWJOBTgRfQHnT5EONcI7pvKGYexkP0Oztb0PDylpQ4JsFEUD0f9WL6jX+
	 0/O8yTSWAJfDorFzGsP7Pehi712JjDPXTWjzppMuyJhy+OszvcS2sAOlwxmA5n97Ub
	 c9M0hNnKERwvlgZNjhx21H4B6k7B4Sy/y9sQBH9g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rd11txyzmT0;
	Sun, 26 Jul 2026 18:14:29 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 11/12] samples/landlock: Add capability and namespace restriction support
Date: Sun, 26 Jul 2026 18:13:56 +0200
Message-ID: <20260726161400.3010511-12-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend the sandboxer sample to demonstrate the new Landlock capability
and namespace restriction features.  The LL_CAP environment variable
takes a colon-delimited list of allowed capabilities, parsed with
cap_from_name(3) from libcap.  Names (e.g. "cap_sys_chroot",
"CAP_SYS_ADMIN") are accepted; numeric strings (e.g. "18") work too via
cap_from_name's internal numeric fallback.  The LL_NS variable takes a
colon-delimited list of allowed namespace types by short name (e.g.
"user:uts:net").  Add best-effort degradation for older kernels that
predate the LANDLOCK_PERM_* features.

Allow creating user and UTS namespaces but deny network namespaces
(works as an unprivileged user).  All capabilities are available (LL_CAP
is not set), but namespace creation is still restricted to the types
listed in LL_NS.  The first command succeeds because user and UTS types
are in the allowed set, and sets the hostname inside the new UTS
namespace.  The second command fails because the network namespace type
is not allowed by the LANDLOCK_PERM_NAMESPACE_USE rule:

  LL_FS_RO=/ LL_FS_RW=/proc LL_NS="user:uts" \
    ./sandboxer /bin/sh -c \
    "unshare --user --uts --map-root-user hostname sandbox \
    && ! unshare --user --net true"

Allow only user namespace creation and CAP_SYS_CHROOT, denying all other
capabilities and namespace types (works as an unprivileged user).  An
unprivileged process creates a user namespace (no capability required)
and calls chroot inside it using the CAP_SYS_CHROOT granted within the
new namespace:

  LL_FS_RO=/ LL_FS_RW="" LL_NS="user" LL_CAP="cap_sys_chroot" \
    ./sandboxer /bin/sh -c \
    "unshare --user --keep-caps chroot / true"

Allow user namespace creation but deny network namespaces, and quiet the
network-namespace denials with LL_NS_QUIET so the denied creation is not
logged (works as an unprivileged user).  Creating the user namespace
succeeds while creating the network namespace is denied, so the negated
second command makes the whole line succeed:

  LL_FS_RO=/ LL_FS_RW=/proc LL_NS="user" LL_NS_QUIET="net" \
    ./sandboxer /bin/sh -c \
    "unshare --user --map-root-user true && ! unshare --user --net true"

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260527181127.879771-9-mic@digikod.net
- Rebased for ABI 11: bump LANDLOCK_ABI_LAST to 11 and extend the ABI
  back-compat fall-through with a new case stripping the LANDLOCK_PERM_*
  handled bits for ABI < 11.
- Adopt the renamed capability and namespace rule attributes: the rule
  bodies use perm plus allowed_capabilities / allowed_namespace_types
  (matching the per-member quiet restructuring in the enforcement
  patches).
- Add LL_CAP_QUIET and LL_NS_QUIET to quiet capability and
  namespace-type denials (per-member, merged into the allowed rule).

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-11-mic@digikod.net
- Rename LANDLOCK_PERM_NAMESPACE_ENTER references to
  LANDLOCK_PERM_NAMESPACE_USE (companion change to the introducing
  commit).
- Replace handled_perm = 0 with a per-bit mask in the ABI compat
  fall-through, mirroring the doc example so future ABI extensions
  adding new LANDLOCK_PERM_* bits do not get stripped.
- Parse LL_CAP values with cap_from_name(3) from libcap so users
  can pass capability names (e.g. "cap_sys_chroot") in addition to
  numbers.  cap_from_name accepts both: the canonical name lookup
  is case-insensitive, and a numeric-string fallback maps "18" to
  CAP_SYS_CHROOT identically to the previous numeric-only path.
  Drop the BITS_PER_TYPE workaround and the manual numeric bound
  check (cap_from_name does the right thing in both cases).  Link
  the sandboxer against libcap by adding userldlibs += -lcap in
  samples/landlock/Makefile.  Update help text and example command
  to show capability names (suggested by Günther Noack).
- Rename the LL_CAPS env var to LL_CAP for consistency with the
  singular form of all other sandboxer env vars (LL_NS, LL_FS_RO,
  LL_FS_RW, LL_TCP_BIND, LL_TCP_CONNECT, LL_SCOPED, LL_FORCE_LOG).
  Internal symbols renamed accordingly: ENV_CAPS_NAME -> ENV_CAP_NAME,
  populate_ruleset_caps() -> populate_ruleset_cap().
- Tingmao Wang's v1 Reviewed-by is not carried forward to v2: the
  cap_from_name() / libcap migration is a material implementation
  change requested by Günther Noack that was not part of his
  review.  Cc'd instead.
---
 samples/landlock/Makefile    |   1 +
 samples/landlock/sandboxer.c | 200 ++++++++++++++++++++++++++++++++++-
 2 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
index 5d601e51c2eb..b30239c8a281 100644
--- a/samples/landlock/Makefile
+++ b/samples/landlock/Makefile
@@ -3,6 +3,7 @@
 userprogs-always-y := sandboxer
 
 userccflags += -I usr/include
+userldlibs += -lcap
 
 .PHONY: all clean
 
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ac71019e6212..b528ef41e2f5 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -14,15 +14,17 @@
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <linux/socket.h>
+#include <sched.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/capability.h>
 #include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <stdbool.h>
 
 #if defined(__GLIBC__)
 #include <linux/prctl.h>
@@ -62,6 +64,10 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_NET_QUIET_NAME "LL_NET_QUIET"
+#define ENV_CAP_NAME "LL_CAP"
+#define ENV_CAP_QUIET_NAME "LL_CAP_QUIET"
+#define ENV_NS_NAME "LL_NS"
+#define ENV_NS_QUIET_NAME "LL_NS_QUIET"
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_QUIET_ACCESS_NAME "LL_QUIET_ACCESS"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
@@ -232,6 +238,161 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	return ret;
 }
 
+static __u64 str2ns(const char *const name)
+{
+	static const struct {
+		const char *name;
+		__u64 value;
+	} ns_map[] = {
+		/* clang-format off */
+		{ "cgroup",	CLONE_NEWCGROUP },
+		{ "ipc",	CLONE_NEWIPC },
+		{ "mnt",	CLONE_NEWNS },
+		{ "net",	CLONE_NEWNET },
+		{ "pid",	CLONE_NEWPID },
+		{ "time",	CLONE_NEWTIME },
+		{ "user",	CLONE_NEWUSER },
+		{ "uts",	CLONE_NEWUTS },
+		/* clang-format on */
+	};
+	size_t i;
+
+	for (i = 0; i < sizeof(ns_map) / sizeof(ns_map[0]); i++) {
+		if (strcmp(name, ns_map[i].name) == 0)
+			return ns_map[i].value;
+	}
+	return 0;
+}
+
+/*
+ * Parses a colon-delimited list of capability names into a bitmask.  Returns 0
+ * on success (mask 0 when the variable is unset or empty), or 1 on a parse
+ * error.
+ */
+static int parse_cap_list(const char *const env_var, __u64 *const mask)
+{
+	int ret = 1;
+	char *env_cap_name, *env_cap_name_next, *strcap;
+
+	*mask = 0;
+	env_cap_name = getenv(env_var);
+	if (!env_cap_name)
+		return 0;
+	env_cap_name = strdup(env_cap_name);
+	unsetenv(env_var);
+
+	env_cap_name_next = env_cap_name;
+	while ((strcap = strsep(&env_cap_name_next, ENV_DELIMITER))) {
+		cap_value_t cap;
+
+		if (strcmp(strcap, "") == 0)
+			continue;
+
+		if (cap_from_name(strcap, &cap)) {
+			fprintf(stderr, "Failed to parse capability \"%s\"\n",
+				strcap);
+			goto out_free_name;
+		}
+		*mask |= 1ULL << cap;
+	}
+	ret = 0;
+
+out_free_name:
+	free(env_cap_name);
+	return ret;
+}
+
+static int populate_ruleset_cap(const char *const allowed_env,
+				const char *const quiet_env,
+				const int ruleset_fd)
+{
+	struct landlock_capability_attr cap_attr = {
+		.perm = LANDLOCK_PERM_CAPABILITY_USE,
+	};
+
+	if (parse_cap_list(allowed_env, &cap_attr.allowed_capabilities))
+		return 1;
+	if (parse_cap_list(quiet_env, &cap_attr.quiet_capabilities))
+		return 1;
+
+	if (!cap_attr.allowed_capabilities && !cap_attr.quiet_capabilities)
+		return 0;
+
+	if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY, &cap_attr,
+			      0)) {
+		fprintf(stderr,
+			"Failed to update the ruleset with capabilities: %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Parses a colon-delimited list of namespace type names into a bitmask.
+ * Returns 0 on success (mask 0 when the variable is unset or empty), or 1 on a
+ * parse error.
+ */
+static int parse_ns_list(const char *const env_var, __u64 *const mask)
+{
+	int ret = 1;
+	char *env_ns_name, *env_ns_name_next, *strns;
+
+	*mask = 0;
+	env_ns_name = getenv(env_var);
+	if (!env_ns_name)
+		return 0;
+	env_ns_name = strdup(env_ns_name);
+	unsetenv(env_var);
+
+	env_ns_name_next = env_ns_name;
+	while ((strns = strsep(&env_ns_name_next, ENV_DELIMITER))) {
+		__u64 ns_type;
+
+		if (strcmp(strns, "") == 0)
+			continue;
+
+		ns_type = str2ns(strns);
+		if (!ns_type) {
+			fprintf(stderr, "Unknown namespace type \"%s\"\n",
+				strns);
+			goto out_free_name;
+		}
+		*mask |= ns_type;
+	}
+	ret = 0;
+
+out_free_name:
+	free(env_ns_name);
+	return ret;
+}
+
+static int populate_ruleset_ns(const char *const allowed_env,
+			       const char *const quiet_env,
+			       const int ruleset_fd)
+{
+	struct landlock_namespace_attr ns_attr = {
+		.perm = LANDLOCK_PERM_NAMESPACE_USE,
+	};
+
+	if (parse_ns_list(allowed_env, &ns_attr.allowed_namespace_types))
+		return 1;
+	if (parse_ns_list(quiet_env, &ns_attr.quiet_namespace_types))
+		return 1;
+
+	if (!ns_attr.allowed_namespace_types && !ns_attr.quiet_namespace_types)
+		return 0;
+
+	if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE, &ns_attr,
+			      0)) {
+		fprintf(stderr,
+			"Failed to update the ruleset with namespace types: %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
 /* Returns true on error, false otherwise. */
 static bool check_ruleset_scope(const char *const env_var,
 				struct landlock_ruleset_attr *ruleset_attr)
@@ -369,7 +530,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 10
+#define LANDLOCK_ABI_LAST 11
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -397,6 +558,17 @@ static const char help[] =
 	"* " ENV_UDP_CONNECT_SEND_NAME ": remote UDP ports allowed to connect "
 	"or send to (client: use as destination port / server: receive only from it)\n"
 	"(caution: sending requires being able to bind to a local source port)\n"
+	"* " ENV_CAP_NAME ": capabilities allowed to use, as names "
+	"or numbers (e.g. cap_net_bind_service, cap_sys_admin, 18)\n"
+	"* " ENV_CAP_QUIET_NAME ": capabilities whose denial should not be logged, "
+	"same value format as " ENV_CAP_NAME " (quieting a member that is also "
+	"allowed is inert)\n"
+	"* " ENV_NS_NAME ": namespace types allowed to use "
+	"(cgroup, ipc, mnt, net, pid, time, user, uts)\n"
+	"* " ENV_NS_QUIET_NAME ": namespace types whose denial should not be "
+	"logged, same value format as " ENV_NS_NAME "\n"
+	"  (quieting a member that is also allowed is inert, as an allowed "
+	"member is never denied)\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -423,6 +595,8 @@ static const char help[] =
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
 	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
+	ENV_CAP_NAME "=\"cap_sys_admin\" "
+	ENV_NS_NAME "=\"user:uts:net\" "
 	ENV_SCOPED_NAME "=\"a:s\" "
 	"%1$s bash -i\n"
 	"\n"
@@ -451,6 +625,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.quiet_access_fs = 0,
 		.quiet_access_net = 0,
 		.quiet_scoped = 0,
+		.handled_perm = LANDLOCK_PERM_CAPABILITY_USE |
+				LANDLOCK_PERM_NAMESPACE_USE,
 	};
 	bool quiet_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
@@ -545,7 +721,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		/* Removes quiet flags for ABI < 10 later on. */
 		quiet_supported = false;
-
+		__attribute__((fallthrough));
+	case 10:
+		/* Removes LANDLOCK_PERM_* for ABI < 11 */
+		ruleset_attr.handled_perm &= ~(LANDLOCK_PERM_NAMESPACE_USE |
+					       LANDLOCK_PERM_CAPABILITY_USE);
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
@@ -590,6 +770,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	}
 
+	/* Removes capability handling if not set by a user. */
+	if (!getenv(ENV_CAP_NAME) && !getenv(ENV_CAP_QUIET_NAME))
+		ruleset_attr.handled_perm &= ~LANDLOCK_PERM_CAPABILITY_USE;
+
+	/* Removes namespace handling if not set by a user. */
+	if (!getenv(ENV_NS_NAME) && !getenv(ENV_NS_QUIET_NAME))
+		ruleset_attr.handled_perm &= ~LANDLOCK_PERM_NAMESPACE_USE;
+
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
@@ -673,6 +861,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 	}
 
+	if (populate_ruleset_cap(ENV_CAP_NAME, ENV_CAP_QUIET_NAME, ruleset_fd))
+		goto err_close_ruleset;
+
+	if (populate_ruleset_ns(ENV_NS_NAME, ENV_NS_QUIET_NAME, ruleset_fd))
+		goto err_close_ruleset;
+
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
-- 
2.54.0

