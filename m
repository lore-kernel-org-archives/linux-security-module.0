Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1718C77B7A
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Jun 2023 20:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjFAUsq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjFAUso (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Jun 2023 16:48:44 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1A19B
        for <linux-security-module@vger.kernel.org>; Thu,  1 Jun 2023 13:48:42 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55858c0c18fso875084eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jun 2023 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685652522; x=1688244522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELf/zkRePONHTGzrk/i/VUoCMd1oMZvqTvJnqJDJ1xI=;
        b=UffwDji+JYy1TTchdaMJV/zMDfuEESReFBA49XtmWleQqqOWKTi76DzgK0hZQ0mWRH
         4C+xrzIygr4GSk9OwqIY0YouY5NNplcq7kLTmVsh9ZmkqD9E486OPZ55zzR/HvdDwgpp
         llFDNlueaByPFd27TEhM4fbPc8yv08qZtgY6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652522; x=1688244522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELf/zkRePONHTGzrk/i/VUoCMd1oMZvqTvJnqJDJ1xI=;
        b=Sk7NONU5Awa/X89cG+khbEnNt1aFdd5eRUu6Ly5bjApHECosAU4NR5MK9UTK9b0QW+
         MzL29AnAOFiKSGEc1r3diPYqEN8eaUnxRjBatqtKQWsGIqL4xiPmA4DMuei3iMxKrd/O
         pOpMbmhBIb3n5JP+uqXuvaJV20X4ZF+MrQJK9TRLI6H9o8s9NxoYutkCOrCCVz7I5QcS
         zssCQpGnwyz6p/c5mnCpu6eWZq350NKyot1hboUCpLYwXmc/M232fzpWYOv/V8mvRi4+
         EgXLmw6aSS7kr+eobVbY4lPz6ylEGY6BadTB5hXn/JFxY5Co3MjV1o45AGbmHjnZAOvt
         pVSA==
X-Gm-Message-State: AC+VfDwgDOxv0Jc3d86kucbuCLJBuhnCDq9Vrg/aaUNA2nW/XhHeWmNa
        sXbMvDJTt3b00DiUth6rESIHvO4sKqNqG5mBl3w+FQ==
X-Google-Smtp-Source: ACHHUZ5QHgkOvg57BcOHAl/rVyRFlXZ6p1Xl7WZDqS4FGNBStWyf6S7TVkxX1Ccj4enMf94fpCtCtVCZImPHqevf7Sg=
X-Received: by 2002:a4a:4585:0:b0:555:9b48:93de with SMTP id
 y127-20020a4a4585000000b005559b4893demr5514916ooa.5.1685652521710; Thu, 01
 Jun 2023 13:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net> <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com> <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
 <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com> <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
In-Reply-To: <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 1 Jun 2023 13:48:30 -0700
Message-ID: <CABi2SkUFe7zOFi3Vr-A6bTGytOdeZkvsPfxxLq9+b0vHfa-bkA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Paul,

On Wed, May 31, 2023 at 6:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> >>>
> >>>
> >> If I understand correctly:
> >> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
> >> process's landlock sandbox status: true/false.
> >
> > There would have to be a new LSM_ATTR_ENFORCMENT to query.
> > Each LSM could then report what, if any, value it choose to.
> > I can't say whether SELinux would take advantage of this.
> > I don't see that Smack would report this attribute.
>
> I think such returned status for LSM_ATTR_ENFORCMENT query would make
> sense, but the syscall could also return -EPERM and other error codes.
>
>
> >
> >>
> >> Is this a right fit for SELinux to also return the process's enforcing
> >> mode ? such as enforcing/permissive.
>
> Paul could answer that, but I think it would be simpler to have two
> different queries, something like LSM_ATTR_ENFORCMENT and
> LSM_ATTR_PERMISSIVE queries.
>
Hi Paul, what do you think ? Could SELinux have something like this.

Thanks!
-Jeff
