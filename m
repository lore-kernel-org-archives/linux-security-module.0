Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306259;
	b=kePrFmKDlQTskJZqbxHW9VEZB4jL1xF4V2P6pB5IqtRxIn4BWXDoIz224oCrs7jQdAQY
	 qdySESHKY7IRSFpEu4PA5Z5b6ww3jqfYBk5b0aFZ3S4f21J4TyXYK1eRtzaKhjqfnvMAU
	 fnEoM9jCbM6x57oPfJmdMp6gWXjXq+tVhwFFcc5a0UsvZTISImmPtq7s5cH00qDFOBtYu
	 hSwP5rI7sQJ26Xo3JOcvpSyWzjFlhq1WEtqCc3LG1H2vPRL0pjDpd0kSU4J/86CyyTSts
	 c+IMGFo3uU1PbO1sAzwYtTJDZ858peUaDjnj+5Ld7KkjeowjgUMXRVIHndA0pkwVi3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BMccRjjG2ys5i2weNXAJcyIIyGs4aeLhA/js8bhyJM0=;
	b=CfnTYxyqejGMT3ak902FkB67Iq+jTQDE57+2qi4M2oecrOWgw6YS3Q6s0j3B70GI8dsq
	 rIXh+HzjulJ1BvQnIBYDd9zU2eBwAj8NYm3KFNdL9Ua4HFSwLFh1GFgRNKbxxFQm6BMWU
	 sh6QO7Rj3yPRHZ06zQmdGsixWq9nMyPKIiiFKncd/nV6BlUuZHC6rvBXGB1IaHpz4ZuPz
	 5mA0zfGEkT+OZZidVIbxsrr3tsK7s3N9cqvBKVUZOfbpvYFmDuvBQC946Xn4cqcaVv/l4
	 nqdw3WngxBVtWQhcsqAEkaMRGo3J4bwpDEVC7vepkIIxjzsuFyk4apnl9HB/xZ63IYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njZXaJlP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41896606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njZXaJlP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED021F000C0;
	Sun, 22 Nov 2026 00:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306258;
	bh=BMccRjjG2ys5i2weNXAJcyIIyGs4aeLhA/js8bhyJM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njZXaJlPbB+uCzZhGzb/wGsjW0jRUhazaqn2mXXJY0ZxdvzcsE8ypNxPjJzPpM7+3
	 Fs5v/4N57wN3paBQSH0F5xdS9TOyGoP2E7Ed0k8AdNVIQYKzOAl6oEpf//X740eRjR
	 saPF/Vs8WUKcRKcCJli1+SCqPB3RjBs51jIKwi825NI5st62tm2bXzdk/4Td8Qf0m7
	 +C8xsgX/ipIIZsdG2i/293urQ3KvAzpkMXFUsLDIy9xWrh4Vo3rEc0AAbS9qjDfp1k
	 /7ZOXgvu3AwbElCxnhfmrQ2YGLA5tSz27EoCIfD4bceBofMbJ9eHApypawhJPTjCAh
	 I0vMN+P9RqFpQ==
Message-ID: <sashiko-outbox-227551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 16/25] fork: Support CLONE_INTO_ROOTNS in
 clone3()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-17-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-17-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rootns: leaf-only PIDNS_ADDING check returns -ENOMEM on dead
  ancestor pid_ns
--

commit 62f2477b1da0630c69ec1a2d1d679d2b7228b9f8
Author: Jarkko Sakkinen <jarkko@kernel.org>

fork: Support CLONE_INTO_ROOTNS in clone3()

This commit adds CLONE_INTO_ROOTNS and struct clone_args.rootns to allow
clone3() to spawn a child process directly into an initialized or running
root namespace.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index 5ae975604571f..6fb49c20cc2df 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -36,6 +36,7 @@
>  #include <uapi/linux/wait.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/fs_struct.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/rootns.h>
>  #include <linux/sched/signal.h>
> @@ -426,3 +427,142 @@ SYSCALL_DEFINE1(rootns, unsigned int, flags)
>  	return fd;
>  }
> =20
[ ... ]
> +int rootns_prepare_fork(struct kernel_clone_args *args)
> +{
> +	struct file *file __free(fput) =3D fget(args->rootns_fd);
> +	struct path root __free(path_put) =3D {};
> +	struct pid_namespace *pid_ns;
> +	bool bootstrapping =3D false;
> +	struct rootns *rootns;
> +	int ret;
> +
> +	if (!file)
> +		return -EBADF;
> +	if (!is_rootns_file(file))
> +		return -EINVAL;
> +
> +	rootns =3D file->private_data;
> +	if (!ns_capable(rootns->user_ns, CAP_SYS_ADMIN) ||
> +	    !ns_capable(rootns->user_ns, CAP_SYS_CHROOT))
> +		return -EPERM;
> +	if (current_chrooted() && !ns_capable(current_user_ns(), CAP_SYS_CHROOT=
))
> +		return -EPERM;
> +
> +	pid_ns =3D rootns->ns->pid_ns_for_children;
> +	if (!pidns_is_ancestor(pid_ns, task_active_pid_ns(current)))
> +		return -EXDEV;
> +
> +	ret =3D mnt_ns_get_root(rootns->ns->mnt_ns, &root);
> +	if (ret)
> +		return ret;
> +
> +	for (;;) {
> +		bool wait =3D false;
> +
> +		scoped_guard(spinlock, &rootns->lock) {
> +			switch (rootns->state) {
> +			case ROOTNS_INIT:
> +				if (!(READ_ONCE(pid_ns->pid_allocated) & PIDNS_ADDING))
> +					return -ESRCH;
> +				if (READ_ONCE(pid_ns->child_reaper))
> +					return -EBUSY;
> +				WRITE_ONCE(rootns->state, ROOTNS_FORKING);
> +				bootstrapping =3D true;
> +				break;
> +			case ROOTNS_FORKING:
> +				wait =3D true;
> +				break;
> +			case ROOTNS_RUNNING:
> +				if (!(READ_ONCE(pid_ns->pid_allocated) & PIDNS_ADDING))
> +					return -ESRCH;
> +				break;
> +			case ROOTNS_DEAD:
> +				return -ESRCH;
> +			}
> +		}
> +		if (!wait)
> +			break;
> +
> +		ret =3D wait_event_killable(rootns->waitq,
> +					  READ_ONCE(rootns->state) !=3D ROOTNS_FORKING);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	args->rootns_file =3D no_free_ptr(file);
> +	args->rootns =3D rootns;
> +	args->rootns_bootstrapping =3D bootstrapping;
> +	return 0;
> +}
> +
> +int rootns_finish_fork(struct kernel_clone_args *args, struct task_struc=
t *p)
> +{
> +	struct file *file __free(fput) =3D args->rootns_file;
> +	struct rootns *rootns =3D args->rootns;
> +	struct pid_namespace *pid_ns =3D rootns->ns->pid_ns_for_children;
> +	int ret;
> +
> +	args->rootns_file =3D NULL;
> +	args->rootns =3D NULL;
> +	if (!IS_ERR(p)) {
> +		if (args->rootns_bootstrapping)
> +			wake_up_all(&rootns->waitq);
> +		if (current->nsproxy->time_ns !=3D rootns->ns->time_ns)
> +			timens_commit(p, rootns->ns->time_ns);
> +		return 0;
> +	}
> +
> +	ret =3D PTR_ERR(p);
> +	if (args->rootns_bootstrapping) {
> +		scoped_guard(spinlock, &rootns->lock) {
> +			if (rootns->state =3D=3D ROOTNS_FORKING)
> +				WRITE_ONCE(rootns->state, ROOTNS_INIT);
> +		}
> +		wake_up_all(&rootns->waitq);
> +		if (ret =3D=3D -EINVAL && !args->set_tid_size &&
> +		    (READ_ONCE(pid_ns->child_reaper) ||
> +		     (READ_ONCE(pid_ns->pid_allocated) & ~PIDNS_ADDING)))
> +			ret =3D -EBUSY;
> +	}
> +	if ((ret =3D=3D -ENOMEM || ret =3D=3D -EBUSY) &&
> +	    !(READ_ONCE(pid_ns->pid_allocated) & PIDNS_ADDING))
> +		return -ESRCH;
> +
> +	return ret;
> +}

[Severity: Medium]
Can clone3(CLONE_INTO_ROOTNS) return -ENOMEM instead of -ESRCH when an
intermediate ancestor PID namespace is tearing down?

rootns_prepare_fork() allows callers in any ancestor active PID namespace,
but both rootns_prepare_fork() and rootns_finish_fork() only check
PIDNS_ADDING on the leaf pid_ns.  If the target rootns was created inside
an intermediate PID namespace whose init exits while the leaf pid_ns still
has PIDNS_ADDING set (for example, when the nested rootns has not been
bootstrapped yet), rootns_prepare_fork() proceeds into copy_process(),
alloc_pid() fails with -ENOMEM when it walks the ancestor PID namespaces,
and rootns_finish_fork() leaves the error as -ENOMEM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D16
