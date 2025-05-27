Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFC2AE99
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356040; cv=none; b=q3FsJmjBQmbRZtN3slnJQoHl6pXReYgIYbkyjAS7qcJ7txyCSQ9Vh8fEhqZH/CBZVe0fQFXzamHiRB+vvXPBXQOfPqKq403oxxEpGjhLRBzqQlNTkDtdnjBXHi4PpIeP8XkBstJ36JXykKQaX+XofMLwJrkgIaEVKT9c6kinBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356040; c=relaxed/simple;
	bh=Xv/dRmh0m35JE7egUOEw1JFCjRd6AcJU6uN69FdDKXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9oTQpE7QQm46wNnt0x0r1WTpPTRU7ecjA4aMRurqksXlbadXoLC2rnL+sF1S9pRMV9GSWHa4tvHqsgO1C4QMinaHlOrm9oTXuYubTOpvurN+9wxn1kMA9YiQoW0elH12z2B0pyNQhMDjV9OrB1V8BZ6sKZkS7JzjPDgB0QftjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhg8qCsA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhg8qCsA"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so21205a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748356037; x=1748960837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHYrUZynmF1+LQe/MzD5OkoDbTa7T8UCiEl2TMfrPDY=;
        b=rhg8qCsA/eBR5yyDY6VEMeHSUlqo4veFiEi3wVOQZZWujmrYx/sWHNnxAyG4aIed18
         1rakhbDcaB/aU/xaftFSB+2jbhmQVKmPHyBHtGMMqqQyphxeRMQApAt9FN93e3fm6pc8
         S1wCtcsKY5UjQyoPyRtZbL+ROvjQE8m8uCHiPmnBDUIe1pa0VYAgP82XQmNIIfIby/P9
         UTd0xU7CPrl1UT552XYrbY4PGFxkvk05m/nZaSoFay+VOO4pPXH2RfA3qVO8d0dxytLn
         jZ2h7TDaj0INEHnYOCiDy3rJKlOfEFlaziplGZsuymHXV2oOTu3hSqbsUh2vaJ/7G8K4
         57VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356037; x=1748960837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHYrUZynmF1+LQe/MzD5OkoDbTa7T8UCiEl2TMfrPDY=;
        b=cLoR/rSroB0fzsMYUctZSinyRk5747B/Gjo40pAnuNJ/xbnOiaIN3wIhNhdCpV1cxM
         1P5VeS1+dqUGj25/2ys4k9H2wmKLAMYL3V03ZvNKIgDz8B0k0AS3F/fbXV1GEniMUuLI
         Q0HKhzU1jPtqtyqSMwjBFoLQackJisqRfhF4h1qPO6an8zngF7KSMjcFHNhucrH3NInj
         L8IBii8SupB0T2I0IgNXlHrbrb8ChVgZ5Mvbk07rwpkKZ+AEru8L4hqntAhkNpqIY21p
         EljCyeIMcdK7bCeZMOvdJqCSeAubZNVAJRd56mQutg8oKkkfNrXKsQa2OVrZNsHM7mtX
         Ra/w==
X-Forwarded-Encrypted: i=1; AJvYcCW+ittW5Ql8fYbFAx+eZYPINGZAV8dx5sRBCoQSicoQzmdvNSaM9AyRDf+Wg3TVmFh87ChTStsSaxZCk9wixndb8RuiJNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA8I6kmydklRQJ5tfK8r/fXR3/hvjaMwLfJzshVkY2UVWgPTi
	eWQlGwmKRLGxI25mH9pC1B5scn9m7BedLTnYp3oy1x6GwPUXtvyGnTCnw5DNUVPPacprXKHaFDI
	2IHH/30RnC5G/Jo16dViQWG6hqKKDU7DNRGHRpZIe
X-Gm-Gg: ASbGncugbKf5Tlc19jY/kzRFa5Rh7Pk6lDyvVALUftPXUBfYcAf/v+n1mcTQzLrY0lU
	VMDHP/PLtsh2N/VmuskubpNso2WC5VgdjWwJZ7rjL3+V8SNwySmfAdbzeE0XMey9f9HuLOqhXuR
	aO3gHI3f/o6o/E1vFTVX09akBflMP+pBRWoqnYNqfbTRDBtbDYqhP5dsAPXVH6QpiW8jxzlto=
X-Google-Smtp-Source: AGHT+IH3iurEiivqwpCv3LwpNAc4Cm+HyZ9vRYcSUb+hOOoZJ5uP01DiVo2wrGQiamywl+YIBIWvHAqsiUIGKo4wZLY=
X-Received: by 2002:a05:6402:1a2e:b0:604:60a6:7852 with SMTP id
 4fb4d7f45d1cf-60460a6795amr171058a12.5.1748356036937; Tue, 27 May 2025
 07:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221184417.27954-2-gnoack3000@gmail.com> <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net> <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net> <20250310.990b29c809af@gnoack.org>
In-Reply-To: <20250310.990b29c809af@gnoack.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 27 May 2025 16:26:40 +0200
X-Gm-Features: AX0GCFvpK-91ujELkNn_E3icY72n1WDjfluE1dOc7gEjoj7KJvFFFzWqMEN0thE
Message-ID: <CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc_z1rrVJw@mail.gmail.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for landlock_restrict_self()
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	sergeh@kernel.org, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:04=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
> Hello Paul and Serge!
>
> On Tue, Mar 04, 2025 at 09:25:51PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Feb 28, 2025 at 06:33:55PM +0100, G=C3=BCnther Noack wrote:
> > > Hello!
> > >
> > > Thanks for the review!
> > >
> > > I'm adding David Howells to this thread as well.  David, maybe you ca=
n
> > > help us and suggest a appropriate way to update the struct cred acros=
s
> > > multiple threads?
>
> Paul and Serge, since you are volunteering to take ownership of
> credentials, maybe you can advise on what is the best approach here?
>
> To summarize the approaches that I have been discussing with Micka=C3=ABl=
:
>
> Approach 1: Use the creds API thread-by-thread (implemented here)
>
>   * Each task calls prepare_creds() and commit_creds() on its own, in
>     line with the way the API is designed to be used (from a single
>     task).
>   * Task work gets scheduled with a pseudo-signal and the task that
>     invoked the syscall is waiting for all of them to return.
>   * Task work can fail at the beginning due to prepare_creds(), in
>     which case all tasks have to abort_creds(). Additional
>     synchronization is needed for that.
>
>   Drawback: We need to grab the system-global task lock to prevent new
>   thread creation and also grab the per-process signal lock to prevent
>   races with other creds accesses, for the entire time as we wait for
>   each task to do the task work.

The tasklist_lock and the siglock cant be used while we're waiting,
they're not sleepable locks. Also, copy_process() currently copies
creds to the new task with copy_creds() without holding any locks yet.

I think one way to implement this option without introducing new locks
in core kernel code would be to have the thread initiating the
credential change do this in three separate steps:

 - loop over the other threads under RCU (for searching for new
threads to send task work to)
 - allocate state for threads (outside RCU, in sleepable context)
 - wait until all threads are in task work


I guess that might look roughly like this, as a rough sketch:


struct landlock_sync_state {
  atomic_t num_threads_entered;
  atomic_t num_threads_done;
  bool abort;
  wait_queue_head_t wq_for_initiator;
  wait_queue_head_t wq_for_others;
};
struct landlock_tw_state {
  struct task_struct *task;
  struct callback_head work;
  struct landlock_sync_state *shared;
};

size_t num_threads_signalled =3D 0;
size_t num_threads_allocated =3D 0;
size_t num_threads_to_allocate;
struct landlock_tw_state **thread_works =3D NULL;
struct landlock_sync_state state;
bool all_threads_signalled =3D false;
while (true) {
  /* scan for threads we haven't sent task work to yet */
  rcu_read_lock();
  num_threads_to_allocate =3D 0;
  for_each_thread(current, thread) {
    /*
     * this PF_EXITING check is a bit dodgy but not much worse than
     * what seccomp already does
    */
    if (thread =3D=3D current || (READ_ONCE(thread->flags) & PF_EXITING))
      continue;

    for (int i=3D0; i<num_threads_signalled; i++) {
      if (thread_works[i]->task =3D=3D thread)
        goto next_thread;
    }

    all_threads_signalled =3D false;
    if (num_threads_allocated > num_threads_signalled) {
      struct landlock_tw_state *ltws =3D thread_works[num_threads_signalled=
];

      ltws->task =3D thread;
      ltws->shared =3D &state;
      if (task_work_add(thread, &ltws->work, TWA_SIGNAL) =3D=3D 0)
        num_threads_signalled++;
    } else {
      num_threads_to_allocate++;
    }

next_thread:;
  }
  rcu_read_unlock();

  if (all_threads_signalled)
    break; /* success */

  /*
   * If we need state for more threads, allocate it now and immediately ret=
ry.
   * Normally we only need to go through this path once, more if we race wi=
th
   * clone().
   */
  if (num_threads_to_allocate) {
    size_t new_count =3D num_threads_allocated + num_threads_to_allocate;
    struct landlock_tw_state **reallocd =3D kvrealloc(thread_works,
size_mul(sizeof(struct landlock_tw_state*), new_count), GFP_KERNEL);
    if (!reallocd)
      goto bailout;
    thread_works =3D reallocd;
    continue;
  }

  /* wait for all the threads we signalled */
  if (wait_event_interruptible(&state.wq_for_initiator,
          atomic_read(&state.num_threads_entered) =3D=3D num_threads_signal=
led))
    goto bailout;

  /*
   * Now loop at least once more to check that none of the threads called
   * clone() in the meantime.
   */
  all_threads_signalled =3D true;
}

/* success */

/* ... coordinate the cred prepare and commit across threads here ... */

bailout:
for (int i=3D0; i<num_threads_signalled; i++) {
  if (task_work_cancel(thread_works[i].task, &thread_works[i].work))
    atomic_inc(&state.num_threads_done);
}
WRITE_ONCE(state.abort, true);
wake_up(&state.wq_for_others);
wait_event(&state.wq_for_initiator,
atomic_read(&state.num_threads_done) =3D=3D num_threads_signalled);


This would be somewhat complex, but at least it would keep the
complexity isolated in the code for updating creds across tasks, so I
think this would be reasonable.
