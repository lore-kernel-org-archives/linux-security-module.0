Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F1FC001DF
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 21:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHCVig (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHCVig (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 17:38:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039702D45
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 14:38:35 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5841be7d15eso16149407b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691098714; x=1691703514;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1fZyaqMLzhnj3I/X+7aFlvGknMr4v8MyGoCMsDVkOI=;
        b=B9gztvpOrAwKvP1YRLu5ksJqh7u9KP2Wso96R0IWmv3c3pzmzvoG60aFD3FycykVF6
         Ki5NiqRDxoLYJB2X+iozw+mZyZHGN0jz8xumcR95qM0rU9Kly45J5LBR+7JFTISNNFmh
         RSqPR/GsQArksNpoqaGp0pwl9jo4NEJfdxQcd+XuapR7k7pWYJtzFnW0I8T7yCKmVxyv
         e2sng3FbmoGdOCwgyN4idVBICiY1geCjx6jpBg08SaszeiGjV42QIN9X40JVkfgxdsGh
         Til5+jpnwImdVsUBKpfOwtM+GvQeF4jqGDND8ksyQ7AFjPqMFklZ2e9THtSwNHeSjsZ8
         tI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691098714; x=1691703514;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1fZyaqMLzhnj3I/X+7aFlvGknMr4v8MyGoCMsDVkOI=;
        b=FW7uvbThqTPjAjaTk1bpBGOSelc6G9UL2iIZRIVH+bvSCGXFxEMQFL3VOlIpKUJDcl
         DUQw1WK2e2Q4jMHBFVn22hMJAhdIZ2Nl+6v/cDjsnMm8yEGWwbnyVJSG3uPkrmUjRyAx
         VeIj7wnTyBS46hlHylo5uFlOzPB4IXxdZpDWqknmAFIFyEIaRKcVwPMk1p8S7H8ifxb3
         x/d9lXBnDx9Brsge5XCQcCKINUxwK3C6RM2J6y+EkZT+SQLxUrHJXzlN5SfWg17jxiuB
         MKRZxt0mNiieSQZl1Mz3nZ3MELV5oRpAAVAMnze8ArQ7WbmrdOeKk9zYVZlbJXLSXDy1
         Xvwg==
X-Gm-Message-State: ABy/qLbvvA2CiLlHMoWntzb6YVNwGQDrDo+4oMoPL2U5++f3BmMZR3l3
        LGaH03p3HbjnLY+hDhe5Z+p3d5HiiyKvNyADa3aMUQaT+UHAVO0cRN9Z
X-Google-Smtp-Source: APBJJlHLtmfgKMjcaD7eCXE/1Q8+bXkKsFxwK1iNfOVD5kXkV7Lnekf7tFDQ7wKkpgR258As87XCB5uY0Bq2tm4wjcE=
X-Received: by 2002:a81:5405:0:b0:584:61ca:107d with SMTP id
 i5-20020a815405000000b0058461ca107dmr18126158ywb.5.1691098713948; Thu, 03 Aug
 2023 14:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com> <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
In-Reply-To: <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 17:38:23 -0400
Message-ID: <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 2, 2023 at 6:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > I've updated the README.md doc based on the feedback, and copied the
> > two new sections below for easier review.  If anyone has any
> > additional feedback or concerns, please let me know.
>
> Another update based on feedback received (thanks everyone!).  Just as
> before, I welcome any comments or feedback you are able to share.

MOAR UPDATES!

## New LSM Hook Guidelines

While LSM hooks are considered outside of the Linux kernel's stable API
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

* New LSM hooks must demonstrate their usefulness by providing a meaningful
implementation for at least one in-kernel LSM.  The goal is to demonstrate =
the
purpose and expected semantics of the hooks.  Out of tree kernel code, and =
pass
through implementations, such as the BPF LSM, are not eligible for LSM hook
reference implementations.

It is important to note that these requirements are not complete, due to th=
e
ever changing nature of the Linux kernel and the unique nature of each LSM
hook.  Ultimately, new LSM hooks are added to the kernel at the discretion =
of
the maintainers and reviewers.

## New LSM Guidelines

Historically we have had few requirements around new LSM additions, with
Arjan van de Ven being the first to describe a basic protocol for accepting=
 new
LSMs into the Linux kernel[^1].  In an attempt to document Arjan's basic id=
eas
and update them for modern Linux kernel development, here are a list of
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
to rise to the level of a formal security model, but it should include a ba=
sic
threat model with a description of the mitigations provided by the LSM.  Bo=
th
the threat model and the LSM mitigations must be considered "reasonable" by
the LSM community as a whole.

* Any user visible interfaces provided by the LSM must be well documented. =
 It
is important to remember the user visible APIs are considered to be "foreve=
r
APIs" by the Linux kernel community; do not add an API that cannot be suppo=
rted
for the next 20+ years.

* New LSMs must be accompanied by a publicly available test suite to verify
basic functionality and help identify regressions.  Test coverage does not =
need
to reach a specific percentage, but core functionality and any user interfa=
ces
should be well covered by the test suite.  Maintaining the test suite in a
public git repository is preferable over tarball snapshots.  Integrating th=
e
test suite with existing automated Linux kernel testing services is encoura=
ged.

* The LSM implementation must follow general Linux kernel coding practices,
faithfully implement the security model and APIs described in the
documentation, and be free of any known defects at the time of submission.

* Any userspace tools or patches created in support of the LSM must be publ=
icly
available, with a public git repository preferable over a tarball snapshot.

It is important to note that these requirements are not complete, due to th=
e
ever changing nature of the Linux kernel and the unique nature of each LSM.
Ultimately, new LSMs are added to the kernel at the discretion of the
maintainers and reviewers.

[^1]: https://lore.kernel.org/all/20071026141358.38342c0f@laptopd505.fenrus=
.org

--=20
paul-moore.com
