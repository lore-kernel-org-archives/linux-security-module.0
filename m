From: keescook@chromium.org (Kees Cook)
Date: Wed,  2 Aug 2017 20:19:11 -0700
Subject: [PATCH 2/4] seccomp: Add SECCOMP_FILTER_FLAG_KILL_PROCESS
In-Reply-To: <1501730353-46840-1-git-send-email-keescook@chromium.org>
References: <1501730353-46840-1-git-send-email-keescook@chromium.org>
Message-ID: <1501730353-46840-3-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Right now, SECCOMP_RET_KILL kills the current thread. There have been
a few requests for RET_KILL to kill the entire process (the thread
group), but since seccomp's u32 return values are ABI, and ordered by
lowest value, with RET_KILL as 0, there isn't a trivial way to provide
an even smaller value that would mean the more restrictive action of
killing the thread group.

Instead, create a filter flag that indicates that a RET_KILL from this
filter must kill the process rather than the thread. This can be set
(and not cleared) via the new SECCOMP_FILTER_FLAG_KILL_PROCESS flag.

Pros:
 - the logic for the filter action is contained in the filter.
 - userspace can detect support for the feature since earlier kernels
   will reject the new flag.
Cons:
 - depends on adding an assignment to the seccomp_run_filters() loop
   (previous patch).

Alternatives to this approach with pros/cons:

- Use a new test during seccomp_run_filters() that treats the RET_DATA
  mask of a RET_KILL action as special. If a new bit is set in the data,
  then treat the return value as -1 (lower than 0).
  Pros:
   - the logic for the filter action is contained in the filter.
  Cons:
   - added complexity to time-sensitive seccomp_run_filters() loop.
   - there isn't a trivial way for userspace to detect if the kernel
     supports the feature (earlier kernels will silently ignore the
     RET_DATA and only kill the thread).

- Have SECCOMP_FILTER_FLAG_KILL_PROCESS attach to the seccomp struct
  rather than the filter.
  Pros:
   - no change needed to seccomp_run_filters() loop.
  Cons:
   - the change in behavior technically originates external to the
     filter, which allows for later filters to "enhance" a previously
     applied filter's RET_KILL to kill the entire process, which may
     be unexpected.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seccomp.h      |  3 ++-
 include/uapi/linux/seccomp.h |  3 ++-
 kernel/seccomp.c             | 12 +++++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index ecc296c137cd..59d001ba655c 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -3,7 +3,8 @@
 
 #include <uapi/linux/seccomp.h>
 
-#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC)
+#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
+					 SECCOMP_FILTER_FLAG_KILL_PROCESS)
 
 #ifdef CONFIG_SECCOMP
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 0f238a43ff1e..4b75d8c297b6 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -15,7 +15,8 @@
 #define SECCOMP_SET_MODE_FILTER	1
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
-#define SECCOMP_FILTER_FLAG_TSYNC	1
+#define SECCOMP_FILTER_FLAG_TSYNC		1
+#define SECCOMP_FILTER_FLAG_KILL_PROCESS	2
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8bdcf01379e4..931eb9cbd093 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -44,6 +44,7 @@
  *         is only needed for handling filters shared across tasks.
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
+ * @kill_process: if true, RET_KILL will kill process rather than thread.
  *
  * seccomp_filter objects are organized in a tree linked via the @prev
  * pointer.  For any task, it appears to be a singly-linked list starting
@@ -59,6 +60,7 @@ struct seccomp_filter {
 	refcount_t usage;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
+	bool kill_process;
 };
 
 /* Limit any path through the tree to 256KB worth of instructions. */
@@ -448,6 +450,10 @@ static long seccomp_attach_filter(unsigned int flags,
 			return ret;
 	}
 
+	/* Set process-killing flag, if present. */
+	if (flags & SECCOMP_FILTER_FLAG_KILL_PROCESS)
+		filter->kill_process = true;
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -658,7 +664,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			seccomp_init_siginfo(&info, this_syscall, data);
 			do_coredump(&info);
 		}
-		do_exit(SIGSYS);
+		/* Kill entire thread group if requested (or went haywire). */
+		if (!match || match->kill_process)
+			do_group_exit(SIGSYS);
+		else
+			do_exit(SIGSYS);
 	}
 
 	unreachable();
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
