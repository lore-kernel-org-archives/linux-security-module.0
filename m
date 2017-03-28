From: mic@digikod.net (=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=)
Date: Wed, 29 Mar 2017 01:46:48 +0200
Subject: [PATCH net-next v6 09/11] seccomp: Enhance test_harness with an
	assert step mechanism
In-Reply-To: <20170328234650.19695-1-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
Message-ID: <20170328234650.19695-10-mic@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This is useful to return an information about the error without being
able to write to TH_LOG_STREAM.

Helpers from test_harness.h may be useful outside of the seccomp
directory.

Signed-off-by: Micka?l Sala?n <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
---
 tools/testing/selftests/seccomp/test_harness.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/test_harness.h b/tools/testing/selftests/seccomp/test_harness.h
index a786c69c7584..77e407663e06 100644
--- a/tools/testing/selftests/seccomp/test_harness.h
+++ b/tools/testing/selftests/seccomp/test_harness.h
@@ -397,7 +397,7 @@ struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
 	int termsig;
-	int passed;
+	__s8 passed;
 	int trigger; /* extra handler after the evaluation */
 	struct __test_metadata *prev, *next;
 };
@@ -476,6 +476,12 @@ void __run_test(struct __test_metadata *t)
 					"instead of by signal (code: %d)\n",
 					t->name,
 					WEXITSTATUS(status));
+			} else if (t->passed < 0) {
+				fprintf(TH_LOG_STREAM,
+					"%s: Failed@step #%d\n",
+					t->name,
+					t->passed * -1);
+				t->passed = 0;
 			}
 		} else if (WIFSIGNALED(status)) {
 			t->passed = 0;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
