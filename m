Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311827;
	b=w4yC8fH+Jhw4D5zWExdTEd2stMkJ30p4ZUfiTMdYf31cZ7zMl6vn8zYE5ANCx1osmWRb
	 PNW0Hetr17/tnI18kaR+ieu2D3htX/IpiF+6UgkSa8kFmTVbBHKsTeHHj7fkWoTjR0Y29
	 aRpijKBS83LvmHcHnupvE4VrH7uFjViUtQgryjbnRFlxIVPRLdC7CoT4y2RMuuYy9E/v3
	 V9T2NBuLy5NG5Ec/UjnN3KLHp4UeTf36AvF7kNwWWGGOF0gIGF+AeDnbcNblTNUVReMTu
	 no8M47S1vjQWryAH7qbOptNKckFkXZ9HUzynB93LFFqssRzZfr2rf6Dt0VF+dQGmFsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311827;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xcFuD9TGh+7BMax0WCH9B1L1wKwMb5cO3D0UHkJWHqQ=;
	b=ajFjifNG257khmhHQtQxenFpBgcqq+812jcZh5f7mxvULFIT8kwK83dwqeXnqFTelXm2
	 jUxIt4edHhBi/FUEFscNdyBjsfC9QNmfYUo43ZepQQFgPx4tYh1uYAhBWA/kAppC4qtf7
	 oBEBBI0JZeJEd/yfYn9fDOsNK2tIAJIxo/9sP/22ynymzVw9+5g/upRCDiGbs+kbPVatl
	 zihTBQR+dz1DLn71SVJ5pQvChCjKvfGZK27hJBIlsvFjtK0OkcFIDOysBOYG3xsiqRmvG
	 R5qZ447lRlNB82l4IoCAMxyNEQ0ZISne2e1ii33Z/OFiZafGsbVLS/in0TZFXNvh51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLWTIuAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D6606A320;
	Sun, 22 Nov 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLWTIuAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E012D1F000C0;
	Sun, 22 Nov 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311827;
	bh=xcFuD9TGh+7BMax0WCH9B1L1wKwMb5cO3D0UHkJWHqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLWTIuAhQt1tfpWhTGgW1y5jlgcDPw6b7NhvZCIJ4LOL8s++76W2WziW1Q5WPwu50
	 NdinTg0Mwu24toCH2Uph1RpQdf2aK+JRJ/3yPJXDxFI0EiOBaKhX6NIT8wJq0XXSS7
	 C8glbI7Efo/3v2t9ZjFlR2HPKxb0PtJgH6arVy5NPW47dDkLcJuIzGKukmeb0/SYBC
	 9S8lKmVEU00v8Vb0Bf/t2dGOnrcb+3e+ZTheievcuR+Jq7mfDCSblXACon9Z/yHToJ
	 Z7KPFfIlGLtVKWv9DpibvbokRjif2y0tXyTDLa+T+gZWFCut2S00zW3suMzVS5xExf
	 FmudS+V0Qsr9A==
Message-ID: <sashiko-outbox-227629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 17/26] fork: Support CLONE_INTO_USERLAND in
 clone3()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP
 Singh" <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122011809.2667684-18-jarkko@kernel.org>
References: <20261122011809.2667684-1-jarkko@kernel.org>
 <20261122011809.2667684-18-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 01:43:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] userland: missing namespace owner permission check in
  userland_prepare_fork()
- [Medium] userland: missing namespace_install LSM check in
  userland_prepare_fork()
--

commit 705db8da85300ec68db1d2ce6e9711aa2f376bb1
Author: Jarkko Sakkinen <jarkko@kernel.org>

fork: Support CLONE_INTO_USERLAND in clone3()

This commit adds CLONE_INTO_USERLAND and struct clone_args.userland to
allow clone3() to spawn a child process directly into an initialized
userland's namespaces and root mount.

> diff --git a/kernel/userland.c b/kernel/userland.c
> index 739f6b98c1035..283b90869d2c6 100644
> --- a/kernel/userland.c
> +++ b/kernel/userland.c
> @@ -541,3 +542,135 @@ SYSCALL_DEFINE1(userland_open, unsigned int, flags)
> =20
>  	return fd;
>  }
> +

[ ... ]

> +int userland_prepare_fork(struct kernel_clone_args *args)
> +{
> +	struct file *file __free(fput) =3D fget(args->userland_fd);
> +	struct path root __free(path_put) =3D {};
> +	struct pid_namespace *pid_ns;
> +	bool bootstrapping =3D false;
> +	struct userland *userland;
> +	int ret;
> +
> +	if (!file)
> +		return -EBADF;
> +	if (!userland_is_file(file))
> +		return -EINVAL;
> +
> +	userland =3D file->private_data;
> +	if (!ns_capable(userland->user_ns, CAP_SYS_ADMIN) ||
> +	    !ns_capable(userland->user_ns, CAP_SYS_CHROOT))
> +		return -EPERM;

[Severity: Medium]
Should userland_prepare_fork() also invoke security_namespace_install() or
a matching LSM check for the target namespaces in userland->user_ns and
userland->ns?

Landlock enforces LANDLOCK_PERMISSION_NAMESPACE_USE via its
namespace_install hook when entering pre-opened namespaces with setns(),
and commit "security: Add userland LSM hooks" later in this series does
not wire Landlock up to security_userland_clone().  Without an LSM check
on those namespaces, a Landlock-sandboxed task holding a pre-opened
userland fd can use clone3(CLONE_INTO_USERLAND) to enter namespaces that
its Landlock domain denies.

> +	if (current_chrooted() && !ns_capable(current_user_ns(), CAP_SYS_CHROOT=
))
> +		return -EPERM;
> +
> +	pid_ns =3D userland->ns->pid_ns_for_children;
> +	if (!pidns_is_ancestor(pid_ns, task_active_pid_ns(current)))
> +		return -EXDEV;

[Severity: High]
Does userland_prepare_fork() need to verify that current either already
belongs to each namespace in userland->ns or holds CAP_SYS_ADMIN in that
namespace's owning user namespace?

In userland_share_nsfd(), a cgroup, IPC, UTS, network, or time namespace
owned by a more privileged user namespace (such as init_user_ns) can be
attached to userland->ns without CAP_SYS_ADMIN in ns->ops->owner(ns) as
long as the caller is currently in that namespace:

kernel/userland.c:userland_share_nsfd() {
    ...
	if (!ns_capable(c->user_ns, CAP_SYS_ADMIN))
		return -EPERM;
	if (!is_current_namespace(ns) &&
	    !ns_capable(ns->ops->owner(ns), CAP_SYS_ADMIN))
		return -EPERM;
    ...
}

Because userland_prepare_fork() only checks capabilities against
userland->user_ns and current_user_ns() before copy_namespaces() installs
userland->ns on the child, a process that shares a parent or host
namespace into a userland and later isolates itself with unshare() (for
example, unshare(CLONE_NEWNET)) can call clone3(CLONE_INTO_USERLAND) to
spawn a child back into the unisolated namespace without holding
CAP_SYS_ADMIN in its owning user namespace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122011809.2667=
684-1-jarkko@kernel.org?part=3D17
