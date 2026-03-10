Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7B33E347
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169467; cv=none; b=aaRuXHLoHmndUX9SWRt+fprJAmrZCZHaIXP0D5GvxsfnYcGYGOsuMQz1jUPqsV2JUQrz8q8mC5q8l1x715eDhbkXQ1jn1YN8KgQiwepYbwNw/rP+6bGSsVm02YNvQqimTBszYouIWq0pBxsYdi1IUz4miqxjq3YPsDDaUKsHVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169467; c=relaxed/simple;
	bh=Aa7W3QOBouqXVTwND5bDbqTgD3mKOl1TSyzQDTDs1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IX2fjrk+YdX1pIYaa8YxnE2gOr2pGW8tmb3SF6r7MytFcC9Bwhd1VfEBOYv1Z/uqW+0t/GAKZvjDjj7Jipa4oCnAySprWejOqYHQa05jATpQyCl20y69/GMEjJIGHrR/p9NolJhkw6Cs+CnL5PEBaWEkEvU+XP9WksJZGxlseGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bU6cBmu7; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bU6cBmu7"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fVjwk32gRzL9N;
	Tue, 10 Mar 2026 20:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773169462;
	bh=+sVNWeB6M2XJvG6NHQw1uSCkMxkwZH2lS8LXOGSP6v8=;
	h=From:To:Cc:Subject:Date:From;
	b=bU6cBmu7MGa15oBrhFPGhKZAoOl0Bqm83wynsYqlzJbIICSNp1HeAWrdkbnP/0S9h
	 YzIpgpaPTbUgipEnm0ssyG2G9AtQFglSRuDGEYRkmuNJmuNUn3gu8nk18H1clPvVLs
	 efnVNx/mf4FBYNzieUfhgA9Dai99TeUo3BEC4dBU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fVjwj4qk7z4qm;
	Tue, 10 Mar 2026 20:04:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH v1] selftests/landlock: Test tsync interruption and cancellation paths
Date: Tue, 10 Mar 2026 20:04:15 +0100
Message-ID: <20260310190416.1913908-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tsync_interrupt test to exercise the signal interruption path in
landlock_restrict_sibling_threads().  When a signal interrupts
wait_for_completion_interruptible() while the calling thread waits for
sibling threads to finish credential preparation, the kernel:

1. Sets ERESTARTNOINTR to request a transparent syscall restart.
2. Calls cancel_tsync_works() to opportunistically dequeue task works
   that have not started running yet.
3. Breaks out of the preparation loop, then unblocks remaining
   task works via complete_all() and waits for them to finish.
4. Returns the error, causing abort_creds() in the syscall handler.

Specifically, cancel_tsync_works() in its entirety, the ERESTARTNOINTR
error branch in landlock_restrict_sibling_threads(), and the
abort_creds() error branch in the landlock_restrict_self() syscall
handler are timing-dependent and not exercised by the existing tsync
tests, making code coverage measurements non-deterministic.

The test spawns a signaler thread that rapidly sends SIGUSR1 to the
calling thread while it performs landlock_restrict_self() with
LANDLOCK_RESTRICT_SELF_TSYNC.  Since ERESTARTNOINTR causes a
transparent restart, userspace always sees the syscall succeed.

This is a best-effort coverage test: the interruption path is exercised
when the signal lands during the preparation wait, which depends on
thread scheduling.  The test creates enough idle sibling threads (200)
to ensure multiple serialized waves of credential preparation even on
machines with many cores (e.g., 64), widening the window for the
signaler.  Deterministic coverage would require wrapping the wait call
with ALLOW_ERROR_INJECTION() and using CONFIG_FAIL_FUNCTION.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Yihan Ding <dingyihan@uniontech.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/tsync_test.c | 91 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
index 37ef0d2270db..2b9ad4f154f4 100644
--- a/tools/testing/selftests/landlock/tsync_test.c
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -6,9 +6,10 @@
  */
 
 #define _GNU_SOURCE
+#include <linux/landlock.h>
 #include <pthread.h>
+#include <signal.h>
 #include <sys/prctl.h>
-#include <linux/landlock.h>
 
 #include "common.h"
 
@@ -158,4 +159,92 @@ TEST(competing_enablement)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+static void signal_nop_handler(int sig)
+{
+}
+
+struct signaler_data {
+	pthread_t target;
+	volatile bool stop;
+};
+
+static void *signaler_thread(void *data)
+{
+	struct signaler_data *sd = data;
+
+	while (!sd->stop)
+		pthread_kill(sd->target, SIGUSR1);
+
+	return NULL;
+}
+
+/*
+ * Number of idle sibling threads.  This must be large enough that even on
+ * machines with many cores, the sibling threads cannot all complete their
+ * credential preparation in a single parallel wave, otherwise the signaler
+ * thread has no window to interrupt wait_for_completion_interruptible().
+ * 200 threads on a 64-core machine yields ~3 serialized waves, giving the
+ * tight signal loop enough time to land an interruption.
+ */
+#define NUM_IDLE_THREADS 200
+
+/*
+ * Exercises the tsync interruption and cancellation paths in tsync.c.
+ *
+ * When a signal interrupts the calling thread while it waits for sibling
+ * threads to finish their credential preparation
+ * (wait_for_completion_interruptible in landlock_restrict_sibling_threads),
+ * the kernel sets ERESTARTNOINTR, cancels queued task works that have not
+ * started yet (cancel_tsync_works), then waits for the remaining works to
+ * finish.  On the error return, syscalls.c aborts the prepared credentials.
+ * The kernel automatically restarts the syscall, so userspace sees success.
+ */
+TEST(tsync_interrupt)
+{
+	size_t i;
+	pthread_t threads[NUM_IDLE_THREADS];
+	pthread_t signaler;
+	struct signaler_data sd;
+	struct sigaction sa = {};
+	const int ruleset_fd = create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	/* Install a no-op SIGUSR1 handler so the signal does not kill us. */
+	sa.sa_handler = signal_nop_handler;
+	sigemptyset(&sa.sa_mask);
+	ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	for (i = 0; i < NUM_IDLE_THREADS; i++)
+		ASSERT_EQ(0, pthread_create(&threads[i], NULL, idle, NULL));
+
+	/*
+	 * Start a signaler thread that continuously sends SIGUSR1 to the
+	 * calling thread.  This maximizes the chance of interrupting
+	 * wait_for_completion_interruptible() in the kernel's tsync path.
+	 */
+	sd.target = pthread_self();
+	sd.stop = false;
+	ASSERT_EQ(0, pthread_create(&signaler, NULL, signaler_thread, &sd));
+
+	/*
+	 * The syscall may be interrupted and transparently restarted by the
+	 * kernel (ERESTARTNOINTR).  From userspace, it should always succeed.
+	 */
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	sd.stop = true;
+	ASSERT_EQ(0, pthread_join(signaler, NULL));
+
+	for (i = 0; i < NUM_IDLE_THREADS; i++) {
+		ASSERT_EQ(0, pthread_cancel(threads[i]));
+		ASSERT_EQ(0, pthread_join(threads[i], NULL));
+	}
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.53.0

