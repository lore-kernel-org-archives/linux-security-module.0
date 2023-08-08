Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99AC001DB
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHHQWh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjHHQVD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 12:21:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D993E0
        for <linux-security-module@vger.kernel.org>; Tue,  8 Aug 2023 08:49:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7659cb9c42aso423151685a.3
        for <linux-security-module@vger.kernel.org>; Tue, 08 Aug 2023 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691509745; x=1692114545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em0u3rAwfsJ9DADQmbz8jINXwrAXQCvwsoKWZ+kvbag=;
        b=XhmtZmN+4X3aHwdqW3pPQRMyQQlli/XhwSdU/PJi+DXyt+yEZuKyAuD8yRPFxZXfel
         3Xy21G0U+rkD+acyyq4aUFern1imNDo6Ew3vPYOhXwFv8fGOgGIA3Cq2jGs4GKlDXOUw
         9JG6WlfRgnU4V8AiIR6KKUpjRqR4ARkvHhL3J3EIgHuNFU1Xsi4w6icTCi4fLbAxJXiM
         Yri4tHKoYDO5v1g3xvvyrCfLrCoWSLYJnyGG/2aOogMmK72TA5S3MHntHKdH3sP2yPBF
         JPbAJTMPgHq689qygQbHobGvQsuRUxIoSoFT0K4P+GhYnMckfJ5/TRlWYTy9INNXUQoR
         lHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509745; x=1692114545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em0u3rAwfsJ9DADQmbz8jINXwrAXQCvwsoKWZ+kvbag=;
        b=Mt/t7nHsN9Kh6IK+2yf9PSdFLSHpAb/VaWMuxh1nq+3rv7QFVwyxJGpvns4hZ4x1G8
         ekYZpabRHd505cdad60W492GDV14hKkKSpr7xWlj064KymG5qOgd4p6TJHfbsTM+mzLR
         kfP/LKWFNI+Je6xzS1H99RJLaJUlytwIeVHhhjF+0mjXDfG7J47e5p96K6eJdYzV8ZRs
         ghSd/myFf87uEQK01NgpcvmyVuz73DpbdIY4VKmtfRSG/a3GY9mgSHwNyk50eGEm8Fiz
         4idR+1Nq5EbEeWbweiLACimJ7eaf2TplbPltjvFUS9V1ubVN/0gPOiG2NK9ho8KV0sYM
         3LeQ==
X-Gm-Message-State: AOJu0YwGEoI73DN5SemDHbwzOcRqGvtSQSIn6zwCOPqv0SAfeuRaSnO/
        goXPty1PFMoVoFVifvHqY3WDSfVU05gYPDz3O+x23g+vdw8fe07jjA==
X-Google-Smtp-Source: AGHT+IGLc34aLVA9ZLIe34W64Ir8n1SwTlr71PLKuPbf1vupgTPfoQCmYXbLiBv77geHjnpKt9FR9UZG6Qiq89sY/1I=
X-Received: by 2002:a81:7741:0:b0:583:7b49:15dd with SMTP id
 s62-20020a817741000000b005837b4915ddmr13398514ywc.48.1691505497509; Tue, 08
 Aug 2023 07:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com>
 <2155117.irdbgypaU6@x2> <CAHC9VhRG2aX-_ye7ZRWpZkR7rq8Op7RUVS3cMtxhF8t1bdw5oQ@mail.gmail.com>
 <6f3a90b9-b210-512a-f74a-6003aebf5c30@I-love.SAKURA.ne.jp>
In-Reply-To: <6f3a90b9-b210-512a-f74a-6003aebf5c30@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Aug 2023 10:38:06 -0400
Message-ID: <CAHC9VhQPROcbN5MfS5pnNDe-YDgLTAY7W9eQkNAJU3kBH43ZEA@mail.gmail.com>
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 8, 2023 at 6:07=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/08 5:13, Paul Moore wrote:
> > On Mon, Aug 7, 2023 at 3:03=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> =
wrote:
> >> On Monday, August 7, 2023 2:53:40 PM EDT Paul Moore wrote:
> >>> On Sun, Aug 6, 2023 at 9:05=E2=80=AFAM Tetsuo Handa
> >>>
> >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>> When an unexpected system event occurs, the administrator may want t=
o
> >>>> identify which application triggered the event. For example, unexpec=
ted
> >>>> process termination is still a real concern enough to write articles
> >>>> like https://access.redhat.com/solutions/165993 . TaskTracker is a
> >>>> trivial LSM module which emits TOMOYO-like information into the audi=
t
> >>>> logs for better understanding of unexpected system events.
> >>>
> >>> Help me understand why all of this information isn't already availabl=
e
> >>> via some combination of Audit and TOMOYO, or simply audit itself?
> >>
> >> Usually when you want this kind of information, you are investigating =
an
> >> incident. You wouldn't place a syscall audit for every execve and then
> >> reconstruct the call chain from that. In the case of long running daem=
ons,
> >> the information could have been rotated away. But typically you want t=
o see
> >> what the entry point is. A sudden shell from bind would be suspicious =
while a
> >> shell from sshd is not.
> >
> > Once again, why not use the existing audit and/or TOMOYO capabilities.
> >
>
> Can't, for Fedora/RHEL does not enable TOMOYO.
> I need a way that can be used by RHEL users running with selinux=3D0.

What makes you think your distribution of choice would enable this new
LSM?  I'm sorry, but this sounds like more of an issue with the
choices made by a distro rather than something missing upstream.

--=20
paul-moore.com
