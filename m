Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A56C678D5
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCHRWG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHRVl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 12:21:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FDBC6C6
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 09:20:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn12so2409562pjb.5
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 09:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678296038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHX6cu7G2oq0OoVmoAYwuSHxrT6e7BdRcaqbogw5xBQ=;
        b=LcfklqPNlhUKJbhE4T+81HP0misiB6PEXffjStOPHmHJ/9wZzvyMcmUG7IEJKrstxJ
         SHoMSym8lNHuz5wPMTdhF9ogLAVex16nIKLopCcGB6UhGsxw061AJYa4Kr7CRj3FBahz
         JK8z14vZCU+ro9rLINJIlen+1+cl5iIqlzdCZgp61EZcfvXbdYVfvZ0c7jaEXYbYhSBM
         mcztkDkVu+IX9lt0SS4P2c6XfDXjwSGm3akM5daQxYEkPHSvdTo6/Ij4fSZCtFrHds1y
         ExX/5MDZXDuQEt1aEIT9yn9xfluFyBkm7BDX4/P0UatsjfRrnNh67gdDTsrmM2/iuptz
         Fl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHX6cu7G2oq0OoVmoAYwuSHxrT6e7BdRcaqbogw5xBQ=;
        b=2Z9OakLy6f3jpncghaiGDUWaUL0s8zYosfmkQ9t9rPxKZGqPkaDTL2I7N/xvGQ9C4C
         wU2yEst75kwaYkpkh8pV1cpHge5lKl/ZwPDcZFTFlym0tMs+qbG+maWB9H5PjvbvvKVz
         f0MvmvA7c3IByeCyU9NjK5uCXBN95+WBqo6x8vJoReIokO2JD8qMMuYHBxqeJ/gMaRad
         zdpX8jhwAyCdeoUkrrSJVJwF1iqqefkWVr51BImXYVkehVaNt+2Yq4c3kMafwOe6gPmk
         qAJgGL8uOxHirwZT4anim09/GrsERGGU2di3V5+hw+kPkLko1e3ucfNV7BwxyiBZpgrF
         WEiA==
X-Gm-Message-State: AO0yUKUly7dqoNM3dg9AEcdOUjuJ6Af9FidEiRcSCXcYUzCnLf/0/aWj
        PCHRAg5jdjLHYvsY2+6oCXlzaynemUyCC5/xFAP4khObwqryT7c=
X-Google-Smtp-Source: AK7set97lO8BWYLEG91BAU1sPDHbsSk6IBUA3GWA90c9SpPkeB9XO8lbUMdxa2pUhbu3eu6gF0PLpndMNRfelj4XZkA=
X-Received: by 2002:a17:902:ab0f:b0:19a:64f6:e147 with SMTP id
 ik15-20020a170902ab0f00b0019a64f6e147mr7692932plb.2.1678296038508; Wed, 08
 Mar 2023 09:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com> <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
 <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
 <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com>
 <5871614020e20f3e529e6d1244c2e207c7ce6004.camel@huaweicloud.com>
 <CAHC9VhTdBTopwGeyfr9YrOPdvczTk3mSGtjoW3_CYKDHMGkf9g@mail.gmail.com> <8a899d7f5f68a9f602efa50c71505f05130eb383.camel@huaweicloud.com>
In-Reply-To: <8a899d7f5f68a9f602efa50c71505f05130eb383.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 12:20:27 -0500
Message-ID: <CAHC9VhSUjkdm0jfm+m=6GK3v9Vf7hV0287U+DrqvQ3RFauQLzQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 8, 2023 at 12:14=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2023-03-08 at 12:09 -0500, Paul Moore wrote:
> > On Tue, Mar 7, 2023 at 11:38=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Tue, 2023-03-07 at 11:33 -0500, Paul Moore wrote:
> > > > On Tue, Mar 7, 2023 at 3:09=E2=80=AFAM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Mon, 2023-03-06 at 13:49 -0500, Paul Moore wrote:
> > > > > > On Thu, Feb 16, 2023 at 10:26=E2=80=AFPM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > > > > Hello all,
> > > > > > >
> > > > > > > The LSM hook comment blocks are a in a rather sad state; sepa=
rated from
> > > > > > > the hook definitions they are often out of mind, and as a res=
ult
> > > > > > > most of them are in varying levels of bit-rot, some severely.=
  This
> > > > > > > patchset moves all of the comment blocks out of lsm_hooks.c a=
nd onto
> > > > > > > the top of the function definitions as one would normally exp=
ect.
> > > > > > > In the process of moving the comment blocks, they have been m=
assaged
> > > > > > > into the standard kernel-doc format for the sake of consisten=
cy and
> > > > > > > easier reading.  Unfortunately, correcting all of the errors =
in the
> > > > > > > comments would have made an extremely long and painful task e=
ven worse,
> > > > > > > so a number of errors remain, but the worst offenders were co=
rrected in
> > > > > > > the move.  Now that the comments are in the proper location, =
and in the
> > > > > > > proper format, my hope is that future patch submissions corre=
cting the
> > > > > > > actual comment contents will be much easier and the comments =
as a whole
> > > > > > > will be easier to maintain.
> > > > > > >
> > > > > > > There are no code changes in this patchset, although since I =
was
> > > > > > > already adding a lot of churn to security.c, the last patch i=
n this
> > > > > > > patchset (22/22) does take the liberty of fixing some rather =
ugly
> > > > > > > style problems.
> > > > > > >
> > > > > > >  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
> > > > > > >  security/security.c       | 2702 +--------------------------=
-------------
> > > > > > >  2 files changed, 1710 insertions(+), 2616 deletions(-)
> > > > > >
> > > > > > Seeing no objections, and the ACK from Casey, I've gone ahead a=
nd
> > > > > > merged this patchset into the lsm/next branch.  There was some =
minor
> > > > > > merge fuzz due to the mount idmap work and some IMA changes, bu=
t the
> > > > > > vast majority of the patchset is exactly as posted.
> > > > >
> > > > > Oh, I thought it was an intermediate version and didn't report so=
me
> > > > > issues:
> > > >
> > > > If you don't see a "RFC" in the patch subject line it's safe to ass=
ume
> > > > it is a "final" version.  Regardless, feedback is never bad, even i=
f
> > > > it is a RFC.
> > > >
> > > > > scripts/kernel-doc security/security.c|grep warning
> > > > > security/security.c:1236: warning: Function parameter or member '=
mnt_opts' not described in 'security_free_mnt_opts'
> > > > > security/security.c:1236: warning: Excess function parameter 'mnt=
_ops' description in 'security_free_mnt_opts'
> > > > > security/security.c:1254: warning: Function parameter or member '=
mnt_opts' not described in 'security_sb_eat_lsm_opts'
> > > > > security/security.c:1254: warning: Excess function parameter 'mnt=
_ops' description in 'security_sb_eat_lsm_opts'
> > > > > security/security.c:1423: warning: Function parameter or member '=
oldsb' not described in 'security_sb_clone_mnt_opts'
> > > > > security/security.c:1423: warning: Function parameter or member '=
newsb' not described in 'security_sb_clone_mnt_opts'
> > > >
> > > > Unsurprising.  Those patches were mostly just to relocate the comme=
nt
> > > > blocks out of lsm_hooks.h and into security.c; while I did fix some=
 of
> > > > the really bad errors, fixing everything in the move wasn't really =
the
> > > > goal, that's for future work.
> > > >
> > > > Did you want to submit a patch to fix those?
> > >
> > > I rebased the stacked IMA/EVM to your patch set, so that it is closer
> > > to the final version. I expect there will not be too many conflicts.
> > >
> > > It is also ok for me to fix those issues in the future.
> >
> > That would be great, thanks.
>
> I meant generically someone... (ok, I got the task).

Ah, okay, no worries.  I'll go ahead and fixup the current kdoc
warnings (today?), but the comment blocks could still use a bit of
review to fix/improve the quality of the comments in general.

--=20
paul-moore.com
