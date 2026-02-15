Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E782D9EC4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152765; cv=none; b=sMJS6p2PF3xJOugoLfUZB0x1BnXHk8vxTxkAsGy74u+gLnZaEwhhIQeBK54LRefoIX5ziTuex7zZvBnjOvIgutMMSgthLnm2N1KPsVzjERPM6wIRlnPP+m+iWzWELXv8Ndr0wx187ch29CfOiBtcuP6Cej/qiDJg0gM7prNYBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152765; c=relaxed/simple;
	bh=VoJLROArgo1mDAQYMBGHlo1q+cSULwXrFiI11nqHdsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I81uf3Zx5SK0sYim5nqPCgnxnpSCHi2CVlyKw8mfgjd+ZXH5JEHgawm7YtdMIlERVrdlVZGf9Ngov4JIcNCzJriICzGF7kWQyHnbOkURq3uIxocEg13eswd3sT/8CNzEPEgFCtYBFMjqIHHCRA/YxXUnkD2Byc30/1GhEI+WDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu23bvbX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu23bvbX"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a316d89so1981869f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152762; x=1771757562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nl1s4UrAwcbU7KE2I26tgLYMcp2clfnUf+iOwSsMsio=;
        b=Mu23bvbXyNkcjcS5sqN6bZmWOTpEThuD8+dZvf6IpsMkx9VVxXna97Etm/3I8E7ook
         DKIyxrlakUqBn+zv20xCxec4bET0a2yXnUn/23NYKkI5Nv0DTYXBFKTyFOiTVkuJvhYb
         wm+/GxlVgCiWlH+Yyj0c0mymRIkNgClmp8fttUbzR2cvT6iJcKeMMjT/yx4YxhN5UiNh
         BR212/cKs9jimQIGgsnyQcGUESlUAAtcw2txXzNcXiPIoBycwZMJwCEJhpF4W6q8e9Kx
         5p08tV0Z1cXL99NzzW8uPzCsnwf6JSLE9AhpTVuXFklTk+TW/ZNPwHU700pUtcNbCvh4
         5FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152762; x=1771757562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nl1s4UrAwcbU7KE2I26tgLYMcp2clfnUf+iOwSsMsio=;
        b=NMR8bBjCwBc406GaT60BkiHdD0btGw7vyqAS96wmOzs42yMILPPfa+YUwtP13DeXO7
         fNjygowppRZgXM2L7LV4r9KbVgW+ONCMF53ZY9Kxxbq4QgYoNDAFv8KW3CBC6yVblL25
         XuRDACbJZKRg9xXxtgSxTJZwHruEQpYUOnC0B4xwSORK8+MgKDLT6vHoh5H9t0QxK34/
         9mhyWhH3pTEn/sAj9MO0kZ9Ti00d0nKoG2d5MRaiZk1JjoVB+vP65RgbfMuIvb3u8kLi
         uIyR3enxzR/pLE7BgNpbYoOEiGm3MNiL1eZLsyyMZQZ1LuotAxpsvvuK6FIR/3LI5JKB
         lnSA==
X-Forwarded-Encrypted: i=1; AJvYcCXNTmgYqSHjEs7psO70Vuljv+NpeNWHwhydL8QiZ3ZDqwXF5B7sGYkN2WYivG2/H+vOmQCXm0Kc8ZIyPA5gM3tCPGL2ykw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HCxIoc0o+PGU1HGCQmm6vGssnObkhnfu+kpRwPeuOZ9ZQEYy
	SVmn3Sy1+r0zPcy06hm3AhHoYFTkEC+FsC7EiOmrzV4TVjnF7wHTYBLE
X-Gm-Gg: AZuq6aK8rYKB88vFy4MZdabECjYn2jraGbjdGuKHUlQw441UA656PSH+5oqdRyNraHR
	FgP0oQ87vHXDTyWoIImaG/qiibHsAk1lUdjYemfyPv4hU1j5IyZphtBf3sc5ey1aMjKr355dUrB
	MtuZD2qCwI5y3/uYZJIJsmPNNZhNtAUAUAwzZhu3clyaR64SZXK47yzfPx+sqKBWcDfotdJQlaR
	bwZPtM0pnQQj81Drc2wxyGg/n3TnKlHV08sqZunpJQ6IasuvknrITcxAG17OQXK92bQE/CkmKDA
	43G5uWb0MfFHrC0n39FmK7AY42qL0Z3NmSelEGiNCJFpWRkB+i0h6Jnv/ORazBvtlQPEgDcDE9M
	oNz6TCrwRTSobIw+w2CbzXH9shcUYHclyGh6iMnIjuKTOWs7yMPFtiGwYSF9Sn3tC5L0HpBcqYs
	MLXaEnuEmjkm5MW5qoU7xWD6nH0kX9n3H19kyTm2v4gFCuuOtO
X-Received: by 2002:a05:6000:1acf:b0:437:8fc0:87e1 with SMTP id ffacd0b85a97d-437979597c6mr13715501f8f.62.1771152762027;
        Sun, 15 Feb 2026 02:52:42 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm19691211f8f.23.2026.02.15.02.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:41 -0800 (PST)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 6/9] landlock/selftests: Check that coredump sockets stay unrestricted
Date: Sun, 15 Feb 2026 11:51:54 +0100
Message-ID: <20260215105158.28132-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
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

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 8fa9d7c49ac3..705d8a13d2e0 100644
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
@@ -4922,6 +4923,127 @@ TEST_F(scoped_domains, unix_seqpacket_connect_to_child_full)
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
+	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	ASSERT_EQ(len, write(fd, pattern, len));
+	EXPECT_EQ(0, close(fd));
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
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	set_core_pattern(_metadata, self->original_core_pattern);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
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
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	set_core_pattern(_metadata, core_pattern);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
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
2.52.0

