Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87731C4167B
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Nov 2023 23:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjKEXhF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Nov 2023 18:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjKEXhE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Nov 2023 18:37:04 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05205136
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 15:37:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da041ffef81so4182703276.0
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 15:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699227420; x=1699832220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzSqKUikOHBeX7iFBnbpnh2tz9SPjogXq2dkiXmXdQE=;
        b=TtmsU3m8CzI0ldMscosDUao0+q27+Gclg00LIcZWWMrZZDZdakv6b2v9y1K1kmeTBl
         Xs2nTZASOKiLBDbV9bglnbR3mfXQ//0DftYeY1uvFPXwXdZFyY33W8QjGXangy+lSV+6
         /JQ3Sz/iSiTXx0yUBpZWLHWughuBSjm6fKjF70AC+qhv1QYf1Oi2ijbq1w4xtdlN5wMf
         pH8KZpWIk9ASwQQBXFxyxWi/RYZdIVbDtojvoQIcOcz84AQ4fF7QAj84e/tpOHz0WAcU
         Tyf7/1reh0fEiNKHPUgt+C+d3BvLZoIOUdhpuazXhwAd6t/zSnChRKYcf+oaC9WhikCX
         cVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699227420; x=1699832220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzSqKUikOHBeX7iFBnbpnh2tz9SPjogXq2dkiXmXdQE=;
        b=eCYlNil8fc0xKNhOBul9gX/8st/FC+0nH8zXFnQipCrgGhv5k3xcGgYzy1Ma7OLDqM
         xKWqX5yalrsUt9u0G3qtPWVyV+WEd/s4tLEKvJzeQSbNAqdrAq6+gxHkjGzEsg8gCRGK
         uqnOPC/LJEgippLyItyVWO7+bBIft2l+NmnSXw1Xr4orm3H35HN5sD9YB84UjeYadmM/
         q3sj1AzfEctMj5xppUfDd3/Yv5JeHAuVJ2fhR3+9CQH+kod7PwMfsnnConmMxPb2jpfM
         F3ISY06oNmFkcPQck/gyjquPfuBAjIDbj7JiMDWffmGC69/qRltmzYev6K/PK5kjLvzN
         1H+w==
X-Gm-Message-State: AOJu0YzIx+l3VCaqpwb/psUqlnUhU7a6xntRu+rJl9f5LKN8BgpISInC
        3eXdECxgJ/aeDIzXXM0ajsQPAybOYAfqQfx9HIt2
X-Google-Smtp-Source: AGHT+IHDsU+1kE9adaZnQPvPUleIvQSF3bEFfshHvM3GEFdpaDfxDryWr4eFwpMOu4AmXCOkBehgWzH7n6BQ2iu0v3s=
X-Received: by 2002:a25:6b44:0:b0:da0:38c8:2e66 with SMTP id
 o4-20020a256b44000000b00da038c82e66mr25816467ybm.3.1699227419896; Sun, 05 Nov
 2023 15:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20231027130320.69469330@canb.auug.org.au> <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
 <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com> <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
 <20231031074649.3bdbec45@canb.auug.org.au> <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
 <20231106101434.70c62773@canb.auug.org.au>
In-Reply-To: <20231106101434.70c62773@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Nov 2023 18:36:49 -0500
Message-ID: <CAHC9VhQkUVCAboT78M3g6LabmzFqKYdsxMHQ7ePETJKnzDiV+Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the apparmor tree with the security tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 5, 2023 at 6:14=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi Paul,
>
> [Sorry for the slow reply]
>
> On Mon, 30 Oct 2023 17:04:01 -0400 Paul Moore <paul@paul-moore.com> wrote=
:
> >
> > On Mon, Oct 30, 2023 at 4:46=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:
> > >
> > > On Mon, 30 Oct 2023 12:52:50 -0400 Paul Moore <paul@paul-moore.com> w=
rote:
> > > >
> > > > On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen <john.johanse=
n@canonical.com> wrote:
> > > > >
> > > > > is part of the Three basic syscalls series, the plan is still to =
have that
> > > > > series bake in next for a full cycle?
> > > >
> > > > Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the L=
SM
> > > > syscall patches and I expect the vast majority of these conflicts t=
o
> > > > disappear, although I'm sure we'll pick up some new ones with the r=
est
> > > > of the v6.7-rcX cycle :)
> > >
> > > These patches should not be in linux-next until after v6.7-rc1.
> >
> > What if we wanted additional testing beyond the typical?  Do you not
> > support that?
>
> No, I try hard not to.  It just complicates things when I and others
> have to cope with conflicts and build problems caused by
> patches/features destined for next+1 while trying to stabilise the
> current/next release.

The LSM, SELinux, and audit dev-staging branches will no longer flow
into the next branches, and I've reset the current lsm/next branch so
this should not be an issue the next time you pull.

> Sometimes it happens that a feature slips after being added to -next,
> but please don't do it deliberately.

--=20
paul-moore.com
