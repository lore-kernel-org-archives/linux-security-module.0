Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CF175BF
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846720; cv=none; b=lv5bjoeGeb1OoVgHbLSdTomQLxexHfGHxWWYA5vspI/Gcq20/Np9rwhoxWAAZHC0PHqdzBeWPi1yR4NFB4YOUZrwEoj7E91boXGjrpe+ORQjzkqToxbofto+6LArUI+JLO5MFmLF9SNR+uqEwQuzjFpbP7aS5WA3Lp4bIzfAH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846720; c=relaxed/simple;
	bh=n6RxvSLnAvAv8QJbkOZfP1xL7uhMGvfhdcxkVNtYaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXmt/4R/yBpvEqwDcfA2NRtSrH3PF3SjJpkrpc8YKaNJPogZJ1XoRHXhLsKWy8d3K3EfQyxorcl53U0aP1+wuprkf1YMYypXqsP4vUkWIxXwP+ya8su2tg6Aejc+CtQ9HywHltQn6AnCnLWwaOQhxelxk/CwevrR4FqXsMk5UoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lw4T4YRs; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lw4T4YRs"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b9kqS2BLMz5kb;
	Mon,  2 Jun 2025 08:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748846708;
	bh=VH6zFQvhPJQBgfTo5ban3m0VUR+MA2qMksTosH15CmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lw4T4YRserDBU+LpHTACnYqcNKHlNHD04fLGz++gFBYs3TqGQTqUFxOYz3ME0FMuO
	 yBFo681TKjHHt3uYqagYONWfNgYebm/HwPfg8IOKJk9GEWqW7Hxpy904RFw4AgsI4k
	 /XxIbCArW470QttbI0RBuvrFj/18eEQAlDDHKb64=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b9kqQ5kGqzqdG;
	Mon,  2 Jun 2025 08:45:06 +0200 (CEST)
Date: Mon, 2 Jun 2025 08:45:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250602.ko3thoc7ooL4@digikod.net>
References: <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net>
 <20250518.be040c48937c@gnoack.org>
 <20250518.xeevoom3kieY@digikod.net>
 <aDmvpOMlaAZOXrji@google.com>
 <20250530.ozeuZufee5yu@digikod.net>
 <aDncH8D9FoyAIsTv@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDncH8D9FoyAIsTv@google.com>
X-Infomaniak-Routing: alpha

On Fri, May 30, 2025 at 06:26:07PM +0200, Günther Noack wrote:
> On Fri, May 30, 2025 at 05:11:34PM +0200, Mickaël Salaün wrote:
> > On Fri, May 30, 2025 at 03:16:20PM +0200, Günther Noack wrote:
> > > On Sun, May 18, 2025 at 09:57:32PM +0200, Mickaël Salaün wrote:
> > > > We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make it
> > > > clear what it does.
> > > > 
> > > > The remaining issues are still the potential memory allocation failures.
> > > > There are two things:
> > > > 
> > > > 1. We should try as much as possible to limit useless credential
> > > >    duplications by not creating a new struct cred if parent credentials
> > > >    are the same.
> > > > 
> > > > 2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
> > > >    landlock_restrict_self(2) should handle memory allocation and
> > > >    transition the process from a known state to another known state.
> > > > 
> > > > What about this approach:
> > > > - "Freeze" all threads of the current process (not ideal but simple) to
> > > >   make sure their credentials don't get updated.
> > > > - Create a new blank credential for the calling thread.
> > > > - Walk through all threads and create a new blank credential for all
> > > >   threads with a different cred than the caller.
> > > > - Inject a task work that will call cred_transfer() for all threads with
> > > >   either the same new credential used by the caller (incrementing the
> > > >   refcount), or it will populate and use a blank one if it has different
> > > >   credentials than the caller.
> > > > 
> > > > This may not efficiently deduplicate credentials for all threads but it
> > > > is a simple deduplication approach that should be useful in most cases.
> > > > 
> > > > The difficult part is mainly in the "fleezing". It would be nice to
> > > > change the cred API to avoid that but I'm not sure how.
> > > 
> > > I don't see an option how we could freeze the credentials of other threads:
> > > 
> > > To freeze a task's credentials, we would have to inhibit that commit_creds()
> > > succeeds on that task, and I don't see how that would be done - we can not
> > > prevent these tasks from calling commit_creds() [1], and when commit_creds()
> > > gets called, it is guaranteed to work.
> > > 
> > > So in my mind, we have to somehow deal with the possibility that a task has a
> > > new and not-previously-seen struct creds, by the time that its task_work gets
> > > called.  As a consequence, I think a call to prepare_creds() would then be
> > > unavoidable in the task_work?
> > 
> > OK, we don't need to freeze all threads, just to block thread creation.
> > 
> > What about that:
> > 1. lock thread creation for this process
> > 2. call prepare_creds() for the calling thread (called new_cred)
> > 3. call cred_alloc_blank() for all other threads, store them in a list,
> >    and exit if ENOMEM
> > 4. asynchronously walk through all threads, and for each:
> >   a. if its creds are the same (i.e. same pointer) as the calling
> >      thread's ones, then call get_cred(new_cred) and
> >      commit_creds(new_cred).
> >   b. otherwise, take a blank cred, call cred_transfer(), add the
> >      Landlock domain, and commit_creds() with it.
> > 5. free all unused blank creds (most)
> > 6. call commit_creds(new_creds) and return
> > 
> > Pros:
> > - do not block threads
> > - minimize cred duplication
> > - atomic operation (from the point of view of the caller): all or
> >   nothing (with an error)
> > - almost no change to existing cred API
> > 
> > Cons:
> > - block thread creation
> > - initially allocate one cred per thread (but free most of them after)
> 
> The proposal is growing on me.
> 
> One way to view transfer_creds() and have it nicely fit into the credentials API
> would be to view prepare_creds() as a convenience wrapper around
> transfer_creds(), so that prepare_creds() is implemented as a function which:
> 
>   1) allocates a new struct cred (this may fail)
>   2) calls transfer_creds() with the new struct cred to populate
> 
> We could then move the bulk of its existing prepare_creds() implementation into
> the new transfer_creds(), and could also move the keyctl implementation to use
> that.

Yes

> 
> A remaining problem is: The caveat and the underlying assumption is that
> transfer_creds() must never fail when it runs in the task work, if we want to
> avoid the additional synchronization.  The existing cases in which the
> credentials preparation logic can return an error are:
> 
> * Allocation failure for struct cred  (we would get rid of this)
> * get_ucounts(new->ucounts) returns NULL  (not supposed to happen, AFAICT)
> * security_prepare_creds() fails.  Existing LSM implementations are:
>   * Tomoyo, SELinux, AppArmor, Landlock: always return 0
>   * SMACK: May return -ENOMEM on allocation failure
> 
> 
> So summing up, in my understanding, the prerequisites for this approach are that:
> 
>   1) get_ucounts() never returns NULL, and
> 
>   2) SMACK does not bubble up allocation errors from the cred_prepare hook
> 
>      Casey, Jarkko: do you think this is realistic for SMACK to change?

There is no issue using cred_alloc_blank() and then transfer_creds().
The allocation is up front and transfer_creds() cannot failed.

> 
> and that
> 
>   3) We can block new thread creation
> 
>      Mickaël, do you have a specific approach in mind for that?

I was thinking to do the same as seccomp: lock siglock and,
check/synchronize credentials in a new LSM hook called just after
copy_seccomp() (when siglock is locked).  However, as pointed out by
Jann, that would not be enough because this new LSM hook would not be
able to allocate new credentials, and the siglock locking happens after
copy_creds().

> 
>      As Jann pointed out in [1], the tasklist_lock and siglock are not sleepable
>      and can't be used while waiting, which is why he proposed an approach where
>      we retry in a loop until no new threads show up any more, while getting the
>      existing threads stuck in the task_work as well (where they can't spawn new
>      threads).

This looks good.  Too bad we need to block all threads.

> 
> 
> Thanks,
> 
> —Günther
> 
> [1] https://lore.kernel.org/all/CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc_z1rrVJw@mail.gmail.com/
> 
