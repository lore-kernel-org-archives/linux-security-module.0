Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBCCA0EDF
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Sep 2023 22:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357910AbjIKWGw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjIKUFJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Sep 2023 16:05:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16909185
        for <linux-security-module@vger.kernel.org>; Mon, 11 Sep 2023 13:05:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59254e181a2so46594627b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Sep 2023 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694462703; x=1695067503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhlMLK8WCLZGaMrHreCTIhW1CPUp3+vyJu4Njc0iJm8=;
        b=WIsqxOb3QL8dFzesIx76fkB0GekBAc3GAzQbCH11tFsTIS6044a34z6tyWDi/YZVHG
         5CfZLEb4froN/F86b35qPZui69zbvIeGUltF6JHCetdQW81PSoXjhMx/OIym+PNWjvDX
         PYuXq7Zpy19w46Qzv2/O3qX4pa1fjYal3OAVYS34B7gT6Xx8yvTamrmTU9IGzNXTaR46
         q0HGpN4DgMWaINBUoALs3xrDyvUk2AZALBCiXaUauuFhynMLIfJap5BxawR0/BCbp6Km
         bS2srerKgYzxVWcr8HI1x1Setr7mRXnGFq5XdCkx23MEV3SC+r5fzQk/a1PF91WHuR5E
         MefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462703; x=1695067503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhlMLK8WCLZGaMrHreCTIhW1CPUp3+vyJu4Njc0iJm8=;
        b=cqvXrQdO2D3laQL9DX8NyFhuWNxGUmeD0VQxrB/2/JFJpSJ4bUcNkjITJ/AuF4oN4N
         DLmKPIb+iebdOVjFxb7rAJgZRVSvHJ7rU8T8h53OjFjVXFqeTgRsVoeN/bmtp2ee5USR
         XmZR1qd1+ocsKH+781bPUs9RlJpcAI9mCOWRh6Gw/h8oDmdMiZ2o8wsTx4bypuNO1FID
         J/uNZsVMHN3V/HYskOYOld9wNMNkxzVh5gEJ5GQ94isPtV8HEZ+hXfo2ZkyJjg1SiAsE
         C3Hnyql6NCb43f3QkXqoMG8mx5qEs/lx+KEdVSIYVdP2Eyy3s+LLKs4X7Ec8OZHZarV+
         vssg==
X-Gm-Message-State: AOJu0YxIjYpbPMpoE0ZhewfID+RjlxVPcyZZlyKyupKqslGgeJHm/43P
        LBkLeYqDzzk7hsVz1qoJ06tIihk4BtkSjn7lLOYce1LU/8EpVXSM7w==
X-Google-Smtp-Source: AGHT+IHGzHQq2UJBivPZSkdEihaA6buSKaXJziY2+kx8pFy7tor3uBu5RFPf9BRQHI51DwMhlDxBfrlRXXv9mpp0BfE=
X-Received: by 2002:a0d:c404:0:b0:594:e357:a1f8 with SMTP id
 g4-20020a0dc404000000b00594e357a1f8mr10068624ywd.24.1694462703084; Mon, 11
 Sep 2023 13:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com> <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
In-Reply-To: <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Sep 2023 16:04:52 -0400
Message-ID: <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 8, 2023 at 8:46=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/03 7:00, Paul Moore wrote:
> > * The new LSM must be sufficiently unique to justify the additional wor=
k
> > involved in reviewing, maintaining, and supporting the LSM.  It is reas=
onable
> > for there to be a level of overlap between LSMs, but either the securit=
y model
> > or the admin/user experience must be significantly unique.
>
> s/work/burden/ ?

Possibly, although I think I prefer "work" here since it has a more
positive connotation than "burden".

> > * Any userspace tools or patches created in support of the LSM must be =
publicly
> > available, with a public git repository preferable over a tarball snaps=
hot.
>
> What is the definition of "publicly" here? Everyone can download related =
resources
> including the source code etc. anonymously (e.g. without asking for creat=
ing user
> account and/or buying subscriptions ) ?

I agree with Serge that you bring up a very good point, and I think
the requirement of being able to download and use the tools without
requiring a account, subscription, etc. is a good one.

I've replaced that guideline with the following:

"If new userspace tools, or patches to existing tools, are necessary to
configure, operate, or otherwise manage the LSM, these tools or patches mus=
t
be publicly available without download restrictions requiring accounts,
subscriptions, etc.  Maintaining these tools or patches in a public git
repository is preferable over tarball snapshots."

I made a similar edit to the test suite guidelines:

"New LSMs must be accompanied by a test suite to verify basic functionality
and help identify regressions.  The test suite must be publicly available
without download restrictions requiring accounts, subscriptions, etc.  Test
coverage does not need to reach a specific percentage, but core functionali=
ty
and any user interfaces should be well covered by the test suite.  Maintain=
ing
the test suite in a public git repository is preferable over tarball snapsh=
ots.
Integrating the test suite with existing automated Linux kernel testing
services is encouraged."

What do you think?

> If one of userspace tools designed for the new LSM depends on the LSM ID,=
 when can
> the author of the new LSM obtain the stable LSM ID for that LSM ?

A permanent LSM ID is assigned to LSMs when they are merged into the
upstream LSM tree.  This is no different than any other kernel defined
macro constant, enum, magic number, etc. that is shared between kernel
and userspace and is considered part of the kernel's API.

LSM developers creating userspace tooling that makes use of the LSM ID
numbers should use the macro name and not the number, this should
allow the tooling to support the permanent LSM ID with a simple
recompile.

I understand you are opposed to the numeric LSM ID as part of the
kernel's API, but I believe this is both the correct way forward, and
consistent with other kernel APIs.  It is your right to disagree, but
I have yet to see a reason to revisit this decision and respectfully
request that you accept this and refrain from revisiting this argument
unless you have new information which would warrant a new discussion.

--=20
paul-moore.com
