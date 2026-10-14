Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878F28CF5D
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967217; cv=none; b=WAuUvNrMFXW3BDIF8dSwhtVXIAorIuXQsyVvAdj8jSaESGeS+Dt742WttFKAJr5tSjiACU5u4REE2A2ju2Sc/8HZHen3UqOZrsPiO0eRqh6o/uEovlqeDOmm1MwElKI3UlJqu/MmgVdCBW6ayARH3Hv4LuO6o6o+5wEW64DF/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967217; c=relaxed/simple;
	bh=wzxEjY0NdftPD9iGIK7tzLzvQuWvRoKa8Opr2+p5mjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3X3TUEoDaJb3eqyxsygGBLOyD96Hm/xmg4YtqHoKhX/PE99VVpTVxqHsmZvtFpGdVMVka62V3etoaGGNN5CmlT5ZDFKMfLQZjR9x6S6g72hFy+Cb+ibi+H1feDJwaCQ3Q8pU5PrlNe0p/6MO/g9g5IRv8m8CYSlWN7SRuepB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Fk2BN58O; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Fk2BN58O"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4PTS2Jm4z1Cm;
	Wed, 14 Oct 2026 10:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791966460;
	bh=tWXHRlKt3UkzRWs0KbJKT9ExDlTQbUCfbje8CQqS6vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fk2BN58OPkesXbnjMPa1+T5tpCX5REmgKlR9b48ChJDf7k1zM+25dt3KyJ+3kra+k
	 5qDevUfm1NGPttcRpF28+otmV/wf6P1tBs3PhyxNRY148cQ0hihBIWv0+yj337GjPi
	 s3YK3pJSLRFM4xVCj3RyMyWM6AIgijDeIDK3tcVY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j4PTR0bHHzhP;
	Wed, 14 Oct 2026 10:27:39 +0200 (CEST)
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
Subject: [PATCH v6 7/8] samples/landlock: Add capability and namespace restriction support
Date: Wed, 14 Oct 2026 10:27:13 +0200
Message-ID: <20261014082718.1435842-8-mic@digikod.net>
In-Reply-To: <20261014082718.1435842-1-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
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
and namespace restriction features.  LL_CAP takes a colon-delimited list
of allowed capabilities.  Numeric values are always accepted; when
libcap development files are available, use cap_from_name(3) to accept
names too.  Builds without libcap warn when capability settings are
used.  This keeps the sample buildable without optional development
files.  LL_NS takes a colon-delimited list of allowed namespace types by
short name.  Add best-effort degradation for older kernels that predate
the LANDLOCK_PERMISSION_* features.

Allow creating user and UTS namespaces but deny network namespaces, as
an unprivileged user.  The first command succeeds and sets the hostname
inside the new UTS namespace; the second is denied because the network
namespace type is not allowed:

  LL_FS_RO=/ LL_FS_RW=/proc LL_NS="user:uts" \
    ./sandboxer /bin/sh -c \
    "unshare --user --uts --map-root-user hostname sandbox \
    && ! unshare --user --net true"

Allow only user namespace creation and CAP_SYS_CHROOT, denying all other
capabilities and namespace types.  An unprivileged process creates a
user namespace, which requires no capability, and calls chroot inside it
using the CAP_SYS_CHROOT granted within that namespace:

  LL_FS_RO=/ LL_FS_RW="" LL_NS="user" LL_CAP="cap_sys_chroot" \
    ./sandboxer /bin/sh -c \
    "unshare --user --keep-caps chroot / true"

Allow user namespace creation but deny network namespaces, and quiet the
network-namespace denials with LL_NS_QUIET so the denied creation is not
audit logged.  The negated second command makes the whole line succeed:

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

Changes since v4:
https://patch.msgid.link/20261002124409.1277970-8-mic@digikod.net
- Keep SAMPLE_LANDLOCK buildable without libcap by accepting numeric
  capabilities, and enable names when the development files are
  available.  Warn when capability settings are used without libcap and
  document the optional dependency in a dedicated Kconfig help paragraph
  (reported by Sashiko).
- Put the conditional libcap header after the generic includes and limit
  the Kconfig probe to header and library availability.
- Source namespace flag values from the kernel UAPI instead of libc,
  whose older headers omit CLONE_NEWTIME (reported by Sashiko).

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-12-mic@digikod.net
- Bump the sample's latest supported ABI to 12.
- Gate namespace and capability permissions and rule calls on ABI 12.
  Consume unsupported settings before executing the sandboxed command.
- Reject capability numbers that cannot fit in the UAPI's 64-bit mask.
- Expand the Kconfig help from filesystem-only wording to the complete
  sandboxer policy and state the libcap development-file dependency.
- Clarify that quiet capability and namespace members suppress audit
  logging, and that quieting alone still restricts the permission.

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
 samples/Kconfig              |  13 +-
 samples/landlock/Makefile    |   5 +
 samples/landlock/sandboxer.c | 269 ++++++++++++++++++++++++++++++++++-
 3 files changed, 282 insertions(+), 5 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..00eed83c07df 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -166,8 +166,17 @@ config SAMPLE_LANDLOCK
 	bool "Landlock example"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
-	  Build a simple Landlock sandbox manager able to start a process
-	  restricted by a user-defined filesystem access control policy.
+	  Build a Landlock sandbox manager able to start a process restricted
+	  by user-defined filesystem, network, scope, namespace, and capability
+	  policies.
+
+	  The optional libcap development headers and library enable capability
+	  names.  Without them, the sample still builds, accepts capability
+	  numbers, and warns when capability settings are used.
+
+config SAMPLE_LANDLOCK_LIBCAP
+	def_bool $(cc_can_link_user,-include sys/capability.h -lcap)
+	depends on SAMPLE_LANDLOCK
 
 config SAMPLE_PIDFD
 	bool "pidfd sample"
diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
index 5d601e51c2eb..db5d327e12e4 100644
--- a/samples/landlock/Makefile
+++ b/samples/landlock/Makefile
@@ -4,6 +4,11 @@ userprogs-always-y := sandboxer
 
 userccflags += -I usr/include
 
+ifeq ($(CONFIG_SAMPLE_LANDLOCK_LIBCAP),y)
+userccflags += -DUSE_LIBCAP
+userldlibs += -lcap
+endif
+
 .PHONY: all clean
 
 all:
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 030583273f3f..1362f08ff14b 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -12,8 +12,11 @@
 #include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <linux/landlock.h>
+#include <linux/sched.h>
 #include <linux/socket.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -22,7 +25,10 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <stdbool.h>
+
+#ifdef USE_LIBCAP
+#include <sys/capability.h>
+#endif
 
 #if defined(__GLIBC__)
 #include <linux/prctl.h>
@@ -62,6 +68,10 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_NET_QUIET_NAME "LL_NET_QUIET"
+#define ENV_NS_NAME "LL_NS"
+#define ENV_NS_QUIET_NAME "LL_NS_QUIET"
+#define ENV_CAP_NAME "LL_CAP"
+#define ENV_CAP_QUIET_NAME "LL_CAP_QUIET"
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_QUIET_ACCESS_NAME "LL_QUIET_ACCESS"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
@@ -69,6 +79,18 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
 #define ENV_DELIMITER ":"
 
+#ifdef USE_LIBCAP
+#define CAP_VALUE_DESCRIPTION "names or numbers"
+#define CAP_VALUE_EXAMPLES "cap_net_bind_service, cap_sys_admin, 18"
+#define CAP_VALUE_EXAMPLE "cap_sys_admin"
+#else
+#define CAP_VALUE_DESCRIPTION "numbers"
+#define CAP_VALUE_EXAMPLES "10, 18, 21"
+#define CAP_VALUE_EXAMPLE "21"
+#endif
+
+#define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
+
 static int str2num(const char *numstr, __u64 *num_dst)
 {
 	char *endptr = NULL;
@@ -232,6 +254,185 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
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
+	for (i = 0; i < ARRAY_SIZE(ns_map); i++) {
+		if (strcmp(name, ns_map[i].name) == 0)
+			return ns_map[i].value;
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
+		.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE,
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
+static int str2cap(const char *const strcap, __u64 *const cap)
+{
+#ifdef USE_LIBCAP
+	cap_value_t value;
+#endif
+
+	if (!str2num(strcap, cap))
+		return 0;
+
+#ifdef USE_LIBCAP
+	if (cap_from_name(strcap, &value))
+		return 1;
+	*cap = value;
+	return 0;
+#else
+	return 1;
+#endif
+}
+
+/*
+ * Parses a colon-delimited list of capability values into a bitmask.  Returns 0
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
+		__u64 cap;
+
+		if (strcmp(strcap, "") == 0)
+			continue;
+
+		if (str2cap(strcap, &cap)) {
+			fprintf(stderr, "Failed to parse capability \"%s\"\n",
+				strcap);
+			goto out_free_name;
+		}
+		if (cap >= sizeof(*mask) * CHAR_BIT) {
+			fprintf(stderr, "Capability \"%s\" is out of range\n",
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
+		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
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
 /* Returns true on error, false otherwise. */
 static bool check_ruleset_scope(const char *const env_var,
 				struct landlock_ruleset_attr *ruleset_attr)
@@ -369,7 +570,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 11
+#define LANDLOCK_ABI_LAST 12
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -397,6 +598,23 @@ static const char help[] =
 	"* " ENV_UDP_CONNECT_SEND_NAME ": remote UDP ports allowed to connect "
 	"or send to (client: use as destination port / server: receive only from it)\n"
 	"(caution: sending requires being able to bind to a local source port)\n"
+	"* " ENV_NS_NAME ": namespace types allowed to use\n"
+	"  (cgroup, ipc, mnt, net, pid, time, user, uts)\n"
+	"* " ENV_NS_QUIET_NAME
+	": namespace types whose denial should not be audit logged\n"
+	"  (same value format as " ENV_NS_NAME
+	"; quieting an allowed member is inert,\n"
+	"  as an allowed member is never denied; setting it alone still\n"
+	"  restricts namespace use, denying every type)\n"
+	"* " ENV_CAP_NAME ": capabilities allowed to use, as "
+	CAP_VALUE_DESCRIPTION "\n"
+	"  (e.g. " CAP_VALUE_EXAMPLES ")\n"
+	"* " ENV_CAP_QUIET_NAME
+	": capabilities whose denial should not be audit logged\n"
+	"  (same value format as " ENV_CAP_NAME
+	"; quieting an allowed member is inert,\n"
+	"  as an allowed member is never denied; setting it alone still\n"
+	"  restricts capability use, denying every capability)\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -423,6 +641,8 @@ static const char help[] =
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
 	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
+	ENV_NS_NAME "=\"user:uts:net\" "
+	ENV_CAP_NAME "=\"" CAP_VALUE_EXAMPLE "\" "
 	ENV_SCOPED_NAME "=\"a:s\" "
 	"%1$s bash -i\n"
 	"\n"
@@ -451,6 +671,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.quiet_access_fs = 0,
 		.quiet_access_net = 0,
 		.quiet_scoped = 0,
+		.handled_permissions = LANDLOCK_PERMISSION_NAMESPACE_USE |
+				       LANDLOCK_PERMISSION_CAPABILITY_USE,
 	};
 	bool quiet_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
@@ -552,7 +774,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		supported_restrict_flags &=
 			~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 		set_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
-
+		__attribute__((fallthrough));
+	case 11:
+		/* Removes LANDLOCK_PERMISSION_* for ABI < 12 */
+		ruleset_attr.handled_permissions &=
+			~(LANDLOCK_PERMISSION_NAMESPACE_USE |
+			  LANDLOCK_PERMISSION_CAPABILITY_USE);
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
@@ -597,6 +824,32 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	}
 
+	/* Removes namespace handling if not set by a user. */
+	if (!getenv(ENV_NS_NAME) && !getenv(ENV_NS_QUIET_NAME))
+		ruleset_attr.handled_permissions &=
+			~LANDLOCK_PERMISSION_NAMESPACE_USE;
+	if (!(ruleset_attr.handled_permissions &
+	      LANDLOCK_PERMISSION_NAMESPACE_USE)) {
+		unsetenv(ENV_NS_NAME);
+		unsetenv(ENV_NS_QUIET_NAME);
+	}
+
+#ifndef USE_LIBCAP
+	if (getenv(ENV_CAP_NAME) || getenv(ENV_CAP_QUIET_NAME))
+		fprintf(stderr,
+			"Warning: Built without libcap; use capability numbers, not names.\n");
+#endif
+
+	/* Removes capability handling if not set by a user. */
+	if (!getenv(ENV_CAP_NAME) && !getenv(ENV_CAP_QUIET_NAME))
+		ruleset_attr.handled_permissions &=
+			~LANDLOCK_PERMISSION_CAPABILITY_USE;
+	if (!(ruleset_attr.handled_permissions &
+	      LANDLOCK_PERMISSION_CAPABILITY_USE)) {
+		unsetenv(ENV_CAP_NAME);
+		unsetenv(ENV_CAP_QUIET_NAME);
+	}
+
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
@@ -680,6 +933,16 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 	}
 
+	if ((ruleset_attr.handled_permissions &
+	     LANDLOCK_PERMISSION_NAMESPACE_USE) &&
+	    populate_ruleset_ns(ENV_NS_NAME, ENV_NS_QUIET_NAME, ruleset_fd))
+		goto err_close_ruleset;
+
+	if ((ruleset_attr.handled_permissions &
+	     LANDLOCK_PERMISSION_CAPABILITY_USE) &&
+	    populate_ruleset_cap(ENV_CAP_NAME, ENV_CAP_QUIET_NAME, ruleset_fd))
+		goto err_close_ruleset;
+
 	if (!(set_restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
 	    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
-- 
2.55.0

