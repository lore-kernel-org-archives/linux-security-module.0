Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F5C54EBE
	for <linux-security-module@archiver.kernel.org>; Sat, 14 Jan 2023 02:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjANCSR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 21:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjANCSQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 21:18:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56EA8BF06
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:18:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so7183101pjm.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeiLZqgLSY+2KPa1rEcKLNimd1+rgPDV+eujRY9aygs=;
        b=cAmpWO6fH4wLwWdSVCx2AkVCZ5IfK/WU4lZYTJs4DzSCX9nVaIrMoiWgb6p5ovcCFw
         Ea6LA7hGeS++B7qoaKFyUjddDMO1J8afiJ6vx0cA7j5rn7SjO0JPhdUAclc+y8JNggzE
         7eVyDMuThwPu3DdtEcCxzLJM2AilsnzLlT2A37AUkIpfP069gOEgjLrhDIsNtrkihs+F
         PJk4bJJCvTe0vegoXmlXcfIMFEeU+jVIy3JuctDQ6tw2O6evjgeZ3j4xYktMzX/KoqlI
         rSIGTAib7DNGNFOWns2FrYrvVCKhwfWLsnqch8TEygDYScOqFA+IOl0n5OnKzmS7NPwn
         TZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeiLZqgLSY+2KPa1rEcKLNimd1+rgPDV+eujRY9aygs=;
        b=YLUASnwzNYKIgUaXFn7O6+20CUAZLGODu5YHIp41dDXBkg3eNYPN3LO5olP8XNoXJz
         Pwy2Ba3DcZWDll4ZuJkb7t4kqQNu1yUVvruB+6EgmmBEfz+K/5L5s4GKioUhoP5C75ip
         +C0uJfDx41ZT1lEM1vQy3PcOinH+ueD5w95Z6y4GbFNNb6irTwjfleM/j8bWV8D6Jpje
         A0PwMrTuHo12pG9M8YOZhUv79zkIUPEbL44GrFxUg819JypnhM5qAIBYKuh6rB4T5GSq
         VbIaoTkDwM2d3pCdQgz5BEOojnegajb9fxkWrRlL8Ddtud7HWnmSA2CMoojWyNo4sPq9
         D9Jg==
X-Gm-Message-State: AFqh2koKgVcbZz9Cw0Cqf6vShNxN2uSaklNk61HqTu/SCrBRE6iaW3Bb
        0j7KkTjUBCZeTYGqG8g2iAEPri0CyxG+aQojruYZYg==
X-Google-Smtp-Source: AMrXdXsyAv+d+ngl+5CL9YTC4DOX5hZaPw1iLS3p4y91pHSEyElZvVtrNLM52E+WBBut6rEnYjZjSoQSDIvooG9LHQM=
X-Received: by 2002:a17:903:1014:b0:193:1d01:4909 with SMTP id
 a20-20020a170903101400b001931d014909mr173712plb.108.1673662694860; Fri, 13
 Jan 2023 18:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20230113053229.1281774-1-jeffxu@google.com> <ab279390-84e1-0bcc-29ca-eea673fdd14c@digikod.net>
In-Reply-To: <ab279390-84e1-0bcc-29ca-eea673fdd14c@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 13 Jan 2023 18:17:37 -0800
Message-ID: <CALmYWFsmKn9-OJ5a+OYjXcWn_XoULhL3efgTEfOFRXXZOf5UFQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/1] selftests/landlock: fix fs_tests when overlayfs
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Awesome, thanks!

On Fri, Jan 13, 2023 at 11:58 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> Thanks Jeff! I pushed this patch in -next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=3Dne=
xt
>
>
> On 13/01/2023 06:32, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Overlayfs can be disabled in kernel config, causing related tests to
> > fail. Adding a check for overlayfs=E2=80=99s supportability at runtime,
> > so we can call SKIP() when needed.
> >
> > Note:
> > Below comments are raised during V7 discussion:
> >
> > Currently SKIP() is applied to FIXTURE_SETUP, FIXTURE_TEARDOWN,
> > TEST_F_FORK, this is because SKIP() apply within the function
> > scope, not the testcase.
> >
> > We would like test infra to have a dedicated environment
> > check hook (FIXTURE_ENV_CHECK) in test infra, called before
> > FIXTURE_SETUP(). If the environment check fails, the remaining
> > of the test will be skipped. The benefit of these are two:
> > 1> if env check pass, in theory, the test should pass.
> > 2> if env check fail, no need to call setup, so no need to cleanup
> > resource.
> >
> > v8:
> > style change, no logic change.
> >
> > v7:
> > https://lore.kernel.org/all/20221229211446.3154454-1-jeffxu@google.com/
> > Fix bug in supports_overlayfs().
> > Manual test with kernel with and without overlayfs.
> >
> > v6: https://lore.kernel.org/all/20221229201215.3006512-1-jeffxu@google.=
com/
> > In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
> > however, FIXTURE_TEARDOWN() will fail. It might be complicated
> > for test infra or testcase itself to have cleanup code handing the
> > success/failure of steps in SETUP().
> >
> > This patch changes the approach, it calls supports_overlay() and SKIP()
> > at the beginning of FIXTURE_SETUP(), FIX_TEARDOWN(), TEST_F_FORK().
> > Because no modification of system is done by the test, cleanup is not
> > needed.
> >
> > v4:
> > https://lore.kernel.org/all/20220823010216.2653012-1-jeffxu@google.com/
> >
> >
> > Jeff Xu (1):
> >    selftests/landlock: skip overlayfs test when not support
> >
> >   tools/testing/selftests/landlock/fs_test.c | 48 +++++++++++++++++++++=
+
> >   1 file changed, 48 insertions(+)
> >
> >
> > base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
