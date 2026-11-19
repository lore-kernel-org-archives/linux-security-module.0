Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117019;
	b=gYvtVFaxNqno1od5rb4loEoRO1pxy8ohF58GGvYh2oNR9HeBrlDX3Tc52QysFAk9tHCG
	 C8d/qCy2ml+bHRSFEz4yt8WaiSmaD+A+MJIlcYm29WPbFR8PSyVlFxABTyizsreHdAOcc
	 9X0273HTTHAM0zylryebn+YOLkoImTiPUcsOA1vwIhngMUrbQspUZ75TApLXLyN1uwdoz
	 XYz8xyrdLLtYTJR+EnuqIFPBz7kzJjCyIBH7ugy/B7X5CnKz2X24IjyzjL7LgQh0H1cz6
	 vUjcUPRFdsVyEbFl/+uCtepanIaRmzctulg8lFEtdXPAOSIY6lbGZuxPyx768oY2lsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y/YfY+oC3S5zb54LFhSRV/k0YjNqqBJZ3NHGLIHdrTg=;
	b=cIvCRnFDJ75OUIhMbzrM2czwoqQzCM+O0RHQKD0p2ANm433IEUWCL236HSS3duc5fIk1
	 We0359oO4w1RfDkSl7Tz8zVrERZOjy3JgEVjMH6cSvqAoSyBtNEKw3KOA/mu+2RzGL5hl
	 tXgvpC9CVk+NT1I+EkpXecIJfRNKh62LOVRhOplVgxfo1KSm+NoAIZkKjN+Ag01kQQhrE
	 Rug0FhWXYsPmZyOuBwHFssSdC8teE4LUVwtgVivEgKUHa0prs8j3CvyYVxha6kEa+UHGV
	 O1Ci0jhRgGcDSWcS3Me2lLjBF/Cs26F8Mg/O7VKVV1l5B2NBups5PoM1mbmGBxKlIGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XnQRPm/F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42B606A320
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnQRPm/F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2F21F000C4;
	Thu, 19 Nov 2026 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117019;
	bh=y/YfY+oC3S5zb54LFhSRV/k0YjNqqBJZ3NHGLIHdrTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnQRPm/F8fnWyHXEJtIk/x41MLHaek0uoWoOBQVBzT6XYjx455oOtd96NJYFUrIWY
	 huLeW7QfxayBwGqbeYDyeF+dbeu6Hi1JIJWxT5SoJ4XkIpvjg49ooy1mkG7xHyjgaC
	 IjSW3Pmr7mOujPocZiK1a3EqCG+seY8966m6/bFyQvaZpE9YyD6eK5BKpq8pxazxrJ
	 8pPTtkkHaaf+D67z5Ryvrx3Bhh51LYk9CsC3JVUmamJPqcOnHT+dw4ZxVzozFVAjpQ
	 4j7z94MFhB2YyRh8kVzwszxM+xDR+Yx2m+aV2rNczlBqYgD/QwyL42dOBVnieK4jPS
	 8H7FUwATL7KbA==
Message-ID: <sashiko-outbox-223950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 08/13] fs: Support FSCONFIG_SET_ROOTNS in
 fsconfig()
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
In-Reply-To: <20261118193539.240065-9-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] fs: unprivileged devpts mount via fsconfig_set_rootns()
  bypasses pty_reserve
- [High] fs: alloc_mnt_ns(fc->user_ns) in fsmount() breaks submount
  MNT_LOCKED
- [Medium] fs: missing FS_CONTEXT_FAILED transition on set_rootns()
  error
- [Medium] fs: fsconfig_set_rootns() loses cpuset context state on
  re-init
- [Medium] fs: may_mount() in fsmount() bypasses fc->user_ns capability
  check
- [Low] fs: missing @init kernel-doc entry in alloc_fs_context()
--

commit fada980b534067d9740aa79ea2751dbe127d6be7
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_ROOTNS in fsconfig()

This commit adds FSCONFIG_SET_ROOTNS to bind a newly opened fs_context to
a target rootns before supplying parameters, allowing unprivileged callers
to open FS_USERNS_MOUNT contexts and configure mounts for a rootns where
they hold CAP_SYS_ADMIN.

> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index a50584df97bea..542dede2f8643 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -259,7 +259,8 @@ static struct fs_context *alloc_fs_context(struct fil=
e_system_type *fs_type,
>  				      struct dentry *reference,
>  				      unsigned int sb_flags,
>  				      unsigned int sb_flags_mask,
> -				      enum fs_context_purpose purpose)
> +				      enum fs_context_purpose purpose,
> +				      bool init)
>  {

[Severity: Low]
The kernel-doc comment above alloc_fs_context() is missing an @init entry
for the new parameter.

[ ... ]

> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 70024870fefa2..3e36270baadb3 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -41,6 +46,76 @@ static inline const char *fetch_message_locked(struct =
fc_log *log, size_t len,
>  	return p;
>  }
> =20
> +/**
> + * DOC: FSCONFIG_SET_ROOTNS
> + *
> + * ``fsconfig(fsfd, FSCONFIG_SET_ROOTNS, NULL, NULL, rootnsfd)`` binds a=
 newly
> + * opened filesystem context to ``rootnsfd`` once before any parameters =
are
> + * supplied (subsequent calls fail with ``-EBUSY``).
> + *
> + * The caller must hold ``CAP_SYS_ADMIN`` in the target ``rootns`` user
> + * namespace, allowing unprivileged callers to configure ``FS_USERNS_MOU=
NT``
> + * filesystems without entering the user namespace first.
> + *
> + * The context is initialized against the ``rootns`` network namespace,
> + * ``fc->user_ns`` is delegated to the ``rootns`` user namespace for
> + * ``FS_USERNS_MOUNT`` and ``FS_USERNS_DELEGATABLE`` filesystems when the
> + * mounter ``fsuid``/``fsgid`` map into it or the caller lacks
> + * ``CAP_SYS_ADMIN`` in its own user namespace, and ``proc`` and ``mqueu=
e``
> + * contexts bind to the target ``rootns`` PID and IPC namespaces.
> + */
> +static int fsconfig_set_rootns(struct fs_context *fc, struct fs_paramete=
r *param)
> +{
> +	struct user_namespace *user_ns;
> +	struct rootns *c;
> +	int ret;
> +
> +	if (!is_rootns_file(param->file))
> +		return -EINVAL;
> +
> +	c =3D param->file->private_data;
> +	user_ns =3D c->user_ns;
> +	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (fc->need_free && fc->ops && fc->ops->free)
> +		fc->ops->free(fc);
> +	fc->need_free =3D false;
> +	fc->fs_private =3D NULL;
> +	fc->s_fs_info =3D NULL;
> +	fc->ops =3D NULL;
> +	fc->sb_flags =3D 0;
> +	fc->global =3D false;
> +	security_free_mnt_opts(&fc->security);
> +
> +	put_net(fc->net_ns);
> +	fc->net_ns =3D get_net(c->ns->net_ns);
> +	put_user_ns(fc->user_ns);
> +	if ((fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))=
 &&
> +	    ((kuid_has_mapping(user_ns, fc->cred->fsuid) &&
> +	      kgid_has_mapping(user_ns, fc->cred->fsgid)) ||
> +	     !ns_capable(fc->cred->user_ns, CAP_SYS_ADMIN)))
> +		fc->user_ns =3D get_user_ns(user_ns);
> +	else
> +		fc->user_ns =3D get_user_ns(fc->cred->user_ns);
> +
> +	ret =3D fc->fs_type->init_fs_context(fc);

[Severity: Medium]
Does re-calling fc->fs_type->init_fs_context(fc) here lose the cpuset
configuration when fsopen("cpuset", 0) was opened by a caller with
may_mount() =3D=3D true?

During the initial fs_context_for_mount() in fsopen(),
cpuset_init_fs_context() configures cpuset_fs_context_ops,
ctx->subsys_mask, and CGRP_ROOT_NOPREFIX, and then replaces fc->fs_type
with &cgroup_fs_type:

kernel/cgroup/cgroup.c:cpuset_init_fs_context() {
    ...
	get_filesystem(&cgroup_fs_type);
	put_filesystem(fc->fs_type);
	fc->fs_type =3D &cgroup_fs_type;
    ...
}

When fsconfig_set_rootns() frees the initial context and calls
fc->fs_type->init_fs_context(fc) again, it invokes
cgroup_init_fs_context() instead of cpuset_init_fs_context(), leaving
ctx->subsys_mask as 0 and fc->ops as &cgroup1_fs_context_ops so cpuset
parameter parsing or superblock creation fails.

> +	if (ret < 0) {
> +		fc->phase =3D FS_CONTEXT_FAILED;
> +		return ret;
> +	}
> +	fc->need_free =3D true;
> +
> +	if (fc->ops->set_rootns) {
> +		ret =3D fc->ops->set_rootns(fc, c);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
Should fc->phase be set to FS_CONTEXT_FAILED when fc->ops->set_rootns()
fails?

By the time set_rootns() runs, the prior filesystem-private state has been
freed, fc->net_ns and fc->user_ns have been overwritten, and
init_fs_context() has re-run in the fsconfig() caller's task context.  If
proc_set_rootns() returns -EINVAL, leaving fc->phase in
FS_CONTEXT_CREATE_NS (or FS_CONTEXT_AWAITING_NS) with fc->rootns_bound
still false leaves a partially mutated context usable for subsequent
parameter parsing, superblock creation, or repeated FSCONFIG_SET_ROOTNS
calls.

[ ... ]

> @@ -137,17 +214,23 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_na=
me, unsigned int, flags)
> =20
>  	audit_log_fsopen(fs_name);
> =20
> -	fs_type =3D get_fs_type(fs_name);
> +	fs_type =3D priv ? get_fs_type(fs_name) : get_fs_type_noload(fs_name);
>  	kfree(fs_name);
>  	if (!fs_type)
> -		return -ENODEV;
> +		return priv ? -ENODEV : -EPERM;
> =20
> -	fc =3D fs_context_for_mount(fs_type, 0);
> +	if (!priv && !(fs_type->fs_flags & FS_USERNS_MOUNT)) {
> +		put_filesystem(fs_type);
> +		return -EPERM;
> +	}
> +
> +	fc =3D priv ? fs_context_for_mount(fs_type, 0) :
> +		    fs_context_for_unpriv_mount(fs_type);

[Severity: High]
Does allowing an unprivileged caller in the initial mount namespace to
open and configure a devpts context via FSCONFIG_SET_ROOTNS bypass
pty_reserve?

devpts has FS_USERNS_MOUNT set, and devpts_init_fs_context() grants access
to the reserved PTY pool solely based on whether current is in the initial
mount namespace:

fs/devpts/inode.c:devpts_init_fs_context() {
    ...
	if (fc->purpose =3D=3D FS_CONTEXT_FOR_MOUNT &&
	    current->nsproxy->mnt_ns =3D=3D init_task.nsproxy->mnt_ns)
		fsi->mount_opts.reserve =3D true;
    ...
}

Previously, fsopen() required may_mount(), forcing unprivileged callers to
unshare a mount namespace first.  With this regression, an unprivileged
user in init_task.nsproxy->mnt_ns can open devpts, bind it to a userns via
FSCONFIG_SET_ROOTNS (which runs devpts_init_fs_context() while still in
the initial mount namespace, setting fsi->mount_opts.reserve =3D true), and
allocate PTYs from the host emergency reserve up to pty_limit.

[ ... ]

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 781380945d784..a6c0a31e275ae 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4658,6 +4659,16 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int,=
 flags,
>  	if (ret)
>  		return ret;
> =20
> +	if (!(flags & FSMOUNT_NAMESPACE)) {
> +		if (fc->rootns_bound) {
> +			if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN) &&
> +			    !may_mount())
> +				return -EPERM;
> +		} else if (!may_mount()) {
> +			return -EPERM;
> +		}
> +	}

[Severity: Medium]
When fc->rootns_bound is true, can a caller lacking CAP_SYS_ADMIN in
fc->user_ns bypass the fc->user_ns capability check by satisfying
may_mount() in its own unprivileged mount namespace (or by passing
FSMOUNT_NAMESPACE)?

Because alloc_mnt_ns() below unconditionally uses fc->user_ns whenever
fc->rootns_bound is true, a task that passes this check via may_mount() in
an unrelated user namespace still allocates the anonymous mount namespace
in fc->user_ns and charges UCOUNT_MNT_NAMESPACES against fc->user_ns.

> +
>  	/* There must be a valid superblock or we can't mount it */
>  	ret =3D -EINVAL;
>  	if (!fc->root)
> @@ -4699,7 +4710,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, =
flags,
>  		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
>  			      open_new_namespace(&new_path, MOUNT_COPY_NEW));
> =20
> -	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> +	ns =3D alloc_mnt_ns(fc->rootns_bound ? fc->user_ns :
> +			  current->nsproxy->mnt_ns->user_ns, true);

[Severity: High]
Does allocating fsmount()'s anonymous mount namespace in fc->user_ns leave
host submounts without MNT_LOCKED when an external manager in init_user_ns
assembles a mount tree for an unprivileged rootns?

When a manager in init_user_ns creates a rootns-bound anonymous root mount
(so dest_mnt->mnt_ns is anonymous with user_ns =3D=3D fc->user_ns) and atta=
ches
a host submount from init_user_ns onto it via move_mount(),
attach_recursive_mnt() compares child->mnt_parent->mnt_ns->user_ns
(fc->user_ns) against current->nsproxy->mnt_ns->user_ns (&init_user_ns):

fs/namespace.c:attach_recursive_mnt() {
    ...
	if (is_anon_ns(ns))
		user_ns =3D current->nsproxy->mnt_ns->user_ns;
	else
		user_ns =3D ns->user_ns;
    ...
		/* Notice when we are propagating across user namespaces */
		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns)
			lock_mnt_tree(child);
    ...
}

lock_mnt_tree(child) only sets MNT_LOCKED on descendants p !=3D child,
leaving child itself unlocked, and commit_tree(child) then moves child into
the anonymous mount namespace owned by fc->user_ns.  When the assembled
anonymous tree is later moved into the target mount namespace (also owned
by fc->user_ns), the user namespaces match, so attach_recursive_mnt() does
not lock the tree and unprivileged users in the target namespace can
unmount the host submount to expose the underlying directory.  Conversely,
attaching a submount that was also created with FSCONFIG_SET_ROOTNS for
fc->user_ns onto the anonymous root mount sees
child->mnt_parent->mnt_ns->user_ns !=3D user_ns and spuriously runs
lock_mnt_tree().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D8
