Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF5C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FEC61050
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhIWPzF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242221AbhIWPzE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Sep 2021 11:55:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F934C061574
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 08:53:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so28413142lfv.4
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAIf9S9YD0oFbCvz8QEsqa7/B46ooiou6kW4WrW11es=;
        b=edcnJ+kYTFajOV6YWgCkDRJ7tuME3jDCu388x+5IygYwj23a8bZILaBVzhLYkO588z
         ljxnaGKMshQurnuGfYg4HBwiC3Ym6JVEffomTleMBklg9nYJ1H9ODcw++lFapFP+L7Zw
         y7IPRTqhyiGYRNXvP5nhI306iiITGHRqHb9Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAIf9S9YD0oFbCvz8QEsqa7/B46ooiou6kW4WrW11es=;
        b=ZIOyGU2Q9uzFxc9WR9lpup1ioSrR04dbK/i3Dt7uc9J7MErZQHGLppaZsjgiipoghV
         XE5bJ056bprArNtz8o5cLx69eCsdSjpr0f2F35S6ll3501GvcEsNRLBSjWgYMprEWLyO
         uVO8I03+AtSet3SQIQOrVea2He9+ZjspL5v2+7emie2z5mpAIeYDvjDLmpgK9OOzmWfL
         IUGebjw76l0USS+SlBhzgLFMRFQujfY1ZtrXebG+p6iBUt73d05CUY+s4wVngi0GdYKG
         HugOAt0ctm0JYgRmTU2nbMjXTCZttzk3U+eohAF2QWcFVvsiHGBeqNZrPfRV8ycOQNxU
         HOWA==
X-Gm-Message-State: AOAM531Q1LTt0tolr+7uN2kjKDDRqM5j11Rl3nd7NAnRRrCUbQLWmmId
        6AVazM/M3NNd4BEzd9qq31XwtJ8i7upsLewu74Q=
X-Google-Smtp-Source: ABdhPJw2gc7kayHsMuUyI6Fc/ZKhM35aokq+RLCJuSoQbpxIXlk8yKhe5PArfFt0TM953BCtyueypA==
X-Received: by 2002:ac2:4d35:: with SMTP id h21mr4757742lfk.237.1632412410002;
        Thu, 23 Sep 2021 08:53:30 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r2sm490461lfm.78.2021.09.23.08.53.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:53:29 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b36so153766ljr.6
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 08:53:28 -0700 (PDT)
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr5757554ljb.31.1632412408652;
 Thu, 23 Sep 2021 08:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
 <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com> <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
In-Reply-To: <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 08:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
Message-ID: <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 23, 2021 at 8:43 AM Paul Moore <paul@paul-moore.com> wrote:
>
> However, we have the LSM framework because there is never one way to
> solve a problem,

The thing is, the lockdown patches were merged because they were allegedly sane.

As far as I can tell, this is purely a SELinux internal bug.

SELinux did something wrong. Stop doing it. Stop sending patches to
then screw up the generic security layer, and violate the rules under
which these patches were accepted.

We have now this week have two discussions about the selinux doing
completely invalid and incorrect things, and both were related to just
thinking that it's ok to just randomly access thread data.

At some point, you just have to look at the SELinux code and say
:"this does something wrong".

Instead of this kind of "no, everybody else is wrong, I will modify
them to do what I mistakenly did".

IOW, just make the patch be

   diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
   index 6517f221d52c..4e93bf5dc8ef 100644
   --- a/security/selinux/hooks.c
   +++ b/security/selinux/hooks.c
   @@ -7016,7 +7016,8 @@ static void selinux_bpf_prog_free(struct
bpf_prog_aux *aux)
    static int selinux_lockdown(enum lockdown_reason what)
    {
        struct common_audit_data ad;
   -    u32 sid = current_sid();
   +    /* Lockdown requests come in non-thread context, can't use
'current_sid()' */
   +    u32 sid = SECINITSID_UNLABELED;
        int invalid_reason = (what <= LOCKDOWN_NONE) ||
                             (what == LOCKDOWN_INTEGRITY_MAX) ||
                             (what >= LOCKDOWN_CONFIDENTIALITY_MAX);

and stop accessing random security ID's from random contexts.

And stop thinking it's ok for SELinux to just do bad things.

               Linus
