Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE4219301
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613386; cv=none; b=QQASqNeBgS8og3gB/sqzA9EYCcuJXFbJW/I9hq4aIUuOCiCRWO9V4MDjisi66bcgYcYDZP9wbEHVf4VJGhZ+nu4KMifpo3UWVWK4ceW6xoV7nUrKQAsx8EmSwuB3J7EwbY573N7Sb//ab3y4MG4P9Mdn1uSVlBLrK5J/CtR6uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613386; c=relaxed/simple;
	bh=ryOuQPOiucdUt6fxxUJSjzyfTGJuQfiP/15I6UJQU4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZ5sPMQLUjyHgLUghv9oMXE7Es5DtXJfWrslM44emKugcRwgWxQLL/P56NFsCxt22UVjkPzM0VoFQGwAvAHQjP1kf9tNziwaQvOKOHpunUFU78WMzwGI3/uvlk/kYEAGQ3Md3pLPcD6eDPh4talEh7MUZuUiWqNeKTIsEdy/GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9O0ulbt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9O0ulbt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48539d21b76so27360775e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613383; x=1774218183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS4JCCNfY5RzwYvdiCJ0WBvb8/RQOg7tIUw+Cvpxn9Y=;
        b=Q9O0ulbt49HB5YTn1bWCWIZJeIloQO8YeheRkyBcLTrxVYhmE/nj5ZBdXYPs2xN4uz
         ZMKOKEC1mg0uPN7dYZBLOc6Wkx1uSYwY9Iod8CU1jIXxatO1ykacpXqY0XHfTX/jEKbD
         GImGKUcdTw39VmvkcUdfhF9scGYzXOXtS3ix4FuN5KCePki4+1/eFd9O2VUcVU30ndBE
         VSFa62bOF6Lc2ly4pQxO3qpVY8tfIQUF51+ZW5banVnAXV5k26AqDQqZUXpLVnb+ukYd
         Dq1cPLdG40Xhem81DsBJ9gxDOSttkqO2PObgveiy53HEgUtCmpbAaADirAE4dlwYG8oq
         XvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613383; x=1774218183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FS4JCCNfY5RzwYvdiCJ0WBvb8/RQOg7tIUw+Cvpxn9Y=;
        b=i3KvcoETkRzb3sqxcVVXsM3u1+GKR8DGen1dO6i8OhPx9v3TVVNE6crVW//CGHKl+q
         gPaLpsfM11aQE9UmLvbWZ9+5Agdy9f/+6aWkubjUP2Mfc2e4wcIg3hXHlwdH9I71x/KZ
         k4FOZu6hQ2u7sN9tjAET437f+ZtUZ98fMn1FHMl2Dm0GV+IDoEuuMrFxijncTjhRCAQz
         y7kdd/eFB37iKz5ya0D/FXWeaiR76OYw3BQMZysr/VpNp1gOn+IuBULVJJbNlK+7ZmzY
         wi+D7HuDn9znyhpuV0K4XJrNZjg18anmq7l5hIL9p+CyA5Fox+Dz66cPnXDvTtI7MJyF
         LArQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Z6+OFOqBWRkQmeAydxXNH6u78RoG2oYsGjIkHGOy6oNzUb7z81G2Z1zS9JKMg2qZmmCMiObPOscEbpsD+8irXh5aJLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPzA81MoT7FZsIjaH8pk5AcHdY/Vzg2tLx92HgljRGLAHubbT
	sQsRv4yhqelAqqo7xDRFjnwDGBf+wGZueOUOADmkgdyrddlTV9yRw/Cp
X-Gm-Gg: ATEYQzwoJPsmRrXFbNkwbvvq3UuCJUhDtq3mPbC7wmj3Py03MPlxt0qmn0m810lC0Zw
	pCPFArUfmvL+Z8MojAcJCyC6ZM+UrLUzr76egIXwhew4wCPWoVFn8u56vrnw6HJ7ZspPxX7mlII
	QhVNVvmjNFFGqdKeycH0RnsbWxNvy/MNDYXbRLnT0offETqfB7hg1bisZvxIoRosZnY/sNu9sZJ
	/k4iOENdmIjC/ODkhY8W8L5WdzWXWgKrXcoXTkGbcLyOby7YWvOG2qc1G8JrN+zQ5qytRvaHlFb
	BcyxKYYopVOaYsCImXlbeLfCSChMbcDL3FjPFO35FiZDi5/0zldLGM3f7ohPTdnSGIu2/YSedEN
	UR5X6GCboSdecKeP/1r0Y1yT3yFDEC7MKAwddK5/pAtSKwcOEp71r8tK1pVpPst1B3tFKvGtdXv
	D9GkKzbLF27v59QquaLaHp+IMwk1FcL7/ECPFuEqe6IxNoGXHp
X-Received: by 2002:a05:600c:3550:b0:483:7020:864 with SMTP id 5b1f17b1804b1-4855670b6a9mr195939735e9.25.1773613382704;
        Sun, 15 Mar 2026 15:23:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm820474065e9.10.2026.03.15.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:23:02 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v6 7/9] landlock/selftests: Check that coredump sockets stay unrestricted
Date: Sun, 15 Mar 2026 23:21:48 +0100
Message-ID: <20260315222150.121952-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even when a process is restricted with the new
LANDLOCK_ACCESS_FS_RESOLVE_SOCKET right, the kernel can continue
writing its coredump to the configured coredump socket.

In the test, we create a local server and rewire the system to write
coredumps into it.  We then create a child process within a Landlock
domain where LANDLOCK_ACCESS_FS_RESOLVE_SOCKET is restricted and make
the process crash.  The test uses SO_PEERCRED to check that the
connecting client process is the expected one.

Includes a fix by Mickaël Salaün for setting the EUID to 0 (see [1]).

Link[1]: https://lore.kernel.org/all/20260218.ohth8theu8Yi@digikod.net/
Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 4198148e172f..a12a4b8105d2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/resource.h>
 #include <sys/sendfile.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
@@ -4930,6 +4931,146 @@ TEST_F(scoped_domains, unix_seqpacket_connect_to_child_full)
 #undef USE_SENDTO
 #undef ENFORCE_ALL
 
+static void read_core_pattern(struct __test_metadata *const _metadata,
+			      char *buf, size_t buf_size)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open("/proc/sys/kernel/core_pattern", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	ret = read(fd, buf, buf_size - 1);
+	ASSERT_LE(0, ret);
+	EXPECT_EQ(0, close(fd));
+
+	buf[ret] = '\0';
+}
+
+static void set_core_pattern(struct __test_metadata *const _metadata,
+			     const char *pattern)
+{
+	int fd;
+	size_t len = strlen(pattern);
+
+	/*
+	 * Writing to /proc/sys/kernel/core_pattern requires EUID 0 because
+	 * sysctl_perm() checks that, ignoring capabilities like
+	 * CAP_SYS_ADMIN or CAP_DAC_OVERRIDE.
+	 *
+	 * Switching EUID clears the dumpable flag, which must be restored
+	 * afterwards to allow coredumps.
+	 */
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, seteuid(0));
+	clear_cap(_metadata, CAP_SETUID);
+
+	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open core_pattern for writing: %s",
+		       strerror(errno));
+	}
+
+	ASSERT_EQ(len, write(fd, pattern, len));
+	EXPECT_EQ(0, close(fd));
+
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, seteuid(getuid()));
+	clear_cap(_metadata, CAP_SETUID);
+
+	/* Restore dumpable flag cleared by seteuid(). */
+	ASSERT_EQ(0, prctl(PR_SET_DUMPABLE, 1, 0, 0, 0));
+}
+
+FIXTURE(coredump)
+{
+	char original_core_pattern[256];
+};
+
+FIXTURE_SETUP(coredump)
+{
+	disable_caps(_metadata);
+	read_core_pattern(_metadata, self->original_core_pattern,
+			  sizeof(self->original_core_pattern));
+}
+
+FIXTURE_TEARDOWN_PARENT(coredump)
+{
+	set_core_pattern(_metadata, self->original_core_pattern);
+}
+
+/*
+ * Test that even when a process is restricted with
+ * LANDLOCK_ACCESS_FS_RESOLVE_UNIX, the kernel can still initiate a connection
+ * to the coredump socket on the processes' behalf.
+ */
+TEST_F_FORK(coredump, socket_not_restricted)
+{
+	static const char core_pattern[] = "@/tmp/landlock_coredump_test.sock";
+	const char *const sock_path = core_pattern + 1;
+	int srv_fd, conn_fd, status;
+	pid_t child_pid;
+	struct ucred cred;
+	socklen_t cred_len = sizeof(cred);
+	char buf[4096];
+
+	/* Set up the coredump server socket. */
+	unlink(sock_path);
+	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, sock_path);
+
+	/* Point coredumps at our socket. */
+	set_core_pattern(_metadata, core_pattern);
+
+	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+		.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	});
+
+	/* Fork a child that crashes. */
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		struct rlimit rl = {
+			.rlim_cur = RLIM_INFINITY,
+			.rlim_max = RLIM_INFINITY,
+		};
+
+		ASSERT_EQ(0, setrlimit(RLIMIT_CORE, &rl));
+
+		/* Crash on purpose. */
+		kill(getpid(), SIGSEGV);
+		_exit(1);
+	}
+
+	/*
+	 * Accept the coredump connection.  If Landlock incorrectly denies the
+	 * kernel's coredump connect, accept() will block forever, so the test
+	 * would time out.
+	 */
+	conn_fd = accept(srv_fd, NULL, NULL);
+	ASSERT_LE(0, conn_fd);
+
+	/* Check that the connection came from the crashing child. */
+	ASSERT_EQ(0, getsockopt(conn_fd, SOL_SOCKET, SO_PEERCRED, &cred,
+				&cred_len));
+	EXPECT_EQ(child_pid, cred.pid);
+
+	/* Drain the coredump data so the kernel can finish. */
+	while (read(conn_fd, buf, sizeof(buf)) > 0)
+		;
+
+	EXPECT_EQ(0, close(conn_fd));
+
+	/* Wait for the child and verify it coredumped. */
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	EXPECT_EQ(0, close(srv_fd));
+	EXPECT_EQ(0, unlink(sock_path));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.53.0

