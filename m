Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53707EB64DD
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 22:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHAWr2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHAWr2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 18:47:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723012B
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 15:47:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5860c7fc2fcso33724867b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Aug 2023 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690930043; x=1691534843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8P1BwyY2zwR75zxz+eMtYpfV1gNVhdf2A33NSmc0/I=;
        b=S+H3ceKCvvMc7DgjWmF+lK/EZHr2ih1WjJVdVWqACxXs7DwDxcCzUv45qBhKJ2rDJ7
         OJAxvqmr1bIBh0tA/OhRI7ej4C3mEaQO3L3wA+vaC/pZSfGWuuJyfI2KAI8t++GS/ISK
         aH+EWH22/Gsjz34/TQqXseMyKc8U5MNm/f0JolbpV/BTxQWQJhhXeordr+V5jfoiyOzb
         87kRS09LDgHESALTARGTgoe66AqItW5ehiZG85RHQZsZ3l9O8XReaT2QIEQUwyHcPXWl
         4ZoKJFySttuGkQK9vwEHyNCIXKxc+XPwvspMCtwhLyYiQXUPJGRAfGifR0iFmp/fDMGa
         reow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690930043; x=1691534843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8P1BwyY2zwR75zxz+eMtYpfV1gNVhdf2A33NSmc0/I=;
        b=iJJ89obllV1sXDfxXB4bYrYpmQf2GPZ7Pnnx74SyEF0rgpY8PIu0/tA3axqUCJFDhr
         yltXfW6RQVsUp9XuDGgELhrO11nuNYTk+5wyvTe24X2V/+6tbh8vAsfW+Qg+r05ozK5q
         T4n3MAeUA6dn6iEuofHfnM1N9nAR79ISe48LzNz0KdvtWNwVB9fihQpIr4nZgZONK6Rp
         608Y2iNZtQS4UIzU7ueawXSBAP0Ta/2fZhhCd8aZcVgZtF1kAAJYQ7e7hVXmyWzbW/5N
         DMbPLIFmA6Co+YDLF/fZX/JaCbZpdko3Ht9h/wW47UPct0ege1e4CeZvGA6O/EqgYtHZ
         0IPQ==
X-Gm-Message-State: AOJu0YyYCHb0b5lBnZjtyY14PK42Vdd/CMXh0e2qIUH7IPlKXHShSKNE
        Im/Ecdcgb/zzWpIaq0ArR6LdyqS0L9HKBiNXeqWIqX4W1TofnryKC2uIKF0=
X-Google-Smtp-Source: AGHT+IF/kBs+E4T2i36OZRHruHdSHPHAj8NMCmU6xkWgnJEgouPEqu9A41+DtE9erfWjPkvyHCgZlm9+BIQv5EMHqq0=
X-Received: by 2002:a0d:d914:0:b0:586:6a71:b018 with SMTP id
 b20-20020a0dd914000000b005866a71b018mr1157503ywe.20.1690930043626; Tue, 01
 Aug 2023 15:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
In-Reply-To: <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Aug 2023 18:47:12 -0400
Message-ID: <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 7, 2023 at 6:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Jul 6, 2023 at 8:32=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> > On 7/6/2023 1:42 PM, Paul Moore wrote:
> > > Hello all,
> > >
> > > With some renewed interest in submitting new LSMs including in the
> > > upstream Linux Kernel I thought it might be a good idea to document
> > > some of our longstanding guidelines around submitting new LSMs.  I'm
> > > posting this mostly as a FYI for those who are working on new LSM
> > > submissions, but also to solicit feedback from everyone on the list
> > > regarding what we should ask of new LSMs.  If you think I'm missing
> > > something important, or believe I've added an unfair requirement,
> > > please let me know.
> > >
> > > I've added the guidelines to the README.md at the top of the LSM tree=
,
> > > but to make life easier for those reviewing the guidelines I'm
> > > copy-n-pasting them below ...

I've updated the README.md doc based on the feedback, and copied the
two new sections below for easier review.  If anyone has any
additional feedback or concerns, please let me know.

## New LSM Hook Guidelines

While LSM hooks are generally considered outside of the Linux Kernel's stab=
le
API promise, due to the nature of the LSM hooks we try to minimize changes =
to
the hooks.  With that in mind, we have the following requirements for new L=
SM
hooks:

* Hooks should be designed to be LSM agnostic.  While it is possible that o=
nly
one LSM might implement the hook at the time of submission, the hook's beha=
vior
should be generic enough that other LSMs could provide a meaningful
implementation.

* The hook must be documented with a function header block that conforms to
the kernel documentation style.  At a minimum the documentation should expl=
ain
the parameters, return values, a brief overall description, any special
considerations for the callers, and any special considerations for the LSM
implementations.

* There must be at least one LSM implementation of the hook included in the
submission to act as a reference for additional LSM implementations.  The
reference implementation must be for one of the upstream, in-kernel LSMs; w=
hile
the BPF LSM is an upstream LSM, it's nature precludes it from being eligibl=
e as
one of the in-kernel LSMs.

## New LSM Guidelines

Historically we have had few requirements around new LSM additions, with
Arjan van de Ven being the first to describe a basic protocol for accepting=
 new
LSMs into the Linux Kernel.  In an attempt to document Arjan's basic ideas =
and
update them for modern Linux Kernel development, here are a list of
requirements for new LSM submissions:

* The new LSM's author(s) must commit to maintain and support the new LSM f=
or
an extended period of time.  While the authors may be currently employed to
develop and support the LSM, there is an expectation upstream that support =
will
continue beyond the author's employment with the original company, or the
company's backing of the LSM.

* New LSMs must include documentation providing a clear explanation of the
LSM's requirements, goals, and expected uses.  The documentation does not n=
eed
to rise to the level of a formal security model, but it must be considered
"reasonable" by the LSM community as a whole.

* Any user visible interfaces provided by the LSM must be well documented. =
 It
is important to remember the user visible APIs are considered to be "foreve=
r
APIs" by the Linux Kernel community; do not add an API that cannot be suppo=
rted
for the next 20+ years.

* The LSM implementation must follow general Linux Kernel coding practices,
faithfully implement the security model and APIs described in the
documentation, and be free of any known defects at the time of submission.

* Any userspace tools or patches created in support of the LSM must be publ=
icly
available, with a public git repository preferable over a tarball snapshot.

--=20
paul-moore.com
