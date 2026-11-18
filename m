Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043722;
	b=Fr6mGfcmj0GtgmAsmE3/gSHRH2rDuh3QfymqFypasugm0OMqvGVMssf6tKcuQ6VlskVY
	 ZaCVA7+ELagPX2FYaPVnCQJHz684BQo92id3Q4/rq3ymtT+yGMbaNN0k9a6589CJ1Zg7F
	 Voj72Z2wnwYFKeWnK2oCjO/sQt69Q8m+QOZfYtW6EnYfaeTuM7XIEm3c89UvQksmeY3ti
	 RIAb24FYyDvmC6wikXi484juMwaUG16zaFalYfr6C6GEOgZtNlWrGibbp2J5EKM3hTcf2
	 bw7RPR7w4TM3KObJMe1Ig6Tq7D0K4HZlEzCe0dzJpr5dU6+AUJzPC4EIlADd874on7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043722;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1eMO0ZdPCEFQ/EmxlhiA7Qy9no17Gyx6XtDtYpbkALU=;
	b=SZ1RhEsW5D5vkvd0mSqdFv38BWuEXnzYHqPfl1GHjlv+cJkXxepPopc5OwestsHnrdKR
	 C/qh057msInX1P0mF6IOa+ffgSZuDLsDTcXy1TOWTyjc8PlxZU6LUhodsaY48P0mUgL92
	 fBPrhuWJyCIb9fo58vm6HrECW1LbpXuJyD6icpbXikecKeltopmgrqGE6SKckfc4TZ8H7
	 K+62e12UkTUu2hZp1geowdyovSEZJv+bEPR/oCsMAyLbHkjnlTrGkw/L7/xtMfXyAp4MA
	 2oFwVRK1XwrEAKToxeH/L9j5BTEKPkJAwJjoXtxGpW8A9o/ax/KVJIp4OYezeW/Aigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlOffqxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A9606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlOffqxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC1C1F000C4;
	Wed, 18 Nov 2026 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043721;
	bh=1eMO0ZdPCEFQ/EmxlhiA7Qy9no17Gyx6XtDtYpbkALU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlOffqxoh9JmlfnCMZQpBnMTvs/2KWqdLeuDzQE5j16E6wKe6CjMnw97euijuEAMs
	 i51UHpromUfBlyFvDmqHggTVOdFOOx8P+ANOeuIiZW0rH2w8zuWJH4Po34gqdJdcQp
	 lwQXjqiU2PbgRYwJmb5NoJxnb+ahONiotIHfhPDcpPXDVo4v3IXUTPhJAbdKXT4VAN
	 WWGkcCoimmcOkNuwGvd29BJdm2HSfLZFhQZf3RD9kubWumPQgIQvbQMJcWPMa/KlK5
	 u4dqLgms+pmjCl/TyMf8V/YYNzicPq9LTJfbC+wkg+p4xu+w3ZPFzq+kNxH/UuCcjW
	 Rt4aE1TqbQ/ag==
Message-ID: <sashiko-outbox-222162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/13] fs: Support FSCONFIG_SET_ROOTNS in
 fsconfig()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Lutomirski" <luto@amacapital.net>, "Ben Segall" <bsegall@google.com>, "Christian
 Brauner" <brauner@kernel.org>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Jan
 Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "John Johansen" <john.johansen@canonical.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261117231352.3816603-9-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Critical] fs: fsconfig_set_rootns() replaces fc->net_ns after
  init_fs_context()
- [High] fs: proc: missing pidns_is_ancestor() check in
  proc_set_rootns()
- [High] fs: broken fc->user_ns delegation in fsconfig_set_rootns()
- [Medium] fs: missing net_ns and ipc_ns capability checks in
  fsconfig_set_rootns()
--

commit 5cbef69c784337269ad86c164ca92e045e18c429
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_ROOTNS in fsconfig()

This commit adds the FSCONFIG_SET_ROOTNS command to fsconfig() so a newly
opened fs_context can be bound to a target root namespace before parsing
parameters.

> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 70024870fefa2..ca3234c8c4e47 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
[ ... ]
> +static int fsconfig_set_rootns(struct fs_context *fc, struct fs_paramete=
r *param)
> +{
> +	struct user_namespace *user_ns;
> +	struct rootns *c;
> +
> +	if (!is_rootns_file(param->file))
> +		return -EINVAL;
> +
> +	c =3D param->file->private_data;
> +	user_ns =3D c->cred->user_ns;
> +	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
> +		return -EPERM;

[Severity: Medium]
Does checking CAP_SYS_ADMIN only against c->cred->user_ns allow rebinding
fc->net_ns or mqueue's ctx->ipc_ns to an ancestor namespace where the
caller lacks privileges?

In create_rootns(), when ROOTNS_USER is passed without ROOTNS_NET or
ROOTNS_IPC, c->ns->net_ns and c->ns->ipc_ns are inherited from
current->nsproxy and remain owned by an ancestor user namespace.  A caller
in an isolated network or IPC namespace that holds CAP_SYS_ADMIN in
c->cred->user_ns can then use a rootns fd to switch fc->net_ns or
ctx->ipc_ns back to that ancestor namespace without holding CAP_SYS_ADMIN
in c->ns->net_ns->user_ns or c->ns->ipc_ns->user_ns.

> +
> +	put_net(fc->net_ns);
> +	fc->net_ns =3D get_net(c->ns->net_ns);

[Severity: Critical]
Can replacing and dropping fc->net_ns here after init_fs_context() has
already run cause a use-after-free in filesystems that cache per-net state
during fsopen()?

During fsopen(), alloc_fs_context() calls fc->fs_type->init_fs_context(fc)
with the caller's current fc->net_ns.  In kAFS, afs_init_fs_context()
stores an unreferenced pointer into that netns:

fs/afs/super.c:afs_init_fs_context() {
	...
	ctx->net =3D afs_net(fc->net_ns);

	/* Default to the workstation cell. */
	cell =3D afs_find_cell(ctx->net, NULL, 0, afs_cell_trace_use_fc);
	if (IS_ERR(cell))
		cell =3D NULL;
	ctx->cell =3D cell;
	...
}

When fsconfig_set_rootns() calls put_net(fc->net_ns), the initial netns
can be freed once the caller exits it, leaving ctx->net dangling when a
subsequent fsconfig() call parses "source" via afs_parse_source() ->
afs_lookup_cell(ctx->net, ...).  If ctx->cell was non-NULL, it instead
holds a cell reference on the old netns and hangs afs_cell_purge() in
wait_var_event(&net->cells_outstanding) on netns exit.

Other filesystems also derive state from fc->net_ns during
init_fs_context() that becomes inconsistent after fc->net_ns changes:
nfsd_init_fs_context() and rpc_init_fs_context() set fc->user_ns from the
initial fc->net_ns->user_ns (and nfsd_fill_super() writes
nn->nfsd_client_dir into current->nsproxy->net_ns while keying the
superblock to fc->net_ns), while nfs_init_fs_context() sets
NFS_MOUNT_NETUNREACH_FATAL from fc->net_ns !=3D &init_net.

> +	if (!fc->global &&
> +	    (fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))=
 &&
> +	    kuid_has_mapping(user_ns, fc->cred->fsuid) &&
> +	    kgid_has_mapping(user_ns, fc->cred->fsgid)) {
> +		put_user_ns(fc->user_ns);
> +		fc->user_ns =3D get_user_ns(user_ns);
> +	}

[Severity: High]
Does delegating fc->user_ns this way work for unentered ROOTNS_USER root
namespaces or for FS_USERNS_MOUNT filesystems?

For an unentered ROOTNS_USER rootns, create_user_ns() leaves uid_map and
gid_map empty until a process exists in the namespace, and
rootns_prepare_fork() rejects fork with -ENOENT while the rootns is in
ROOTNS_EMPTY before "/" is mounted.  Because kuid_has_mapping() and
kgid_has_mapping() are false, fsconfig_set_rootns() silently leaves
fc->user_ns unchanged while returning 0, so a privileged manager creates
an init_user_ns superblock (without SB_I_NODEV) and an unprivileged caller
later fails mount_capable(fc) with -EPERM.  Meanwhile, mqueue_set_rootns()
unconditionally overwrites fc->user_ns with ctx->ipc_ns->user_ns, so
mqueue_get_inode() assigns unmapped current_fsuid()/current_fsgid() values
to the root inode.

Conversely, when uid_map and gid_map are populated and fc->user_ns is
switched to a target userns different from current_user_ns(),
FS_USERNS_MOUNT filesystems that require fc->user_ns =3D=3D current_user_ns=
()
(such as ovl_fill_super(), ovl_parse_param(), and bm_fill_super()) reject
the mount with -EINVAL:

fs/overlayfs/super.c:ovl_fill_super() {
	...
	/* The fscontext fd may have been passed to another user namespace. */
	if (fc->user_ns !=3D current_user_ns())
		goto out_err;
	...
}

> +	if (fc->ops->set_rootns)
> +		fc->ops->set_rootns(fc, c);
> +	fc->phase =3D FS_CONTEXT_CREATE_PARAMS;
> +	return 0;
> +}
[ ... ]
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a7..5976029ad3f80 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
[ ... ]
> @@ -323,6 +325,16 @@ static int proc_get_tree(struct fs_context *fc)
>  	return get_tree_nodev(fc, proc_fill_super);
>  }
> =20
> +static void proc_set_rootns(struct fs_context *fc, struct rootns *rootns)
> +{
> +	struct proc_fs_context *ctx =3D fc->fs_private;
> +
> +	put_pid_ns(ctx->pid_ns);
> +	ctx->pid_ns =3D get_pid_ns(rootns->ns->pid_ns_for_children);
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> +}

[Severity: High]
Should proc_set_rootns() verify that rootns->ns->pid_ns_for_children is a
descendant of task_active_pid_ns(current)?

Both proc_parse_pidns_param() and rootns_prepare_fork() enforce
pidns_is_ancestor(target, task_active_pid_ns(current)).  Without that
check here (and a return value from ->set_rootns()), a process confined to
a child or sibling PID namespace within the same user namespace can use a
rootns fd to mount procfs for an ancestor or sibling PID namespace outside
its active PID namespace hierarchy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D8
