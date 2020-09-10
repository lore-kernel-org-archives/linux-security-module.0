Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA5C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEB02080A
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1fFI0y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIJU7L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgIJUzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 16:55:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8212C061757
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:55:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so10798335ejb.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WIiEBg2V+e3hARqFde0aiNR5ScO14X3JJL78bMDSrs=;
        b=L1fFI0y0Pe7czKsJuyVbxrmCDK0BnWq+6Kvh94sOd+r3i7msl/xLwLjzzzL9c28sAK
         rR/+QnQaVicDMJJygLh0QwtQZRBvwqQJ5B/ajnk1a5e6wni2BRpk21gKHUzsEjqhdZlC
         iNnidHCMLR8KiKmhBg9yFZO8/CrMLJAzGj7kfuVVeFwgzG8EdxWJtB4hNNKdRY4VNRNi
         4fsNcbKzW3Vus8t+CEXPUuK+1etDhZqfaf5eNc0V+gczmE2YOW+pKG3W/Ot9ScdzAV9L
         5xA17qxbjuoEpJU1m/PvmZL3DAYqeFNX1Tief9l5wRZX2ahMJBmPCcBHUhzF2E/mTgnd
         rd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WIiEBg2V+e3hARqFde0aiNR5ScO14X3JJL78bMDSrs=;
        b=AlWYAZmr5ycJFgqoGV2vfMIzbcmoD5cnshCIxAbPCNC1r4c2+6RhSn1XphSE3I9HZx
         RTBV5VIUJ+JsGyEp28ea1WkpnX8+jKZAPNhCKQpAiToL+v2+jcLKVoPn8LLQi+HNaF8L
         KGPk8iNWupgwL7xWkTgDqg95igVdo1m0bdtq/0tK5lq1sZWTEJ1r9nNl4k7ICivYoVGg
         7c0Gfv8/Pgw1n4u2XiyWLil1oJ9fSElka0u13gGs+cpcFt8dZ2Hjq2MNl79IxltfCUvl
         1elphSuibfOr89HYh3eqCBZ7jjv+cY2vmLid4MnRXhxD8T1KE0fTjt/We/VwjJ7Q9fRY
         jG3g==
X-Gm-Message-State: AOAM532YJLjETxBn36IuLWBLw/u9ISc/0WNkHTaWIKccu8IIXu1dgcus
        CaCPTtjwcLezfjZAj0pBogFp+88Djh55M1Ic2SEjbw==
X-Google-Smtp-Source: ABdhPJz2fcbh8Swae5gqu3WCfXH+VoeuT8fBYorB0A9IvemCCzCy2a8aXjwcmpKuCfugC/8/pRR1MEGeVzo0AYRbaxo=
X-Received: by 2002:a17:906:1513:: with SMTP id b19mr11068344ejd.537.1599771337075;
 Thu, 10 Sep 2020 13:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org> <20200910202107.3799376-7-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-7-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 22:55:11 +0200
Message-ID: <CAG48ez0boPBDm=Uh5xHXAxTj0BTRGyGp4uCgPgw7PkOCo47Hdg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force attack
To:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 10, 2020 at 10:22 PM Kees Cook <keescook@chromium.org> wrote:
> In order to mitigate a fork brute force attack it is necessary to kill
> all the offending tasks. This tasks are all the ones that share the
> statistical data with the current task (the task that has crashed).
>
> Since the attack detection is done in the function fbfam_handle_attack()
> that is called every time a core dump is triggered, only is needed to
> kill the others tasks that share the same statistical data, not the
> current one as this is in the path to be killed.
>
> When the SIGKILL signal is sent to the offending tasks from the function
> fbfam_kill_tasks(), this one will be called again during the core dump
> due to the shared statistical data shows a quickly crashing rate. So, to
> avoid kill again the same tasks due to a recursive call of this
> function, it is necessary to disable the attack detection.
>
> To disable this attack detection, add a condition in the function
> fbfam_handle_attack() to not compute the crashing rate when the jiffies
> stored in the statistical data are set to zero.
[...]
>  /**
> - * fbfam_handle_attack() - Fork brute force attack detection.
> + * fbfam_kill_tasks() - Kill the offending tasks
> + *
> + * When a fork brute force attack is detected it is necessary to kill all the
> + * offending tasks. Since this function is called from fbfam_handle_attack(),
> + * and so, every time a core dump is triggered, only is needed to kill the
> + * others tasks that share the same statistical data, not the current one as
> + * this is in the path to be killed.
> + *
> + * When the SIGKILL signal is sent to the offending tasks, this function will be
> + * called again during the core dump due to the shared statistical data shows a
> + * quickly crashing rate. So, to avoid kill again the same tasks due to a
> + * recursive call of this function, it is necessary to disable the attack
> + * detection setting the jiffies to zero.
> + *
> + * To improve the for_each_process loop it is possible to end it when all the
> + * tasks that shared the same statistics are found.

This is not a fastpath, there's no need to be clever and optimize
things here, please get rid of that optimization. Especially since
that fastpath looks racy against concurrent execve().

> + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +static int fbfam_kill_tasks(void)
> +{
> +       struct fbfam_stats *stats = current->fbfam_stats;
> +       struct task_struct *p;
> +       unsigned int to_kill, killed = 0;
> +
> +       if (!stats)
> +               return -EFAULT;
> +
> +       to_kill = refcount_read(&stats->refc) - 1;
> +       if (!to_kill)
> +               return 0;
> +
> +       /* Disable the attack detection */
> +       stats->jiffies = 0;
> +       rcu_read_lock();
> +
> +       for_each_process(p) {
> +               if (p == current || p->fbfam_stats != stats)

p->fbfam_stats could change concurrently, you should at least use
READ_ONCE() here.

Also, if this codepath is hit by a non-leader thread, "p == current"
will always be false, and you'll end up killing the caller, too. You
may want to compare with current->group_leader instead.


> +                       continue;
> +
> +               do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> +               pr_warn("fbfam: Offending process with PID %d killed\n",
> +                       p->pid);

Normally pr_*() messages about tasks mention not just the pid, but
also the ->comm name of the task.

> +               killed += 1;
> +               if (killed >= to_kill)
> +                       break;
> +       }
> +
> +       rcu_read_unlock();
> +       return 0;
> +}
