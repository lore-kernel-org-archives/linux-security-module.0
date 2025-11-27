Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80726F29F
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239537; cv=none; b=bagBuHhFh0E1kJlqJN4/NZPVtLXyjKhlU5v0hxgl2XkN5CoJ/iJnPGfOmntnkyZBGadElwvCYIkPkdZL8QafooSOud0OF98hhO47L6tHmrM1Ngu7mj/xhIhCgjfJ861UzV/URChUZkQJ0SBlaGY1vmTIAB7SF2A/uo79712QxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239537; c=relaxed/simple;
	bh=GyJ3o5qfR6cqmPkOHsgh0P9eFO/R0XYurLhER62zzyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDLvB06k457Zglg3hokW2XT3E3mJT5ZU0phgR9UrIWOiy25JbBs0KcZyVpO7qMKbw/vnpoBiGz0saraQtnlpOla6V1LBJF5tAXGCZYwFFOou4bBOydVf5qusW/noYT2ApuIDy0qZb9rW7psDmsQWiXqvV5dqliHrmnqpm12sMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKFUFmGC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKFUFmGC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso6115175e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764239533; x=1764844333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/IhTZONkluOKlTgm2ZycslvEunFiqGakSs0SYii3+E=;
        b=SKFUFmGCPu/ZGlEC8BPRjqk+w19c+zdqh0jlYnU4EGMGjeGWbRsK3SB+34AEwCsH+z
         cMCBVDNVtNBaRuaQBYw8hzCY7fLTOj+9CHmLMmPfOAlayRUaE44YR83zY7e2uzewVmOO
         l/P0CP1olp1HWpgH7aVhxtf9wrBdCfppA4pedWkZoN6TOTJZsan9FKpZdCozXw1G4Fni
         8iteELQVVxWY68VopTc/vaEF1NLk9qwPFOsel5duOqIB+m2i11EVKpMDNC3Ib20Q1DsZ
         jVP63Wxv3YeQjDHdT8Qx1Th2KHrrwiLQO4OqVdnA95OuU0z1039e0GJp01ttAC3xrhWJ
         t68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239533; x=1764844333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/IhTZONkluOKlTgm2ZycslvEunFiqGakSs0SYii3+E=;
        b=o8IIQNDvv8PMRTXffgGLtaJsOqIYEBXk1ee5vQpgRrIWYucALmyApKmkCOrD7tLJ7i
         /iw3dUzcccL1skX+kTqsO7ACWb0qJ+8ns9Lxz2hxcwLWi63T1w+qmBZtgEkelRs4eS8B
         cmM5QzSMUlCfN669trkYhDrVi+/u01fHqwmN/LnpNk+V0EpjbxuG10kZAb27Nt8bwBEl
         E7ac/oZNONh1OPph+CMvxkD0Mhq4MucyD4GduFBkskMED0CMQ0CsgzYKmvFiUGcmC47x
         v2IpABZAMFYcB/pls1ADVLRc8TW2ERe5iXgE9QbIzSyrf/qKM2cMx46Qx9mpIk1AHkQP
         JD7A==
X-Forwarded-Encrypted: i=1; AJvYcCVOEiEHhBhFoszvNT7JeHkKiquE+uw1KGq7a31i+oALlwcF081vdApMMh5aJkUD+Ks9RE7tTZ32/wZaKjkUobN7TFUlqAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Sw9ciFoAis6mbtKurWgrUAr0I+4pnI7lPFtnqoP5diq6DcAx
	bt7eNbFkDj41Uf6xnstx3UWqnovSQ8uKhsF3Uwm7Kk6FlnEhSGZxeIUU2lXvEb/3Xk+wDCoLu0W
	WSn4Fjw==
X-Gm-Gg: ASbGnctrvtY5TgtCABcZDf5Q5H9S5bm39IHCc8wWzQnj3s3I1ZCP4r3Y0dOAUmhKldB
	wWDvpfmdIybrkVC/8c/Mdmd8D8nHNplHTnRX/3GX6huCUwQ0SWVC4bN8katzqx+qWkFhXlg7EYF
	9RxJDDNoSasBCq6ps47lPqHzF3C1wSfMyi7WniLCNtRGrKqInz72W581Flnzt/Vk7G5rD1ct+u4
	+lP6tkiawm08NKNK/l5hXG57DZrHkFt0Gb0VwQydWQgMIrrn5P1k5fVqUIF7eaP4Dsk3SfoY0FO
	cYTl5ZSA93Y9HREtdPr8iC7ZAWhgU6eRAdxGbutpbdOpLVbonMSDO0U0y6j30bG13V/JhyrjUNg
	E3EC6RynpslExgUXRcNjERJTH00FzDnLxe9ie9BnRLLdwQ/XMZ/1pDOVYzP98j5VwqguCLYMMuD
	F6sH+Dx9poyutKy51DoxoBp9MPq7SLYMl3ajl3o9dYRQ==
X-Google-Smtp-Source: AGHT+IGkFUzKtQ1ejM+R7d0HZ9a0PYFnLhNqdoQuu3BLywxBzYnRSnQkxBO/YDpNCJQo2wLXR8Gzxw==
X-Received: by 2002:a05:600c:46c3:b0:477:6d96:b3ca with SMTP id 5b1f17b1804b1-477c01743e2mr225378745e9.5.1764239533095;
        Thu, 27 Nov 2025 02:32:13 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:2372:89e8:ec59:7515])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790530f0a4sm63532045e9.8.2025.11.27.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:32:12 -0800 (PST)
Date: Thu, 27 Nov 2025 11:32:07 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <aSgopxqRkzKhvUXw@google.com>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
 <CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5yx-Na1VLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5yx-Na1VLQ@mail.gmail.com>

On Fri, Oct 24, 2025 at 11:11:10PM +0200, Jann Horn wrote:
> On Wed, Oct 1, 2025 at 1:18 PM Günther Noack <gnoack@google.com> wrote:
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
> This looks good to me overall, though there are a couple details to fix.
> 
> [...]
> > +static inline void landlock_cred_copy(struct landlock_cred_security *dst,
> > +                                     const struct landlock_cred_security *src)
> > +{
> > +       if (dst->domain)
> > +               landlock_put_ruleset(dst->domain);
> > +
> > +       *dst = *src;
> 
> nit: I would add a short comment at the definition of struct
> landlock_cred_security noting that this function memcpy's the entire
> struct

Sounds good. I added a small remark "when updating this, also update
landlock_cred_copy() if needed".

> > +
> > +       if (dst->domain)
> > +               landlock_get_ruleset(src->domain);
> > +}
> [...]
> > +/*
> > + * tsync_works_grow_by - preallocates space for n more contexts in s
> > + *
> > + * Returns:
> > + *   -ENOMEM if the (re)allocation fails
> > + *   0       if the allocation succeeds, partially succeeds, or no reallocation was needed
> > + */
> > +static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
> > +{
> > +       int i;
> > +       size_t new_capacity = s->capacity + n;
> 
> (You only have to grow to `s->size + n` but I guess this works too.)

Thanks, well spotted. This was indeed the intended behavior, the
new_capacity <= s->capacity check also makes much more sense that
way. (I have a more detailed answer in another reply.)  I fixed this
and also added an overflow check for good measure.


> > +       struct tsync_work **works;
> > +
> > +       if (new_capacity <= s->capacity)
> > +               return 0;
> > +
> > +       works = krealloc_array(s->works, new_capacity, sizeof(s->works[0]),
> > +                              flags);
> > +       if (IS_ERR(works))
> > +               return PTR_ERR(works);
> 
> The kmalloc function family returns NULL on failure, so you have to
> check for NULL here instead of IS_ERR(), and then return -ENOMEM
> instead of PTR_ERR().

Thanks, fixed.


> > +       s->works = works;
> > +
> > +       for (i = s->capacity; i < new_capacity; i++) {
> > +               s->works[i] = kzalloc(sizeof(*s->works[i]), flags);
> > +               if (IS_ERR(s->works[i])) {
> 
> (again, kzalloc() returns NULL on failure)

Done.


> > +                       /*
> > +                        * Leave the object in a consistent state,
> > +                        * but return an error.
> > +                        */
> > +                       s->capacity = i;
> > +                       return PTR_ERR(s->works[i]);
> > +               }
> > +       }
> > +       s->capacity = new_capacity;
> > +       return 0;
> > +}
> [...]
> > +/*
> > + * tsync_works_free - free memory held by s and drop all task references
> > + */
> > +static void tsync_works_free(struct tsync_works *s)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < s->size; i++)
> > +               put_task_struct(s->works[i]->task);
> 
> You'll need a NULL check before calling put_task_struct(), since the
> task_work_add() failure path can NULL out ->task. (Alternatively you
> could leave the task pointer intact in the task_work_add() failure
> path, since task_work_add() only fails if the task is already
> PF_EXITING. The &work_exited marker which causes task_work_add() to
> fail is only put on the task work list when task_work_run() runs on a
> PF_EXITING task.)

Thanks for spotting this, this is correct!  I added a NULL check.

> > +       for (i = 0; i < s->capacity; i++)
> > +               kfree(s->works[i]);
> > +       kfree(s->works);
> > +       s->works = NULL;
> > +       s->size = 0;
> > +       s->capacity = 0;
> > +}
> > +
> > +/*
> > + * restrict_sibling_threads - enables a Landlock policy for all sibling threads
> > + */
> > +static int restrict_sibling_threads(const struct cred *old_cred,
> > +                                   const struct cred *new_cred)
> > +{
> > +       int res;
> > +       struct task_struct *thread, *caller;
> > +       struct tsync_shared_context shared_ctx;
> > +       struct tsync_works works = {};
> > +       size_t newly_discovered_threads;
> > +       bool found_more_threads;
> > +       struct tsync_work *ctx;
> > +
> > +       atomic_set(&shared_ctx.preparation_error, 0);
> > +       init_completion(&shared_ctx.all_prepared);
> > +       init_completion(&shared_ctx.ready_to_commit);
> > +       atomic_set(&shared_ctx.num_unfinished, 0);
> 
> I think num_unfinished should be initialized to 1 here and decremented
> later on, I think, similar to how num_preparing works. Though it only
> matters in the edge case where the first thread we send task work to
> immediately fails the memory allocation. (And then you can also remove
> that "if (works.size)" check before
> "wait_for_completion(&shared_ctx.all_finished)".)

Thank you, good catch!

The works.size check was inaccurate, because in the case of an error
during task_work_add(), it wasn't actually counting the number of
scheduled task works, but overestimating it.  The scenario is a bit
obscure, but initializing num_unfinished is a more robust approach
that rules out that variant of bugs.


> > +       init_completion(&shared_ctx.all_finished);
> > +       shared_ctx.old_cred = old_cred;
> > +       shared_ctx.new_cred = new_cred;
> > +
> > +       caller = current;
> [...]
> > +                       init_task_work(&ctx->work,
> > +                                      restrict_one_thread_callback);
> > +                       res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> > +                       if (res) {
> > +                               /*
> > +                                * Remove the task from ctx so that we will
> > +                                * revisit the task at a later stage, if it
> > +                                * still exists.
> > +                                */
> > +                               put_task_struct_rcu_user(ctx->task);
> 
> The complement to get_task_struct() is put_task_struct(), which I see
> you also used in tsync_works_free(). put_task_struct_rcu_user() is for
> a different, special type of task_struct reference.

Thanks, done.


> > +                               ctx->task = NULL;
> > +
> > +                               atomic_set(&shared_ctx.preparation_error, res);
> 
> I think you don't want to set preparation_error here - that would
> cause the syscall to return -ESRCH if we happen to race with an
> exiting thread. Just remove that line - in the next iteration, we'll
> skip this thread even if it still exists, because it has PF_EXITING
> set by this point.

Thanks, that is correct and I fixed it as you suggested. -- The thread
exiting is the only reason why task_work_add() can fail.  In the
(perfectly valid) case where one of the sibling threads happens to
exit, we do not want the landlock_restrict_self() syscall to fail just
because of that.


> > +                               atomic_dec(&shared_ctx.num_preparing);
> > +                               atomic_dec(&shared_ctx.num_unfinished);
> > +                       }
> > +               }
> > +               rcu_read_unlock();
> > +
> > +               /*
> > +                * Decrement num_preparing for current, to undo that we
> > +                * initialized it to 1 at the beginning of the inner loop.
> > +                */
> > +               if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> > +                       wait_for_completion(&shared_ctx.all_prepared);
> 
> I'm sorry, because this will make the patch a little bit more
> complicated, but... I don't think you can use wait_for_completion()
> here. Consider the scenario where two userspace threads of the same
> process call this functionality (or a kernel subsystem that does
> something similar) simultaneously. Each thread will wait for the other
> indefinitely, and userspace won't even be able to resolve the deadlock
> by killing the processes.
> Similar issues would probably apply if, for example, GDB tried to
> attach to the process with bad timing - if GDB ptrace-stops another
> thread before you schedule task work for it, and then tries to
> ptrace-stop this thread, I think this thread could essentially be in a
> deadlock with GDB.
> 
> You'll have to do something else here. I think the best solution would
> be to use wait_for_completion_interruptible() instead; then if that
> fails, tear down all the task work stuff that was already scheduled,
> and return with error -ERESTARTNOINTR. Something like (entirely
> untested):
> 
> /* interruptible wait to avoid deadlocks while waiting for other tasks
> to enter our task work */
> if (wait_for_completion_interruptible(&shared_ctx.all_prepared)) {
>   atomic_set(&shared_ctx.preparation_error, -ERESTARTNOINTR);
>   for (int i=0; i<works.size; i++) {
>     if (task_work_cancel(works.works[i]->task, &works.works[i]->work))
>       if (atomic_dec_return(&shared_ctx.num_preparing))
>         complete_all(&shared_ctx.all_prepared);
>   }
>   /* at this point we're only waiting for tasks that are already
> executing the task work */
>   wait_for_completion(&shared_ctx.all_prepared);
> }
> 
> Note that if the syscall returns -ERESTARTNOINTR, that won't be
> visible to userspace (except for debugging tools like strace/gdb); the
> kernel ensures that the syscall will transparently re-execute
> immediately. (It literally decrements the saved userspace instruction
> pointer by the size of a syscall instruction, so that when the kernel
> returns to userspace, the next instruction that executes will redo the
> syscall.) This allows us to break the deadlock without having to write
> any ugly retry logic or throwing userspace-visible errors.

Thank you again for catching this!

I used your suggestion, with the following (minor) differences:

1. Factored it out as a function (indentation level got too high...)
2. typo: call complete_all() only if atomic_dec_return() returns 0
3. Do the same barrier synchronization dance with num_unfinished/all_finished as well.

...and I also implemented a selftest for the case where
landlock_restrict_self() gets called by two adjacent threads at the
same time.

I'll write down my reasoning why this works for reference:

The problem in V2 is that we can run into a deadlock in the case where
two thread call landlock_restrict_self().  In that case, they'll both
become uninterruptible at syscall entry and try to schedule a
task_work for each other.  Then, they proceed to wait for each other's
task_work to execute, which never happens because the task_work never
gets scheduled.

This is resolved by using an interruptible wait.  With the
interruptible wait, the task can detect the condition where a signal
(or task work) comes in, execute that task_work and bail out of the
system call cleanly (we un-schedule the task_works for other threads
that are still pending and we abort all the task_works that have
already started to run by setting the shared_ctx.preparation_error).
After returning from the system call with -ERESTARTNOINTR, it gets
retried automatically to recover from the problem.

In all the other cases where we wait_for_completion() uninterruptibly,
we can reason about that returning, because these happen under
circumstances where we know that the task works we are waiting for
have all been started already.

I have reproduced the deadlock and verified the fixed implementation
with the selftest, by temporarily adding mdelay() calls and a lot of
logging in strategic places.

> 
> > +       } while (found_more_threads &&
> > +                !atomic_read(&shared_ctx.preparation_error));
> > +
> > +       /*
> > +        * We now have all sibling threads blocking and in "prepared" state in
> > +        * the task work. Ask all threads to commit.
> > +        */
> > +       complete_all(&shared_ctx.ready_to_commit);
> > +
> > +       if (works.size)
> > +               wait_for_completion(&shared_ctx.all_finished);
> > +
> > +       tsync_works_free(&works);
> > +
> > +       return atomic_read(&shared_ctx.preparation_error);
> > +}
> [...]
> > @@ -566,5 +987,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >         new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
> >  #endif /* CONFIG_AUDIT */
> >
> > +       if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
> > +               res = restrict_sibling_threads(current_cred(), new_cred);
> > +               if (res != 0) {
> > +                       abort_creds(new_cred);
> > +                       return res;
> > +               }
> > +       }
> 
> Annoyingly, there is a special-case path above for the case where
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set without actually
> applying any ruleset. In that case you won't reach this point, and so
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF would only affect the
> current thread in that case. I doubt it'd be very noticeable, but
> still, it might be a good idea to rearrange things here a bit... maybe
> instead of the current `if (!ruleset) return commit_creds(new_cred);`,
> put some of the subsequent stuff in a `if (ruleset) {` block?

Thanks, I fixed that one as well.

—Günther
