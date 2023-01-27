Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A66C54EAA
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Jan 2023 18:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjA0SBh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Jan 2023 13:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjA0SBg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Jan 2023 13:01:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A77CCB9
        for <linux-security-module@vger.kernel.org>; Fri, 27 Jan 2023 10:01:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id ay1so3722403pfb.7
        for <linux-security-module@vger.kernel.org>; Fri, 27 Jan 2023 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT7Kn5x2Wu1FCI9gyzBjdUw9zENHLmXMgAr1g8mXS8U=;
        b=lE7jhcWfvt1eskx7t93mYi4pl1ljCVde7nttDfLoHEOyKkGRCfXWgrmn61MLpjhiZz
         guJ17Riyx/IO6p8uuAZLki7BipcwzMXnf647WctU6QRNqrJ0ntBVUN3hwgRGtBdPuTFN
         hQ5WL8Vvu267lZ7TX3Qsbhe5dqCcqANdSBVeLaWdylUAdmwmG3posbvw0O+jd8nc/lFn
         1S0WAtJm0m7aLDCg9eawPt0IRnDmYMojNME8bOuJ87LWDsjo2F0bezkYf2hohYRG804K
         V76xKvywVUztgQ8QgQy3xXCwZIMPL4J5eSO7mIOAnouYXzv5Dy+cnpaD57nURJ9nO+zy
         S1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT7Kn5x2Wu1FCI9gyzBjdUw9zENHLmXMgAr1g8mXS8U=;
        b=J6Ia1uS5yfZjKGf+Qmq9nyI4ZyMPb1g+CERtI9YreyPRzCv5ymbZQaT02vQIN3T6Gm
         Whwgwu7HQu/MwyTPGtGu8XpA6a+As/Oam2+grRjGVJ1AcYW0e9Z7zo8TdeYLoXUSPbdz
         ++A9ipn0Bi6g6KBmopfagNeiUOpPGfxoKswoxsR8KLt8iJolGvGNwjkK0mmWuqDwz2Ex
         sw0gqlnl1t/W9tEPSqLq+3dKVFjSY+uFqb8Wc0664V2F724HAKS8U60uoOz4HG5hY6hy
         nOxorgYMiSc86jae6xVOMnzvRvuWYhUAUG4TgAQKXskRdtrHtkTwdLma17EVsAtbOmJP
         jvqg==
X-Gm-Message-State: AFqh2koQ3n1GO4lsfu1NpieT2gqgVduwjJVMENCXJVHct73UjMgPGwnc
        MnWBwDjuPtWf3G9qdBqqVRfs28EKlf5J3CiTY8pGxw==
X-Google-Smtp-Source: AMrXdXvMgOtQ9iDD4nY5mH6Uzc1+rh+cfI3Lf461g/XsE5jjs1mKRyLEztdGBUfpjCNjE7r8Ki1NLI4f3ukqtGS6yTQ=
X-Received: by 2002:aa7:90d8:0:b0:577:3e5e:7a4 with SMTP id
 k24-20020aa790d8000000b005773e5e07a4mr5284446pfk.57.1674842495136; Fri, 27
 Jan 2023 10:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20230114020306.1407195-1-jeffxu@google.com> <bf4f1810-86a3-0b3d-2cb6-3431861d03c9@digikod.net>
In-Reply-To: <bf4f1810-86a3-0b3d-2cb6-3431861d03c9@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 27 Jan 2023 10:00:57 -0800
Message-ID: <CALmYWFvZ+oEpkM7t0xiJT=aTDkoj1meGmgMa6PoRb7oZP-TAYQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] selftests/landlock: fix ptrace_test
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Awesome, thanks!

On Fri, Jan 27, 2023 at 10:00 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> Thanks, it will soon be in -next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=3Dne=
xt
>
> On 14/01/2023 03:03, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Landlock ptrace failed because YAMA is enabled.
> > This patch check YAMA value and skip related tests.
> >
> > V6:
> > - Squash change from Micka=C3=ABl Sala=C3=BCn
> > - Link: https://lore.kernel.org/r/20230113175308.50900-1-mic@digikod.ne=
t
> > - Add can_read_child and can_read_parent
> > - Remove SKIP(), add log for incomplete test.
> >
> > V5:
> > - https://lore.kernel.org/all/20230113050755.1277736-1-jeffxu@google.co=
m/
> > - address comments from groeck@google.com
> >
> > V4:
> > - https://lore.kernel.org/all/20230103190314.3882177-1-jeffxu@google.co=
m
> > - apply can_trace_parent and can_trace_child to smaller scope.
> >
> > V3:
> > https://lore.kernel.org/all/20221227140244.1041292-1-jeffxu@google.com
> > - add can_trace_parent and can_trace_child to handle yama value.
> >
> > V2:
> > https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.or=
g
> > - update from code review comments.
> >
> > V1:
> > https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.or=
g
> > - skip specific testcase according to YAMA value
> >
> > V0:
> > https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
> > - skip entire ptrace when YAMA is not 0.
> >
> > Jeff Xu (1):
> >    selftests/landlock: skip ptrace_test according to YAMA
> >
> >   .../testing/selftests/landlock/ptrace_test.c  | 112 +++++++++++++++--=
-
> >   1 file changed, 94 insertions(+), 18 deletions(-)
> >
> >
> > base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
