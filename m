Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE01F4C83;
	Fri, 28 Feb 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764044; cv=none; b=Gxc7S/BomB1gInby4dlYU0kdDbhmUJq0y9/suZUt83BU4XkjB8kkrQ9pKF/liw6o/gOgricQX3aKS/non96fpYqsg0JUdzbUJzON7ptT4Bf+JyeYIef8jMAivuognEeagg4E806e+vGngEXAE1vnxvtwO5pF1QsHnGI5uPSg0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764044; c=relaxed/simple;
	bh=ga7vifj5ctJiMEimouIoEeSZP+WD4Qt8UQwAuS8nLSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUHOO54jOmE9i38LOridJtGi0up29VW4k7mKJCDeFByN5BUBo9yfGsdytBOPSgyzMzqjuZYmJQnQJ+Xsi6fQ5BHyDO0VpA0TCmfOLLm9L3DYhML98ZUU7xftMS+dSB7Jv3V0/ruAR4OxWUNqaVTvVUANfkuR76TeaEVOb8AzuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4fL8kYw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4fL8kYw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so990479f8f.1;
        Fri, 28 Feb 2025 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740764040; x=1741368840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23YyeJYoDnTiEoCT9jrABPEwXgQJdKRqvAUOqdnjfw0=;
        b=C4fL8kYwUz7pNiyIwWFJdTTPVk0j2154JL7EvvVepUTUiGcGdpk+U5un37rDp3OFU/
         HAd63MwhcPgl4V0EzxRWG9R7hupLptOVz+6hoBDWCCjxwQti18WUAU8MemcRDqnD0cKk
         t2KrViUSWpt6ndm9ORwpmuNHVcxBZP4FKhVCT0nUTurlIiiJlPfBPQzgYQb0sV0bt43p
         E3iRWDfz1x3HGt+KO6JJdd3kTaJIrb8aazM7z9DKPZ9ttmZVoWX3F/bDyq2y7Rji3Bpn
         +dt/Zq+JBSc23Fk0NH3/sLfJ/UlXUsntjku3D2XHZuhl86T850FgOMxBqraMOVvVuC3S
         Ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764040; x=1741368840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23YyeJYoDnTiEoCT9jrABPEwXgQJdKRqvAUOqdnjfw0=;
        b=Yy1T/lIsJFni/Vp6Orxg7Ss3A5/QD+vaOn+SnhlNicIfphLH23Muj025ynu42v3ogn
         /TQm3UIMxZdCMVjii61wSWcuyQW4VD/T5SSqiF/KCYYIaTCpKpN3hDoQR6GjSyGmYMe0
         nOabYizoRwP5rgVxC0WOQeVGie3HhsFjFAqklHH/lmpXRqg+tRA7lIOE71YlRU9+JHaE
         5/MN+MPngsFIj087kkRblWV2TPPEkEVtZDAAkVAO5UiH7Xy9W/ZcozuKMZb72B115MJy
         31HGLxQDwBL0sCwisZR3sg8gQeuNgPwXgRZ9tCsFcBlPWYHLW/XWZ4VKe1FP2h2HY4U+
         MLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnak1dWZq3M7TG98ngdVvCufYuqGiJ8LyDpn9u6iA2M7gh3eT8EtMx4uFZOZFhSMtDEN0qvvE5V1MhXd8=@vger.kernel.org, AJvYcCXsHMkkHnJ2NE44I7jyaY5fq46Np5+4tGcXG1VnqGp172sw4F7sYg6Mdg8QFzKnI3okuuB2TzqZlZHhEbj+FelvQMVexGSV@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrY1/Kub2LB8kmenquqnU20q9NMUUq8LKn6YWI5E/ce2/w2B5
	e04MAY95xb8lvVo0JWN4zRQqnuZL4KrYwB1aK+Qu18V8zq9TsKks
X-Gm-Gg: ASbGncv8Jj3MmiMbWv5jNmGs+67djV6MmBZIrqrhowwh7Tv4fUSTLIYbWEyzDQOfxm8
	qWeiRwL2rjGCWO64sjLcesfRL8vOP9V9n962f8ahNqZDuPUTtv9WYV72tCoAqRp/JCL9rOxs23n
	sonVfMSh1teSocmj8WY2jK2Fd19AVbOQVrzLwWr/fHMb2HpjacX8PneXsyjFt6cdTvRa5bbxTjt
	guOHj9kUqM9jszyeHg7hWkQQvLgJ0xMaGJ47WiWXstgOfjcXHiYlcvgcdcqyizZce4LAbkMAVSW
	M3WunbDjNJHLfHuhVkS9WU7Yw2w=
X-Google-Smtp-Source: AGHT+IHTK8/RcRphtxwyeFz/0jFdhUlC7OzjWAWrhnu193+Bz1EaBcdxtyKUxLwDSrD1z7RRl2IMkg==
X-Received: by 2002:a05:6000:1868:b0:390:de58:d7fe with SMTP id ffacd0b85a97d-390eca40e2bmr4017603f8f.51.1740764039886;
        Fri, 28 Feb 2025 09:33:59 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47b7c4fsm5839637f8f.52.2025.02.28.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:33:59 -0800 (PST)
Date: Fri, 28 Feb 2025 18:33:55 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	Peter Newman <peternewman@google.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250228.b3794e33d5c0@gnoack.org>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227.Aequah6Avieg@digikod.net>

Hello!

Thanks for the review!

I'm adding David Howells to this thread as well.  David, maybe you can
help us and suggest a appropriate way to update the struct cred across
multiple threads?

On Thu, Feb 27, 2025 at 09:53:11PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 21, 2025 at 07:44:17PM +0100, Günther Noack wrote:
> > Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
> > given Landlock ruleset is applied to all threads of the calling
> > process, instead of only the current one.
> 
> I initially though that we may pick another flag name but I now think
> reusing the same name as for seccomp would be less confusing for users.

+1, under the assumption that we implement a "syncing" behaviour here,
I also think that the name is good.


> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index a9760d252fc2d..63792a6cde5ca 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c

> > +static struct cred *
> > +landlock_prepare_creds(const struct landlock_ruleset *old_dom,
> > +		       struct landlock_ruleset *new_dom)
> > +{
> > +	struct cred *new_cred;
> > +	struct landlock_cred_security *new_llcred;
> > +
> > +	/*
> > +	 * Similar checks as for seccomp(2), except that an -EPERM may be
> > +	 * returned.
> > +	 */
> > +	if (!task_no_new_privs(current) &&
> > +	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> > +		return ERR_PTR(-EPERM);
> 
> This should only be done for the calling thread, so just reusing the
> existing code from landlock_restrict_self().
> 
> If the no_new_privs property is set for the current thread, it would
> make sense to just set it for all other threads once we are sure we can
> sandbox all of them (see seccomp_sync_threads).

(See discussion below regarding NO_NEW_PRIVS)


> For this we need to have two for_each_thread loops: one to check that
> the current thread is legitimate to sandbox all the other threads and
> make sure no error could arise (e.g. memory allocation), and another
> loop to safely enforce the restrictions if the first one was OK.
> 
> The handling of the following prepare_cred()'s failure is the main
> issue, but see my proposal below.
> 
> > +
> > +	/* Prepares new credentials. */
> > +	new_cred = prepare_creds();
> > +	if (!new_cred)
> > +		return ERR_PTR(-ENOMEM);
> 
> Instead of creating one new credential per thread, we should use the
> newly created one (from landlock_restrict_self) and increment its
> references.  In most cases that would avoid duplicating information and
> wasting memory by creating one struct cred per thread.

struct cred contains all kinds of other credentials as well, besides
Landlock and NO_NEW_PRIVS. *In normal scenarios* I believe that the
struct cred is the same for all threads, but this is not guaranteed.

We can make it safe by requiring that all threads must point to the
same struct cred, as you are suggesting below.  But how are users
supposed to reason about whether all threads share the same struct
cred?  To my knowledge, it is an implementation detail of the kernel.
We can't expect callers to understand what properties belong to struct
cred, and that list of properties can potentially change in the future
as well.

This is why in the proposal I sent, the only thing that matters about
the preexisting struct cred is the Landlock domain which is stored in
it.  This is a lower bar to meet and seems more appropriate for this
Landlock-specific syscall.


> > +	new_llcred = landlock_cred(new_cred);
> > +	if (new_llcred->domain != old_dom) {
> > +		abort_creds(new_cred);
> > +		return ERR_PTR(-ESRCH);
> 
> To avoid dealing with prepare_creds()'s error, I think we could just
> check that all threads have (initially) the same credentials, and either
> swap this same old credential with the new one (created by the caller),
> or swap the Landlock domain (and set no_new_privs) if the credentials
> changed between the initial check and now.

This would be working around the API documented in
Documentation/security/credentials.rst, where the affected task should
do its own prepare_creds()/abort_creds()/commit_creds() dance.

After seeing how it had turned out in the keyctl case with an
additional LSM hook, I was hoping to use the suggested API and do
things as intended here.  prepare_creds() and commit_creds() do more
than just switching pointers and refcounts, it is not clear to me that
prepare_creds() on one task and commit_creds() on another would work
with the same struct cred.


> Actually it might be up to
> three loops:
> 
> (lock cred_guard_mutex)

FWIW, Peter Newman (CC'd) also pointed me at the tasklist lock, which
is also used in Seccomp.  I believe we would also have to grab this
one *before* starting to iterate over the list of tasks and *after*
committing the last credentials, so that we don't spawn new tasks in
the middle of the operation, which might still inherit old
credentials.  (The drawback is that it is a global lock.)


> 1. Check that all threads use the same credential, or abort the whole
>    operation otherwise.
> 
> 2. If the caller has no_new_privs (and passed the Landlock checks), set
>    no_new_privs to all threads.

I am still conflicted about this.  This seems like a too implicit way
to set NO_NEW_PRIVS and might surprise callers.  After all, we are not
setting it in the single-threaded landlock_restrict_self() case
either.


> 3. Run a work_task on each thread that will either:
>    - if old thread's credential is still the same as the caller's
>      credentials, swap it with the new one with get_cred()/put_cred();
>    - otherwise, this means that the thread changed its credential after
>      the first loop but because we set no_new_privs, this alternative
>      credential should not give more privileges and we should be safe to
>      only swap the Landlock domain with the new one (if different).
>      Indeed, this alternative credential might be used by other threads
>      from the same process, but AFAIK not by threads from other
>      processes thanks to cred_guard_mutex.  This would require to bypass
>      the const pointer though.  Holding cred_guard_mutex will also make
>      sure that domains were not updated under our feet by another call
>      to landlock_restrict_self().

Hmm, in the second case we'd still have to use the
prepare_creds()/abort_creds()/commit_creds() API with all of its
potential failure modes.  Or, we would have to swizzle out contents of
struct cred directly, but that would be side-stepping that API again.

I would prefer not to side-step that cred-updating API, given how it
turned out in the keyctl case.  If it is absolutely necessary to
change struct cred differently, I would rather introduce a new
"official" way to change struct cred than to work around it from the
outside without David Howells' knowledge.  But I'd prefer to do it
with the existing update API, if we can.


> (unlock cred_guard_mutex)
> 
> Another approach would be to leverage an LSM hook to deny credential
> changes for a thread while we are changing them for the whole process,
> but I'm not sure it would be better.
> 
> Kees, Paul, Jann, any better idea?
> 
> > +	}
> > +
> > +	/* Replaces the old (prepared) domain. */
> > +	landlock_put_ruleset(new_llcred->domain);
> > +	landlock_get_ruleset(new_dom);
> > +	new_llcred->domain = new_dom;
> > +
> > +	return new_cred;
> > +}
> > +
> > +/*
> > + * restrict_one_thread - update a thread's Landlock domain in lockstep with the
> > + * other threads in the same process.
> > + *
> > + * When this is run, the same function gets run in all other threads in the same
> > + * process.  The concurrently running function invocations coordinate to wait
> > + * until they are all done with the preparation step and have reported back
> > + * errors from the preparation step, if necessary.
> > + *
> > + * Afterwards, depending on the presence of an error, all threads either commit
> > + * or abort the prepared credentials.  The commit operation can not fail any more.
> > + */
> > +static void restrict_one_thread(struct landlock_tsync_shared_context *ctx)
> > +{
> > +	int res;
> > +	struct cred *cred = landlock_prepare_creds(ctx->old_dom, ctx->new_dom);
> > +
> > +	/* On error, set the error and continue. (Do not return early.) */
> > +	if (IS_ERR(cred))
> > +		atomic_set(&ctx->preparation_error, PTR_ERR(cred));
> > +
> > +	/*
> > +	 * Barrier: Wait until all threads are done preparing.
> > +	 * After this point, we can have no more failures.
> > +	 */
> > +	if (atomic_dec_return(&ctx->num_preparing) == 0)
> > +		complete_all(&ctx->all_prepared);
> > +	wait_for_completion(&ctx->all_prepared);
> 
> The logic is OK but the side effect would be to block all threads, which
> is an issue.  That's why we need at least two loops run by the calling
> thread, and the other threads should not have to wait.

If we do "prepare" and "commit" in two different loops, we'd still
need to start a "task_work" for the threads in the "commit" loop so
that they update their struct cred.  And if the struct cred changed in
the meantime between the two loops, what do we do?  If we want
all-or-nothing semantics, we'd still have to check for modification in
the task_work and synchronize with a barrier between all tasks, right?
Doesn't that have the same problems?  (I would also expect that
wait-time-wise, the "landlock_prepare_creds" part would be quicker
than waiting for the "all_prepared" barrier, so this doesn't seem to
make a big difference?)

> 
> > +
> > +	/*
> > +	 * Abort the commit if any of the threads had an error.
> > +	 * (It might also be this thread.)  Otherwise, commit.
> > +	 */
> > +	res = atomic_read(&ctx->preparation_error);
> > +	if (res) {
> > +		if (!IS_ERR(cred))
> > +			abort_creds(cred);
> > +	} else {
> > +		commit_creds(cred);
> > +	}
> > +
> > +	/* Notify the calling thread once all threads are done */
> > +	if (atomic_dec_return(&ctx->num_unfinished) == 0)
> > +		complete_all(&ctx->all_finished);
> > +}
> > +
> > +/*
> > + * restrict_one_thread_callback - task_work callback for restricting a thread
> > + *
> > + * Calls restrict_one_thread with the struct landlock_shared_tsync_context
> > + * and frees up the per-work_task landlock_tsync_context afterwards.
> > + */
> > +static void restrict_one_thread_callback(struct callback_head *work)
> > +{
> > +	struct landlock_tsync_context *ctx =
> > +		container_of(work, struct landlock_tsync_context, work);
> > +	struct landlock_tsync_shared_context *sctx = ctx->ctx;
> > +
> > +	restrict_one_thread(sctx);
> > +	kfree(ctx);
> > +}
> > +
> > +/*
> > + * restrict_all_threads - enables a Landlock policy for all threads
> > + */
> > +static int restrict_all_threads(const int ruleset_fd)
> > +{
> > +	int res;
> > +	struct task_struct *thread, *caller;
> > +	struct landlock_tsync_shared_context sctx;
> > +	struct landlock_ruleset *ruleset;
> > +
> > +	/*
> > +	 * XXX: Need to double check race conditions and deadlocks before
> > +	 * merging this upstream. We probably need additional locking.
> > +	 */
> > +
> > +	/* Starting with 1, as we're already counting current. */
> > +	atomic_set(&sctx.num_preparing, 1);
> > +	atomic_set(&sctx.num_unfinished, 1);
> > +	init_completion(&sctx.all_prepared);
> > +	init_completion(&sctx.all_finished);
> > +	atomic_set(&sctx.preparation_error, 0);
> > +	sctx.old_dom = landlock_get_current_domain();
> > +
> > +	/* Gets and checks the ruleset. */
> > +	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
> > +	if (IS_ERR(ruleset))
> > +		return PTR_ERR(ruleset);
> > +
> > +	/*
> > +	 * We pre-merge the domain for all threads,
> > +	 * so that all threads end up with exactly the same domain.
> > +	 */
> > +	sctx.new_dom = landlock_merge_ruleset(sctx.old_dom, ruleset);
> > +	landlock_put_ruleset(ruleset);
> > +	if (IS_ERR(sctx.new_dom))
> > +		return PTR_ERR(sctx.new_dom);
> 
> What is specific to this function should only start here.  The flag
> checks (new ones are coming with the audit patch series), the ruleset
> FD, the preapre_creds(), and the landlock_merge_ruleset() should be the
> same.  We can initialize shared states from here.

I'm not sure I understand fully; is the suggestion that I reorder the
work at the top of restrict_all_threads() so that the parts that are
also done in the single threaded-case can be factored out and done in
the calling function?

> 
> > +
> > +	landlock_get_ruleset(sctx.old_dom);
> > +
> > +	caller = current;
> > +	for_each_thread(caller, thread) {
> > +		/* Skip current, since it is initiating the sync. */
> > +		if (thread == caller)
> > +			continue;
> > +
> > +		/* Skip exited threads. */
> > +		if (thread->flags & PF_EXITING)
> > +			continue;
> > +
> > +		/* Deallocation is done by the task_work itself. */
> > +		struct landlock_tsync_context *ctx =
> > +			kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> > +		if (!ctx) {
> > +			/*
> > +			 * On error, keep already started threads from
> > +			 * accidentally committing.  Do not start additional
> > +			 * threads.
> > +			 */
> > +			atomic_set(&sctx.preparation_error, -ENOMEM);
> > +			break;
> > +		}
> > +
> > +		ctx->ctx = &sctx;
> > +		atomic_inc(&sctx.num_preparing);
> > +		atomic_inc(&sctx.num_unfinished);
> > +		init_task_work(&ctx->work, restrict_one_thread_callback);
> > +		res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> > +		if (res) {
> > +			atomic_set(&sctx.preparation_error, res);
> > +			atomic_dec(&sctx.num_preparing);
> > +			atomic_dec(&sctx.num_unfinished);
> > +		}
> > +	}
> > +
> > +	/* and do the same on the current thread */
> > +	restrict_one_thread(&sctx);
> > +
> > +	res = atomic_read(&sctx.preparation_error);
> > +	wait_for_completion(&sctx.all_finished);
> > +	landlock_put_ruleset(sctx.new_dom);
> > +	landlock_put_ruleset(sctx.old_dom);
> > +	return res;
> > +}
> > +
> >  /**
> >   * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
> >   *
> >   * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
> > - * @flags: Must be 0.
> > + * @flags: Flags to modify the behavior.
> >   *
> > - * This system call enables to enforce a Landlock ruleset on the current
> > - * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> > + * This system call enforces a Landlock ruleset on the current thread.
> > + * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> >   * namespace or is running with no_new_privs.  This avoids scenarios where
> >   * unprivileged tasks can affect the behavior of privileged children.
> >   *
> > + * If %LANDLOCK_RESTRICT_SELF_TSYNC is specified in @flags, the ruleset will be
> > + * applied to all threads of the current process.  For this, all threads must be
> > + * in the same Landlock domain and fulfill the normal requirements for enforcing
> > + * a Landlock ruleset.
> > + *
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> > @@ -447,6 +664,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
> >   *   %CAP_SYS_ADMIN in its namespace.
> >   * - %E2BIG: The maximum number of stacked rulesets is reached for the current
> >   *   thread.
> > + * - %ESRCH: When called with %LANDLOCK_RESTRICT_SELF_TSYNC, the processes'
> > + *   threads were in different Landlock domains.
> >   */
> >  SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  		flags)
> > @@ -467,10 +686,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  
> > -	/* No flag for now. */
> > -	if (flags)
> > +	/* TSYNC is the only supported flag. */
> > +	if (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC)
> >  		return -EINVAL;
> >  
> > +	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC)
> > +		return restrict_all_threads(ruleset_fd);
> > +
> 
> As explained above, restrict_all_threads()'s logic should be called
> later.
> 
> Starting here, as seccomp does, we can lock siglock (whatever flags are
> used) to be sure there is not concurrent call to
> landlock_restrict_self() on other threads of the same process.
> 
> If LANDLOCK_RESTRICT_SELF_TSYNC is set, we also need to lock
> cred_guard_mutex to avoid race conditions with concurrent execve calls.

I was confused about this lock, but found the remark in the seccomp
logic again as well, which says:

  /*
   * Make sure we cannot change seccomp or nnp state via TSYNC
   * while another thread is in the middle of calling exec.
   */

In my understanding, cred_guard_mutex gets locked in early stages of a
execve() that prepares the "bprm".  If I understand this correctly,
this is the scenario where the other thread is starting to run
execve() (about to replace the entire process), but at the same time
it still looks like a normal thread that belongs to the process.  Is
that right?

> >  	/* Gets and checks the ruleset. */
> >  	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
> >  	if (IS_ERR(ruleset))
> > -- 
> > 2.48.1
> > 
> > 

Thanks for the review and for keeping the discussion at the more
conceptual level for now!

–Günther
