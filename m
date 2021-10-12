Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E4C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442D60E90
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhJLVMH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhJLVMG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 17:12:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B1C061570
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 14:10:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec8so1364393edb.6
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIc7J0I6FwSkiki0MmnUpJSfDb1DE1q0Qfd20XtQZGE=;
        b=sCl/s36AnuHjjSjZlTl4dMn27h1JVRb4iDvBU/MdVjbwFaWy1Zy9l9+e40FQLo/UG9
         WgE216AhaJMkhWLLRr45EOFJ6Qj2n6j+0sjKP0U44jvE6oo+PJYHNO1hlhfsruegmRlD
         YPZ7h6tjM0R3fFU6HRwID9wFC3kxvVHnYzS8AS71LTqdNxgCUccyZzqXtTDuKBhqoT4i
         rpJumK9Q3+9vuNUTDb8LhJ0bgWQflES/c+XJ7mriPBb6J2jOglaWERCpri8UOIPtgmFY
         o/DXY8IGKWd7AGetWMTFcZJNohPPQebDr/P/KWANobgAPXeBCdiYKIK6UBOG6XVDChaL
         DFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIc7J0I6FwSkiki0MmnUpJSfDb1DE1q0Qfd20XtQZGE=;
        b=mxQHNm8QLauwb1bjQ4poNi4iltHi//k2wDk2iRF1YbbJmCYUb8vCSgxxueHiPzD5BH
         3DYEV5pxtYR07JMswVYulx7Ea1asfWCx5XbHcN3ZbS7RvzgB/BT8WanXu6jSOx6rRHWi
         fXDdTctFLPHUQE3XZMVdSw6q1LyU3hYqWGdcD28DpSp+3FjmCb50uJG6rnHDfOiYkvVU
         K9CEi33IvtdFVYNX7T/tvPVOvKz4SSTzHfUTU7Tf5wBL/GkLdva0fJygW5G0ksvIAWjw
         N+vta356J/yifV/fDaDgmnQSSg4jzt7CJeZOqG739Sv4rjYM19uCbw0tUwjb2tGEOAep
         Uxag==
X-Gm-Message-State: AOAM531qNB1Rrtyih4NbolLHJrcSi1BqDRxc1Is3YDxFwh3SiFqZ78Bg
        gbiFiBFSi95ZgN9mNpRfaOylEgzWLDIkacS9bB0U
X-Google-Smtp-Source: ABdhPJwoz8GHidIBsTuYLRywH+7rV4r6zIPCZy4GmxzdM4b+0NCo6+Qre0OXbJU2v/mBZ3BAvCDSEyiXFRAnNEvY/MU=
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr2941132edb.318.1634073003025;
 Tue, 12 Oct 2021 14:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011133704.1704369-1-brauner@kernel.org> <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
 <20211012103830.s7kzijrn25ucjasr@wittgenstein> <CAHC9VhSd32Q_tCctwYB0y4EXGCV8_9QajkNkkc96EwjdFsVkJw@mail.gmail.com>
 <CAFqZXNu7OEFVaS-oJH_JhsCWg3aN67Hajbiw8U8Zd+TSMKatOQ@mail.gmail.com>
In-Reply-To: <CAFqZXNu7OEFVaS-oJH_JhsCWg3aN67Hajbiw8U8Zd+TSMKatOQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 17:09:51 -0400
Message-ID: <CAHC9VhR2kvwaYWZtXrZty7X_uQCr+pHnm6rHFAGzUDrstBpT_g@mail.gmail.com>
Subject: Re: [PATCH] security/landlock: use square brackets around "landlock-ruleset"
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 12, 2021 at 4:38 PM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> On Tue, Oct 12, 2021 at 8:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Oct 12, 2021 at 6:38 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > On Mon, Oct 11, 2021 at 04:38:55PM +0200, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > > On 11/10/2021 15:37, Christian Brauner wrote:
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > >
> > > > > Make the name of the anon inode fd "[landlock-ruleset]" instead o=
f
> > > > > "landlock-ruleset". This is minor but most anon inode fds already
> > > > > carry square brackets around their name:
> > > > >
> > > > >     [eventfd]
> > > > >     [eventpoll]
> > > > >     [fanotify]
> > > > >     [fscontext]
> > > > >     [io_uring]
> > > > >     [pidfd]
> > > > >     [signalfd]
> > > > >     [timerfd]
> > > > >     [userfaultfd]
> > > > >
> > > > > For the sake of consistency lets do the same for the landlock-rul=
eset anon
> > > > > inode fd that comes with landlock. We did the same in
> > > > > 1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontex=
t" [ver #2]")
> > > > > for the new mount api.
> > > >
> > > > Before creating "landlock-ruleset" FD, I looked at other anonymous =
FD
> > > > and saw this kind of inconsistency. I don't get why we need to add =
extra
> > > > characters to names, those brackets seem useless. If it should be p=
art
> > >
> > > Past inconsistency shouldn't justify future inconsistency. If you hav=
e a
> > > strong opinion about this for landlock I'm not going to push for it.
> > > Exchanging more than 2-3 email about something like this seems too mu=
ch.
> >
> > [NOTE: adding the SELinux list as well as Chris (SELinux refrence
> > policy maintainer) and Petr (Fedora/RHEL SELinux)]
> >
> > Chris and Petr, do either of you currently have any policy that
> > references the "landlock-ruleset" anonymous inode?  In other words,
> > would adding the brackets around the name cause you any problems?
>
> AFAIU, the anon_inode transitions (the only mechanism where the "file
> name" would be exposed to the policy) are done only for inodes created
> by anon_inode_getfd_secure(), which is currently only used by
> userfaultfd. So you don't even need to ask that question; at this
> point it should be safe to change any of the names except
> "[userfaultfd]" as far as SELinux policy is concerned.

There is also io_uring if you look at selinux/next.

Regardless, thanks, I didn't check to see if landlock was using the
new anon inode interface, since both Micka=C3=ABl and Christian were
concerned about breaking SELinux I had assumed they were using it :)

--=20
paul moore
www.paul-moore.com
