Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48000C61DA3
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Feb 2023 21:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBUV1z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBUV1y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Feb 2023 16:27:54 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E884311E0
        for <linux-security-module@vger.kernel.org>; Tue, 21 Feb 2023 13:27:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c23so1675771pjo.4
        for <linux-security-module@vger.kernel.org>; Tue, 21 Feb 2023 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OY49XJYkmM8JwgqMEdZVA4MqBlSEgJvqRRu26pssVSQ=;
        b=MK1ZdFyoSgafsQYiNhM2z8RU8qST7kMFlVALVE84kW9msIKU4uzzNItmuVOIsYu9ka
         nHpiR+GtxyydEbFK9iE9TeAMMJYXsmZOia/0H6JEW+UMyTAYZh71Rvzc+MZEmbsZ7nFy
         LX3+qZ4aZFt1/nETKxIHJ4nSfNj/Gqm0XJI/+f70tv+RwGnYx4pNGQeLhmdp+BSAuJ5L
         +972AzpiHg+DVaYuqwUtVr1ipToYs9cKZfYMAxvJ18lt3soz4ZxuWmHvvwS+/zJ43UqO
         +2+JG7EqG94638AL6QxidFvaw+kzxYdkg0CLQzIK/9IkcIoRl2r5b0gZTsRvRSj/RWSb
         KBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY49XJYkmM8JwgqMEdZVA4MqBlSEgJvqRRu26pssVSQ=;
        b=50B2fjHGN4ry2yXJwtd91IM1ahFUwBulxXxJ0Jb8UH5xyyhPWrGGMSmCUELzJ2r+Rr
         FPRIeIH2ezAPbTIZW1XCeocOp+6uqTax1Q6Pp5szQl+fhon6psdm7NuS62rXaZ9nlZjj
         r6lGOaaCXsyuPWkAxYO9eNzIp7MVNBo7u2rKWnvmOjWJ+njBWqcdaotzR4uRoSJrnHpn
         vPH35HSMsArbr54bK7fGTg5xsy2GXBeuOIZASGQKo7vSV9fCEisghApauKtpxgeXNvYz
         qBGGx86wlw89SkUSniaRLkqDJLYzgxnVkJcPQGGALVc3XfTS44D3VK9VZF8AjZjAGx4j
         aaoA==
X-Gm-Message-State: AO0yUKWNOOPfHQdQQIH4FjuAqj07MSOqQ329PceEAra8zjYQ9RQjl+Es
        McuhdrwscGm4PyM5nkai3IkNhD0mztuTxb8kVk++Jw==
X-Google-Smtp-Source: AK7set867sporZ6Oxux1gnqSqjH0N76mlhGVHkzYxRu5jfG0srUFnnFaMa832/+NgaXWwsI+EMVAy0m81JmVEZXbCL0=
X-Received: by 2002:a17:90b:38c8:b0:230:8730:c1f7 with SMTP id
 nn8-20020a17090b38c800b002308730c1f7mr1659668pjb.27.1677014836106; Tue, 21
 Feb 2023 13:27:16 -0800 (PST)
MIME-Version: 1.0
References: <YO2S+C7Cw7AS7bsg@google.com> <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com> <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com> <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
In-Reply-To: <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
From:   Anil Altinay <aaltinay@google.com>
Date:   Tue, 21 Feb 2023 13:27:03 -0800
Message-ID: <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I can test the patch with 5.10 and 5.15 kernels in different machines.
Just let me know which machine types you would like me to test.

On Mon, Feb 20, 2023 at 12:42 AM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 2/17/23 02:44, Sebastian Andrzej Siewior wrote:
> > On 2023-02-16 16:08:10 [-0800], John Johansen wrote:
> >> --- a/security/apparmor/lsm.c
> >> +++ b/security/apparmor/lsm.c
> >> @@ -49,12 +49,19 @@ union aa_buffer {
> >>      char buffer[1];
> >>   };
> >> +struct aa_local_cache {
> >> +    unsigned int contention;
> >> +    unsigned int hold;
> >> +    struct list_head head;
> >> +};
> >
> > if you stick a local_lock_t into that struct, then you could replace
> >       cache = get_cpu_ptr(&aa_local_buffers);
> > with
> >       local_lock(&aa_local_buffers.lock);
> >       cache = this_cpu_ptr(&aa_local_buffers);
> >
> > You would get the preempt_disable() based locking for the per-CPU
> > variable (as with get_cpu_ptr()) and additionally some lockdep
> > validation which would warn if it is used outside of task context (IRQ).
> >
> I did look at local_locks and there was a reason I didn't use them. I
> can't recall as the original iteration of this is over a year old now.
> I will have to dig into it again.
>
> > I didn't parse completely the hold/contention logic but it seems to work
> > ;)
> > You check "cache->count >=  2" twice but I don't see an inc/ dec of it
> > nor is it part of aa_local_cache.
> >
> sadly I messed up the reordering of this and the debug patch. This will be
> fixed in v4.
>
> > I can't parse how many items can end up on the local list if the global
> > list is locked. My guess would be more than 2 due the ->hold parameter.
> >
> So this iteration, forces pushing back to global list if there are already
> two on the local list. The hold parameter just affects how long the
> buffers remain on the local list, before trying to place them back on
> the global list.
>
> Originally before the count was added more than 2 buffers could end up
> on the local list, and having too many local buffers is a waste of
> memory. The count got added to address this. The value of 2 (which should
> be switched to a define) was chosen because no mediation routine currently
> uses more than 2 buffers.
>
> Note that this doesn't mean that more than two buffers can be allocated
> to a tasks on a cpu. Its possible in some cases to have a task have
> allocated buffers and to still have buffers on the local cache list.
>
> > Do you have any numbers on the machine and performance it improved? It
> > sure will be a good selling point.
> >
>
> I can include some supporting info, for a 16 core machine. But it will
> take some time to for me to get access to a bigger machine, where this
> is much more important. Hence the call for some of the other people
> on this thread to test.
>
> thanks for the feedback
>
