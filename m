Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70836CDF3
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615435; cv=none; b=UNlCgn16XGVaiVJFRf6k8tAc0vMGZRzrj2ZfuZKazQ7JIYRo0zX5o3Uwe1avZTW/qHGbiUQ9PsyysQ4u74HRHpj43VJXhxF4FwRu7vfV1dshy8BSwBx3g49d8syT/TDOUDo3mvJMJ+rLIMZfrlhvuk+OKAWIZXRiXpVfioRYKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615435; c=relaxed/simple;
	bh=SQ7GBMLnXX5I3bFBCOmeZQZl5xHUI3hMGXJu0wAGPhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=PFAZZ0yaErFeppFT45MoFl98lcRmo5IDs6yAiK6oyIzPNgSjQ+vxuiwEpsJ0TsE6zq4Vv5Hm3Dm4A7R4ydFUHJkxZ38bRxw0gwzvLVbe3G0OR+dlN0bzUIzIFh9DBfboqQyFYLQQ8XqtrMCIBs30crOc6C3c8ykeusMtG+/n7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GplIoEt+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GplIoEt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783615432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1EhtpTNPWeURbn3yhN8uvjzdNLJOl63hKvo6ZRXyxc=;
	b=GplIoEt+GuoTp+HqIm13MER9BB204l300P0lle03mt1PoGqsEWWaQaMbQJWibH3e+y20cS
	Yp7fOlDWucnaQG//qsNJBYe9nbS0qXvLOwu0N8mTvcDlYZHy47wdRy4bNn9sWMhN5q//A0
	mtBfuKSLWLAHWHv2Vva7IiG5+j20dTE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-7QAmzfxFPCGgsOgKlzBNJg-1; Thu,
 09 Jul 2026 12:43:49 -0400
X-MC-Unique: 7QAmzfxFPCGgsOgKlzBNJg-1
X-Mimecast-MFC-AGG-ID: 7QAmzfxFPCGgsOgKlzBNJg_1783615428
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4EE2180267E;
	Thu,  9 Jul 2026 16:43:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.50.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FFE1195608A;
	Thu,  9 Jul 2026 16:43:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rbriggs@redhat.com
Subject: [PATCH] selftests/landlock: Fix screwed up pointers in the scoped_signal_test
Date: Thu,  9 Jul 2026 18:43:40 +0200
Message-ID: <20260709164340.339656-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 0yWjmFzrAlaa9RxDZYdJTGdd9lRpc-ZmxhU3ZQKvbjY_1783615428
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Thomas Huth <thuth@redhat.com>

The scoped_signal_test uses pthread_join(..., (void **)&ret)) in
a couple of places, i.e. the return value of the thread is stored
in the shape of a "void *" into the memory location of &ret.
Pointers are 64-bit on modern computers, but the ret variable is
declared as a simple "enum thread_return" which is only 32 bits.
So the pthread_join() will overflow the ret variable by 4 byte.

The problem is very visible on big endian systems like s390x
where the test is failing: The least significant byte that carries
the return code of the thread is not written into the ret variable
here, but somewhere else in the stack frame, so the comparison
for the right return code is failing here.

Fix it by getting rid of the enum and defining the THREAD_* constants
and "ret" variables as proper "void *" pointers. This way we can
also get rid of some ugly (void *) castings in a couple of spots.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/landlock/scoped_signal_test.c   | 44 +++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index f24f2c28f62e5..58d25157fe781 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -249,12 +249,10 @@ TEST_F(scoped_domains, check_access_signal)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-enum thread_return {
-	THREAD_INVALID = 0,
-	THREAD_SUCCESS = 1,
-	THREAD_ERROR = 2,
-	THREAD_TEST_FAILED = 3,
-};
+#define THREAD_INVALID		((void *)0)
+#define THREAD_SUCCESS		((void *)1)
+#define THREAD_ERROR		((void *)2)
+#define THREAD_TEST_FAILED	((void *)3)
 
 static void *thread_sync(void *arg)
 {
@@ -262,15 +260,15 @@ static void *thread_sync(void *arg)
 	char buf;
 
 	if (read(pipe_read, &buf, 1) != 1)
-		return (void *)THREAD_ERROR;
+		return THREAD_ERROR;
 
-	return (void *)THREAD_SUCCESS;
+	return THREAD_SUCCESS;
 }
 
 TEST(signal_scoping_thread_before)
 {
 	pthread_t no_sandbox_thread;
-	enum thread_return ret = THREAD_INVALID;
+	void *ret = THREAD_INVALID;
 	int thread_pipe[2];
 
 	drop_caps(_metadata);
@@ -285,7 +283,7 @@ TEST(signal_scoping_thread_before)
 	EXPECT_EQ(0, pthread_kill(no_sandbox_thread, 0));
 	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
 
-	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
+	EXPECT_EQ(0, pthread_join(no_sandbox_thread, &ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
 
 	EXPECT_EQ(0, close(thread_pipe[0]));
@@ -295,7 +293,7 @@ TEST(signal_scoping_thread_before)
 TEST(signal_scoping_thread_after)
 {
 	pthread_t scoped_thread;
-	enum thread_return ret = THREAD_INVALID;
+	void *ret = THREAD_INVALID;
 	int thread_pipe[2];
 
 	drop_caps(_metadata);
@@ -310,7 +308,7 @@ TEST(signal_scoping_thread_after)
 	EXPECT_EQ(0, pthread_kill(scoped_thread, 0));
 	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
 
-	EXPECT_EQ(0, pthread_join(scoped_thread, (void **)&ret));
+	EXPECT_EQ(0, pthread_join(scoped_thread, &ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
 
 	EXPECT_EQ(0, close(thread_pipe[0]));
@@ -327,20 +325,20 @@ void *thread_setuid(void *ptr)
 	char buf;
 
 	if (read(arg->pipe_read, &buf, 1) != 1)
-		return (void *)THREAD_ERROR;
+		return THREAD_ERROR;
 
 	/* libc's setuid() should update all thread's credentials. */
 	if (getuid() != arg->new_uid)
-		return (void *)THREAD_TEST_FAILED;
+		return THREAD_TEST_FAILED;
 
-	return (void *)THREAD_SUCCESS;
+	return THREAD_SUCCESS;
 }
 
 TEST(signal_scoping_thread_setuid)
 {
 	struct thread_setuid_args arg;
 	pthread_t no_sandbox_thread;
-	enum thread_return ret = THREAD_INVALID;
+	void *ret = THREAD_INVALID;
 	int pipe_parent[2];
 	int prev_uid;
 
@@ -367,7 +365,7 @@ TEST(signal_scoping_thread_setuid)
 	EXPECT_EQ(arg.new_uid, getuid());
 	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
 
-	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
+	EXPECT_EQ(0, pthread_join(no_sandbox_thread, &ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
 
 	clear_cap(_metadata, CAP_SETUID);
@@ -667,20 +665,20 @@ static void *thread_setown_scoped(void *arg)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0)
-		return (void *)THREAD_ERROR;
+		return THREAD_ERROR;
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
 	    landlock_restrict_self(ruleset_fd, 0)) {
 		close(ruleset_fd);
-		return (void *)THREAD_ERROR;
+		return THREAD_ERROR;
 	}
 	close(ruleset_fd);
 
 	/* Makes this process group own the SIGIO source. */
 	if (fcntl(fd, F_SETSIG, SIGURG) || fcntl(fd, F_SETOWN, -getpgrp()) ||
 	    fcntl(fd, F_SETFL, O_ASYNC))
-		return (void *)THREAD_ERROR;
+		return THREAD_ERROR;
 
-	return (void *)THREAD_SUCCESS;
+	return THREAD_SUCCESS;
 }
 
 /*
@@ -702,7 +700,7 @@ TEST(sigio_to_pgid_self)
 {
 	int trigger[2];
 	pthread_t thread;
-	enum thread_return ret = THREAD_INVALID;
+	void *ret = THREAD_INVALID;
 	int i;
 
 	drop_caps(_metadata);
@@ -722,7 +720,7 @@ TEST(sigio_to_pgid_self)
 	 */
 	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_setown_scoped,
 				    &trigger[0]));
-	ASSERT_EQ(0, pthread_join(thread, (void **)&ret));
+	ASSERT_EQ(0, pthread_join(thread, &ret));
 	ASSERT_EQ(THREAD_SUCCESS, ret);
 
 	/* Fans SIGURG out to the process group. */
-- 
2.55.0

