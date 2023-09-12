Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05BEE3F0D
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjILTAm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjILTAm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Sep 2023 15:00:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E773E6
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 12:00:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58d31f142eeso59392907b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694545237; x=1695150037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGRiATL2lFlIkBSvoBGxDF1sGP2EyD95RTr7BhE2srU=;
        b=BFZOquvxSK5zpBgZhSCemf5DOeywusn037G3yIfbOrgELbkH7m2mP84qzwEGiXbSpn
         ozFr+FSzeU0fK+PYDsv3OUiFXnaZOxYPlY+QUnyRy4CuImoEDP5OP/0PHHJx3vXG0hPM
         KbGR9qsN0RT4K9Flam+91DiErjjgyBaG4ywpc6N43XWW+YKvQjD6Cpts8lntC9BEd3Sn
         RPftw2kBAmNhYOYqYhYzIAKBU7nVB+oCaqz5HAxaqOmlC9CCGHzjODD6ujb/zjMyWqnL
         5L+n0B/u6sAejuIObgKqWMJzcijwaquar55uT9PhZRrO6TF+I2/8WrSXgFVTtgcuFyWP
         SePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694545237; x=1695150037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGRiATL2lFlIkBSvoBGxDF1sGP2EyD95RTr7BhE2srU=;
        b=K1WGou+jJQR9VfL5g+WLdb82FNTd4eyFJ3Ar0KtYHBlip/uf1lUXKXqQujayqiKGhb
         DBk7/E9G/0FwSJlxfKmR7bU8MuDb8tJ8Tm+7sNubnyOFveQzyfat028Tf/XOelrTYtf1
         8OKVWCx2RtnwIc3ZUmSJHERD/EDv7p/2s0S7OvDGeG2RHpNqIY6BUB177Zob6bLLT6o3
         P4mzEvL0uWeOe11PVoFNJSdmaf4C1/V2S6LCSrBXtePIX5sV4aSojmQsz417Xq1nOWNu
         5RrBcgh76VPDm5J9WNoZ3f2+7cNaifjB66teLfFrOnYQX1ReUqDQZQWbAB3mtT5Z/GPr
         FkJw==
X-Gm-Message-State: AOJu0YwiPy8iRSmft0/grgvWrWVcInbaUV7qHpaGOhFdfHOVDD13BS2y
        ux6+QIqz1P/zJYgLmwWFEe2b4FIjlSKdUibWLO44V07Hu5n7h9Q=
X-Google-Smtp-Source: AGHT+IHpXpMxc/Euo1UFVVQpYMxE3o7/1Vdd9zcTUK7QT5KbbUHuGq5c68AoPexaaaL8GeWZnFSINGVCSEq0FPIXxRE=
X-Received: by 2002:a81:5cc1:0:b0:589:fcb2:d57f with SMTP id
 q184-20020a815cc1000000b00589fcb2d57fmr279341ywb.37.1694545237369; Tue, 12
 Sep 2023 12:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com> <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
In-Reply-To: <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 15:00:26 -0400
Message-ID: <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 12, 2023 at 2:40=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 9/12/2023 11:08 AM, Paul Moore wrote:
> >
> > Once again, we've already discussed this many, many times: out-of-tree
> > LSMs are not the priority and that is not going to change.  One
> > corollary of this is that we are not going to assign LSM IDs to LSMs
> > that remain out-of-tree as this would negatively impact the LSM layer
> > by cluttering/depleting the LSM ID space.  LSMs that are working
> > towards integration with the upstream Linux kernel can self-assign a
> > temporary LSM ID which will be finalized upon merging in the LSM tree.
> > Based on all of the arguments you have already submitted - and let us
> > be very clear: you are the only one speaking out against this - I see
> > no reason to change this policy.
>
> I won't say this is a great idea, or that I endorse it, but we could
> allocate a range of LSM ID values ( 10000 - 10999 ? ) that we promise
> will never be given to an upstream LSM. We wouldn't make any guarantees
> about conflicts otherwise. These could be used by LSMs before they are
> accepted upstream or by LSMs that don't have upstream aspirations. I
> seriously doubt that anyone using such an LSM is going to be mixing
> multiple such LSMs without being capable of managing ID conflicts.

Not a crazy idea.  I had debated something similar, a reserved
"private use" or "experimentation" range; there is definitely
precedence for that in other areas, e.g. network protocols.  What held
me back is that invariably folks will want to create long-term
persistent registrations against this space for their out-of-tree LSMs
which would require some sort of unofficial, adhoc registration
authority which starts to get a bit silly in my opinion (the
registration authority for the Linux kernel API is the upstream Linux
kernel community).

Temporary assignments while a LSM is undergoing the review-revision
cycle on its way to being merged is something different and if we need
a couple of reserved numbers for that (one or two MAX) we can consider
that, but I don't expect this to be a major problem in practice.  LSMs
that are in this transient pre-merge state shouldn't be used for
production purposes and thus a LSM ID change on merging shouldn't be a
problem.

--=20
paul-moore.com
