Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9966C6FD1A
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Mar 2023 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCGQgS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCGQf0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C3894740
        for <linux-security-module@vger.kernel.org>; Tue,  7 Mar 2023 08:34:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bo22so13773579pjb.4
        for <linux-security-module@vger.kernel.org>; Tue, 07 Mar 2023 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678206848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1S+Oj9k/CH++etW/Ysk7C1IzOlnJZFlnazXQV8AC7U=;
        b=ddpeK/bPh/Y8kU9YMw4ZTWrV8a+v+BFy5pwSuSoxLE+Dr99//hOjUQqTZq/1VMSRRr
         EAjldUnUSfICNgV9QZp9UU6Bz9STM0BEXfpe2m3C7Oo0mao2ZrYfIB4CYzd7LMo7yBPl
         uUk7P78RE2BUrNU2YHmPCxH74pt0Oopu2aaJ2o247wJ7/mS3TDbO2bJ6d6If3zK975Hj
         H00+pTT2p81/ZMYHiZz0b6f0HsltNrWf+XtsA7UiehZrUKIC3/eo59imRgDxyKVYaMA7
         QUttAIC3Lo1tPRS7xO2EYrrKhaHs3svt0lpZjC04vKZc+f2h2xh6yhVsRzqvamAHV3lo
         DmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1S+Oj9k/CH++etW/Ysk7C1IzOlnJZFlnazXQV8AC7U=;
        b=mb+nqttmNNPj0Jec8cmzI5vLSMymrAUJICZB1dPzADvn8evvqfE5e8U9zy/2bN1nZl
         c3kiw4T2eqay14fgGTlEecz3N8yeRU08E+jetvE8/CiDTD5goSkFmRsDUpEPh3mJN5yu
         C2ZznM+L10lrA6yXcI6ApWYwrDKWvomIf8LmrT0b6gnh9bYSk0j7l8Aoh7EOV1i9vlPp
         qfPcPevrMJ5YE0kEac9MYaRgjwvGIeUyIfW7HOhChi8VRub/lx+9hXa5h1OX7G19/2Nm
         dM09h3lczhhMtdsfu7ln8/d5uOnKuqq12L7AR2Uyi9ffav4K0qNCCvtgG0NZAJ97rQ1C
         bwIg==
X-Gm-Message-State: AO0yUKXe80NJIG5ieMBq1F4Jrwp3k6CQo2qIRKJ+H0c+LHISK0dMCsr0
        WqUY+g1006iV6LWgd0iLhA38rWXEv/QM8r++IzS8w1ITxYKvIRc=
X-Google-Smtp-Source: AK7set/onW4yTCBlAfECfxg6wZDuhi0ESl0ZFC0ct1SRK9PrzKD4nOP0ofiupvZf6Vt8PshhbZ2oVHheGd709oa1AuA=
X-Received: by 2002:a17:902:ed82:b0:19a:e3d4:216e with SMTP id
 e2-20020a170902ed8200b0019ae3d4216emr5773247plj.7.1678206847967; Tue, 07 Mar
 2023 08:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com> <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
 <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
In-Reply-To: <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Mar 2023 11:33:56 -0500
Message-ID: <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 7, 2023 at 3:09=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2023-03-06 at 13:49 -0500, Paul Moore wrote:
> > On Thu, Feb 16, 2023 at 10:26=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > Hello all,
> > >
> > > The LSM hook comment blocks are a in a rather sad state; separated fr=
om
> > > the hook definitions they are often out of mind, and as a result
> > > most of them are in varying levels of bit-rot, some severely.  This
> > > patchset moves all of the comment blocks out of lsm_hooks.c and onto
> > > the top of the function definitions as one would normally expect.
> > > In the process of moving the comment blocks, they have been massaged
> > > into the standard kernel-doc format for the sake of consistency and
> > > easier reading.  Unfortunately, correcting all of the errors in the
> > > comments would have made an extremely long and painful task even wors=
e,
> > > so a number of errors remain, but the worst offenders were corrected =
in
> > > the move.  Now that the comments are in the proper location, and in t=
he
> > > proper format, my hope is that future patch submissions correcting th=
e
> > > actual comment contents will be much easier and the comments as a who=
le
> > > will be easier to maintain.
> > >
> > > There are no code changes in this patchset, although since I was
> > > already adding a lot of churn to security.c, the last patch in this
> > > patchset (22/22) does take the liberty of fixing some rather ugly
> > > style problems.
> > >
> > >  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
> > >  security/security.c       | 2702 +----------------------------------=
-----
> > >  2 files changed, 1710 insertions(+), 2616 deletions(-)
> >
> > Seeing no objections, and the ACK from Casey, I've gone ahead and
> > merged this patchset into the lsm/next branch.  There was some minor
> > merge fuzz due to the mount idmap work and some IMA changes, but the
> > vast majority of the patchset is exactly as posted.
>
> Oh, I thought it was an intermediate version and didn't report some
> issues:

If you don't see a "RFC" in the patch subject line it's safe to assume
it is a "final" version.  Regardless, feedback is never bad, even if
it is a RFC.

> scripts/kernel-doc security/security.c|grep warning
> security/security.c:1236: warning: Function parameter or member 'mnt_opts=
' not described in 'security_free_mnt_opts'
> security/security.c:1236: warning: Excess function parameter 'mnt_ops' de=
scription in 'security_free_mnt_opts'
> security/security.c:1254: warning: Function parameter or member 'mnt_opts=
' not described in 'security_sb_eat_lsm_opts'
> security/security.c:1254: warning: Excess function parameter 'mnt_ops' de=
scription in 'security_sb_eat_lsm_opts'
> security/security.c:1423: warning: Function parameter or member 'oldsb' n=
ot described in 'security_sb_clone_mnt_opts'
> security/security.c:1423: warning: Function parameter or member 'newsb' n=
ot described in 'security_sb_clone_mnt_opts'

Unsurprising.  Those patches were mostly just to relocate the comment
blocks out of lsm_hooks.h and into security.c; while I did fix some of
the really bad errors, fixing everything in the move wasn't really the
goal, that's for future work.

Did you want to submit a patch to fix those?

--=20
paul-moore.com
