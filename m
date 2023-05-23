Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C620C7EE2A
	for <linux-security-module@archiver.kernel.org>; Tue, 23 May 2023 21:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEWVNH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 May 2023 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEWVNG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 May 2023 17:13:06 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E37E5
        for <linux-security-module@vger.kernel.org>; Tue, 23 May 2023 14:13:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba8151a744fso293196276.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 May 2023 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684876383; x=1687468383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe/mryGe1SPximyn0Y5PuCcjJFRj4T+DAjqI4VqhjcA=;
        b=HWAIhiLYx7ppesW7Fo1Uvikjm6LjImfoNRrvTZs1B6bqi4KYaPovtkfGi22fBD3xK4
         rLH4Iby1fDBFyJwh6aEGMc6MLnTkTpccwcXeWLBsFs/LlZ5XzgX+Efhpk+No+y8QruKd
         KmoAcnrTpdXYoW7P+g51kp3v4BLPkhdYhztyuGC5MBS7D9290MEPRLHFCkAFnkmxx5IL
         8bSu20mEqukQTfjGVka6UyEBm5daBXZSxClBamEjJFKc9R8GoQ/4JfxXtSDJ9dmrhhuj
         GkrYa4kUutzZymKIo+0jsSTedUTwPQX3YI9cWsN4dn37W3yUJRkDoOX0UBfNzcKeZ0a7
         dZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684876383; x=1687468383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe/mryGe1SPximyn0Y5PuCcjJFRj4T+DAjqI4VqhjcA=;
        b=FV8e/2dU8Ld4EBMRP3WTDOWhj1MS2iEzdb8sA0TtTsBEY9XC9YXqEk810CWkalWmd6
         mvc3rMSOrPBQ+tXXmEJVPKhLyEtEWNI0xSJUEFBjAO2fNrkQkIuUjN4SLewIE910wJWk
         reacwB3jEYOr346ZQl/oPF1SiiX5xJaKzdh63pcF5+OLDddmfgx0uBXsuLfylF958JSp
         P5b2+T/Lt+obg1QmBq6g3iwcPbIzfXTpv47IcydmNPECLY/nIgPSLxfFrqAM9O7YA3nA
         C0LB6DOm8AWY6qsiwb3zsXIkF1nWe3ZA37H/KpaRjd0fpRZ9BhhmKxZ5YPW1SM4SGQwI
         YDdw==
X-Gm-Message-State: AC+VfDxALPnEHv6ILrcyzyAZh57H8rRD/bBgmYM5qvOGWFrmA5VaEqdO
        4BaBHoDI1P0FVKua/DQgkLF3+P0unLytT4ErFvY/
X-Google-Smtp-Source: ACHHUZ4f+Ek2wXY3RmRVYqhQsfzKxKiVZYioKxz8k/qtxoy0rfb2ON2OI16pGO/EygZcjpN5BkNdfM4XzhbhBXF8YV0=
X-Received: by 2002:a25:74c6:0:b0:ba8:24ff:f7dd with SMTP id
 p189-20020a2574c6000000b00ba824fff7ddmr16009648ybc.48.1684876383388; Tue, 23
 May 2023 14:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com> <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
In-Reply-To: <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 17:12:52 -0400
Message-ID: <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 23, 2023 at 2:13=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote=
:
> On Mon, May 22, 2023 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > > On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> > > > Adds a new getprocattr hook function to the Landlock LSM, which tra=
cks
> > > > the landlocked state of the process. This is invoked when user-spac=
e
> > > > reads /proc/[pid]/attr/domain
> > >
> > > Please don't add a Landlock specific entry directly in the attr/
> > > directory. Add it only to attr/landlock.
> > >
> > > Also be aware that the LSM maintainer (Paul Moore) wants to move
> > > away from the /proc/.../attr interfaces in favor of a new system call=
,
> > > which is in review.
> >
> > What Casey said above.
> >
> > There is still some uncertainty around timing, and if we're perfectly
> > honest, acceptance of the new syscalls at the Linus level, but yes, I
> > would very much like to see the LSM infrastructure move away from
> > procfs and towards a syscall API.  Part of the reasoning is that the
> > current procfs API is ill-suited to handle the multiple, stacked LSMs
> > and the other part being the complexity of procfs in a namespaced
> > system.  If the syscall API is ultimately rejected, we will need to
> > revisit the idea of a procfs API, but even then I think we'll need to
> > make some changes to the current approach.
> >
> > As I believe we are in the latter stages of review for the syscall
> > API, perhaps you could take a look and ensure that the current
> > proposed API works for what you are envisioning with Landlock?
> >
> Which review/patch to look for the proposed API ?

See Casey's reply if you haven't already.  You can also find the LSM
list archived on lore.kernel.org; that is probably the best way to
track LSM development if you don't want to subscribe to the list.

* https://lore.kernel.org/linux-security-module

> I guess ChromeOS will need to backport to 5.10 when the proposal is accep=
ted.

Maybe?  Distro specific backports aren't generally on-topic for the
upstream Linux mailing lists, especially large commercial distros with
plenty of developers to take care of things like that.

--=20
paul-moore.com
