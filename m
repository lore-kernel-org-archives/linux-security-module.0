Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306260;
	b=gMWS8CRXppem+Ul9IbupwbBEwU9denXRH7YhcoTJCTHNQprRF914W/FNMubcR7O8h+86
	 VXsAV5jjP8p5esb+eW1IjByTMQamQuOWQVQ+i9wGaBrtVFBCKNfUHnlqJM3C5mNTSypjJ
	 eQ3GDmdCz4/5mVXFeObdVtGvg1pbuVjCR24MD169Eh5x2WPWyAqDErqe5wO1+DhyXco4Y
	 soCa6tTnreVhnVMuFRgEWprnd+fawyDBmpsNkIzVDD1Q/ngJs5ec4R3Pq0+I+qDWwtLA+
	 EZrHVWXiKMenP6G28eZn0ZKGnV+SicN01fMLP6fxmM3GlQcQHd3EMkazFgFOK1ln6OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mJnzJ1/4fleHoLG1FgU2nPuff2XTKEAtpi6kFgEvrTI=;
	b=S9zgjfD4QjS6LLRYgW1OXPg+qURwOhzWTI2f4v6tEU9v4Bkwwvt8ZNdiOMKyMwetR6QO
	 Bcu1ovgox21sbW6dPvim7if5C0psub2t3ph3hSnc5gfgKFQG0g4YO9Aj4Sh1AVPAvnQFx
	 WKUemmr5e9VsWvk7YIg0ZSOGqFQq6VK03Iu/kMUAwg1iu27XHcw97y9OTKKiqUNcq4a4Z
	 hXkiZOqS5uDYKqUe0WPF9mmpaqIoeLK92A8czlwe9EotKY+MvPpH/a7reZrEyfP1n0M3q
	 H+LSpccNOdBQ4SiXjwVup4KJvupx/92/+Zh4pqXTwb+AjnoX/QdhPwG1ALx4w6AxPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lytczblw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4B606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lytczblw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4B81F000C4;
	Sun, 22 Nov 2026 00:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306260;
	bh=mJnzJ1/4fleHoLG1FgU2nPuff2XTKEAtpi6kFgEvrTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lytczblw7VPLLPzLQ2VWXouheglnC1Jn8pzaJeH2QnyvHLYUvW1QVfVNNFn7cEhgU
	 nFN5K4Odc9zHnq54Tnz0zs7L6Si0eDV0BvmLti3Xz1EoMqwjO4C+oirtMXgmA7TyA3
	 dOGSDJtKYDhGxuXeKMI++8Lh98qTzlrtLkBksZIFwq7Gl8qQYSkt/tCrX+SJS0lZdL
	 4G4uUwvYUZTed5aQiW+yLhOa+GZNDQ3jeiKyJRAnjvPf/Man5uefi27rffR7jcLIVo
	 vNJ1tZJASO177H4m/nWZxiKxzgl3EqM9nUJYWDIeoxkigKwginxdyMU6kyp2eiuq7K
	 BC3Uhvy1Qnb8Q==
Message-ID: <sashiko-outbox-227552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 17/25] fs: Support FSCONFIG_SET_ROOTNS in
 fsconfig()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-18-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-18-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:59 +0000
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
- [High] fs: incomplete namespace binding validation in
  fsconfig_set_rootns()
- [Medium] fs: stale fsopen() credentials retained in fc->cred by
  fsconfig_set_rootns()
--

commit f8ec195808901fb7269d7229635728d247b672b9
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_ROOTNS in fsconfig()

This commit adds FSCONFIG_SET_ROOTNS and the ->set_rootns() fs_context
operation so callers with CAP_SYS_ADMIN in a target rootns user namespace
can bind a newly opened fs_context to that rootns before supplying mount
parameters.

> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 70024870fefa2..e0d65f6018a7e 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
[ ... ]
> +static int fsconfig_set_rootns(struct fs_context *fc, struct fs_paramete=
r *param)
> +{
[ ... ]
> +	put_net(fc->net_ns);
> +	fc->net_ns =3D get_net(c->ns->net_ns);
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns =3D get_user_ns(user_ns);

[Severity: Medium]
Should fsconfig_set_rootns() also replace fc->cred with get_current_cred()?

alloc_fs_context() sets fc->cred at fsopen() time, when an unprivileged
FS_CONTEXT_AWAITING_NS context has not yet been authorized against any
target namespace.  If the fscontext fd is passed to another task or
credentials change before FSCONFIG_SET_ROOTNS, consumers such as
dentry_open(..., fc->cred) in fsmount() and proc_fill_super()
(fs_info->mounter_cred) will use the fsopen() caller's credentials rather
than the credentials that authorized FSCONFIG_SET_ROOTNS.

> +
> +	fc->rootns_bound =3D true;
> +	fc->rootns_mnt_id =3D c->ns->mnt_ns->ns.ns_id;
> +
> +	ret =3D fc->fs_type->init_fs_context(fc);
> +	if (ret < 0) {
> +		fc->rootns_bound =3D false;
> +		fc->phase =3D FS_CONTEXT_FAILED;
> +		return ret;
> +	}
> +	fc->need_free =3D true;
> +
> +	if (fc->ops->set_rootns) {
> +		ret =3D fc->ops->set_rootns(fc, c);
> +		if (ret < 0) {
> +			fc->rootns_bound =3D false;
> +			fc->phase =3D FS_CONTEXT_FAILED;
> +			return ret;
> +		}
> +	}
> +	if (fc->user_ns !=3D user_ns) {
> +		fc->rootns_bound =3D false;
> +		fc->phase =3D FS_CONTEXT_FAILED;
> +		return -EOPNOTSUPP;
> +	}

[Severity: High]
Is checking fc->user_ns !=3D user_ns enough to verify that the filesystem
supports binding to the target rootns?

binder_fs_type sets FS_USERNS_MOUNT, and binderfs_init_fs_context() neither
changes fc->user_ns nor implements ->set_rootns(), so fsconfig_set_rootns()
succeeds with fc->user_ns set to c->user_ns.  When FSCONFIG_CMD_CREATE then
runs binderfs_fill_super(), it captures the caller's current IPC namespace
instead of c->ns->ipc_ns:

drivers/android/binder/rust_binderfs.c:binderfs_fill_super() {
    ...
	info->ipc_ns =3D get_ipc_ns(current->nsproxy->ipc_ns);
    ...
}

drivers/android/binder/rust_binderfs.c:binderfs_binder_device_create() {
    ...
	bool use_reserve =3D (info->ipc_ns =3D=3D &init_ipc_ns);
    ...
}

An unprivileged caller in init_ipc_ns that binds a binderfs context to an
unprivileged rootns gets a superblock owned by c->user_ns with
info->ipc_ns =3D=3D &init_ipc_ns, allowing it to bypass
BINDERFS_MAX_MINOR_CAPPED and allocate from the minor pool reserved for the
initial IPC namespace.

Similarly, sysfs_init_fs_context() and cgroup_init_fs_context() capture
current's net or cgroup namespace and overwrite fc->user_ns with that
namespace's owning user_ns without implementing ->set_rootns(); if
current's net or cgroup namespace happens to be owned by c->user_ns,
fc->user_ns =3D=3D user_ns holds and the context silently binds to current's
namespace instead of c->ns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D17
