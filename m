Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98689239594
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235953; cv=none; b=GJ1T1dXH/m/C6Sv4MYWPdiNwTufEwnIIMjpNtSSU62ro7fA8BbntkfN7QygcBgtqULqi8X8Cv/oQT4Ukm2B+JGQSz90UzuT5yJdjU6bGWmWIzv3Q9nKdCPAgP33h/6eeDiVU7B+d+rscrR9ku2lDDkr0x+w5tPuD7INAzFLoTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235953; c=relaxed/simple;
	bh=RI3VU7VYrjiIOXvXuGiOqx69AzvlJvzHHtiR11n/r1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxmWulC+6Ik04+l7Z6fB1nWoZUIRRBtTQ/sVOrQzPIOp0VHvymOV+TSdYpGHITEbg3vVKMjXJcexmwQoupaNY97oRmVsdwCWP3bkmU183Oizn0Tvda/6S5uXuPU4nVV3LMBNkD/FQ1Xj2948eYvrf2f9ThAS3X80GQTi6mEMGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWJ2Vqep; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWJ2Vqep"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso356055f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235950; x=1764840750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9ZdYOKn63iPj+OVfDR0OHnLILRSq1T0QnS+z/qxeF4=;
        b=GWJ2Vqep4LUzI7cAGVHHA689cPpTHgQHckaKI4pYVesAT9HX7UZTr2W79K5FdSjzk0
         s8AD9jYQpHg4Z6+loebVQMBj1MRFw5DcjjVc7yCeFwYCizsrXgTft9mANKKKZ6obYgWt
         SkMG6P2VarMqD1mRr8nQh/9x/HKlaW/yxH5Jtu2IzQ6XqIgdQs3sdXBlzz0FObxJh58l
         LG/doXMbqY1pdNMeciTgzRDUrmBesH9fhqSxJtKpkMEc8JnGFtylcaXGH/23yKgCAk+o
         /j1pQpEP7S1nZmGmzGh59xnw0puZ6nP48558bBtZGZhXViNShHQPyrs5M8fA4NM7OtAU
         REdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235950; x=1764840750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9ZdYOKn63iPj+OVfDR0OHnLILRSq1T0QnS+z/qxeF4=;
        b=fy6X5oGYt6ZIrRfUJRVZ2MEuem876llXRCRwwZRdYOaqzsAV+CVz4Ycio7yYnagUXz
         8z0A27lWnzvE8k9uZheNsHSnAQFMtWcn3zHdCV99/s4OfUxgnmS9rdn5ZV3nZ6GWnrYs
         iAc8hKeCX1zJppXWIZcgZupRU9npiK+4F+2Jg4JN2tUytRAUTgGhjim4nGP/fNO4IKOg
         DRIKkAtcoJxWsyLuQdvYAkf28l+JiKMLUddPVJsU31xbwe/LVj+acvRyl73op3alO62K
         KJWlqSeS8VjxRe+VTJoI6e6OLnYruZo5vWxBtsDjIUT2L88gcdRs2880RkLXVRWNsXuw
         l80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSYAZ2geYw2Fb45BNtqyocfbC6RlPRst6rSlKy+Oc//x+9ou2CKjcXetjwivtlkxauEdAGeUs1cRmGFj+Yybp8Y3txMPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcvQJttxD3GeQ+NneTzKQiSpVzBat8G1rn6l7IvaVE1LVqRL4
	/ZBT/rlVBsbNvhmDN4msjtJwkui8vTIkolfIex9z7uFKhPkLEM1ghH7kmqERJ/OiEw==
X-Gm-Gg: ASbGncuwxdz773LyB2njY95mTBbCIEK5h7pGEi8aCUC7vNBv8PoxySuuSUi77JT8cVP
	jj0eFAdfkcyw2kliDOnnCXqp6kPz47xCZuyQTl6L79+OjWbNhnPKDJ+nKYTW7+2Gv1ftTcpF8eU
	Bl2xrPlYcVYMRfIwtXj89ooyRgTqUmZ3llm58vWOJIIWBci+uebQ7Qt1e0jDJdtx5UKwErhnfeL
	NXgHqgnvxK/DDI3unFxkphnhPB+HOZQEtUEC8pAvJhwexHrl+PdnroFZe/5PsIOpx6mzwMW92YV
	IYUiZI6OgHy9LQpOiuz6NfY3Z75vKpl3cdRQmnVvag/+3asWRlHEpGugw707rt41mrg+HlsyU7l
	TFS/MSzyBiQQJSp6UkqugLTWyJ0eGJ/nm07+Sd92etycTyyJjSc9/d/U5ndx+jtwXjiONT4T2sP
	/FvDAVtQXbXdt6e8dZ2fpF3OzOiT/7wMa5IhjjgcFIXA==
X-Google-Smtp-Source: AGHT+IFurgxVemYzJu4yXCQInFC8HyYfJXdwq8km6GSVnaH7DrzI+QU5tbez3w6AOHJFQ7z0a80lyQ==
X-Received: by 2002:a05:6000:40dd:b0:42b:39fb:e87f with SMTP id ffacd0b85a97d-42e0f350357mr10591359f8f.49.1764235949604;
        Thu, 27 Nov 2025 01:32:29 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:2372:89e8:ec59:7515])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6064sm2495137f8f.13.2025.11.27.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:32:26 -0800 (PST)
Date: Thu, 27 Nov 2025 10:32:21 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <aSgapXYd_Kbtw9ZB@google.com>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
 <20251017.ohthoos9Ogha@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017.ohthoos9Ogha@digikod.net>

Hello!

Thank you for the review!  It has taken a while, but now V3 is almost
ready and I have the answers to these questions.

On Fri, Oct 17, 2025 at 05:04:23PM +0200, Mickaël Salaün wrote:
> On Wed, Oct 01, 2025 at 01:18:06PM +0200, Günther Noack wrote:
> > Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
> > given Landlock ruleset is applied to all threads of the calling
> > process, instead of only the current one.
> > 
> > Without this flag, multithreaded userspace programs currently resort
> > to using the nptl(7)/libpsx hack for multithreaded policy enforcement,
> > which is also used by libcap and for setuid(2).  Using this scheme,
> > the threads of a process enforce the same Landlock ruleset, but the
> > resulting Landlock domains are still separate, which makes a
> > difference for Landlock's "scoped" access rights, where the domain
> > identity and nesting is used.  As a result, when using
> > LANLDOCK_SCOPE_SIGNAL, signaling between sibling threads stops
> > working.  This is a problem for programming languages and frameworks
> > which are inherently multithreaded (e.g. Go).
> 
> Having different Landlock domains also means that we get different
> domains ID, and the audit logs might confuse users.

True, I added that to the commit message.


> > Cc: Mickaël Salaün <mic@digikod.net>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: linux-security-module@vger.kernel.org
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h |   4 +
> >  security/landlock/cred.h      |  12 +
> >  security/landlock/limits.h    |   2 +-
> >  security/landlock/syscalls.c  | 433 +++++++++++++++++++++++++++++++++-
> 
> You can move most of this code to a new tsync.c file.

Done.


> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -117,11 +117,15 @@ struct landlock_ruleset_attr {
> >   *     future nested domains, not the one being created. It can also be used
> >   *     with a @ruleset_fd value of -1 to mute subdomain logs without creating a
> >   *     domain.
> > + *
> > + * %LANDLOCK_RESTRICT_SELF_TSYNC
> > + *    Apply the given ruleset atomically to all threads of the current process.
> 
> Please bump the Landlock ABI version and update the doc.

Done.

Docs: I added flag description to the landlock.h header so that it
appears in the documentation for the system call, and added an entry
to the section where we describe the differences between the ABI
versions.


> > diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> > index c82fe63ec598..eb28eeade760 100644
> > --- a/security/landlock/cred.h
> > +++ b/security/landlock/cred.h
> > @@ -65,6 +65,18 @@ landlock_cred(const struct cred *cred)
> >  	return cred->security + landlock_blob_sizes.lbs_cred;
> >  }
> >  
> > +static inline void landlock_cred_copy(struct landlock_cred_security *dst,
> > +				      const struct landlock_cred_security *src)
> > +{
> 
> You can simplify by removing the domain checks which are already done by
> landlock_put/get_ruleset().
> 
> > +	if (dst->domain)
> > +		landlock_put_ruleset(dst->domain);
> > +
> > +	*dst = *src;
> > +
> > +	if (dst->domain)
> > +		landlock_get_ruleset(src->domain);

Done.


> > +/*
> > + * restrict_one_thread - update a thread's Landlock domain in lockstep with the
> > + * other threads in the same process
> > + *
> > + * When this is run, the same function gets run in all other threads in the same
> > + * process (except for the calling thread which called landlock_restrict_self).
> > + * The concurrently running invocations of restrict_one_thread coordinate
> > + * through the shared ctx object to do their work in lockstep to implement
> > + * all-or-nothing semantics for enforcing the new Landlock domain.
> > + *
> > + * Afterwards, depending on the presence of an error, all threads either commit
> > + * or abort the prepared credentials.  The commit operation can not fail any more.
> > + */
> > +static void restrict_one_thread(struct tsync_shared_context *ctx)
> > +{
> > +	int res;
> 
> For consistency with existing code, please use "err" instead of "res".

Done.

> > +	struct cred *cred = NULL;
> > +	const struct cred *current_cred = current_cred();
> 
> No need for this variable.

Done.

> > +
> > +	if (current_cred == ctx->old_cred) {
> > +		/*
> > +		 * As a shortcut, switch out old_cred with new_cred, if
> > +		 * possible.
> > +		 *
> > +		 * Note: We are intentionally dropping the const qualifier here,
> > +		 * because it is required by commit_creds() and abort_creds().
> > +		 */
> > +		cred = (struct cred *)get_cred(ctx->new_cred);
> 
> Good.  You can extend the comment to explain that this optimization
> avoid creating new credentials in most cases, and then save memory.

Sounds good, I extended that comment a bit.


> > +	} else {
> > +		/* Else, prepare new creds and populate them. */
> > +		cred = prepare_creds();
> > +
> > +		if (!cred) {
> > +			atomic_set(&ctx->preparation_error, -ENOMEM);
> > +
> > +			/*
> > +			 * Even on error, we need to adhere to the protocol and
> > +			 * coordinate with concurrently running invocations.
> > +			 */
> > +			if (atomic_dec_return(&ctx->num_preparing) == 0)
> > +				complete_all(&ctx->all_prepared);
> > +
> > +			goto out;
> > +		}
> > +
> > +		landlock_cred_copy(landlock_cred(cred),
> > +				   landlock_cred(ctx->new_cred));
> > +	}
> > +
> > +	/*
> > +	 * Barrier: Wait until all threads are done preparing.
> > +	 * After this point, we can have no more failures.
> > +	 */
> > +	if (atomic_dec_return(&ctx->num_preparing) == 0)
> > +		complete_all(&ctx->all_prepared);
> > +
> > +	/*
> > +	 * Wait for signal from calling thread that it's safe to read the
> > +	 * preparation error now and we are ready to commit (or abort).
> > +	 */
> > +	wait_for_completion(&ctx->ready_to_commit);
> > +
> > +	/* Abort the commit if any of the other threads had an error. */
> > +	res = atomic_read(&ctx->preparation_error);
> > +	if (res) {
> > +		abort_creds(cred);
> > +		goto out;
> > +	}
> > +
> > +	/* If needed, establish enforcement prerequisites. */
> > +	if (!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> > +		task_set_no_new_privs(current);
> 
> We should always set PR_SET_NO_NEW_PRIVS if it is set on the calling
> thread as done by seccomp.  We should just store the result of
> task_no_new_privs() in tsync_shared_context and use it as condition here.
> This should be explained in the documentation.
> 
> This also mean that if the calling thread has CAP_SYS_ADMIN but not
> PR_SET_NO_NEW_PRIVS, then a sibling thread could not have CAP_SYS_ADMIN
> nor PR_SET_NO_NEW_PRIVS.  This would be a risky state but mainly because
> of the CAP_SYS_ADMIN inconsistency, not really the missing
> PR_SET_NO_NEW_PRIVS.

OK, done.  In line with seccomp now, where the logic is (pseudocode):

  if (task_no_new_privs(caller))
      task_set_no_new_privs(current);

As you are saying as well, the situation where the caller has
CAP_SYS_ADMIN but not PR_SET_NO_NEW_PRIVS results in sibling threads
that will also end up without PR_SET_NO_NEW_PRIVS.  But this is also
consistent with Seccomp.


> > +
> > +	commit_creds(cred);
> > +
> > +out:
> > +	/* Notify the calling thread once all threads are done */
> > +	if (atomic_dec_return(&ctx->num_unfinished) == 0)
> > +		complete_all(&ctx->all_finished);
> > +}
> > +
> > +/*
> > + * restrict_one_thread_callback - task_work callback for restricting a thread
> > + *
> > + * Calls restrict_one_thread with the struct landlock_shared_tsync_context.
> > + */
> > +static void restrict_one_thread_callback(struct callback_head *work)
> > +{
> > +	struct tsync_work *ctx = container_of(work, struct tsync_work, work);
> > +
> > +	restrict_one_thread(ctx->shared_ctx);
> > +}
> > +
> > +/*
> > + * struct tsync_works - a growable array of per-task contexts
> > + *
> > + * The zero-initialized struct represents the empty array.
> > + */
> > +struct tsync_works {
> > +	struct tsync_work **works;
> > +	size_t size;
> > +	size_t capacity;
> > +};
> > +
> > +/*
> > + * tsync_works_provide - provides a preallocated tsync_work for the given task
> > + *
> > + * This also stores a task pointer in the context and increments the reference
> > + * count of the task.
> > + *
> > + * Returns:
> > + *   A pointer to the preallocated context struct, with task filled in.
> > + *
> > + *   NULL, if we ran out of preallocated context structs.
> > + */
> > +static struct tsync_work *tsync_works_provide(struct tsync_works *s,
> > +					      struct task_struct *task)
> > +{
> > +	struct tsync_work *ctx;
> > +
> > +	if (s->size >= s->capacity)
> 
> In which case can this happen?  Should we wrap this in a WARN_ON_ONCE()?

As Jann also said in his reply, it can happen if the number of
existing threads differs between the first for_each_thread() loop
where we count the threads and the second for_each_thread() loop where
we fill the allocated slots in the array.  If it happens, we deal with
it by doing an additional loop to discover new threads.


> > +		return NULL;
> > +
> > +	ctx = s->works[s->size];
> > +	s->size++;
> > +
> > +	ctx->task = get_task_struct(task);
> > +	return ctx;
> > +}
> > +
> > +/*
> > + * tsync_works_grow_by - preallocates space for n more contexts in s
> > + *
> > + * Returns:
> > + *   -ENOMEM if the (re)allocation fails
> > + *   0       if the allocation succeeds, partially succeeds, or no reallocation was needed
> > + */
> > +static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
> > +{
> > +	int i;
> 
> size_t i;

Done.


> > +	size_t new_capacity = s->capacity + n;
> 
> > +	struct tsync_work **works;
> > +
> > +	if (new_capacity <= s->capacity)
> 
> This integer overflow check should return an error instead.

Oh, this was not meant to check overflow, actually.

As Jann is remarking in [1], what should really have happened here is
that the capacity should have been increased to s->size + n instead of
s->capacity + n a few lines above.  With that logic, it also makes
more sense to check whether the new capacity is below-or-equal the old
capacity, as it can legitimately happen in cases where the previously
allocated size was not used up in its entirety.  In that case, it is
possible that we already have sufficient space for the additional n
items, and it is reasonable to return 0 in that case.  (The semantics
of the function are "make sure that I have enough space for n
additional items", and that is fulfilled without error.)

[1] http://lore.kernel.org/all/CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5yx-Na1VLQ@mail.gmail.com

I did add an overflow check as well, for good measure (it's
practically for free).

> 
> > +		return 0;
> > +
> > +	works = krealloc_array(s->works, new_capacity, sizeof(s->works[0]),
> > +			       flags);
> > +	if (IS_ERR(works))
> > +		return PTR_ERR(works);
> > +
> > +	s->works = works;
> > +
> > +	for (i = s->capacity; i < new_capacity; i++) {
> > +		s->works[i] = kzalloc(sizeof(*s->works[i]), flags);
> 
> We should use a local variable to avoid storing an error code in
> s->works[i] and potentially dereferencing it later (e.g. in
> tsync_work_free).

As Jann also pointed out in the other mail, this was a mistake -
kzalloc returns NULL on failure, not an error code. (Fixed)

I extracted a local variable anyway, it's a bit clearer to read.


> Why can't we avoid this loop entirely and allocate a flat array with
> only one call to krealloc_array()?  Why struct tsync_works->works needs
> to be a pointer to a pointer?

We pass out pointers to the struct tsync_work elements when calling
task_work_add(), and these pointers are used by the task_work logic
and by our own implementation of that task_work,
restrict_one_thread_callback().  If these elements were directly in
the array, realloc would move them to new locations and these pointers
would then point into freed memory.

Discussed by Jann in [2] as well.

[2] https://lore.kernel.org/all/CAG48ez2KoF6hVSJwdPfUpN3oroMww6Mu1+-bsBSbO8C5f91P6Q@mail.gmail.com/

If we were to take a very close look at all the affected code, we
could potentially convince ourselves that we can discard these objects
after the all_prepared point, but this all seems like a brittle coding
pattern that would go against normal conventions and could break in a
future version. (e.g. when task_work_run() would invoke
"work->func(work)", the memory behind that "work" pointer would get
freed halfway throughout that invocation.  It seems a bit brittle.)
I'd prefer to not base our code correctness on such complicated
assumptions about other corners of the code.


> > +		if (IS_ERR(s->works[i])) {
> > +			/*
> > +			 * Leave the object in a consistent state,
> > +			 * but return an error.
> > +			 */
> > +			s->capacity = i;
> > +			return PTR_ERR(s->works[i]);
> > +		}
> > +	}
> > +	s->capacity = new_capacity;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * tsync_works_contains - checks for presence of task in s
> > + */
> > +static bool tsync_works_contains_task(struct tsync_works *s,
> > +				      struct task_struct *task)
> > +{
> > +	size_t i;
> > +
> > +	for (i = 0; i < s->size; i++)
> > +		if (s->works[i]->task == task)
> > +			return true;
> > +	return false;
> > +}
> > +
> > +/*
> > + * tsync_works_free - free memory held by s and drop all task references
> > + */
> > +static void tsync_works_free(struct tsync_works *s)
> 
> tsync_works_put() would be more appropriate since this function doesn't
> free s.

put() is usually a reference count decrement, and we don't do that either.
After a bit of thinking, I settled on tsync_works_release(), which is
a slightly more generic wording that does not sound like a refcount.


> > @@ -566,5 +987,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
> >  #endif /* CONFIG_AUDIT */
> >  
> > +	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
> > +		res = restrict_sibling_threads(current_cred(), new_cred);
> > +		if (res != 0) {
> 
> if (!err) {

Done.

(Corrected it in another place in landlock_restrict_sibling_threads() as well)


—Günther
