Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D6C7EE23
	for <linux-security-module@archiver.kernel.org>; Tue, 23 May 2023 06:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjEWGN0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 May 2023 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjEWGNY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 May 2023 02:13:24 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484A118
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 23:13:23 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-552b65f527dso3921841eaf.3
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684822403; x=1687414403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUm2yyJ18/we9uWrtAeUXp0j49gBv2i5N9eMM4ufGTs=;
        b=GG0g8WfCc6HHGFwZ3Q4geQfiXu8q0mdCit1KpbfmuKo749SACnWNdiuNzfsELaxDxW
         LAEkkcKi2zrFmWFOffqXs2e3dW8CfpjcPCUa2sucHosnzNkvZvKsLPFKstlTkCGDkLQe
         NG5teIrqiJbS4k11RkQTygNOthYMiHoCXdLm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684822403; x=1687414403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUm2yyJ18/we9uWrtAeUXp0j49gBv2i5N9eMM4ufGTs=;
        b=iA4ZFtzsg3FyXjS2R4sAuPqdy/E2WnqOQg1uVdVfpBFjE4C4/vPRYyNbSEU0i4xaRN
         ydBwKg5v/dBo/RCsGISskuwu5ZcGssv5mDmozjnPSvqY9j2VzvGGcZMJoIlYddCeBfIC
         /cooPWzFzCO9E6m1lNAeSFa4kVNLiK8qiIFzTu9LGoLCjgmVJ2IEvrt5vAscdsixhT0O
         n7OHGLue5zUf8x3O7pNb6azet5VcklPDG44GJK04F8LqvA6pKyDs2QsMoeWIaBCGun4c
         9OhooElg8SeISKUwp8xDDwY/14xb9ChSXw7amIiuL9yfkdE/BfxOtPM6bX03qkEP21wd
         BBsQ==
X-Gm-Message-State: AC+VfDy1umkf6p8KtpIyrwmtmgNb8MAl+zNS49tn5PkhKh/D0OzqsFUr
        2qEMFeH0BZt4WRzhZwGgGcfZH3T2guV5p86Z2FZ2Uw==
X-Google-Smtp-Source: ACHHUZ6F23qb7h+EGPpL38qW3WqZRoDU/VkBc77G9UEijr6X5cpziPQd//zIqeBcgjTVAtPpmEIxz4tuh4xHXRC5BWg=
X-Received: by 2002:a4a:614b:0:b0:54f:49ad:1c8f with SMTP id
 u11-20020a4a614b000000b0054f49ad1c8fmr5596636ooe.1.1684822403143; Mon, 22 May
 2023 23:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 22 May 2023 23:13:12 -0700
Message-ID: <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Paul Moore <paul@paul-moore.com>
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

On Mon, May 22, 2023 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> > > Adds a new getprocattr hook function to the Landlock LSM, which track=
s
> > > the landlocked state of the process. This is invoked when user-space
> > > reads /proc/[pid]/attr/domain
> >
> > Please don't add a Landlock specific entry directly in the attr/
> > directory. Add it only to attr/landlock.
> >
> > Also be aware that the LSM maintainer (Paul Moore) wants to move
> > away from the /proc/.../attr interfaces in favor of a new system call,
> > which is in review.
>
> What Casey said above.
>
> There is still some uncertainty around timing, and if we're perfectly
> honest, acceptance of the new syscalls at the Linus level, but yes, I
> would very much like to see the LSM infrastructure move away from
> procfs and towards a syscall API.  Part of the reasoning is that the
> current procfs API is ill-suited to handle the multiple, stacked LSMs
> and the other part being the complexity of procfs in a namespaced
> system.  If the syscall API is ultimately rejected, we will need to
> revisit the idea of a procfs API, but even then I think we'll need to
> make some changes to the current approach.
>
> As I believe we are in the latter stages of review for the syscall
> API, perhaps you could take a look and ensure that the current
> proposed API works for what you are envisioning with Landlock?
>
Which review/patch to look for the proposed API ?
I guess ChromeOS will need to backport to 5.10 when the proposal is accepte=
d.

Thanks
-Jeff


> --
> paul-moore.com
