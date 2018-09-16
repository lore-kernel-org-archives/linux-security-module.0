From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:58 -0700
Subject: [PATCH 17/18] LSM: Provide init debugging
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-18-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Booting with "lsm.debug" will report details on how LSM ordering
decisions are being made. Additionally changes tense of "Framework
initialized" to "... initializing" since it hadn't finished its
work yet.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 security/security.c                           | 30 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6d6bb9481193..c3e44a27c86a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2274,6 +2274,8 @@
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
+	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/security.c b/security/security.c
index f09a4bb3cb86..3b84b7eeb08c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -12,6 +12,8 @@
  *	(at your option) any later version.
  */
 
+#define pr_fmt(fmt) "LSM: " fmt
+
 #include <linux/bpf.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
@@ -46,6 +48,13 @@ static const char *bootparam_lsms;
 static struct lsm_info **possible_lsms __initdata;
 static struct lsm_info *exclusive __initdata;
 
+static bool debug __initdata;
+#define init_debug(...)						\
+	do {							\
+		if (debug)					\
+			pr_info(__VA_ARGS__);			\
+	} while (0)
+
 /* Mark an LSM's enabled flag, if it exists. */
 static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
@@ -71,6 +80,7 @@ static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
 	if (possible_lsm(lsm)) {
+		init_debug("duplicate: %s\n", lsm->name);
 		return;
 	}
 
@@ -78,6 +88,7 @@ static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
 		return;
 
 	possible_lsms[last_lsm++] = lsm;
+	init_debug("%s possible: %s\n", from, lsm->name);
 }
 
 /* Default boot: populate possible LSMs list with builtin ordering. */
@@ -117,12 +128,18 @@ static void __init prepare_lsm_order_commandline(void)
 	next = sep;
 	/* Walk commandline list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (lsm->order == LSM_ORDER_MUTABLE &&
 			    !strcmp(lsm->name, name)) {
 				append_possible_lsm(lsm, "commandline");
+				found = true;
 			}
 		}
+
+		if (!found)
+			init_debug("ignoring: %s\n", name);
 	}
 	kfree(sep);
 
@@ -133,6 +150,7 @@ static void __init prepare_lsm_order_commandline(void)
 				continue;
 
 			set_enabled(lsm, false);
+			init_debug("disabled: %s\n", lsm->name);
 		}
 	}
 }
@@ -187,6 +205,7 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
 			exclusive = lsm;
+			init_debug("exclusive: %s\n", exclusive->name);
 		}
 		lsm->init();
 	}
@@ -211,12 +230,13 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
+	pr_info("Security Framework initializing\n");
+
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 	possible_lsms = kcalloc(LSM_COUNT + 1, sizeof(*possible_lsms),
 				GFP_KERNEL);
-	pr_info("Security Framework initialized\n");
 
 	prepare_lsm_order();
 	lsm_init();
@@ -233,6 +253,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Enable LSM order debugging. */
+static int __init enable_debug(char *str)
+{
+	debug = true;
+	return 1;
+}
+__setup("lsm.debug", enable_debug);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1
