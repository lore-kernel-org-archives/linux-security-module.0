Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177191;
	b=p1HVdGHZ/BAElzvNwIXU6UrWHGHzejF7b/jRomoh/zaY0TWt0J4lF8akXjncdsfyRU/Z
	 DUzSXRer0RiySLCzvRtyeBtFHvXwUO8TZCqZIzrPEjV7Tt98dQRtvBin9wN6V0FZQX0Pl
	 LQJ9qliqopccDac+2vCSniCTxV+T1iWY0CEZiPpD7560lnDxLVHkV3tz7ZT6hBP3WQpty
	 YIxtDxibysnN4beavyZvLY4C33UkJEWIsj/RL+kT70y5fPH6NJcmY1AECFrrmRYZyPXWn
	 95RoEQ0nYcIKwCqcMhALdrwm17qxurT/XqyJuhvqFR9WAFZeGUgabsneU3pz/0zdUPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=syKKADMyplobMGqibHGWdeKiAGGflNX1cl1V6TROdFw=;
	b=IG03HGCLWkwceadLocRqzdng8Qk4KDLr3EQwClNBEdQt9TNnG1tJoYO2tOsPu+Axm5Zw
	 uFsJE8XS9hfggNnEiOfD4RxeBL9rONvbnYyP4fdpjkM06krDNDb4gLvGeTjLO6d2jjkiO
	 iKoK5Jofb87RO655ByDZ4IsiJBTxjjo4rfvlSWdAIsxPM3yqp9D5A4Mkgc8mPTFfrDQSa
	 2FE6zoLO/oO7W4TXvgC72VLsGfQQ0RvV35UUwR+QtgMOUDz5YzDnw1k65xOH0/B8HmWc1
	 HDnTMKicHXXiEDUqQJCSDq7Pq6UneA9f6pEarxB10KdRRbiJpUaRjCHPwGvoT7oseLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fD/NaCGx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDB606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fD/NaCGx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABB11F01829;
	Wed, 28 Oct 2026 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177190;
	bh=syKKADMyplobMGqibHGWdeKiAGGflNX1cl1V6TROdFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fD/NaCGx3WGLV5YPrnhnhPw4oumIuUUD8dINqujH4Jy2qdXlP+A49qI0xl71OwtOJ
	 g5SmXjS/G5OpZmtOgwEgHqm89XgzYNMZyCA4W+l0Mbmo4zsp3wcuJJ5n2ig7tqPoUb
	 JURNu2WYtycwGEc3w0Xpb1SPRMyFEkACmF62e38UnrXOTUXTSihGVE4En2YXgtvr2Z
	 aT0mES8wpgN4HJGcZhjPWDGISXH1rh9+Zl5MhGA6W1gJKgMT6diqcIyDyYbMuKIg4p
	 QpsasePUWTEC53/eQ/okzQ13923ZCX8FUIorOpTu03ynMNcgAeecHiewdm24YV/N3u
	 HTyvQ2K3vqLEA==
Message-ID: <sashiko-outbox-187635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] pidfd: Add task path ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Linxuan" <me@black-desk.cn>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "John Johansen" <john.johansen@canonical.com>, "Georgia
 Garcia" <georgia.garcia@canonical.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-mm@kvack.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
In-Reply-To: <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
 <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 08:46:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pidfd: missing d_weak_revalidate() check in pidfd_ioctl() task p=
ath opens
--

commit ce70068de308fcb3a1353124233724116074eb7b
Author: Chen Linxuan <me@black-desk.cn>

pidfd: Add task path ioctls

This commit adds the PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT ioctls
to return close-on-exec O_PATH file descriptors referencing a target task's
executable, current working directory, and root directory.

> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index b70ec50f64da9..1e5b0dcb99756 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c

[ ... ]

> @@ -707,6 +733,18 @@ static long pidfd_ioctl(struct file *file, unsigned =
int cmd, unsigned long arg)
>  	if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
>  		return pidfd_info(file, cmd, arg);
> =20
> +	switch (cmd) {
> +	case PIDFD_GET_EXE:
> +	case PIDFD_GET_CWD:
> +	case PIDFD_GET_ROOT:
> +		error =3D pidfd_get_task_path(pidfd_pid(file), cmd, arg, &path);
> +		if (error)
> +			return error;
> +
> +		return FD_ADD(O_CLOEXEC,
> +			      dentry_open(&path, O_PATH, current_cred()));
> +	}

[Severity: Medium]
Should pidfd_ioctl() check DCACHE_OP_WEAK_REVALIDATE and invoke
d_weak_revalidate() on path.dentry before calling dentry_open()?

When a task's root, cwd, or exe is opened through /proc/<pid>/{root,cwd,exe=
},
proc_pid_get_link() jumps to the target path via nd_jump_link(), setting
ND_JUMPED in struct nameidata. Before do_o_path() calls vfs_open(),
path_lookupat() calls complete_walk() in fs/namei.c:

	if (likely(!(nd->state & ND_JUMPED)))
		return 0;

	if (likely(!(dentry->d_flags & DCACHE_OP_WEAK_REVALIDATE)))
		return 0;

	status =3D dentry->d_op->d_weak_revalidate(dentry, nd->flags);

Because pidfd_ioctl() passes &path directly to
dentry_open() -> vfs_open() -> do_dentry_open() with O_PATH,
d_weak_revalidate() is never called.

In particular, failfs relies on failfs_d_weak_revalidate() in fs/failfs.c to
prevent a task's root or cwd in failfs from being opened with O_PATH:

static int failfs_d_weak_revalidate(struct dentry *dentry, unsigned int fla=
gs)
{
	/*
	 * The root is only ever reached as a path-walk terminal by jumping
	 * to it: as "/" when it is the caller's root, or through a
	 * /proc/<pid>/{root,cwd} magic link. ->permission() already fails
	 * every walk of a component, but a jump lands on the root without
	 * one. Refuse here too so the root cannot be pinned by an O_PATH
	 * open or encoded into a file handle.
	 */
	return -EOPNOTSUPP;
}

If a task sets its working directory or root to failfs via
fchdir(FD_FAILFS_ROOT) or fchroot(FD_FAILFS_ROOT, 0), calling
ioctl(pidfd, PIDFD_GET_CWD, 0) or ioctl(pidfd, PIDFD_GET_ROOT, 0) bypasses
failfs_d_weak_revalidate() and returns an O_PATH file descriptor pinning
failfs_root_path, in addition to skipping weak revalidation on filesystems
such as NFS, 9p, and overlayfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-pidfd-get-=
paths-v4-0-e2a6a47e3c95@black-desk.cn?part=3D3
