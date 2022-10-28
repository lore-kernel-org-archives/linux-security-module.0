Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E1ECAAA1
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Oct 2022 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJ1Jwc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJ1Jvt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 05:51:49 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEB4CA14
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 02:50:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t10so5626394oib.5
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJOZ7nL7nUVuoXx6yfQht5u/rUZxqZv4VWUs7Qhk1hE=;
        b=S+L4GQkz4K2pt5kvTSs7/jsFd+v4roBTopqwYwg+8o6Na4sBXhcTSbz7wEDkGAI+NK
         lJauWzD8V+54/PrUQtCtpm3oKEI41aOA/MF3NoVLQflahvkfwYZxelcWj2mCFJI8TWCp
         PQ+oJO3h9bySb85KPZOUhujjDzLLDvmYykIsfrXcQNXZgW4TqlBm12B/+DKoyg66O0BA
         HICK80lucWEeOYsu7aic6GVjd/3BLaLYKz6g+ymlqPRfLpgu8qUCPhvEk0wz+CA0OlEv
         tGYMRkRrRk/LqNec81DzkrMYXDbx83aeAXmLB4A3hS8HUMlp2w2HJFIvgy9616d+M+rq
         VhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJOZ7nL7nUVuoXx6yfQht5u/rUZxqZv4VWUs7Qhk1hE=;
        b=ikVfd1/AuBXscdIqePQRZnwTy7qAvz1xRQlPnI9xTrIk6BQxwwE2ETjGKMoRceyRBX
         cdUr8+uuSgqpsnd+T92DmOTNQ8dcNam8UgoAOtTUIyR6bYEXKosEOYZxJG+OL+QtNTO4
         0LfOZgBxGCcsksbLpFCTPSVPl41sVpImLJ29JJg2N7bQXuLUurtzdQWKlACQpDi0v+2M
         8KOkubLfQBKAXVX4QEUOGBkiITOXaGsm95w8mGfpcssTCmRVaED1tyiz0S+7bmszshqx
         k3Zx5NYa22s3mbg4Y/HhDmYoOmW3M7G3rvxhCm0DJ6pSV0HHRJqutQzjI/fiGWSi6Q7w
         siFA==
X-Gm-Message-State: ACrzQf3ZE1zdEaSSn/H4koX4gnWgYf34Ra0p5EWfik0KdHZdwYeAou22
        OEHU+6RE7E5bsQRB6Cr3JqK5nq/Tjn1g4+JP/t6W
X-Google-Smtp-Source: AMsMyM5LT56WrX8xq2cDEwU9MowuTZJprtvIM+mNwCDsAdE4o56WE0f9ds+W9OIiqC1+bVos/ZfrkQ3B85DspeKDevQ=
X-Received: by 2002:a05:6808:10d4:b0:359:c147:7afe with SMTP id
 s20-20020a05680810d400b00359c1477afemr3882403ois.172.1666950617668; Fri, 28
 Oct 2022 02:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com> <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com> <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com> <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com> <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com> <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com> <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
In-Reply-To: <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 05:50:06 -0400
Message-ID: <CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 26, 2022 at 8:02 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/10/27 5:11, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 7:20 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2022/10/25 19:26, John Johansen wrote:
> >>> no, Casey is not. He is trying to find a path forward to get LSM
> >>> stacking upstream sooner than later. He has made proposals that
> >>> admittedly you have not liked, but he has at least tried to propose
> >>> ideas that could work within the insane set of constraints.
> >>
> >> I'm OK with getting LSM stacking upstream. But changes made based on
> >> only built-in modules are bad. If LSM id cannot be assigned to loadable
> >> LSM modules at runtime because not all loadable LSM modules will be
> >> in-tree in order to get an LSM id assigned, loadable LSM modules won't
> >> be able to utilize e.g. lsm_module_list system call (or whatever
> >> changes made while trying to unshare resources/interfaces currently
> >> shared among SELinux/Smack/AppArmor).
> >
> > As a reminder, the LSM layer, just like the rest of the kernel, has no
> > plans to provide any level of consideration or support for out-of-tree
> > kernel code.  LSMs which are not part of the upstream Linux kernel are
> > not our concern here; if they fail to work with the syscall and/or LSM
> > stacking changes merged, that should not be considered a blocker to
> > upstream development.
> >
>
> No. You are misunderstanding.

With all due respect, I understand your point very well, I'm simply
trying to explain to you the position that the Linux Kernel has
historically taken with respect to out-of-tree and in-development
code.

> This problem is not limited to out-of-tree and/or
> loadable LSM modules. This change prevents new LSM modules from getting upstream
> due to a chicken-and-egg problem.

It does *not* prevent new LSM modules from being merged upstream.

It may make it more difficult for out-of-tree modules to remain
out-of-tree, but that is both not a concern of the upstream community
nor is it the concern you are currently describing.

> Currently anyone can start writing new LSM modules using name as identifier. But
> you are trying to forbid using name as identifier, and trying to force using integer
> as identifier, but that integer will not be provided unless new LSM modules get
> upstream.

That is correct.  In order to have a LSM identifier token the LSM must
be upstream.

> Then, how those who want to write new LSM modules can start writing LSM modules and
> propose userspace changes for new LSM modules? They can't use the identifier unless
> their LSM module get upstream, which in turn forces them not to propose interface for
> userspace programs, which in turn makes it difficult to get new LSM modules tested
> by users, which in turn makes it difficult to get upstream due to "who is using your
> LSM module" question, which in turn makes it difficult to get the identifier...

First, new LSMs generally do not need extensive userspace
modifications; of course there may be some, but when one considers the
entirety of a modern Linux distribution the actual percentage should
be quite small.  In addition, it is not uncommon for in-development
LSMs to have a set of privately, i.e. not upstreamed, patched
userspace tools while the new LSM works to get upstream.  These
private userspace patches are generally merged after the LSM has been
merged into the kernel.

> You are trying to force CONFIG_MODULES=n by just "we don't care about out-of-tree code".

That is not the goal at all and I would appreciate it if you could
stop slandering the motivations of the LSM syscall effort.

> Trying to change identifier from name to integer is a serious bug.

I disagree.  One would have a similar problem - userspace
awareness/enablement - regardless of if a name or a token is used.
Ultimately the challenge is getting userspace developers to accept a
change that is not part of the upstream Linux Kernel and thus not
guaranteed under the usual "don't break userspace" kernel API promise.

-- 
paul-moore.com
