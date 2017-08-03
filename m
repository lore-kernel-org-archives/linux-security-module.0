From: keescook@chromium.org (Kees Cook)
Date: Wed,  2 Aug 2017 20:19:10 -0700
Subject: [PATCH 1/4] seccomp: Provide matching filter for introspection
In-Reply-To: <1501730353-46840-1-git-send-email-keescook@chromium.org>
References: <1501730353-46840-1-git-send-email-keescook@chromium.org>
Message-ID: <1501730353-46840-2-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Both the upcoming logging improvements and changes to RET_KILL will need
to know which filter a given seccomp return value originated from. In
order to delay logic processing of result until after the seccomp loop,
this adds a single pointer assignment on matches. This will allow both
log and RET_KILL logic to work off the filter rather than doing more
expensive tests inside the time-critical run_filters loop.

Running tight cycles of getpid() with filters attached shows no measurable
difference in speed.

Suggested-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 98b59b5db90b..8bdcf01379e4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -171,10 +171,12 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
+ * @match: stores struct seccomp_filter that resulted in the return value
  *
  * Returns valid seccomp BPF response codes.
  */
-static u32 seccomp_run_filters(const struct seccomp_data *sd)
+static u32 seccomp_run_filters(const struct seccomp_data *sd,
+			       struct seccomp_filter **match)
 {
 	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
@@ -198,8 +200,10 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd)
 	for (; f; f = f->prev) {
 		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
 
-		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
+		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION)) {
 			ret = cur_ret;
+			*match = f;
+		}
 	}
 	return ret;
 }
@@ -566,6 +570,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			    const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
+	struct seccomp_filter *match = NULL;
 	int data;
 
 	/*
@@ -574,7 +579,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	 */
 	rmb();
 
-	filter_ret = seccomp_run_filters(sd);
+	filter_ret = seccomp_run_filters(sd, &match);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION;
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
