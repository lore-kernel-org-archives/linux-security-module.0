Return-Path: <SRS0=daWi=T5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7484C28CC2
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BF824044
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 18:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rm6Op6Is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfE2SMN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 May 2019 14:12:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45049 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfE2SMN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 May 2019 14:12:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so2961488otj.11
        for <linux-security-module@vger.kernel.org>; Wed, 29 May 2019 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+LiWYxMhAJfHLsG+v7LjjWofEdKFy9soNO63HkV+20=;
        b=rm6Op6Is2WyS28sYE2LrvmC6hYEVlBfSDkJUVaKtEPXkpkcEEgwFZx9EaFMzxA7QHN
         jGLyhbIH7d3TLdKtfCeO8OKvbDMjlklbUFMA1y1Fzv7/GietI7aZdu2oEsVBu6nVgRND
         D8Pg4xBc/mwxRuJEOgG/C4KpUU6MF5i1lnkZLF+zkyEz7Jx20Jz5VQFv40woP8Itc/Vb
         j9auqkQ5XEeP8zQAuW8EihZdk+7rwfnJdOzqFkabhy2air3lPgExNOXh8nOIvkDc2p7e
         nwmhXppgGZ1QaQxGpM3UFjxRCl6MxPJt9OTN+C6ag2JF4pxEOtDBt//jHJ1wROrhskj/
         /LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+LiWYxMhAJfHLsG+v7LjjWofEdKFy9soNO63HkV+20=;
        b=pUI+dviScJTpIB6iQWDQQ3vh8eag5LbE6UUf870ojbgBi4JQ8hB1dCbxuFSfAwgSNo
         UHbp889MLUunInhQXRmQF+80aZM2cb3FrNHI8zIKT+bKNlH8kj/PSarymRSk/eq3Oopu
         gEDKjsE7hYozFKdbHcjNh+tcoBj9UHTSFVqo0pmFCD/U5BWKTAx5HR0bbEDSwspL5BYf
         ARReXqi42DdIpUW7/WVI9x9owTu12yhnYcvode8ZmLKepW+hiUROsgAebvc5SRJN3KvO
         2jKy8oxPfuEEHU6NIIEfnznQSqvDhTBXT46/i63XR4MEBagHZUYI9+F3Xp64zuBtRypk
         5DXA==
X-Gm-Message-State: APjAAAX6LANEfuuYz56khNbyuuvMw/+TCtdfdxNg10Gr/fjig5yVzwAI
        /BPSbhOaINLnnsXU/WAgq3H5j6KS3+bqsnCloC4z+g==
X-Google-Smtp-Source: APXvYqw+3MUKe4d0cvSOyC631nuMT0M0/zG0ddXI9fhLgtQNKsQ1SVQlwExS86mDMdF/84VeJAo+Iz4GbbdE8HpYvNI=
X-Received: by 2002:a9d:148:: with SMTP id 66mr30932226otu.32.1559153527342;
 Wed, 29 May 2019 11:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
 <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net> <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
In-Reply-To: <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 20:11:40 +0200
Message-ID: <CAG48ez2S+i2wxpWXVGpEAprgY9gtjxyejLfbZtrqu5YOkQ81Nw@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 29, 2019 at 7:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
> >> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 5/29/2019 4:00 AM, David Howells wrote:
> >>> Jann Horn <jannh@google.com> wrote:
> >>>
> >>>>> +void post_mount_notification(struct mount *changed,
> >>>>> +                            struct mount_notification *notify)
> >>>>> +{
> >>>>> +       const struct cred *cred = current_cred();
> >>>> This current_cred() looks bogus to me. Can't mount topology changes
> >>>> come from all sorts of places? For example, umount_mnt() from
> >>>> umount_tree() from dissolve_on_fput() from __fput(), which could
> >>>> happen pretty much anywhere depending on where the last reference gets
> >>>> dropped?
> >>> IIRC, that's what Casey argued is the right thing to do from a security PoV.
> >>> Casey?
> >> You need to identify the credential of the subject that triggered
> >> the event. If it isn't current_cred(), the cred needs to be passed
> >> in to post_mount_notification(), or derived by some other means.
> > Taking a step back, why do we care who triggered the event?  It seems to me that we should care whether the event happened and whether the *receiver* is permitted to know that.
>
> There are two filesystems, "dot" and "dash". I am not allowed
> to communicate with Fred on the system, and all precautions have
> been taken to ensure I cannot. Fred asks for notifications on
> all mount activity. I perform actions that result in notifications
> on "dot" and "dash". Fred receives notifications and interprets
> them using Morse code. This is not OK. If Wilma, who *is* allowed
> to communicate with Fred, does the same actions, he should be
> allowed to get the messages via Morse.

In other words, a classic covert channel. You can't really prevent two
cooperating processes from communicating through a covert channel on a
modern computer. You can transmit information through the scheduler,
through hyperthread resource sharing, through CPU data caches, through
disk contention, through page cache state, through RAM contention, and
probably dozens of other ways that I can't think of right now. There
have been plenty of papers that demonstrated things like an SSH
connection between two virtual machines without network access running
on the same physical host (<https://gruss.cc/files/hello.pdf>),
communication between a VM and a browser running on the host system,
and so on.
