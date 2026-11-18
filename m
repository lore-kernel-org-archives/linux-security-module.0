Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043713;
	b=XT7sSh27RuAOOszJjaNBeNunNZePCJuS/RVjFHu4+PBQ4UotMzU9O3gjBWL6BgL0x4Z5
	 4hiLcL+dUrd4JbUwNKW1s4JysNP0IEhix5msgvwkdx8I+og3VuAJOjoJ20FjYUy9eEYuF
	 oowJJYMkqjleflr4gFZ9ng1Na/hQaZPySQETI2SwBYhKXOsi6R30sPFtPqy3y9HtosqKb
	 dQALZ8oiz/S3EJ/cLSNc4TnZkBYpUA7LwJcFUT9OJl0tRRATYP/4teK6eeu4oWxye9KHV
	 GXiiglTQ7rGgNN69YikxQwEtGDZaGA8Q6lKSFEIaKKfbGdDKuouprkMRHGPs6yykRdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8rRvSXkDiuzji/rN0zB7/tikoYTvj8vrWQExWSK68WA=;
	b=gmqRTOKSG4JxJLqEWiSHRHzINvAbFgXh/EIgfZYm8iy0Tf/eUjMTbLudEREY/Th5QsOA
	 04LxbY2F72HGSoBVJl4q/Hz38ShirUqlCvplm2rWDFGhn9s6gpmxnF30xiTNhcU+ORjsL
	 ALCMXjLtYgas0cN8Va37JUi6oc8/Ue2pwfaRC7tPs0hGdEVcgJusU+9QbWmqPo3NEWQPZ
	 PVSqU43Lze9j+E9acwuR5OfJhC37Hh4digz4yO5/6TApbnJbEiEi5wjqfo+2BAuEURiYx
	 YBSqdm2uFo3wyD38eE+PAWFibXyLFVrcsF6Y4LwbbAFESY0272HZqVk7936Zv3JNpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OERKgB7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C81606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OERKgB7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261FD1F000C4;
	Wed, 18 Nov 2026 23:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043712;
	bh=8rRvSXkDiuzji/rN0zB7/tikoYTvj8vrWQExWSK68WA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OERKgB7Fr45GWa7sl3DJZXCGl8q9UbCwtxu55KJwGp4LLVXptuHFJOn1UHDehdivb
	 HsK8CP4BEa69Lfba34u8qA/XJW0HO+vJUiLN92PlBMBKn9sMt+HFQdtVWm9eMCRcw+
	 tlyn3swRLSUZ4LqeYb5WZ6OGJZ3VhnRgZHvNSQklnhAQnPjEMWZRYGZkvKAQcnpPg1
	 D5O4NxplsTSbP950PQmrWQkJ5w3JjkKFahbIY3BgVMuRvbKZ85UcXNwsqBKmxemXb3
	 avkFnSfJgb/u0a0bgyUtUu6NDxTLyuD5pJiDk/KfyOm7qKK+xbDJhICfHHT5McVLkT
	 M/1h0OPTL/QmQ==
Message-ID: <sashiko-outbox-222158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/13] rootns: Add rootns_create() system call
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
In-Reply-To: <20261117231352.3816603-5-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:10 +0000
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
- [High] rootns: UAF via unreferenced pid_ns->rootns in create_rootns()
- [High] rootns: cred->user mismatch in create_rootns_creds() for
  ROOTNS_USER
--

commit 58de372391f170ac432dcc21ea8238b956c72a12
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_create() system call

This commit adds the rootns_create() system call to allocate a detached
root namespace with dedicated mount and PID namespaces, optional extra
namespaces, and credentials, returning a control file descriptor.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index e3b203322ae23..caa810b65d0da 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -145,3 +145,142 @@ void exit_rootns(struct pid_namespace *pid_ns, stru=
ct task_struct *tsk)
>  	wake_up_poll(&c->waitq, EPOLLHUP);
>  	put_rootns(c);
>  }
> +
> +/*
> + * Create credentials for a rootns. Drop keyrings from the new credentia=
l to
> + * avoid unnecessary pinning.
> + */
> +static const struct cred *create_rootns_creds(unsigned int flags)
> +{
> +	struct cred *new;
> +	int ret;
> +
> +	new =3D prepare_creds();
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +#ifdef CONFIG_KEYS
> +	key_put(new->thread_keyring);
> +	new->thread_keyring =3D NULL;
> +	key_put(new->process_keyring);
> +	new->process_keyring =3D NULL;
> +	key_put(new->session_keyring);
> +	new->session_keyring =3D NULL;
> +	key_put(new->request_key_auth);
> +	new->request_key_auth =3D NULL;
> +#endif
> +	if (!(flags & ROOTNS_USER))
> +		return new;
> +
> +	ret =3D create_user_ns(new);
> +	if (ret < 0)
> +		goto err;
> +	new->euid =3D new->user_ns->owner;
> +	new->egid =3D new->user_ns->group;
> +
> +	new->uid =3D new->euid;
> +	new->suid =3D new->euid;
> +	new->fsuid =3D new->euid;
> +	new->gid =3D new->egid;
> +	new->sgid =3D new->egid;
> +	new->fsgid =3D new->egid;
> +	ret =3D set_cred_ucounts(new);
> +	if (ret < 0)
> +		goto err;
> +	return new;

[Severity: High]
Does overwriting new->uid with new->euid without updating new->user leave
cred->user out of sync when the caller's real and effective UIDs differ?

prepare_creds() clones new->user from current->cred->user (the caller's
real UID).  If a process with real UID 0 switches its effective UID via
seteuid() before calling rootns_create(ROOTNS_USER), new->uid and
new->ucounts are set to the unprivileged effective UID, while new->user
remains INIT_USER.  Tasks entering the rootns then bypass the RLIMIT_NPROC
check in copy_process() (which skips enforcement when
p->real_cred->user =3D=3D INIT_USER) and charge per-user_struct resources to
the wrong user_struct.

Allocating the matching user_struct with alloc_uid(new->uid) and releasing
the old one with free_uid(new->user), as set_user() does in kernel/sys.c,
would keep cred->user consistent with cred->uid.

> +
> +err:
> +	abort_creds(new);
> +	return ERR_PTR(ret);
> +}
> +
> +/*
> + * Create a new rootns.
> + */
> +static struct rootns *create_rootns(unsigned int flags)
> +{
[ ... ]
> +	ns =3D create_new_namespaces(clone_flags, current->nsproxy, cred->user_=
ns,
> +				   NULL);
> +	if (IS_ERR(ns)) {
> +		ret =3D PTR_ERR(ns);
> +		goto err_put;
> +	}
> +
> +	c->ns =3D ns;
> +	ns->pid_ns_for_children->rootns =3D c;
> +	nsproxy_ns_active_get(ns);

[Severity: High]
Can storing an uncounted pointer in ns->pid_ns_for_children->rootns lead
to a use-after-free in exit_rootns()?

create_new_namespaces() adds ns->pid_ns_for_children to the namespace
tree, and nsproxy_ns_active_get() marks it active before any init task is
forked into the rootns.  However, the reference on c that pairs with
exit_rootns() is only taken in copy_rootns() when c->state is
ROOTNS_FORKING, and put_rootns() does not clear
c->ns->pid_ns_for_children->rootns:

kernel/rootns.c:copy_rootns() {
	if (likely(!c || READ_ONCE(c->state) !=3D ROOTNS_FORKING))
		return;

	scoped_guard(spinlock, &c->lock) {
		get_rootns(c);
...
}

If a process with CAP_SYS_ADMIN in init_user_ns opens the active PID
namespace via open_by_handle_at(FD_NSFS_ROOT, ...), enters it with
setns(), and forks a child while c->state is still ROOTNS_EMPTY, that
child becomes the PID namespace's child_reaper without copy_rootns()
taking a reference on c.  When the child exits, zap_pid_ns_processes()
calls exit_rootns(), which dereferences the dangling pid_ns->rootns
pointer if the rootns fd was already closed, or drops the control fd's
sole reference on c while the fd is still open.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D4
