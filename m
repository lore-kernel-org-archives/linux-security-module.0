Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A92FB0AB
	for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340310; cv=none; b=dcCREBeGIBg6Bpe+EtZ/RAvWZkvO9U0sdqk/V3ognxiYzHj2Nf5T4PllRtCA9BbJOPCXHKK06aKrDKzJFZKPwnKGS9J+6D2NP3xbvM3+dRYl61PleJHe6t7N8BuWvBa21WWp9PfnOtql8HSQryd0yal41oM/lDcRwdpCbmCWVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340310; c=relaxed/simple;
	bh=RUScoPmeu611HPgKVWnusfapdovDrGbWm/YA/FmJh+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGR+/LjiGXWU6SAFl2f9JzD0fg06as9BXxpiwi17wPsaj6tQr1Pc446IV1iUsZfnZw58iqSTg8qcdlAhkFqOB/CP3XVsJjSiL+xJYujek3JM+oZqJx3koJIZJXhKU03aQINaKM2elT4MwK41AnAtK9bPP1r5lW53nJFDnZvRslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTvkFWgM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTvkFWgM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so958a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761340307; x=1761945107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VspeXcxDsKYB1s6JKLm4yyRqd0232xzXbNa1Czm0k4=;
        b=KTvkFWgMV++osy1CjbcN3UPI4RClzrkLnWPoPCxaw1FN8HlaZtkWXrj7O0aurFfZD4
         u4Nwh2DPKFTIcGLdAKB8//LrHR5MMIOAVNrIHFKJs+MknNEctBaTkx35UjJuzLP2GDuU
         4BCOI2DraIJD0qMrhLT7vuP1AR/vXxAm/0WK9SzBgXBPla03m9ttvRhIzaqHl4UY3KOs
         Y668ZIX2pw7re7Mdi9r3xnj+eYg5rT4QwtyvI65MrC7hAVVq4IvpT3Z4SyS+pW9R80nE
         UUu32mYR0EKKANuAp0CQQKa8tFBegv5O8BmgL4Oni1kTF8lwDQOrURmgrdjTAPhBpLn2
         D1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761340307; x=1761945107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VspeXcxDsKYB1s6JKLm4yyRqd0232xzXbNa1Czm0k4=;
        b=bJH4rNd2XeV12EX9rdSznt0rTfSoKF5r3Oyvuic1DfDn+8GZhXZQ0PJbyLpaQEjPoN
         nf5GQYwqMsfLS8702Zm2XPhtfM18BuzuxWdhOaR6BSbPvlca6zFcus0rxtJ3x8JACd2s
         6rNJoVbQcTzC8gsZdRbcVpE/qu/IGJDFjPiljWR9kFTg4yfHuw/kJ6vQ6LquQeHYRXck
         a9VQXuD89nRVL3FI/3708ZCLLgCm6UscUzNeVtNAkoP7R9e1I6hgEbmflZMscPpGm0DV
         TysCgFR8bBPcSjcURSFCPduBPM7mPhDnsZiQxL7XglLVDBsc5o5ejXI/4FNz9T3sbzaj
         3Ruw==
X-Forwarded-Encrypted: i=1; AJvYcCWHrOs6GYoFE4SWp0zApUzb54biWoVAoF6mkYShpKFJUXCnmvzHbvn6era6oaTZOAW19f2vM5Ivf57vVB8Yg7G+x/umz+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aNcQI1WdzBZVmJuWupz23zYVBY1qaqAliT5vQgDeejPo0gHD
	TrrDowkOXhdYpp3YN8+NU36f7ThqLISTDXu4tPbxie5sav7B+YQ75FA2zecdFaoNRAWY9CdWSQb
	G5JU90D0xsL/aFVvUc5RZFNOwCdQTpDKl/nmrxeL7
X-Gm-Gg: ASbGncs25gka3QGmFBVzOS6r5gYU2ci6p5jVXo9lqyOeqRe8AZ6mSHalUYqOF95PrYi
	IvpzhWe2hgrda0fTFHdWUf/ssmXABEfBJ+PnwsfOMiA2/P/FGP2WCA8a+l9rWAoB2CbsjgVkIjR
	j0G1yIF2txYDkHDaVE/D+Wua/mTDSljOcCvoguFfBg1A2/vRngCwjzIHyIoQzV7QdQdIKu/vb/8
	3aNDJbritkSDpPY4QZCSWc495syvSMXkm2Gdn01w0L6//xcMgop3QMs3gEm8ZpLpVaYRK8HbSrt
	2Ly7lUbA4qQd6Q==
X-Google-Smtp-Source: AGHT+IEdhI04b/zcODyPwavXcpAlFkkSlVsgX+LcQ50epmJZL2VSAxuBvAqNaZTrrkMsyCTEEnf4G29jDEqfw0943VE=
X-Received: by 2002:a05:6402:1606:b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-63e7c534ce3mr29147a12.3.1761340306596; Fri, 24 Oct 2025
 14:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111807.18902-1-gnoack@google.com> <20251001111807.18902-2-gnoack@google.com>
In-Reply-To: <20251001111807.18902-2-gnoack@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 23:11:10 +0200
X-Gm-Features: AWmQ_bkXJIRCaCV5s7BScVJ5nmYtYGZ690er2FZ4TnkqMxqwWDtUEEKQs_b3vHI
Message-ID: <CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5yx-Na1VLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for landlock_restrict_self()
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:18=E2=80=AFPM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
> Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
> given Landlock ruleset is applied to all threads of the calling
> process, instead of only the current one.
>
> Without this flag, multithreaded userspace programs currently resort
> to using the nptl(7)/libpsx hack for multithreaded policy enforcement,
> which is also used by libcap and for setuid(2).  Using this scheme,
> the threads of a process enforce the same Landlock ruleset, but the
> resulting Landlock domains are still separate, which makes a
> difference for Landlock's "scoped" access rights, where the domain
> identity and nesting is used.  As a result, when using
> LANLDOCK_SCOPE_SIGNAL, signaling between sibling threads stops
> working.  This is a problem for programming languages and frameworks
> which are inherently multithreaded (e.g. Go).

This looks good to me overall, though there are a couple details to fix.

[...]
> +static inline void landlock_cred_copy(struct landlock_cred_security *dst=
,
> +                                     const struct landlock_cred_security=
 *src)
> +{
> +       if (dst->domain)
> +               landlock_put_ruleset(dst->domain);
> +
> +       *dst =3D *src;

nit: I would add a short comment at the definition of struct
landlock_cred_security noting that this function memcpy's the entire
struct

> +
> +       if (dst->domain)
> +               landlock_get_ruleset(src->domain);
> +}
[...]
> +/*
> + * tsync_works_grow_by - preallocates space for n more contexts in s
> + *
> + * Returns:
> + *   -ENOMEM if the (re)allocation fails
> + *   0       if the allocation succeeds, partially succeeds, or no reall=
ocation was needed
> + */
> +static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t fl=
ags)
> +{
> +       int i;
> +       size_t new_capacity =3D s->capacity + n;

(You only have to grow to `s->size + n` but I guess this works too.)

> +       struct tsync_work **works;
> +
> +       if (new_capacity <=3D s->capacity)
> +               return 0;
> +
> +       works =3D krealloc_array(s->works, new_capacity, sizeof(s->works[=
0]),
> +                              flags);
> +       if (IS_ERR(works))
> +               return PTR_ERR(works);

The kmalloc function family returns NULL on failure, so you have to
check for NULL here instead of IS_ERR(), and then return -ENOMEM
instead of PTR_ERR().

> +
> +       s->works =3D works;
> +
> +       for (i =3D s->capacity; i < new_capacity; i++) {
> +               s->works[i] =3D kzalloc(sizeof(*s->works[i]), flags);
> +               if (IS_ERR(s->works[i])) {

(again, kzalloc() returns NULL on failure)

> +                       /*
> +                        * Leave the object in a consistent state,
> +                        * but return an error.
> +                        */
> +                       s->capacity =3D i;
> +                       return PTR_ERR(s->works[i]);
> +               }
> +       }
> +       s->capacity =3D new_capacity;
> +       return 0;
> +}
[...]
> +/*
> + * tsync_works_free - free memory held by s and drop all task references
> + */
> +static void tsync_works_free(struct tsync_works *s)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < s->size; i++)
> +               put_task_struct(s->works[i]->task);

You'll need a NULL check before calling put_task_struct(), since the
task_work_add() failure path can NULL out ->task. (Alternatively you
could leave the task pointer intact in the task_work_add() failure
path, since task_work_add() only fails if the task is already
PF_EXITING. The &work_exited marker which causes task_work_add() to
fail is only put on the task work list when task_work_run() runs on a
PF_EXITING task.)

> +       for (i =3D 0; i < s->capacity; i++)
> +               kfree(s->works[i]);
> +       kfree(s->works);
> +       s->works =3D NULL;
> +       s->size =3D 0;
> +       s->capacity =3D 0;
> +}
> +
> +/*
> + * restrict_sibling_threads - enables a Landlock policy for all sibling =
threads
> + */
> +static int restrict_sibling_threads(const struct cred *old_cred,
> +                                   const struct cred *new_cred)
> +{
> +       int res;
> +       struct task_struct *thread, *caller;
> +       struct tsync_shared_context shared_ctx;
> +       struct tsync_works works =3D {};
> +       size_t newly_discovered_threads;
> +       bool found_more_threads;
> +       struct tsync_work *ctx;
> +
> +       atomic_set(&shared_ctx.preparation_error, 0);
> +       init_completion(&shared_ctx.all_prepared);
> +       init_completion(&shared_ctx.ready_to_commit);
> +       atomic_set(&shared_ctx.num_unfinished, 0);

I think num_unfinished should be initialized to 1 here and decremented
later on, I think, similar to how num_preparing works. Though it only
matters in the edge case where the first thread we send task work to
immediately fails the memory allocation. (And then you can also remove
that "if (works.size)" check before
"wait_for_completion(&shared_ctx.all_finished)".)

> +       init_completion(&shared_ctx.all_finished);
> +       shared_ctx.old_cred =3D old_cred;
> +       shared_ctx.new_cred =3D new_cred;
> +
> +       caller =3D current;
[...]
> +                       init_task_work(&ctx->work,
> +                                      restrict_one_thread_callback);
> +                       res =3D task_work_add(thread, &ctx->work, TWA_SIG=
NAL);
> +                       if (res) {
> +                               /*
> +                                * Remove the task from ctx so that we wi=
ll
> +                                * revisit the task at a later stage, if =
it
> +                                * still exists.
> +                                */
> +                               put_task_struct_rcu_user(ctx->task);

The complement to get_task_struct() is put_task_struct(), which I see
you also used in tsync_works_free(). put_task_struct_rcu_user() is for
a different, special type of task_struct reference.

> +                               ctx->task =3D NULL;
> +
> +                               atomic_set(&shared_ctx.preparation_error,=
 res);

I think you don't want to set preparation_error here - that would
cause the syscall to return -ESRCH if we happen to race with an
exiting thread. Just remove that line - in the next iteration, we'll
skip this thread even if it still exists, because it has PF_EXITING
set by this point.

> +                               atomic_dec(&shared_ctx.num_preparing);
> +                               atomic_dec(&shared_ctx.num_unfinished);
> +                       }
> +               }
> +               rcu_read_unlock();
> +
> +               /*
> +                * Decrement num_preparing for current, to undo that we
> +                * initialized it to 1 at the beginning of the inner loop=
.
> +                */
> +               if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> +                       wait_for_completion(&shared_ctx.all_prepared);

I'm sorry, because this will make the patch a little bit more
complicated, but... I don't think you can use wait_for_completion()
here. Consider the scenario where two userspace threads of the same
process call this functionality (or a kernel subsystem that does
something similar) simultaneously. Each thread will wait for the other
indefinitely, and userspace won't even be able to resolve the deadlock
by killing the processes.
Similar issues would probably apply if, for example, GDB tried to
attach to the process with bad timing - if GDB ptrace-stops another
thread before you schedule task work for it, and then tries to
ptrace-stop this thread, I think this thread could essentially be in a
deadlock with GDB.

You'll have to do something else here. I think the best solution would
be to use wait_for_completion_interruptible() instead; then if that
fails, tear down all the task work stuff that was already scheduled,
and return with error -ERESTARTNOINTR. Something like (entirely
untested):

/* interruptible wait to avoid deadlocks while waiting for other tasks
to enter our task work */
if (wait_for_completion_interruptible(&shared_ctx.all_prepared)) {
  atomic_set(&shared_ctx.preparation_error, -ERESTARTNOINTR);
  for (int i=3D0; i<works.size; i++) {
    if (task_work_cancel(works.works[i]->task, &works.works[i]->work))
      if (atomic_dec_return(&shared_ctx.num_preparing))
        complete_all(&shared_ctx.all_prepared);
  }
  /* at this point we're only waiting for tasks that are already
executing the task work */
  wait_for_completion(&shared_ctx.all_prepared);
}

Note that if the syscall returns -ERESTARTNOINTR, that won't be
visible to userspace (except for debugging tools like strace/gdb); the
kernel ensures that the syscall will transparently re-execute
immediately. (It literally decrements the saved userspace instruction
pointer by the size of a syscall instruction, so that when the kernel
returns to userspace, the next instruction that executes will redo the
syscall.) This allows us to break the deadlock without having to write
any ugly retry logic or throwing userspace-visible errors.

> +       } while (found_more_threads &&
> +                !atomic_read(&shared_ctx.preparation_error));
> +
> +       /*
> +        * We now have all sibling threads blocking and in "prepared" sta=
te in
> +        * the task work. Ask all threads to commit.
> +        */
> +       complete_all(&shared_ctx.ready_to_commit);
> +
> +       if (works.size)
> +               wait_for_completion(&shared_ctx.all_finished);
> +
> +       tsync_works_free(&works);
> +
> +       return atomic_read(&shared_ctx.preparation_error);
> +}
[...]
> @@ -566,5 +987,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, r=
uleset_fd, const __u32,
>         new_llcred->domain_exec |=3D BIT(new_dom->num_layers - 1);
>  #endif /* CONFIG_AUDIT */
>
> +       if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
> +               res =3D restrict_sibling_threads(current_cred(), new_cred=
);
> +               if (res !=3D 0) {
> +                       abort_creds(new_cred);
> +                       return res;
> +               }
> +       }

Annoyingly, there is a special-case path above for the case where
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set without actually
applying any ruleset. In that case you won't reach this point, and so
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF would only affect the
current thread in that case. I doubt it'd be very noticeable, but
still, it might be a good idea to rearrange things here a bit... maybe
instead of the current `if (!ruleset) return commit_creds(new_cred);`,
put some of the subsequent stuff in a `if (ruleset) {` block?
