Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46298C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Oct 2023 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJ3VER (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Oct 2023 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjJ3VEQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Oct 2023 17:04:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85251FC
        for <linux-security-module@vger.kernel.org>; Mon, 30 Oct 2023 14:04:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da37522a363so123957276.0
        for <linux-security-module@vger.kernel.org>; Mon, 30 Oct 2023 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698699853; x=1699304653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IRBB4v+xNKwfa339/f54Eupmf6Jk1Nhnt0RmKMHDA0=;
        b=BmsmR0SISl+xP97UkzsUvLRJ0VnfYymUBTxOCtmdUgJREceVK/++izMXyzy6L2FClB
         vLjelyrAuZ9G9bv+pqvGPQ9KzJYmpk05sHzAKHQMs7AJ/wqrn8J9LCCc3gGuG9iYWzQH
         NAa+2P+3OvfGuoUYWHFb7N+CigQxbNc2SX6rPFE29jyMdI7edt+mn3S5z0NQs6aKwG55
         jbp3dDQ2gb6O7ffvwJpkdkKVggp1oU7XhMw/ac+KoWX5Cyx6gfJbn4HoSd0N+VmRAx+i
         zjER/MARXQfXwC1OfG56ogmzD+SpfKLWYZmaSPcLd4pYcUqICjJyrTIZZ6X3RyTiHAUr
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699853; x=1699304653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IRBB4v+xNKwfa339/f54Eupmf6Jk1Nhnt0RmKMHDA0=;
        b=gIDUfGnroAHx9KjsngMavLHDdjpP3V957G/10taZ0ghkP0y1c41q8Q950Qptmuoo1b
         sFKxnMhtrTrEyzp+JzDwolmJTR2GmikO76vWjr7PEitQuFx32btrXfSVyrhwA2Sd1+RG
         6b06S/clzHdlAqhVkOf9S5M5GhnTfWOzSmYRebsyvDsSxAUiwjE8Rwi6m8oehv3EsWk/
         EURTo0OR/UVGURN/gyI1ZVRKQ2ozZMvufAWk/voZVpOCTsIWCgVuTmt/s2u8TKzfEVod
         Jrq0VawcKJUp5FQ1mIytumGAf89D2ONwGM2ZdjVk4NWUToLcBUiXxE34tvRDD7m+a0/P
         7a9g==
X-Gm-Message-State: AOJu0Yz3mD7fqKQxdvSvN3Ev/Q2lTruDtgJSomGtBiftQ3yvOddhbACW
        EEu9nHPPZNlHpmgo7u7/j3Wkyf/RtFYZeT6w4PTx
X-Google-Smtp-Source: AGHT+IHgWT98tQeMKmbprLoIOO4qYYNM0FKQ8Yylq7cSYwMVyIM6xEJkoJ8OMu86XlQJpwgHYhnP6KQuaS4mdiHRKF0=
X-Received: by 2002:a25:a2ca:0:b0:d9a:c218:817c with SMTP id
 c10-20020a25a2ca000000b00d9ac218817cmr11419967ybn.4.1698699852727; Mon, 30
 Oct 2023 14:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231027130320.69469330@canb.auug.org.au> <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
 <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com> <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
 <20231031074649.3bdbec45@canb.auug.org.au>
In-Reply-To: <20231031074649.3bdbec45@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Oct 2023 17:04:01 -0400
Message-ID: <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
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

On Mon, Oct 30, 2023 at 4:46=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Paul,
>
> On Mon, 30 Oct 2023 12:52:50 -0400 Paul Moore <paul@paul-moore.com> wrote=
:
> >
> > On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen <john.johansen@ca=
nonical.com> wrote:
> > >
> > > is part of the Three basic syscalls series, the plan is still to have=
 that
> > > series bake in next for a full cycle?
> >
> > Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the LSM
> > syscall patches and I expect the vast majority of these conflicts to
> > disappear, although I'm sure we'll pick up some new ones with the rest
> > of the v6.7-rcX cycle :)
>
> These patches should not be in linux-next until after v6.7-rc1.

What if we wanted additional testing beyond the typical?  Do you not
support that?

--=20
paul-moore.com
