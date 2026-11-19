Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117025;
	b=jctiJUZzHT7ZUz0QZL50vbq/ZWfnQitD4iTz+PqUvOOxKh2vHKhyX4R+Jk25n9w0JtY5
	 JEQalU8U1eygqJ9Qnvhlk4fjXLLylIXozqXT/q+b3u+kuCG0kSXRXINNmB6c34dE9nt1Z
	 YcZRiV5v+9h+hmKj/U+xdqbTqVUr9CgUmA2reN9Jd71bsZTQBVLvYBydXC/ecp7I5e9x/
	 v8wlorlYBKMv7INAXa3rDn512ZaOLr3qAj17N7A04rm+S28UKzZv/BoKvELNkItsXchAF
	 BLAkgymtZtBnyBPdbf2dW3kCtPIcjidMKpc+5rTST5+GMvRB+9cK9Wkz4au/o9cUVOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j3OHGDRLYJbgj/ErJ8HaxI5UhxRADPxZ13wjmhDTfns=;
	b=KxGoCeKPE8NV2iCXQIczVxb6LYlIRrteEssBkHouyOTNWB7CtLCWEiN+9rsEdz4kKlx8
	 quZbv6P/KX4DP/I2FF8azUaghoYrO9+Ymg0yzScXH7mp6oMG/f5dTQUMyvRL+6qqDS7Un
	 LphJ4CkjKOuh8lKY/4uClb65Z3PepSTxlDka6H9mhtJyGmDgiqPOQazwRhN8cqi7NMBhi
	 JQZ7/G6oT0FP8QBoPPM4tse+0WLrVbog/MYqsrbazxtXHViBo7LAL+Lp5pQEUi5C1K2um
	 ozCYn85gMsQcswVX12hbuwF3z0AdhRhR7kJ3QREI7q49s8lg9twJ53FgYaGVSqDqJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CTP9jal/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6422606A32A
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTP9jal/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B811F000C6;
	Thu, 19 Nov 2026 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117025;
	bh=j3OHGDRLYJbgj/ErJ8HaxI5UhxRADPxZ13wjmhDTfns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTP9jal//bKnwBy4ySVLUylckhZpJ1oQ3RzkBH+MakR00H55hqpxMiM0UMyr2rTjy
	 TPcuKjGT7gdm0mDNHbhwNfHF5fK6x6y0dizYyHP/0YBUVzz8gnV2m9Kr58qkSN/x5Z
	 FpZbxkZm/2FivINqu78yjPSJbHekGGqs2zZrVjLrrQoUFOcL0WQJKDFCnk2oB5MDUT
	 DELNUYxzCICjI+YJf6QDNm/ZouSn/w2qMx9chXaOiNsliTtgPUu63o2atye1YaUtLJ
	 u7yBUphIJvQ35Mt9hI50jjUWoRFtf7HipHsXUomtppwVTjyTqmURVyTL7pFRQnd3Sr
	 /fi/TVAO7R6ow==
Message-ID: <sashiko-outbox-223954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 12/13] selftests/rootns: Add root namespace test
 suite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Lutomirski" <luto@amacapital.net>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Frederic Weisbecker" <frederic@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "John Johansen" <john.johansen@canonical.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Thomas Gleixner" <tglx@kernel.org>, "Valentin
 Schneider" <vschneid@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261118193539.240065-13-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-13-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:37:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/rootns: shared mount propagation in
  move_mount_existing_mntns()
- [Medium] selftests/rootns: missing SKIP() on ENOSYS and silent skips
  in child helpers
- [Low] selftests/rootns: stack direction and lifetime hazard in
  clone_with_flags()
--

commit 101069d69b43912a16a7832bfad97b5398c581ce
Author: Jarkko Sakkinen <jarkko@kernel.org>

selftests/rootns: Add root namespace test suite

This commit adds a kselftest harness suite under
tools/testing/selftests/rootns to verify the root namespace and mount
namespace configuration uAPI and security invariants.

> diff --git a/tools/testing/selftests/rootns/smoke.c b/tools/testing/selft=
ests/rootns/smoke.c
> new file mode 100644
> index 0000000000000..f0e3158ea4bec
> --- /dev/null
> +++ b/tools/testing/selftests/rootns/smoke.c
> @@ -0,0 +1,1934 @@

[ ... ]

> +static int clone_with_flags(int flags)
> +{
> +	const size_t stack_size =3D 64 * 1024;
> +	void *stack;
> +	pid_t pid;
> +	int status;
> +	int ret;
> +
> +	stack =3D malloc(stack_size);
> +	if (!stack)
> +		return -ENOMEM;
> +
> +	pid =3D clone(clone_exit, (char *)stack + stack_size,
> +		    SIGCHLD | flags, NULL);
> +	if (pid < 0)
> +		ret =3D -errno;
> +	else if (waitpid(pid, &status, 0) < 0)
> +		ret =3D -errno;
> +	else if (!WIFEXITED(status) || WEXITSTATUS(status))
> +		ret =3D -EIO;
> +	else
> +		ret =3D 0;
> +
> +	free(stack);
> +	return ret;
> +}

[Severity: Low]
Can passing (char *)stack + stack_size to clone() write past the end of the
heap buffer on architectures where the stack grows upward, such as PA-RISC?
Also, if waitpid() fails (for example on EINTR), free(stack) runs while the
child may still be executing on that stack.  Using sys_clone3() with stack =
=3D 0
and stack_size =3D 0 would avoid manual stack allocation and work regardles=
s of
stack growth direction.

[ ... ]

> +FIXTURE_SETUP(rootns) {
> +	self->cfd =3D create_test_rootns(false, ROOTNS_KILL_ON_CLOSE |
> +				       ROOTNS_CLOSE_ON_EXEC);
> +	if (self->cfd < 0 && geteuid() !=3D 0 &&
> +	    (errno =3D=3D EPERM || errno =3D=3D EACCES || errno =3D=3D EINVAL ||
> +	     errno =3D=3D ENOSPC || errno =3D=3D EOVERFLOW))
> +		SKIP(return, "pre-idmap submount setup requires mapped userns");
> +	ASSERT_GE(self->cfd, 0);
> +}

[Severity: Medium]
Will this fail instead of skipping when CONFIG_ROOTNS is disabled (errno =
=3D=3D
ENOSYS) or when geteuid() =3D=3D 0 hits EPERM, EACCES, or ENOSPC?  Because =
rootns
is added unconditionally to TARGETS in tools/testing/selftests/Makefile whi=
le
CONFIG_ROOTNS defaults to n, running make run_tests on a kernel without
CONFIG_ROOTNS will fail all tests in this binary instead of skipping them.

The same issue applies to TEST(get_nsfd), while TEST_F(rootns, mount_perms)
omits -ENOSPC when checking the return value of create_rootns_as_uid().  In
addition, the forked child helpers in mount_perms, clone_perms, fsconfig, a=
nd
unpriv_no_userns call _exit(0) when unprivileged namespace creation fails
with EPERM, EACCES, EINVAL, or ENOSPC, causing the parent to report a silent
pass instead of a skip with a reason string (and unpriv_no_userns fails with
exit status 4 on ENOSYS).

[ ... ]

> +TEST_F(rootns, move_mount_existing_mntns) {
> +	int ready_pipe[2];
> +	int hold_pipe[2];
> +	char path[64];
> +	int marker_fd;
> +	int mntns_fd;
> +	char ch;
> +	pid_t pid;
> +	int fsfd;
> +	int mfd;
> +
> +	ASSERT_EQ(pipe2(ready_pipe, O_CLOEXEC), 0);
> +	ASSERT_EQ(pipe2(hold_pipe, O_CLOEXEC), 0);
> +
> +	pid =3D fork();
> +	ASSERT_GE(pid, 0);
> +	if (pid =3D=3D 0) {
> +		struct statfs st;
> +
> +		close(self->cfd);
> +		close(ready_pipe[0]);
> +		close(hold_pipe[1]);
> +
> +		if (unshare(CLONE_NEWNS) < 0)
> +			_exit(1);
> +		if (write(ready_pipe[1], "r", 1) !=3D 1)
> +			_exit(2);
> +		close(ready_pipe[1]);
> +
> +		if (read(hold_pipe[0], &ch, 1) !=3D 1)
> +			_exit(3);
> +		close(hold_pipe[0]);
> +
> +		if (statfs("/tmp", &st) < 0)
> +			_exit(4);
> +		if ((unsigned long)st.f_type !=3D (unsigned long)TMPFS_MAGIC)
> +			_exit(5);
> +		if (access("/tmp/hot_mounted", F_OK) < 0)
> +			_exit(6);
> +		_exit(0);
> +	}
> +	close(ready_pipe[1]);
> +	close(hold_pipe[0]);
> +
> +	ASSERT_EQ(read(ready_pipe[0], &ch, 1), 1);
> +	close(ready_pipe[0]);
> +
> +	snprintf(path, sizeof(path), "/proc/%d/ns/mnt", (int)pid);
> +	mntns_fd =3D open(path, O_RDONLY | O_CLOEXEC);
> +	ASSERT_GE(mntns_fd, 0);
> +
> +	fsfd =3D sys_fsopen("tmpfs", 0);
> +	ASSERT_GE(fsfd, 0);
> +	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
> +	mfd =3D sys_fsmount(fsfd, 0, 0);
> +	close(fsfd);
> +	ASSERT_GE(mfd, 0);
> +
> +	marker_fd =3D openat(mfd, "hot_mounted",
> +			   O_CREAT | O_WRONLY | O_CLOEXEC, 0644);
> +	ASSERT_GE(marker_fd, 0);
> +	close(marker_fd);
> +
> +	/* Existing mnt_ns already has "/", so "/" must fail with EBUSY. */
> +	ASSERT_EQ(sys_move_mount(mfd, "", mntns_fd, "/",
> +				 MOVE_MOUNT_F_EMPTY_PATH |
> +				 MOVE_MOUNT_T_MNTNS), -1);
> +	ASSERT_EQ(errno, EBUSY);
> +
> +	/* Hot-mounting onto a relative path inside the live mnt_ns succeeds. */
> +	ASSERT_EQ(sys_move_mount(mfd, "", mntns_fd, "tmp",
> +				 MOVE_MOUNT_F_EMPTY_PATH |
> +				 MOVE_MOUNT_T_MNTNS), 0);

[Severity: Medium]
Does sys_move_mount() here propagate the new tmpfs mount onto /tmp in the
host mount namespace?

Because the child calls unshare(CLONE_NEWNS) without unsharing a user
namespace or remounting "/" with MS_REC | MS_PRIVATE, its mounts stay in the
same shared peer group as the host mount namespace when "/" or "/tmp" is
mounted MS_SHARED (the default on systemd hosts).  Attaching mfd onto "tmp"
in mntns_fd then propagates a peer tmpfs mount onto the host's /tmp that
remains mounted after the child and mntns_fd exit, hiding the host's /tmp
contents.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D12
