Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85AAC07E9C
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jul 2021 06:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91EC6128E
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jul 2021 06:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGFGTd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Jul 2021 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhGFGTd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Jul 2021 02:19:33 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7CFC06175F
        for <linux-security-module@vger.kernel.org>; Mon,  5 Jul 2021 23:16:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a4so11198401qkn.11
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jul 2021 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RoGi9t0tW2ZKROiX5vNisDNKd+fSc5OvBjzFvq9gYvY=;
        b=Gzikz/eEBoqeajZIRReKOOFftA9UC4oI3fDNZSYLwbrN7EhOyOoeZZbyAq7/X0gOp/
         7ZHFoxagwFKR/kNQPsReYVp3UN8qK9Wmq++mMcdbCp3Z+7soiKCdhZjBi3Jdt5HMmaTD
         ancHpki5hiBvZImHkvRiV/fWyF/dRYbykcoNMcYvE5RuDT41CvD1ZtMMRUcwM1r6PsLf
         TH86Owk2G9QAGXBUBGHjv6E+xPI+6s8ykNNsYJpb6GEkk5yWJZUasI0+A04RwOHtPTRX
         g1z5Y2RRQXZsY8Z59zqhUIJNciL3iOeVw/NFnKBOtubTMxsg804Wrn5vu2rzv8oh5XQ6
         /P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoGi9t0tW2ZKROiX5vNisDNKd+fSc5OvBjzFvq9gYvY=;
        b=pnhWy30ct/uu/fbgujilT04wIyZHlTSBip94TWXLGSI89dNI2+fJWeIEsONnJ+VHT/
         VAAAA6EHPxfWECV1tiZSxJMU5CyTN3D2hgZyJG50aRjHpSuATxDMNte0Pk3pMyb4g26+
         wmg0zQX/D28YExKvqTmjBxdcKqckFqhw5zEI1p50RTmIMcS8D+45eNoje7uWreIrVeiB
         KGi/ZmTIxz1/hS5NwQPB7R5oJdNfGSYLfcOK3evr8pMfJuURQod0Jgjw3Q3LgUhFwNbV
         a2bLCGWgEDM/FLqBV+grSdit8udlkDC2gpu8+gWly4wctsak1T5MlYTIoIv4hldyUlBL
         Q3IQ==
X-Gm-Message-State: AOAM530THBTXY4VBZ/odsGzeDXAmKy6uwnPuk5iCBBeF6ki5C9KuD4h9
        E3c4t4HSGhJ31VvJNX4+Mot8z2KzVNLJrvibFxctYw==
X-Google-Smtp-Source: ABdhPJyElgbPmnSLXpF3gDkS9q6qlbT44UUR+C2RdRC7k5GdNuckFsTGeES9VmBRwkAuEmhnnRsNMypzRe7fvelAWWo=
X-Received: by 2002:a37:6614:: with SMTP id a20mr10617401qkc.501.1625552213306;
 Mon, 05 Jul 2021 23:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210705084453.2151729-1-elver@google.com> <20210705084453.2151729-2-elver@google.com>
In-Reply-To: <20210705084453.2151729-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Jul 2021 08:16:39 +0200
Message-ID: <CACT4Y+ZjjuW5wZ-QsYj7btZYYyNEiSnGh6JtV3bmSNx9mY_bZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf: Refactor permissions check into perf_check_permission()
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 5, 2021 at 10:45 AM Marco Elver <elver@google.com> wrote:
>
> Refactor the permission check in perf_event_open() into a helper
> perf_check_permission(). This makes the permission check logic more
> readable (because we no longer have a negated disjunction). Add a
> comment mentioning the ptrace check also checks the uid.
>
> No functional change intended.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v3:
> * Introduce this patch to refactor the permissions checking logic to
>   make it more readable (reported by Eric W. Biederman).
> ---
>  kernel/events/core.c | 58 ++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79ee82e644a..3008b986994b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11912,6 +11912,37 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
>         return gctx;
>  }
>
> +static bool
> +perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
> +{
> +       unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
> +       bool is_capable = perfmon_capable();
> +
> +       if (attr->sigtrap) {
> +               /*
> +                * perf_event_attr::sigtrap sends signals to the other task.
> +                * Require the current task to also have CAP_KILL.
> +                */
> +               rcu_read_lock();
> +               is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
> +               rcu_read_unlock();
> +
> +               /*
> +                * If the required capabilities aren't available, checks for
> +                * ptrace permissions: upgrade to ATTACH, since sending signals
> +                * can effectively change the target task.
> +                */
> +               ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
> +       }
> +
> +       /*
> +        * Preserve ptrace permission check for backwards compatibility. The
> +        * ptrace check also includes checks that the current task and other
> +        * task have matching uids, and is therefore not done here explicitly.
> +        */
> +       return is_capable || ptrace_may_access(task, ptrace_mode);
> +}
> +
>  /**
>   * sys_perf_event_open - open a performance event, associate it to a task/cpu
>   *
> @@ -12152,43 +12183,18 @@ SYSCALL_DEFINE5(perf_event_open,
>         }
>
>         if (task) {
> -               unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
> -               bool is_capable;
> -
>                 err = down_read_interruptible(&task->signal->exec_update_lock);
>                 if (err)
>                         goto err_file;
>
> -               is_capable = perfmon_capable();
> -               if (attr.sigtrap) {
> -                       /*
> -                        * perf_event_attr::sigtrap sends signals to the other
> -                        * task. Require the current task to also have
> -                        * CAP_KILL.
> -                        */
> -                       rcu_read_lock();
> -                       is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
> -                       rcu_read_unlock();
> -
> -                       /*
> -                        * If the required capabilities aren't available, checks
> -                        * for ptrace permissions: upgrade to ATTACH, since
> -                        * sending signals can effectively change the target
> -                        * task.
> -                        */
> -                       ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
> -               }
> -
>                 /*
> -                * Preserve ptrace permission check for backwards compatibility.
> -                *
>                  * We must hold exec_update_lock across this and any potential
>                  * perf_install_in_context() call for this new event to
>                  * serialize against exec() altering our credentials (and the
>                  * perf_event_exit_task() that could imply).
>                  */
>                 err = -EACCES;
> -               if (!is_capable && !ptrace_may_access(task, ptrace_mode))
> +               if (!perf_check_permission(&attr, task))
>                         goto err_cred;
>         }
>
> --
> 2.32.0.93.g670b81a890-goog
>
