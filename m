Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B12F39A1
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445164; cv=none; b=C5RZSFzWth22ncuK4hoTyk/Q03ZwlyjPpao4pA0XBg1ZrukUGFoMyv+xc2Hah8zFSQHu7d2N1W4niNP3Syi8efyD+Zx/x2BMbL+k9ZUrIYQzPxkBb8pqi8aRHvfUEtv94XFtw7ZmgIW31MvHozup2iQxyB6bFt7yjjajFG+qtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445164; c=relaxed/simple;
	bh=H6fsDxRe2dAxvUTpHuKtMK28p97hK9sXFXCbSRnb2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDZNgfLP6NLiaivcSYn2xWbEsxz8JbU2Lk7stF0zt832oRpql0x3cBIDbz/W8Jc5rcvi1llwfpaSnEHtlo8EvcXqdRW7UwfjIFGLJoB+vE/cqt5Dptvl6blOuNq8/1mFE+oQZph4DelubdcShAtA41X/S3UwHl0wVVAzfbc7sjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xEVN1TfR; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xEVN1TfR"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGSDv5jTCzjV0;
	Wed, 18 Feb 2026 21:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771445151;
	bh=/hJ7CZ9L29pzTlm8j5C5ZKut4Tr3GLdiwSl1kSPNMb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xEVN1TfRwBGyi3erL994zElGfFjQCmgJRPjkWkwGH1YyIS42E2MCj+sQqiYpEHCOJ
	 h7yMbkozOuVAp+s6jUgaIwEdujZbE7n7PSoxPx5PQepRH85ehsJVurObM8/vT1q21o
	 vCmmkcBDhR4vGHSNZo7p+6TZkyasaPPqY0p+BM70=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGSDt5pzQzbj0;
	Wed, 18 Feb 2026 21:05:50 +0100 (CET)
Date: Wed, 18 Feb 2026 21:05:46 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 6/9] landlock/selftests: Check that coredump sockets
 stay unrestricted
Message-ID: <20260218.ohth8theu8Yi@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-7-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-7-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:54AM +0100, Günther Noack wrote:
> Even when a process is restricted with the new
> LANDLOCK_ACCESS_FS_RESOLVE_SOCKET right, the kernel can continue
> writing its coredump to the configured coredump socket.
> 
> In the test, we create a local server and rewire the system to write
> coredumps into it.  We then create a child process within a Landlock
> domain where LANDLOCK_ACCESS_FS_RESOLVE_SOCKET is restricted and make
> the process crash.  The test uses SO_PEERCRED to check that the
> connecting client process is the expected one.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 8fa9d7c49ac3..705d8a13d2e0 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -22,6 +22,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
> +#include <sys/resource.h>
>  #include <sys/sendfile.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> @@ -4922,6 +4923,127 @@ TEST_F(scoped_domains, unix_seqpacket_connect_to_child_full)
>  #undef USE_SENDTO
>  #undef ENFORCE_ALL
>  
> +static void read_core_pattern(struct __test_metadata *const _metadata,
> +			      char *buf, size_t buf_size)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd = open("/proc/sys/kernel/core_pattern", O_RDONLY | O_CLOEXEC);
> +	ASSERT_LE(0, fd);
> +
> +	ret = read(fd, buf, buf_size - 1);
> +	ASSERT_LE(0, ret);
> +	EXPECT_EQ(0, close(fd));
> +
> +	buf[ret] = '\0';
> +}
> +
> +static void set_core_pattern(struct __test_metadata *const _metadata,
> +			     const char *pattern)
> +{
> +	int fd;
> +	size_t len = strlen(pattern);
> +
> +	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, fd);
> +
> +	ASSERT_EQ(len, write(fd, pattern, len));
> +	EXPECT_EQ(0, close(fd));
> +}

I had to fix this helper to make it work with check-linux.sh:

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index ae32513fb54b..64887d34079a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4659,11 +4659,34 @@ static void set_core_pattern(struct __test_metadata *const _metadata,
 	int fd;
 	size_t len = strlen(pattern);
 
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
 	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
-	ASSERT_LE(0, fd);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open core_pattern for writing: %s",
+		       strerror(errno));
+	}
 
 	ASSERT_EQ(len, write(fd, pattern, len));
 	EXPECT_EQ(0, close(fd));
+
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, seteuid(getuid()));
+	clear_cap(_metadata, CAP_SETUID);
+
+	/* Restore dumpable flag cleared by seteuid(). */
+	ASSERT_EQ(0, prctl(PR_SET_DUMPABLE, 1 , 0, 0, 0));
 }
 
 FIXTURE(coredump)
@@ -4680,9 +4703,7 @@ FIXTURE_SETUP(coredump)
 
 FIXTURE_TEARDOWN_PARENT(coredump)
 {
-	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_core_pattern(_metadata, self->original_core_pattern);
-	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
 /*
@@ -4705,9 +4726,7 @@ TEST_F_FORK(coredump, socket_not_restricted)
 	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, sock_path);
 
 	/* Point coredumps at our socket. */
-	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_core_pattern(_metadata, core_pattern);
-	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);


Please run tests in this (minimal) environment.

> +
> +FIXTURE(coredump)
> +{
> +	char original_core_pattern[256];
> +};
> +
> +FIXTURE_SETUP(coredump)
> +{
> +	disable_caps(_metadata);
> +	read_core_pattern(_metadata, self->original_core_pattern,
> +			  sizeof(self->original_core_pattern));
> +}
> +
> +FIXTURE_TEARDOWN_PARENT(coredump)
> +{
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	set_core_pattern(_metadata, self->original_core_pattern);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +/*
> + * Test that even when a process is restricted with
> + * LANDLOCK_ACCESS_FS_RESOLVE_UNIX, the kernel can still initiate a connection
> + * to the coredump socket on the processes' behalf.
> + */
> +TEST_F_FORK(coredump, socket_not_restricted)
> +{
> +	static const char core_pattern[] = "@/tmp/landlock_coredump_test.sock";
> +	const char *const sock_path = core_pattern + 1;
> +	int srv_fd, conn_fd, status;
> +	pid_t child_pid;
> +	struct ucred cred;
> +	socklen_t cred_len = sizeof(cred);
> +	char buf[4096];
> +
> +	/* Set up the coredump server socket. */
> +	unlink(sock_path);
> +	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, sock_path);
> +
> +	/* Point coredumps at our socket. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	set_core_pattern(_metadata, core_pattern);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
> +	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	});
> +
> +	/* Fork a child that crashes. */
> +	child_pid = fork();
> +	ASSERT_LE(0, child_pid);
> +	if (child_pid == 0) {
> +		struct rlimit rl = {
> +			.rlim_cur = RLIM_INFINITY,
> +			.rlim_max = RLIM_INFINITY,
> +		};
> +
> +		ASSERT_EQ(0, setrlimit(RLIMIT_CORE, &rl));
> +
> +		/* Crash on purpose. */
> +		kill(getpid(), SIGSEGV);
> +		_exit(1);
> +	}
> +
> +	/*
> +	 * Accept the coredump connection.  If Landlock incorrectly denies the
> +	 * kernel's coredump connect, accept() will block forever, so the test
> +	 * would time out.
> +	 */
> +	conn_fd = accept(srv_fd, NULL, NULL);
> +	ASSERT_LE(0, conn_fd);
> +
> +	/* Check that the connection came from the crashing child. */
> +	ASSERT_EQ(0, getsockopt(conn_fd, SOL_SOCKET, SO_PEERCRED, &cred,
> +				&cred_len));
> +	EXPECT_EQ(child_pid, cred.pid);
> +
> +	/* Drain the coredump data so the kernel can finish. */
> +	while (read(conn_fd, buf, sizeof(buf)) > 0)
> +		;
> +
> +	EXPECT_EQ(0, close(conn_fd));
> +
> +	/* Wait for the child and verify it coredumped. */
> +	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
> +	ASSERT_TRUE(WIFSIGNALED(status));
> +	ASSERT_TRUE(WCOREDUMP(status));
> +
> +	EXPECT_EQ(0, close(srv_fd));
> +	EXPECT_EQ(0, unlink(sock_path));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.52.0
> 
> 
