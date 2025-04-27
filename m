Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699611BEF7E;
	Sun, 27 Apr 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717919; cv=none; b=uPsQRhqhF8jCHG50O+UckZwGSAggMm3jgzRWI3MkrExyCShPAbvB308NqjdgfeehaJVaegQgNXIT8ZMto22ZfUtFU/8G6c1bpy7e9DLbdIRkJ1cY2T9jzJix5GNHrbgdYJhMZPUuc5ErGlMlvSN8URLqHZVzQArUOcGXtB6Kwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717919; c=relaxed/simple;
	bh=1XPUuCoX8gvHexCqhRpn3WS8WotpYcenLSO8ViMNUqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgWcBad9iPYYQ+QCahlTZTvgmwp8rvTSaWVxt4s0BDg8aUbKRJ2GFnts6PiO0IjHnoYvmdeF2VlS76oZaL1fK8oYZy+C5Hyt71loRUlPZ7ae2jVIqD7Sdgpf2hVy6zAc0xMX8iA+LCCHrSWDrGc3mDrdaiDUYssTlRZnspkM4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk1YUsoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk1YUsoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6740C4CEE2;
	Sun, 27 Apr 2025 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745717918;
	bh=1XPUuCoX8gvHexCqhRpn3WS8WotpYcenLSO8ViMNUqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk1YUsoSGPXSzB4Aesga2mfUuhydwUtSnj0mwiG0zVyrYVnT+1ZmmbDb9gCue3hWY
	 XOlnZ0g13bFYYDG4RoIVtcEj06NWpWoKiEXQpAu1BDvsgUhr1+ifxCLZ3VxkXwvSPw
	 rdmKifoCiHRUCP18MV6CVfQLafH7dLBZSyrgavJn9ljprPDgN/mdkMTAM/rBPggpx/
	 d2FwqwtkGl+tdgxsqw3po//JPHH2yRz95ayIHkqRpQsutAIa2s3efGvS08iO2egxnG
	 5+4yAryXsclEAL87IMwSNlKkQ9Aj9ZUyfHPRnlNGGQkMJ3xYpHRmtrNo8oKjcIF9I8
	 0M5RI6zhvJDAg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	llvm@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] lib/tests: Add randstruct KUnit test
Date: Sat, 26 Apr 2025 18:38:34 -0700
Message-Id: <20250427013836.877214-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427013604.work.926-kees@kernel.org>
References: <20250427013604.work.926-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11713; i=kees@kernel.org; h=from:subject; bh=1XPUuCoX8gvHexCqhRpn3WS8WotpYcenLSO8ViMNUqI=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm8XbNy63eETFiwNNM1zV9yns27SVnR0remnGKQ1VZ2P To9amdXRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETyjjD84XD+dXTLwg2iRtHy R8sDP6WI5LtFPObcaxY2cUPe31nznzH8U3ki9+DOtLy5vlc31th0bbuUeXXp6+y0GRt6DEsUXk+ dxAsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Perform basic validation about layout randomization and initialization
tracking when using CONFIG_RANDSTRUCT=y. Tested using:

$ ./tools/testing/kunit/kunit.py run \
	--kconfig_add CONFIG_RANDSTRUCT_FULL=y \
	randstruct
[17:22:30] ================= randstruct (2 subtests) ==================
[17:22:30] [PASSED] randstruct_layout
[17:22:30] [PASSED] randstruct_initializers
[17:22:30] =================== [PASSED] randstruct ====================
[17:22:30] ============================================================
[17:22:30] Testing complete. Ran 2 tests: passed: 2
[17:22:30] Elapsed time: 5.091s total, 0.001s configuring, 4.974s building, 0.086s running

Adding "--make_option LLVM=1" can be used to test Clang, which also
passes.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Bill Wendling <morbo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>
Cc: Diego Vieira <diego.daniel.professional@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: <llvm@lists.linux.dev>
---
 MAINTAINERS                  |   1 +
 lib/Kconfig.debug            |   8 +
 lib/tests/Makefile           |   1 +
 lib/tests/randstruct_kunit.c | 283 +++++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 lib/tests/randstruct_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..aeb3e7911852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12879,6 +12879,7 @@ F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	include/linux/ucopysize.h
 F:	kernel/configs/hardening.config
+F:	lib/tests/randstruct_kunit.c
 F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
 F:	security/Kconfig.hardening
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..6479cec900c7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2863,6 +2863,14 @@ config OVERFLOW_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RANDSTRUCT_KUNIT_TEST
+	tristate "Test randstruct structure layout randomization at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for the checking CONFIG_RANDSTRUCT=y, which
+	  randomizes structure layouts.
+
 config STACKINIT_KUNIT_TEST
 	tristate "Test level of stack variable initialization" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 5a4794c1826e..56d645014482 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
+obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
diff --git a/lib/tests/randstruct_kunit.c b/lib/tests/randstruct_kunit.c
new file mode 100644
index 000000000000..6fc23dfa57b6
--- /dev/null
+++ b/lib/tests/randstruct_kunit.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test cases for struct randomization, i.e. CONFIG_RANDSTRUCT=y.
+ *
+ * For example, see:
+ * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/start.rst
+ *	./tools/testing/kunit/kunit.py run randstruct [--raw_output] \
+ *		[--make_option LLVM=1] \
+ *		--kconfig_add CONFIG_RANDSTRUCT_FULL=y
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#define DO_MANY_MEMBERS(macro, args...)	\
+	macro(a, args)			\
+	macro(b, args)			\
+	macro(c, args)			\
+	macro(d, args)			\
+	macro(e, args)			\
+	macro(f, args)			\
+	macro(g, args)			\
+	macro(h, args)
+
+#define do_enum(x, ignored)	MEMBER_NAME_ ## x,
+enum randstruct_member_names {
+	DO_MANY_MEMBERS(do_enum)
+	MEMBER_NAME_MAX,
+};
+/* Make sure the macros are working: want 8 test members. */
+_Static_assert(MEMBER_NAME_MAX == 8);
+
+/* This is an unsigned long member to match the function pointer size */
+#define unsigned_long_member(x, ignored)	unsigned long x;
+struct randstruct_untouched {
+	DO_MANY_MEMBERS(unsigned_long_member)
+};
+
+/* Struct explicitly marked with __randomize_layout. */
+struct randstruct_shuffled {
+	DO_MANY_MEMBERS(unsigned_long_member)
+} __randomize_layout;
+#undef unsigned_long_member
+
+/* Struct implicitly randomized from being all func ptrs. */
+#define func_member(x, ignored)	size_t (*x)(int);
+struct randstruct_funcs_untouched {
+	DO_MANY_MEMBERS(func_member)
+} __no_randomize_layout;
+
+struct randstruct_funcs_shuffled {
+	DO_MANY_MEMBERS(func_member)
+};
+#undef func_member
+
+#define func_body(x, ignored)					\
+static noinline size_t func_##x(int arg)			\
+{								\
+	return offsetof(struct randstruct_funcs_untouched, x);	\
+}
+DO_MANY_MEMBERS(func_body)
+
+/* Various mixed types. */
+#define mixed_members					\
+	bool a;						\
+	short b;					\
+	unsigned int c __aligned(16);			\
+	size_t d;					\
+	char e;						\
+	u64 f;						\
+	union {						\
+		struct randstruct_shuffled shuffled;	\
+		uintptr_t g;				\
+	};						\
+	union {						\
+		void *ptr;				\
+		char h;					\
+	};
+
+struct randstruct_mixed_untouched {
+	mixed_members
+};
+
+struct randstruct_mixed_shuffled {
+	mixed_members
+} __randomize_layout;
+#undef mixed_members
+
+struct contains_randstruct_untouched {
+	int before;
+	struct randstruct_untouched untouched;
+	int after;
+};
+
+struct contains_randstruct_shuffled {
+	int before;
+	struct randstruct_shuffled shuffled;
+	int after;
+};
+
+static void randstruct_layout(struct kunit *test)
+{
+	int mismatches;
+
+#define check_mismatch(x, untouched, shuffled)	\
+	if (offsetof(untouched, x) != offsetof(shuffled, x))	\
+		mismatches++;					\
+	kunit_info(test, #shuffled "::" #x " @ %zu (vs %zu)\n",	\
+		   offsetof(shuffled, x),			\
+		   offsetof(untouched, x));			\
+
+#define check_pair(outcome, untouched, shuffled)		\
+	mismatches = 0;						\
+	DO_MANY_MEMBERS(check_mismatch, untouched, shuffled)	\
+	kunit_info(test, "Differing " #untouched " vs " #shuffled " member positions: %d\n", \
+		   mismatches);					\
+	KUNIT_##outcome##_MSG(test, mismatches, 0,		\
+			      #untouched " vs " #shuffled " layouts: unlucky or broken?\n");
+
+	check_pair(EXPECT_EQ, struct randstruct_untouched, struct randstruct_untouched)
+	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_shuffled)
+	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_funcs_shuffled)
+	check_pair(EXPECT_GT, struct randstruct_funcs_untouched, struct randstruct_funcs_shuffled)
+	check_pair(EXPECT_GT, struct randstruct_mixed_untouched, struct randstruct_mixed_shuffled)
+#undef check_pair
+
+#undef check_mismatch
+}
+
+#define check_mismatch(x, ignore)				\
+	KUNIT_EXPECT_EQ_MSG(test, untouched->x, shuffled->x,	\
+			    "Mismatched member value in %s initializer\n", \
+			    name);
+
+static void test_check_init(struct kunit *test, const char *name,
+			    struct randstruct_untouched *untouched,
+			    struct randstruct_shuffled *shuffled)
+{
+	DO_MANY_MEMBERS(check_mismatch)
+}
+
+static void test_check_mixed_init(struct kunit *test, const char *name,
+				  struct randstruct_mixed_untouched *untouched,
+				  struct randstruct_mixed_shuffled *shuffled)
+{
+	DO_MANY_MEMBERS(check_mismatch)
+}
+#undef check_mismatch
+
+#define check_mismatch(x, ignore)				\
+	KUNIT_EXPECT_EQ_MSG(test, untouched->untouched.x,	\
+			    shuffled->shuffled.x,		\
+			    "Mismatched member value in %s initializer\n", \
+			    name);
+static void test_check_contained_init(struct kunit *test, const char *name,
+				      struct contains_randstruct_untouched *untouched,
+				      struct contains_randstruct_shuffled *shuffled)
+{
+	DO_MANY_MEMBERS(check_mismatch)
+}
+#undef check_mismatch
+
+#define check_mismatch(x, ignore)					\
+	KUNIT_EXPECT_PTR_EQ_MSG(test, untouched->x, shuffled->x,	\
+			    "Mismatched member value in %s initializer\n", \
+			    name);
+
+static void test_check_funcs_init(struct kunit *test, const char *name,
+				  struct randstruct_funcs_untouched *untouched,
+				  struct randstruct_funcs_shuffled *shuffled)
+{
+	DO_MANY_MEMBERS(check_mismatch)
+}
+#undef check_mismatch
+
+static void randstruct_initializers(struct kunit *test)
+{
+#define init_members		\
+		.a = 1,		\
+		.b = 3,		\
+		.c = 5,		\
+		.d = 7,		\
+		.e = 11,	\
+		.f = 13,	\
+		.g = 17,	\
+		.h = 19,
+	struct randstruct_untouched untouched = {
+		init_members
+	};
+	struct randstruct_shuffled shuffled = {
+		init_members
+	};
+	struct randstruct_mixed_untouched mixed_untouched = {
+		init_members
+	};
+	struct randstruct_mixed_shuffled mixed_shuffled = {
+		init_members
+	};
+	struct contains_randstruct_untouched contains_untouched = {
+		.untouched = {
+			init_members
+		},
+	};
+	struct contains_randstruct_shuffled contains_shuffled = {
+		.shuffled = {
+			init_members
+		},
+	};
+#define func_member(x, ignored)	\
+		.x = func_##x,
+	struct randstruct_funcs_untouched funcs_untouched = {
+		DO_MANY_MEMBERS(func_member)
+	};
+	struct randstruct_funcs_shuffled funcs_shuffled = {
+		DO_MANY_MEMBERS(func_member)
+	};
+
+	test_check_init(test, "named", &untouched, &shuffled);
+	test_check_init(test, "unnamed", &untouched,
+		&(struct randstruct_shuffled){
+			init_members
+		});
+
+	test_check_contained_init(test, "named", &contains_untouched, &contains_shuffled);
+	test_check_contained_init(test, "unnamed", &contains_untouched,
+		&(struct contains_randstruct_shuffled){
+			.shuffled = (struct randstruct_shuffled){
+				init_members
+			},
+		});
+
+	test_check_contained_init(test, "named", &contains_untouched, &contains_shuffled);
+	test_check_contained_init(test, "unnamed copy", &contains_untouched,
+		&(struct contains_randstruct_shuffled){
+			/* full struct copy initializer */
+			.shuffled = shuffled,
+		});
+
+	test_check_mixed_init(test, "named", &mixed_untouched, &mixed_shuffled);
+	test_check_mixed_init(test, "unnamed", &mixed_untouched,
+		&(struct randstruct_mixed_shuffled){
+			init_members
+		});
+
+	test_check_funcs_init(test, "named", &funcs_untouched, &funcs_shuffled);
+	test_check_funcs_init(test, "unnamed", &funcs_untouched,
+		&(struct randstruct_funcs_shuffled){
+			DO_MANY_MEMBERS(func_member)
+		});
+
+#undef func_member
+#undef init_members
+}
+
+static int randstruct_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_RANDSTRUCT))
+		kunit_skip(test, "Not built with CONFIG_RANDSTRUCT=y");
+
+	return 0;
+}
+
+static struct kunit_case randstruct_test_cases[] = {
+	KUNIT_CASE(randstruct_layout),
+	KUNIT_CASE(randstruct_initializers),
+	{}
+};
+
+static struct kunit_suite randstruct_test_suite = {
+	.name = "randstruct",
+	.init = randstruct_test_init,
+	.test_cases = randstruct_test_cases,
+};
+
+kunit_test_suites(&randstruct_test_suite);
+
+MODULE_DESCRIPTION("Test cases for struct randomization");
+MODULE_LICENSE("GPL");
-- 
2.34.1

