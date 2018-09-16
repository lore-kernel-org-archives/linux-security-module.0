From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:57 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-17-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

To prepare for having a third type of LSM ("shared blob"), this implements
dynamic handling of LSM ordering. The visible change here is that the
"security=" boot commandline is now a comma-separated ordered list of
all LSMs, not just the single "exclusive" LSM. This means that the
"minor" LSMs can now be disabled at boot time by omitting them from the
commandline. Additionally LSM ordering becomes entirely mutable for LSMs
with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
first).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  13 +-
 security/security.c                           | 145 ++++++++++++++----
 2 files changed, 126 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..6d6bb9481193 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4027,11 +4027,14 @@
 			Note: increases power consumption, thus should only be
 			enabled if running jitter sensitive (HPC/RT) workloads.
 
-	security=	[SECURITY] Choose a security module to enable at boot.
-			If this boot parameter is not specified, only the first
-			security module asking for security registration will be
-			loaded. An invalid security module name will be treated
-			as if no module has been chosen.
+	security=	[SECURITY] An ordered comma-separated list of
+			security modules to attempt to enable at boot. If
+			this boot parameter is not specified, only the
+			security modules asking for initialization will be
+			enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
+			or invalid security modules will be ignored. The
+			capability module is always loaded first, without
+			regard to this parameter.
 
 	selinux=	[SELINUX] Disable or enable SELinux at boot time.
 			Format: { "0" | "1" }
diff --git a/security/security.c b/security/security.c
index 67532326a0ce..f09a4bb3cb86 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,17 +32,18 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
+static const char *bootparam_lsms;
 
+/* Ordered list of possible LSMs to initialize. */
+static struct lsm_info **possible_lsms __initdata;
 static struct lsm_info *exclusive __initdata;
 
 /* Mark an LSM's enabled flag, if it exists. */
@@ -52,6 +53,108 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 		*lsm->enabled = enabled;
 }
 
+/* Is an LSM already listed in the possible LSMs list? */
+static bool __init possible_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = possible_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of possible LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (possible_lsm(lsm)) {
+		return;
+	}
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	possible_lsms[last_lsm++] = lsm;
+}
+
+/* Default boot: populate possible LSMs list with builtin ordering. */
+static void __init prepare_lsm_order_builtin(void)
+{
+	struct lsm_info *lsm;
+
+	/* All minor LSMs should go next. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_MINOR &&
+		    lsm->order == LSM_ORDER_MUTABLE)
+			append_possible_lsm(lsm, "builtin minor");
+	}
+
+	/* Then the CONFIG_DEFAULT_SECURITY exclusive LSM. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE &&
+		    !strcmp(CONFIG_DEFAULT_SECURITY, lsm->name))
+			append_possible_lsm(lsm, "builtin default");
+	}
+
+	/* Then other exclusive LSMs, in case above is disabled. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE &&
+		    strcmp(CONFIG_DEFAULT_SECURITY, lsm->name))
+			append_possible_lsm(lsm, "builtin extra");
+	}
+}
+
+/* "security=" boot: populate possible LSMs list from boot commandline. */
+static void __init prepare_lsm_order_commandline(void)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(bootparam_lsms, GFP_KERNEL);
+	next = sep;
+	/* Walk commandline list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    !strcmp(lsm->name, name)) {
+				append_possible_lsm(lsm, "commandline");
+			}
+		}
+	}
+	kfree(sep);
+
+	/* Mark any LSMs missing from commandline as explicitly disabled. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_MUTABLE) {
+			if (possible_lsm(lsm))
+				continue;
+
+			set_enabled(lsm, false);
+		}
+	}
+}
+
+/* Populate possible LSMs list from build order or commandline order. */
+static void __init prepare_lsm_order(void)
+{
+	struct lsm_info *lsm;
+
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_possible_lsm(lsm, "first");
+	}
+
+	/* If no commandline order defined, use builtin order. */
+	if (!bootparam_lsms)
+		prepare_lsm_order_builtin();
+	else
+		prepare_lsm_order_commandline();
+}
+
 /* Is an LSM allowed to be enabled? */
 static bool __init lsm_enabled(struct lsm_info *lsm)
 {
@@ -69,10 +172,6 @@ static bool __init lsm_enabled(struct lsm_info *lsm)
 	if (exclusive)
 		return false;
 
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -93,17 +192,13 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 	}
 }
 
-static void __init lsm_init(enum lsm_type type)
+/* Initialize all possible LSMs in order, if they are enabled. */
+static void __init lsm_init(void)
 {
-	struct lsm_info *lsm;
-	enum lsm_order order;
+	struct lsm_info **lsm;
 
-	for (order = LSM_ORDER_FIRST; order < LSM_ORDER_MAX; order++) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (lsm->type == type && lsm->order == order)
-				maybe_enable_lsm(lsm);
-		}
-	}
+	for (lsm = possible_lsms; *lsm; lsm++)
+		maybe_enable_lsm(*lsm);
 }
 
 /**
@@ -119,25 +214,21 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
+	possible_lsms = kcalloc(LSM_COUNT + 1, sizeof(*possible_lsms),
+				GFP_KERNEL);
 	pr_info("Security Framework initialized\n");
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	lsm_init(LSM_TYPE_MINOR);
-
-	/*
-	 * Load all the remaining security modules.
-	 */
-	lsm_init(LSM_TYPE_EXCLUSIVE);
+	prepare_lsm_order();
+	lsm_init();
 
+	kfree(possible_lsms);
 	return 0;
 }
 
 /* Save user chosen LSM */
 static int __init choose_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	bootparam_lsms = str;
 	return 1;
 }
 __setup("security=", choose_lsm);
-- 
2.17.1
