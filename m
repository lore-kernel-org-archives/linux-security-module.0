Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181593C278C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285108; cv=none; b=hkX/63ZNafapzNKlZXQn6qCbjTFG9yCF0ZzjbVaf9v6RNff9t2VMkEzMFHUBQwanTLBxdj3dG/nYVBznztTx/zIybS2CWc2boZBhp8J43gEpbxL+JLOtWxgEsvOIw2+uIYZl/vw/wh/nWKT9h3r7oDiDtI9MziAeKEzIvjm2YcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285108; c=relaxed/simple;
	bh=soSjTG95ht7W/sofZ3swr5xdYwxH+YayUkQUqZGq7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=melcAMoWUVrsicO/BRCs/Cyf9606UZ/yMlFTiRcM3BQk6V4YYmC9BWuvLq+s92U3tMwH/U9l+GKMHJWB8iaBa2MLJdnsYaAtP4w5BeOwsUqqz/00/i5xtywLVMAdFRTa5xd7pv6LnZjZkCk1eMToLYmoLVHr/dCjStxaWiyxcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWOd8MJY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWOd8MJY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-487012ce896so2099775e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774285105; x=1774889905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IErThYYEnjWcOyFkuLbJo/2qjPpdzT2BIhU/7PK6OzA=;
        b=qWOd8MJY/pnyKfzJ66Tr4ITf51sQTe/Y3U5dFiuYnh2uFBBCcv7R+O8N/7OZHQ614a
         jBnJ7KrInBK6hNQKJwTCqAZoWf4CUIkMeueVB+9vwuxT7oGKRvACrCyyJ4I9n+0y3e31
         NhoVkG9an5xEfepqpU/s/YbyUkIuJn2JU3J6sGQTEm34WIhTBpt3JCtpB9P+R+/HPEeU
         HbMJyMT7mG3UkcCVpGi569dErgjVE6eW3CQpc4mF+VwGJzbw+XNllwlvE/xf4rhteq96
         iO+TU2NxDa48XTIELZWIcdVfNrGtcw2ssWGJxJseaRs6yScNoLF1zn3ZEzyzFgijma96
         /Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285105; x=1774889905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IErThYYEnjWcOyFkuLbJo/2qjPpdzT2BIhU/7PK6OzA=;
        b=LyLtZPf0ZV3Sx2rC/OB4M1l2FMtJv5Xp3jsGZD+x3Wi4bQalXtA72zdZZuQ3n2I0UN
         oIOT6uU33ZQNf3fCnYbFNjqLZvitj9MusnkAfq4TqnwlFKiUCW3qH5F0sGT67OD6GKSf
         qQj1QQQEmhQ1uDKeO1jhrBsYLaFgSiD7fqHwqhyRexhvejA4GP7EIWwhMngA1Dw3PDsj
         PXAYFUIYziLlAEAHJIHlwPsBdINTMz9QOQURFjS8MA1HuoZ6sfSFKAmIIMODyvFpDnvn
         9m3qEUBExYMl2ceZw/x9RzTHyUIsfbnhrulVnhX0otvWyMqquzGEW/tWdOwKlJcEhGAh
         R5FA==
X-Forwarded-Encrypted: i=1; AJvYcCVGuDc+qr//tWuIOn/ydjXi6InD9WxTPnUzKguuSg1NbWF2wf8yhUxBLk4PUgi/L0OM8sQQQuiXRm+1fP9jmqD2JoNklt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNecGPXwXiDP1ILVLsFpeIV+6jb+v1oTVNlr9791kPXUGwDfHk
	yx6P3nssiRcEEMD9Lp0/6jELR7quVCj+MXrhnGfgW+PUHStmMUueAVGW
X-Gm-Gg: ATEYQzzBtAeUqhKEDAFauiqv5UBdNtNhiNzYr0J9dmzbX+tyDMrDIPhu+utuvCfI+k6
	7u5jvtU12SKM8YKR0eBlta4FCohntzZ96kF2l7uebVAsmWakquxVsuVyiazGzrhbmd3Vky98DEx
	3z3mdoBpQxTNtIEOfO0bZOuhf3fSWWzYovMMvtAOVGNPA31zQ0XNsjJfssheiGqL4m+Vv/KqO2a
	4BSddYxrU7c1sGzHU3NxQiUQn/Z5k7kxn2cTgWrBn04lclIxaCYN6vp1C5lN0jeoQsZrmpjowcb
	Fb0035191ZH1yoLHcWlqIboEFEvzKNSUMmBlXov5fc9yZ/TlsS9aqSaZoiqF4Ht7rHuoLDpbZ5y
	7kWBfBomDMIYQmf6YZjcXBnXtX7Upb2LlVyYqmwPSeKXHCk50T2iA9sumYEO2DiQfTXrctyM56X
	szffwTz0ANP/7WdqaYe0AXSnLM/M4KlAvOv8qQvIxFgeJULBrF
X-Received: by 2002:a05:600c:4fc9:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-486fede7393mr181754435e9.5.1774285105226;
        Mon, 23 Mar 2026 09:58:25 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm33171017f8f.32.2026.03.23.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:24 -0700 (PDT)
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
Subject: [PATCH v7 09/11] selftests/landlock: Check that coredump sockets stay unrestricted
Date: Mon, 23 Mar 2026 17:56:51 +0100
Message-ID: <20260323165654.193957-10-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even when a process is restricted with the new
LANDLOCK_ACCESS_FS_RESOLVE_UNIX right, the kernel can continue writing
its coredump to the configured coredump socket.

In the test, we create a local server and rewire the system to write
coredumps into it.  We then create a child process within a Landlock
domain where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is restricted and make
the process crash.  The test uses SO_PEERCRED to check that the
connecting client process is the expected one.

Includes a fix by Mickaël Salaün for setting the EUID to 0 (see [1]).

Link[1]: https://lore.kernel.org/all/20260218.ohth8theu8Yi@digikod.net/
Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 143 +++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 3dad643741f7..af0f0b16129a 100644
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
@@ -4928,6 +4929,148 @@ TEST_F(scoped_domains, unix_seqpacket_connect_to_child_full)
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
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+			   });
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

