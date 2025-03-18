Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE357199384
	for <linux-security-module@vger.kernel.org>; Tue, 18 Mar 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315115; cv=none; b=bZ7tCPuCr+OR4nCH+P3rdCmjlWDyxFLazaG0qSoJIeu1Sf9onCIjEsAcWJ/ufs+Tggz9zEP0rv5HarlZiKW2ZnBmZ0/58HtlQF7OSfe9QmY+JYS2jMNAMrj/Hw80nvkftqct+8osY+v8hugna+dA4HPyskH1DXCEclCxY/DnZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315115; c=relaxed/simple;
	bh=1RBQDWdg9iqGvv/I8EHH0aO+3nGkCQlJ4bPcUmMPXMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv3/BGFeSq07heDaU/MPW0qfc413FWhCsWrs6rGQYRug91FZ0vHN98Tt35wjqynEkGnMa5jk3JGo2cH1KH5Xv7q09MyY3w0BRXoOAfJGOtq/iuDlCVMYcBj7wNW5E2uPFeOqVlY/WEkITsvjeh21y1eC0nJjYWnIOP9KpNuiZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AtQWLK2a; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AtQWLK2a"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH430h2gzNVb;
	Tue, 18 Mar 2025 17:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314498;
	bh=UXiF1shysFn1yAggDsS2yy31i7H9y6GM9Q6og25J/a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtQWLK2a8FehgvCIPa1WSAp0oS8elnTUkjuBHiHIZWk1wxzl3VO39T9W/DYInyvy3
	 job2vgIOJWXug4BI2og36NXKCfeXEWbQkD+jQGiPeGGLbYIqOzOmqFq8u9R99qlQ/H
	 JBRN7ZS93l7mS1DwttsbbGeOZBXbyudFRrxhrt4Q=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH421zMMz3kM;
	Tue, 18 Mar 2025 17:14:58 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 6/8] selftests/landlock: Split signal_scoping_threads tests
Date: Tue, 18 Mar 2025 17:14:41 +0100
Message-ID: <20250318161443.279194-7-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Split signal_scoping_threads tests into signal_scoping_thread_before
and signal_scoping_thread_after.

Use local variables for thread synchronization.  Fix exported function.
Replace some asserts with expects.

Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Cc: Günther Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-7-mic@digikod.net
---

Changes since v1:
- New patch.
---
 .../selftests/landlock/scoped_signal_test.c   | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 767f117703b7..d313cb626225 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -249,47 +249,66 @@ TEST_F(scoped_domains, check_access_signal)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-static int thread_pipe[2];
-
 enum thread_return {
 	THREAD_INVALID = 0,
 	THREAD_SUCCESS = 1,
 	THREAD_ERROR = 2,
 };
 
-void *thread_func(void *arg)
+static void *thread_sync(void *arg)
 {
+	const int pipe_read = *(int *)arg;
 	char buf;
 
-	if (read(thread_pipe[0], &buf, 1) != 1)
+	if (read(pipe_read, &buf, 1) != 1)
 		return (void *)THREAD_ERROR;
 
 	return (void *)THREAD_SUCCESS;
 }
 
-TEST(signal_scoping_threads)
+TEST(signal_scoping_thread_before)
 {
-	pthread_t no_sandbox_thread, scoped_thread;
+	pthread_t no_sandbox_thread;
 	enum thread_return ret = THREAD_INVALID;
+	int thread_pipe[2];
 
 	drop_caps(_metadata);
 	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
 
-	ASSERT_EQ(0,
-		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
+	ASSERT_EQ(0, pthread_create(&no_sandbox_thread, NULL, thread_sync,
+				    &thread_pipe[0]));
 
-	/* Restricts the domain after creating the first thread. */
+	/* Enforces restriction after creating the thread. */
 	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
 
-	ASSERT_EQ(0, pthread_kill(no_sandbox_thread, 0));
-	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
-
-	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
-	ASSERT_EQ(0, pthread_kill(scoped_thread, 0));
-	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
+	EXPECT_EQ(0, pthread_kill(no_sandbox_thread, 0));
+	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
 
 	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
+
+	EXPECT_EQ(0, close(thread_pipe[0]));
+	EXPECT_EQ(0, close(thread_pipe[1]));
+}
+
+TEST(signal_scoping_thread_after)
+{
+	pthread_t scoped_thread;
+	enum thread_return ret = THREAD_INVALID;
+	int thread_pipe[2];
+
+	drop_caps(_metadata);
+	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
+
+	/* Enforces restriction before creating the thread. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_sync,
+				    &thread_pipe[0]));
+
+	EXPECT_EQ(0, pthread_kill(scoped_thread, 0));
+	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
+
 	EXPECT_EQ(0, pthread_join(scoped_thread, (void **)&ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
 
-- 
2.48.1

