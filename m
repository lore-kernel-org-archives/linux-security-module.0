Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9551EEE3F09
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjILSJI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjILSJH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Sep 2023 14:09:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911F115
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 11:09:03 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59b5484fbe6so47759367b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694542143; x=1695146943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUAG38+T8vu5uTueEpIAgiD2khOdb4X1efQU3bs+6hQ=;
        b=Q/1s9wF5x/16g2eeKNF7uNcf6EzspK/hw5UXVNF3IO937dRd7gO4t4KmNOy/v7UZ+y
         Dc2Rqol6D9rdfpXy15+43cqOflNlWalFg8gw3AhHjYdZ/3+Mym53sYBFYUKp7QLYZRIB
         aiMUAfKV2fZvBf9Uy/Q1WVnKeRc7chEx2SHGnI2KsS9fe+SqreCKgLXZzqFD5zvP8xNi
         bJYa3oaEEQByFDiZOSAam+Dk9bsmjjjjdxbZ2SWUl8YltUy7SMieb8GWMtORIZ7GPUZt
         Ubxz1qlssgnjvFT24BZstUiTo06D50p+oz7czBwm2sZx81u5brLFjSlCaNuKK3CYp4aX
         1zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542143; x=1695146943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUAG38+T8vu5uTueEpIAgiD2khOdb4X1efQU3bs+6hQ=;
        b=kRJFZ2RQtHVVAw4Dfvv1mLoVxPCzL2NBv8EZOkAP+r6Bjyk/3CuKbbTOejOxu0LL8o
         DkOb6K9CO6UCepn6ekQea7bzdJxFneSFvzhhrgMczSSf3+uQJDlmJ71k8XVHpQ1v4rQV
         TfWDlqOGItap1hepIYodQ+dCTBryAegIHns7jtt8UilzHVLRGZwjKjRGFp+kah2UZxEy
         Ep7gyUQiH8QWY8A48Ui3eDdY4bQdVJzZmazylY9u/mFPRSRbWjjdDH2HIJT8DdX+g5JS
         vhV9UgHWO9Mwz6MP4DdDwKkuPQQbx/GJ7yEGRU1/q6in6qkmHVWOXWaN19z325kk1iqi
         id9Q==
X-Gm-Message-State: AOJu0YyMBxiOUQ+v0teVllRnByCVt5HaTIEv5hvTW1o9YZOE192C2GKd
        cpAYooXLPS7GeytI599DkOhP1+hVHFEV8GB9biEn1cTx79LWZug=
X-Google-Smtp-Source: AGHT+IEK6/E32CyfQtFN20WSeZUDuZ2hgGi0WgblUFofcfLEbl0zINNDGO0Q0BBtMfp0a+rcM1kRkWYJmDA1XgipKWE=
X-Received: by 2002:a81:5208:0:b0:594:fd81:c3bf with SMTP id
 g8-20020a815208000000b00594fd81c3bfmr269446ywb.1.1694542142703; Tue, 12 Sep
 2023 11:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com> <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
In-Reply-To: <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 14:08:51 -0400
Message-ID: <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 11, 2023 at 9:29=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/09/12 5:04, Paul Moore wrote:
> >> If one of userspace tools designed for the new LSM depends on the LSM =
ID, when can
> >> the author of the new LSM obtain the stable LSM ID for that LSM ?
> >
> > A permanent LSM ID is assigned to LSMs when they are merged into the
> > upstream LSM tree.  This is no different than any other kernel defined
> > macro constant, enum, magic number, etc. that is shared between kernel
> > and userspace and is considered part of the kernel's API.
>
> Then, your
>
>   * The new LSM must be sufficiently unique to justify the additional wor=
k
>   involved in reviewing, maintaining, and supporting the LSM.  It is reas=
onable
>   for there to be a level of overlap between LSMs, but either the securit=
y model
>   or the admin/user experience must be significantly unique.
>
> is an ultimately unfair requirement, for the combination of
>
>   Ultimately, new LSMs are added to the kernel at the discretion of the m=
aintainers
>   and reviewers.
>
> and
>
>   A permanent LSM ID is assigned to LSMs when they are merged into the up=
stream
>   LSM tree.
>
> causes locking out not-yet-in-tree and out-of-tree LSMs.

As discussed many times prior, I consider in-tree, upstreamed LSMs my
priority when it comes to decision making.  LSMs which are under
development and are working to be merged come next, and LSMs which
have decided to remain out-of-tree remain last.  I do not
intentionally plan to make life difficult for the out-of-tree LSMs,
but if that happens as a result of design decisions intended to
benefit in-tree LSMs that is acceptable as far as I am concerned.  You
are free to disagree, but I believe the policy I've described here is
consistent with the bulk of the other kernel subsystems and I have no
plans to change this policy.

> > I understand you are opposed to the numeric LSM ID as part of the
> > kernel's API, but I believe this is both the correct way forward, and
> > consistent with other kernel APIs.  It is your right to disagree, but
> > I have yet to see a reason to revisit this decision and respectfully
> > request that you accept this and refrain from revisiting this argument
> > unless you have new information which would warrant a new discussion.
>
> I'm not against the numeric LSM ID itself. I'm against the policy for ass=
igning
> numeric LSM ID. The numeric LSM ID can become the correct way forward onl=
y if
> the following problem is solved.
>
> A market is not a location where only products that passed a patent exami=
nation
> are available ...

Once again, we've already discussed this many, many times: out-of-tree
LSMs are not the priority and that is not going to change.  One
corollary of this is that we are not going to assign LSM IDs to LSMs
that remain out-of-tree as this would negatively impact the LSM layer
by cluttering/depleting the LSM ID space.  LSMs that are working
towards integration with the upstream Linux kernel can self-assign a
temporary LSM ID which will be finalized upon merging in the LSM tree.
Based on all of the arguments you have already submitted - and let us
be very clear: you are the only one speaking out against this - I see
no reason to change this policy.

> The LSM ID is not a API. The LSM ID is a publicly available database.

By every definition of "API" that I have ever seen, the LSM ID *is*
part of the proposed LSM syscall API.

In my last email in this thread I asked you to refrain from revisiting
old arguments.  Unfortunately you either chose to reject that request
or you mistakenly thought your latest email was presenting new ideas
as opposed to a slight reframing of your existing objections.  I am
sorry that we have reached this point, but I am done discussing this
with you Tetsuo; unless I see any new arguments from you this will be
my last reply to you on this topic.

--=20
paul-moore.com
