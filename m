Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E50C001DF
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjHBWAf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjHBWAf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 18:00:35 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72A115
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 15:00:34 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56c711a889dso182862eaf.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Aug 2023 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691013633; x=1691618433;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5DM9QIKobU14o5wBMtACBOeCV9xxolnvQXduVXvXnw=;
        b=AkUGFIr2XcdMuhIqWjQbvxWiKr7BnqHEW7ngGwygBdZUgWly1lRM5AKpWd5JWHhJqw
         ye9qDGOEz7P3zGq6zh3uGfVOOiUFOZWaYYFKI+1tx2uPE0RWE+DBT8FrPfY5FnI9VjkT
         Fg+lZkB2FrPCspiuAeOOXbY2CHP78hNTloZ4e3NJQS804LB3ZfDjRh1fAh95+Uh35HQV
         iuNasyjyo163e/Fg1JAboH7thypvDyNHIumQfCtVqHOBtTgC4bMBjyCXDHZ+oywt80Wp
         0l3u2idVflIRQXkm+UKmNWxftB3Nzd68KcMCczvl4qIyCNQTBnCemwd60OERmYpDzSiX
         5W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013633; x=1691618433;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5DM9QIKobU14o5wBMtACBOeCV9xxolnvQXduVXvXnw=;
        b=MgQfh+iWgXvNzBSjLZ2tgYDdi89t3zipgg0HhYyRTYqkCwxRCpL3CmD9Rc42D4dpIQ
         DJv5jhquXY+GI2vjKqmK9/vvMRczwWXAQHUZLyA0aurFCbUBRp3Ee+Qc5ibS3TjMKPli
         jf1UbEh9rzZGzcOhKbCOlBrVmniKtanVzdIATA1B4i8sTHTEk/njJvfBb+jNN7Dg2fOk
         o4XuyLzfEnniskjdRM+7uYFoW109X0QulSPKCIZjklWGxZ9C+CyiMvRAubfJ4OlisVc/
         qfzz/noiQUB9jH7wf4K78s979l5p65Yqs0mpVC9RtJ9npHXbBKxypOdT6mYj2AEZDkf0
         hDvQ==
X-Gm-Message-State: ABy/qLZ6jhUn6nE1dpp2TY6xFoEPDdPz+Lhkfw+FOuzMNaO7nGnCyX/5
        EEfof3NqJp0wsgcoEr118yzVRHSqhcQ3w5Q86MixR5QVPiJ82KGvMzgr
X-Google-Smtp-Source: APBJJlG8eHqjI2JtBHRDC6MIirrqPih97lpXbxjDwXQ1V56qc/ZoxfBCMRh+8sKmDmm+c8FTkL31ztJCarQ175C4078=
X-Received: by 2002:a05:6358:c28:b0:139:c4ee:8680 with SMTP id
 f40-20020a0563580c2800b00139c4ee8680mr9430629rwj.16.1691013633197; Wed, 02
 Aug 2023 15:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Aug 2023 18:00:22 -0400
Message-ID: <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> I've updated the README.md doc based on the feedback, and copied the
> two new sections below for easier review.  If anyone has any
> additional feedback or concerns, please let me know.

Another update based on feedback received (thanks everyone!).  Just as
before, I welcome any comments or feedback you are able to share.

## New LSM Hook Guidelines

While LSM hooks are considered outside of the Linux Kernel's stable API
promise, in order to limit unnecessary churn within the kernel we do try to
minimize changes to the set of LSM hooks.  With that in mind, we have the
following requirements for new LSM hooks:

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
the BPF LSM is an upstream LSM, its nature precludes it from being eligible=
 as
one of the in-kernel LSMs.

It is important to note that these requirements are not complete, due to th=
e
ever changing nature of the Linux Kernel and the unique nature of each LSM
hook.  Ultimately, new LSM hooks are added to the kernel at the discretion =
of
the maintainers and reviewers.

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

* The new LSM must be sufficiently unique to justify the additional work
involved in reviewing, maintaining, and supporting the LSM.  It is reasonab=
le
for there to be a level of overlap between LSMs, but either the security mo=
del
or the admin/user experience must be significantly unique.

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

* New LSMs must be accompanied by a test suite to verify basic functionalit=
y
and help identify regressions.  Test coverage does not need to reach a spec=
ific
percentage, but core functionality and any user interfaces should be well
covered by the test suite.  Integration with existing automated Linux Kerne=
l
testing services is encouraged.

* The LSM implementation must follow general Linux Kernel coding practices,
faithfully implement the security model and APIs described in the
documentation, and be free of any known defects at the time of submission.

* Any userspace tools or patches created in support of the LSM must be publ=
icly
available, with a public git repository preferable over a tarball snapshot.

It is important to note that these requirements are not complete, due to th=
e
ever changing nature of the Linux Kernel and the unique nature of each LSM.
Ultimately, new LSMs are added to the kernel at the discretion of the
maintainers and reviewers.

--=20
paul-moore.com
