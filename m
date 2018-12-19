Return-Path: <SRS0=ZDpT=O4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A2C43387
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Dec 2018 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536202070D
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Dec 2018 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpnaZUGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeLSSm3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:42:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55139 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeLSSm3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Dec 2018 13:42:29 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so11203802ita.4
        for <linux-security-module@vger.kernel.org>; Wed, 19 Dec 2018 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVTnhPYqJyasq4GmNoyFjBD0F8OLVw6YqkQSU93KBdY=;
        b=tpnaZUGbgoz462o647vKp2ar88rROAf2MVZiH4sMVVXE/fTbYoc+rOnp1vimrr8m4l
         GqNXWFFnAZH9ZTLqc6DYHrGkOa7clSx7ADZrYY2mdu846r7SX80ZO8oK2iKalkNxv4Fi
         btcUOJ7x87Veix6u1S0rz+fyVGwzxtKbxj4SiRITRYEf2oC8aMlns3RhhJXHG6xok0aP
         lHzRSLHjjMVdwSypY3sfGnFn7/6KbEiAQjcISrWPG7/7OIXAuwznluex1aU2Goz7ObBd
         wYe9S4jvdTvk7yQc39w0Cel8i7MhJYmGPjXhhKHnA1gHxzIa91HL6QkvTIqAKSkq7+C9
         p8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVTnhPYqJyasq4GmNoyFjBD0F8OLVw6YqkQSU93KBdY=;
        b=AFrHbZBVFag5tJ+ZnT/Uu1Fj0W6PVtNvHgqPlwvHeCT2X2AozNPrfpk0Kb6oerDePY
         +Y6LD+SVLqTTNZe9NiLmKeG4VLWLJ59tueYWhtkZLusy5y8sciDQkn4tSTtnJqgHku3G
         G82SagjPibc/BTi3RdMbprqCV36hHHtGtOIi2anvzang7bqoIyARkMc3AgkO0prz0PD7
         7wgsLCMOzN4zdjxhk62dTGvsrKPxJ3VeoHEwRng8+9JhC41CsagxKuI6pFlaJwDV7utF
         Kk5Dl/bdkxjyP5MZLlaWmV3yXBbWR3IywtWhB9X0A8Lzohr+d32oIHCQ4epeinYN1PXR
         elMw==
X-Gm-Message-State: AA+aEWbKJ9le9YTNhVvtn+B1hY2XeD8LlfrqFT+cI6o8GRqMEkcTRhWp
        vLO20+CMuVzH4oTnUZqp+/jUwAUkCF2+0BDFlx1BIm9aUbweTQ==
X-Google-Smtp-Source: AFSGD/UkLvlYn0eBpl/X+v3zxqikD6cwHFRQKx65ub4SYezF8V3GWyw+MRd7ZD0ATXMdatVie/auLhxq2H9bPHZ8T/I=
X-Received: by 2002:a02:8904:: with SMTP id o4mr20185222jaj.35.1545244948214;
 Wed, 19 Dec 2018 10:42:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e728ec057d5c9d90@google.com> <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
In-Reply-To: <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Dec 2018 19:42:17 +0100
Message-ID: <CACT4Y+YqWgZZFXdX2A2jVYEdHfY9ywGMgRRP5W4Uqdu__rA63g@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 19, 2018 at 11:13 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/12/19 18:27, syzbot wrote:
> > HEAD commit:    ddfbab46539f Merge tag 'scsi-fixes' of git://git.kernel.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b87fa3400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=bcad772bbc241b4c6147
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13912ccd400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145781db400000
>
> This is not a LSM problem, for the reproducer is calling
> sched_setattr(SCHED_DEADLINE) with very large values.
>
>   sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_??? */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=2251799813724439, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
>
> I think that this problem is nothing but an insane sched_setattr() parameter.
>
> #syz invalid

Note there was another one with sched_setattr, which turned out to be
some serious problem in kernel (sched_setattr should not cause CPU
stall for 3 minutes):
INFO: rcu detected stall in do_idle
https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
https://groups.google.com/forum/#!msg/syzkaller-bugs/crrfvusGtwI/IoD_zus4BgAJ

Maybe it another incarnation of the same bug, that one is still not fixed.
