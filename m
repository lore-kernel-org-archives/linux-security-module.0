Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511B31F989
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021942; cv=pass; b=b3XvAga//8i3V6aL4DwqDyctK+q+trg1xviqm5fWRu7vX0FmgR+1v8XetWlLZbLLHMF7FwOQaf3XMHE2AGyKVlM8CjWK/U1CajldH9F5D0hHa04GBupps0lLqbb6IdvrHOMti0UWye0MIPEqUtUVXnVhmsg/S45Wg+itc25BlxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021942; c=relaxed/simple;
	bh=gTOx7EH1voNp8N7JYu+h59hbOKIzl4POlomWmUZTuaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrr0AVb6D2oA0R9MvpBNsEfDfm0rUk4SXCRxG4+RMv3TbwsZhJVvSCOrWrADoP14io0i8mc4Osm2i5tPJ0WPjx+NoXM0t5YdhBEjf24k8Y9ffVsP+7EEfOvjs1GcoRkwSt72AnZANQpY6kHDSYe0BMzkM7L2leba6dC47LZRvY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mV4iDkzb; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mV4iDkzb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cede6375caso105935ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Aug 2026 06:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786021934; cv=none;
        d=google.com; s=arc-20260327;
        b=jJjEib3yN0GsYk4uLK9mjQ5Fa0R+0Tig9ilnl1d/wbbkip76xF4VWs2MXeAWx4OP1i
         G0cHoxnWnJMhRrkLlkZLfhaYRpvvSRh5+VhleszCd9XZpx6twzbkeaddjmzfezuqE+7h
         LAqnmzZI3X5Km8XOEAjmyJXtUq8BXHTuHuf/G4Nczz3X0OlNKNmuRmiEgq+h/sZCpV1Q
         rgbn7mCjfsD/y3Yy56MAfcSktk09IaKwXQHJCGX2USJ8TuLwBYTjP0CrlUujkd3r9fA7
         pEkVzMWvP+Y1FjRywI0hsImVBWfgwBkWZzpdqMiDHeVnZyAT6Tq9o7bUaL2lsOnfr4w/
         crIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        fh=CJxIoEQzJXYON6Ybt0grYiwBLtvMqJohu56GkSbEiec=;
        b=Uc+R6L+ZYx6zsHdU0LbDvV7TOmIY3L+DmgLIb4NCiUlHxQMOsp/T4SP9LiqYU2DzDy
         cn2ZoQbgKZLsrB4bEQ0KWUw6GoisAko1bHuGToq3qqYvqvsM/Fg5qFrPm+tGi+UqjQtF
         GtB2J6/W1eHR3PtdZoykkcYUjLzFg5W7EJ2OoeogifHA20sN6cx8YwEIs2keLQorc57w
         72CEYVjBAlxXC6nZZ5uXsxkv5FQtP8i6OcWAbZ/hJmUjFhNirIQYHz5rwFT49m1a471J
         HQTzQlZF02EVkl5I9cXYv8IpM0ervCaNGPi/86317QQCz0WhWm/Xlov+oFjTRluGM8Oh
         CCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786021934; x=1786626734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        b=mV4iDkzbg8jIFwoK2W7fjfRIKSpuVpyDrL4qrv2A2N+KVQyTcOzs4hyNMNR072rCdn
         I13UBVucdxyLx8KPc5stdwL3RQgykvahqjmr3tVLI+x809VOOgsRk0gmWpmKxXd5KiZw
         WXxT+7wwjtXrlojwu4zQ+NvjfFn6UQOEMt/a01XZFn4tekZaMAv6EEJs6c8Y/B05oIVW
         MwSHsWWep7jBYV03ZNxFo3cTDEJIX8Tj2JjKsLFTfobGLXUWUlHDa2idVyI0ZtU/1R4+
         wub/+vK1EMyz2m4O7E7iKZlOYNGVHZ2Ih8eW5lMpwmu23Rl+LVe994G7iTBFCgZ3Zrpt
         xvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021934; x=1786626734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        b=Tbah8tlYX2XzT+raToFKYJl7OZDXJ+th8vNLsASTWf62dvARnVsHUig8p8xSrTnqQm
         QjRe45x4FU/U2R9k99gVihxlsIGdvzEqfYHufeX3lnt40/byh8XlXgKn8NJnkBc9DHU4
         W/jKFb4IXY+mAD4r5y2dIr+Ue90JHQbhzFUZlmPVPX0/93jgvSsHy8tVIRseWJ8irvfg
         Bhj+wSaOyKBnuVlymnafD2u/N0mijFNUPo9FCHA678REix1Wryfe0epsO6Hw/IszPN0W
         HQ5dCtNUs0Gc1qfWViHaHhSibl882QwqMwPVXHAeXgYeMSFm3G8L01A0mhhsfX9/yV+8
         Kcng==
X-Forwarded-Encrypted: i=1; AHgh+RrARc2Z4ZxaC88exlkahDEXox9V8g1aciAdcbn2zOY/EXMKPmCw6tz94v+2m0Uem7JyibN0ny2m8u2Wo4mPCY1V3A3mTKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jQCZds0vMpawWcVb8SUeueGD95N91Qer+2oy8AfPgkFLCS7t
	Cu/qHg6Lcrr/FMqqZ4IsF/QTrX+NSEfnIWM5HPnK6+4cG7+7vwuzVmE3+fk4+2+qbvE3qvRLhEH
	U3v0Zu8xr2BcH1nOmyRDFbu5cQ7QJypMnDsY9Hf2Q
X-Gm-Gg: AR+sD13n0eiGoQc2fcNaTnFsOvkIe9kl+PC+NIHccpgrQQz+ysf71EKMmW7ZTpmliIK
	txWQmI+71rKvreb1kKy1eGHPrkIxutJFFOb0UWDXql4ZyUTTQPuQowpxVW6va3x8GBzTXB97J8V
	NDJQJh5DZrsZ7xa7PmrF9ys+UMNAUkNJaiWVk/c6JowiZrwEEedhNNF/c5wwoSJ7/soQ76NoiG1
	Z1VOWdQ4CI6Br34SQNaUXeUMhGaUkp+flDAvKB9z8GUCc5fR5emblgWUdB9mi2NVlFn9ECwez03
	3fHBXCgtjxXAR0ht/h8avLPGONupoWnQ0AmGpcQNvIUCz3HWgfZ1Vw7XqTa4nA1/Xx5ZL+O8x7L
	Nlorg1wqN3p7p3QSzoW+hAHyOmWi0b2g=
X-Received: by 2002:a17:902:ce90:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2d0f2a1ac97mr7375425ad.4.1786021933682; Thu, 06 Aug 2026
 06:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
 <20260806073244.GM49951@noisy.programming.kicks-ass.net> <00168bff-3d44-4701-9931-1e02105410ed@canonical.com>
In-Reply-To: <00168bff-3d44-4701-9931-1e02105410ed@canonical.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 6 Aug 2026 15:11:36 +0200
X-Gm-Features: AUfX_mwaMKvH8autja6WPUiF9yY0qYb3sB5ZSNxQ5smDHdnj5Wwh-lN0MJH4-ys
Message-ID: <CAG48ez25v6=GZzK2iNQepDeKpgAEWBPrkovJqzjSiJsOCLNSeQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>, Peter Zijlstra <peterz@infradead.org>
Cc: John Johansen <john@apparmor.net>, Georgia Garcia <georgia.garcia@canonical.com>, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:06=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/6/26 00:32, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2026 at 05:38:07PM +0200, Jann Horn wrote:
> >
> >> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> >> index 0646804860ff..ce19fc14060c 100644
> >> --- a/include/linux/task_work.h
> >> +++ b/include/linux/task_work.h
> >> @@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct =
task_struct *task,
> >>      bool (*match)(struct callback_head *, void *data), void *data);
> >>   struct callback_head *task_work_cancel_func(struct task_struct *, ta=
sk_work_func_t);
> >>   bool task_work_cancel(struct task_struct *task, struct callback_head=
 *cb);
> >> +bool task_work_has_func(struct task_struct *task, task_work_func_t fu=
nc);
> >>   void task_work_run(void);
> >>
> >>   static inline void exit_task_work(struct task_struct *task)
> >> diff --git a/kernel/task_work.c b/kernel/task_work.c
> >> index 0f7519f8e7c9..f83d1528e0bc 100644
> >> --- a/kernel/task_work.c
> >> +++ b/kernel/task_work.c
> >> @@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, s=
truct callback_head *cb)
> >>      return ret =3D=3D cb;
> >>   }
> >>
> >> +bool task_work_has_func(struct task_struct *task, task_work_func_t fu=
nc)
> >> +{
> >> +    struct callback_head *work;
> >> +
> >> +    if (!task_work_pending(task))
> >> +            return false;
> >> +    guard(raw_spinlock_irqsave)(&task->pi_lock);
> >> +    for (work =3D READ_ONCE(task->task_works); work; work =3D READ_ON=
CE(work->next)) {
> >> +            if (work->func =3D=3D func)
> >> +                    return true;
> >> +    }
> >> +    return false;
> >> +}
> >> +
> >>   /**
> >>    * task_work_run - execute the works added by task_work_add()
> >>    *
> >
> > This thing is quite terrible. And AFAICT the only purpose is to
> > determine if said task already has said function enqueued. Why not add =
a
> > single bit to struct task_struct for this? I'm sure we have a spare bit
> > somewhere.
> >
>
> single bit wouldn't work generically to represent the different functions
> that could be enqueued but we could stick a flag in the apparmor task
> security blob, so we could just check if apparmor has enqueued its
> function.
>
> The trade-off is you don't get an admittedly ugly generic fn that someone
> else could use.

Yeah, makes sense, I'll rework this to not touch task_work.c and
instead do something with the apparmor task blob.
