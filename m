Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81EEB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 22:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGGWDF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGGWCx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 18:02:53 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F2FF
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 15:02:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579ef51428eso30939597b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jul 2023 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688767369; x=1691359369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fozmS9ohykuMG0mt3q/2GCQDPQotf5ax46cgz0nSs8A=;
        b=No04q+7lqQGEKheZMR2X3AggIo92qoc2sBapBqWn2dDcZM2kmHRgS3+1Gji89yaHuS
         AkWeDyfNh8Fr20HRuXvxeYyCDbd5FS9JuwaKcrPqCo2DiE0nFx+7rXqpudXnW+PIC4Dg
         E3s4FP+JSK04XWYBSovFqrTeTx2jcMwFMQMlzECh8OGFX8xfW7asJdPNVlJjQT13bHv9
         GbQcWIx/Ue/53OCYJgFVuAGpJ2U7BvCNzqKoist2iFLE1H9qr7FaKgzXBJwFfl49tLtg
         rfRe43Ft6ZUuXSvhHJ3O/rALIVqT+Lq0lGFvmXShnZR0HrOZt87g6YUPWWPr0sV8pysU
         PImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767369; x=1691359369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fozmS9ohykuMG0mt3q/2GCQDPQotf5ax46cgz0nSs8A=;
        b=ADImnUp0gZT0R8oouL2C8DaoAdXQsKQmcf4W12hHyhkJ+fD6AwfpCZIjRxXXsHt6bZ
         V+1t+F7tDYOmAh4+PiI+q0sa59dp0RxK3qOow5iKHQ43DalJ8DAQ1csJImV2TUs0ttBN
         Rwpi8f+a9Qh98og6HnY2MA30pNjNspFYO+rfY98axYjUfIiinm/BC2BwYXYrdzSKlGMc
         IEk76utwzhHu3LRry19oehbuBZjqPqS5tnX3AfhhYA3zdWe7OAlc5eXSIdhEOPlvNx9W
         NwQknPTdr4Wgz2Euklc9vgHTmzmXTuT7S5TilgEgzW250/Wx4VR9VXtNPuy08heXeO1Z
         +QXw==
X-Gm-Message-State: ABy/qLY/yOBngSsTr+p+N0AsyVZmfJi08XVpkse/q3BrFBaVzbnmrUxU
        LYTT2x3b6UB2B/Kbh/g3lDw0tUpqr5HV63Q17xyVQpElCpclojg=
X-Google-Smtp-Source: APBJJlG3TvD8Pqt5wx4z2jkkp9copBuy+99im1kuC2agsSreMwXGOeqkJnR/wvB+pB04QB3xP+6aic94M15N7iIJlfg=
X-Received: by 2002:a81:5b07:0:b0:561:206a:ee52 with SMTP id
 p7-20020a815b07000000b00561206aee52mr8570083ywb.24.1688767369454; Fri, 07 Jul
 2023 15:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
In-Reply-To: <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 18:02:38 -0400
Message-ID: <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 6, 2023 at 8:32=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/6/2023 1:42 PM, Paul Moore wrote:
> > Hello all,
> >
> > With some renewed interest in submitting new LSMs including in the
> > upstream Linux Kernel I thought it might be a good idea to document
> > some of our longstanding guidelines around submitting new LSMs.  I'm
> > posting this mostly as a FYI for those who are working on new LSM
> > submissions, but also to solicit feedback from everyone on the list
> > regarding what we should ask of new LSMs.  If you think I'm missing
> > something important, or believe I've added an unfair requirement,
> > please let me know.
> >
> > I've added the guidelines to the README.md at the top of the LSM tree,
> > but to make life easier for those reviewing the guidelines I'm
> > copy-n-pasting them below:
> >
> > * New LSMs must include documentation providing a clear explanation of
> > the LSM's requirements, goals, and expected uses. The documentation
> > does not need to rise to the level of a formal security model, but it
> > must be considered "reasonable" by the LSM community as a whole.
> >
> > * Any user visible interfaces provided by the LSM must be well
> > documented. It is important to remember the user visible APIs are
> > considered to be "forever APIs" by the Linux Kernel community; do not
> > add an API that cannot be supported for the next 20+ years.
> >
> > * Any userspace tools or patches created in support of the LSM must be
> > publicly available, with a public git repository preferable over a
> > tarball snapshot.
> >
> > * The LSM implementation must follow general Linux Kernel coding
> > practices, faithfully implement the security model and APIs described
> > in the documentation, and be free of any known defects at the time of
> > submission.
>
> Some commitment to maintaining the LSM for a reasonable time must be
> provided. Although this should probably be implicit in the use cases
> and goals, changes in product direction or employment status can leave
> an LSM orphaned before its time.

That's a good point, likely worth mentioning.  We're currently being
bit by that with SafeSetID, so the implicit understanding may need to
be made a bit more explicit.

> New LSM hooks introduced need to be generically usable. Use of LSM
> specific data should be avoided. The hook should include data at a
> granularity that can accommodate the existing LSMs as well as the
> new one. The data granularity must be appropriate for the sub-system
> from which it is called.

I hadn't thought of adding a section on adding new LSM hooks, but that
seems like a good idea too.  Thanks.

--=20
paul-moore.com
