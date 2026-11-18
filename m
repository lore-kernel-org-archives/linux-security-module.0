Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978587;
	b=0Ap0uqD5uBxLVudDqJN2/5NtyG+qKq+IsFXeSLwwvL+/0/BS4Ni7pU50iuoLL7NsLrf5
	 ly2syEavEpoP9cKbSVFtSypymjYldnZ4G1f0emNQTj6M2ESkcRi082y8e/r0C+n00vx8g
	 Bp6AyHYUNUEP9BLw67cdyhXiZupzCQj2deMtRlGIZAUAq+lo5+AVh3+aDaeoGMO17byaw
	 lHRTwErFmnmabxxnuxLMtWlrrIkfkxTyvpuOMhjY7QC9Y7pGO+DzPUY/l0I9zzdekl5Nw
	 DNNZuT0jR7Eia/kLeteXWajMUlkDCRHN96Ka4OXfvUoYDycmy5JztEZNC+l/qGIBuaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M1t0OG5hPXiCiaFk6hIj2QHLA/2XZTBsU25238l1JRs=;
	b=T5nLnpmvtXaGd+iKL4ixC8EXayQL46/PpGtHH65ascIdHWWTJzGDY9p4PrGLNYXc1Fl2
	 UH//9HdaRtsFWMDHETKQHRnWgxqradDWOtV6IBFpdDPybHY9VQz11BlTcigkMsAHunBWH
	 4qyPh9cqnOHzgxX1WZG6fHJS/wk2V4N5xzcfAjj1G9ET6Pfn5WKgDf5wnBd9XRj0ZTfFn
	 2dGJriwyfBQ9TELtJRkvJgeBQKkBj2JFKcGQqfO27bcaR3vLAMs8F6XIuYt+zHJKKdQPp
	 bPO+vA3szgOLG7lLdt5lRcENQ1S6Ke6x08HwxpLkzoLNrLNvm4P5LtJvpsbbKBUCCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwUzcB70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31B606A325
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwUzcB70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8291F000C4;
	Wed, 18 Nov 2026 05:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978587;
	bh=M1t0OG5hPXiCiaFk6hIj2QHLA/2XZTBsU25238l1JRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwUzcB70grBFLs9IGOjbyF70guJqjsxk88ZAUaiytABfn6ddCHSRmOVmLhb7zEaRn
	 HrFxNNyM1NhJLr9E+BEFYYCvbPvnEHixd6OvpfG9xzKUXgIlJWTONC5Rd1Jb1VioOq
	 jhOSfj7leJNVLVPiKqDFqj5Y4n8AZj9pyozGacNzkix2nzC8LVNvDYlNdPSS6YhFUP
	 qCCP0Py9RukHEw2pAJqhIt8ByUG1mNECibnNhlsqhrWSs8PPQ4oSOXLfHczy1EbThH
	 kB1clV3JBRnp0IydGuampvhC6YsMD5LVx6fzvvuOtbOYZuJS2atXiNI/ZL5TIui8XM
	 IRdyK02nsrf2A==
Message-ID: <sashiko-outbox-220139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/13] rootns: Add rootns_create() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Howells" <dhowells@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Vlastimil Babka" <vbabka@kernel.org>
In-Reply-To: <20261117050841.3289652-5-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:44 +0000
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
- [High] rootns: cred->user mismatch in create_rootns_creds() when
  ROOTNS_USER is set
- [High] rootns: UAF via unreferenced pid_ns_for_children->rootns in
  create_rootns()
--

commit b0275fb9f88bbbd1444c1c6937b46e36c52e8fe7
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_create() system call

This commit adds the rootns_create() system call to allocate a detached
root namespace with dedicated mount and PID namespaces plus optional
namespaces selected by flags, returning a control file descriptor.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index e3b203322ae23..904d75ce9d909 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -145,3 +145,143 @@ void exit_rootns(struct pid_namespace *pid_ns, stru=
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

[Severity: High]
Does updating new->uid to new->euid without updating new->user leave
new->user pointing to the caller's old real UID user_struct?

prepare_creds() clones new->user from current->cred->user.  When the
caller's real UID differs from its effective UID (for example, a manager
process with real UID 0 that switched its effective UID via seteuid()
before calling rootns_create(ROOTNS_USER)), tasks entering the rootns
inherit new->user =3D=3D INIT_USER while running as the unprivileged UID,
bypassing RLIMIT_NPROC checks in copy_process() and misattributing
per-user_struct resource accounting.

Updating new->user via alloc_uid(new->uid) and freeing the old reference
with free_uid(), as set_user() does in kernel/sys.c, would keep new->user
consistent with new->uid.

> +	if (ret < 0)
> +		goto err;
> +	return new;
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
> +	ns->rootns =3D c;
> +	ns->pid_ns_for_children->rootns =3D c;
> +	nsproxy_ns_active_get(ns);

[Severity: High]
Can storing an uncounted pointer in ns->pid_ns_for_children->rootns before
copy_rootns() runs lead to a use-after-free in exit_rootns()?

create_new_namespaces() adds ns->pid_ns_for_children to the namespace tree
and nsproxy_ns_active_get() marks it active, while the reference on c that
pairs with exit_rootns() -> put_rootns(c) is only taken later in
copy_rootns() when c->state is ROOTNS_FORKING:

kernel/rootns.c:copy_rootns() {
    ...
	scoped_guard(spinlock, &c->lock) {
		get_rootns(c);
		WRITE_ONCE(c->init_pid, get_task_pid(tsk, PIDTYPE_TGID));
		WRITE_ONCE(c->state, ROOTNS_RUNNING);
	}
}

A process with CAP_SYS_ADMIN in init_user_ns and init_pid_ns can open the
active PID namespace via open_by_handle_at(FD_NSFS_ROOT, ...), enter it
with setns(), and fork a child that becomes child_reaper without going
through ROOTNS_FORKING.  If the rootns fd was already closed, put_rootns()
frees c without clearing pid_ns->rootns, and when that child exits,
zap_pid_ns_processes() -> exit_rootns() dereferences and frees c a second
time.  If the rootns fd is still open when the child exits, exit_rootns()
drops the control fd's sole reference on c, freeing it while the fd still
references it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D4
