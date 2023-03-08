Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99099C678D5
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCHRJj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHRJh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 12:09:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7CBC7A6
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 09:09:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so18287245plz.8
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678295375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0E7IdBcPGDWLVrEs3VCRDoj5ebPnxVAi2ObOXtwaIw=;
        b=RwZUWiHFc3FlawweWuI4Le2kYf/vo6kg1f4tKGBa3FOo7cSj963WCm/6hFa+JRIcHC
         cm34KkwP5RroNuAVtFIu6WNDts1H58drkwuYGWt10HU8fy4xJRpIMoXe+dF0MZFZHeTu
         2VIviA/ULVvC2SCZaZ9TI8FdjiYrlwhfT1iGVku0A27zVrT1YhoxhVZaNnmqO5RtlFZ0
         ocGVZVovh6MopvuEEz0EwCXAYe74dGSwcksZxiw7UFlLO0TjKIr8Bl7TVthcAZY45sZ0
         WSuAE7TnuJUKHm3aVBqElIJ7AA0fHSZvtBiEvNbbdYi+Ind2ZPoTti4U89G8QRsfCG/E
         Qteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0E7IdBcPGDWLVrEs3VCRDoj5ebPnxVAi2ObOXtwaIw=;
        b=jPKtylCU2s7OPOFy3wVwO2pEhosg9JtzErxsDVWoFm00h21+UdRl3/p4IsNyt58Kax
         rubaegfhdAlcjK3WoAiCiLkp6Vh0GKhBJH3X9CdNH8GlRQCsGdI9GVoKo7dQzLmhdcJM
         8l3s5aQ27MLjbipj4gN6ureHKBDgxaaXhF150AYm9UHOGxNebucr9QBlM+dbWiJnFupg
         HTEkbO+6vyQUNY6pBmE1kKSWarsuxiT6mDtSuGaQPF0u1j9ydFd3/+/F5ZWLSWiMU1hm
         8VD1RNAhlxOmws1D7CDLhuTF0jRVOL9hF1t/gHGq/uckZzvbhFV9lYgFJ2rOkZ7RAfoJ
         lCyw==
X-Gm-Message-State: AO0yUKUNIbqudMUWoItTkEl+CeIgOhgeBB4CDEZlSAPfQDw8ujJBooG1
        e7TfP6ZMQNcW1gEje+nC0wvQLBFELk3894aMGBebby7h1U0kfcI=
X-Google-Smtp-Source: AK7set/pulongWMsqooQuOI2UHyGjztX7eS74v0eGP95Ea3g8wMaMgMPJTQFmanNHkZvOlp1UFK+t7q2aiPcJZtkEKY=
X-Received: by 2002:a17:903:493:b0:19a:f63a:47de with SMTP id
 jj19-20020a170903049300b0019af63a47demr7283277plb.7.1678295375427; Wed, 08
 Mar 2023 09:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com> <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
 <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
 <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com> <5871614020e20f3e529e6d1244c2e207c7ce6004.camel@huaweicloud.com>
In-Reply-To: <5871614020e20f3e529e6d1244c2e207c7ce6004.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 12:09:24 -0500
Message-ID: <CAHC9VhTdBTopwGeyfr9YrOPdvczTk3mSGtjoW3_CYKDHMGkf9g@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 7, 2023 at 11:38=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2023-03-07 at 11:33 -0500, Paul Moore wrote:
> > On Tue, Mar 7, 2023 at 3:09=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Mon, 2023-03-06 at 13:49 -0500, Paul Moore wrote:
> > > > On Thu, Feb 16, 2023 at 10:26=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > Hello all,
> > > > >
> > > > > The LSM hook comment blocks are a in a rather sad state; separate=
d from
> > > > > the hook definitions they are often out of mind, and as a result
> > > > > most of them are in varying levels of bit-rot, some severely.  Th=
is
> > > > > patchset moves all of the comment blocks out of lsm_hooks.c and o=
nto
> > > > > the top of the function definitions as one would normally expect.
> > > > > In the process of moving the comment blocks, they have been massa=
ged
> > > > > into the standard kernel-doc format for the sake of consistency a=
nd
> > > > > easier reading.  Unfortunately, correcting all of the errors in t=
he
> > > > > comments would have made an extremely long and painful task even =
worse,
> > > > > so a number of errors remain, but the worst offenders were correc=
ted in
> > > > > the move.  Now that the comments are in the proper location, and =
in the
> > > > > proper format, my hope is that future patch submissions correctin=
g the
> > > > > actual comment contents will be much easier and the comments as a=
 whole
> > > > > will be easier to maintain.
> > > > >
> > > > > There are no code changes in this patchset, although since I was
> > > > > already adding a lot of churn to security.c, the last patch in th=
is
> > > > > patchset (22/22) does take the liberty of fixing some rather ugly
> > > > > style problems.
> > > > >
> > > > >  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
> > > > >  security/security.c       | 2702 +------------------------------=
---------
> > > > >  2 files changed, 1710 insertions(+), 2616 deletions(-)
> > > >
> > > > Seeing no objections, and the ACK from Casey, I've gone ahead and
> > > > merged this patchset into the lsm/next branch.  There was some mino=
r
> > > > merge fuzz due to the mount idmap work and some IMA changes, but th=
e
> > > > vast majority of the patchset is exactly as posted.
> > >
> > > Oh, I thought it was an intermediate version and didn't report some
> > > issues:
> >
> > If you don't see a "RFC" in the patch subject line it's safe to assume
> > it is a "final" version.  Regardless, feedback is never bad, even if
> > it is a RFC.
> >
> > > scripts/kernel-doc security/security.c|grep warning
> > > security/security.c:1236: warning: Function parameter or member 'mnt_=
opts' not described in 'security_free_mnt_opts'
> > > security/security.c:1236: warning: Excess function parameter 'mnt_ops=
' description in 'security_free_mnt_opts'
> > > security/security.c:1254: warning: Function parameter or member 'mnt_=
opts' not described in 'security_sb_eat_lsm_opts'
> > > security/security.c:1254: warning: Excess function parameter 'mnt_ops=
' description in 'security_sb_eat_lsm_opts'
> > > security/security.c:1423: warning: Function parameter or member 'olds=
b' not described in 'security_sb_clone_mnt_opts'
> > > security/security.c:1423: warning: Function parameter or member 'news=
b' not described in 'security_sb_clone_mnt_opts'
> >
> > Unsurprising.  Those patches were mostly just to relocate the comment
> > blocks out of lsm_hooks.h and into security.c; while I did fix some of
> > the really bad errors, fixing everything in the move wasn't really the
> > goal, that's for future work.
> >
> > Did you want to submit a patch to fix those?
>
> I rebased the stacked IMA/EVM to your patch set, so that it is closer
> to the final version. I expect there will not be too many conflicts.
>
> It is also ok for me to fix those issues in the future.

That would be great, thanks.

--=20
paul-moore.com
