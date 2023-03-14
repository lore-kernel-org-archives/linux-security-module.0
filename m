Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A55C7618D
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Mar 2023 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCNWAp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Mar 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCNWAo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Mar 2023 18:00:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973219BD
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 15:00:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e194so17276279ybf.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678831239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maagjvDsBJlC+y9OhD63kuSqb+IWdYfP9/wCJDIkyks=;
        b=HhGszPtBXTd6nPQVL9vB5aTyWQNhCOqmEp/KKZGUKmpYxEi5ZtWDX1KwK7bZZ91YN8
         q0xwcVdvRHNBlo/QO6YxGPANCiqIS2wtH9jV8YJMe+3ugvfFYIRncyhopRjyFscaR1tP
         YlEkhEAEUqFUTHzvoIIl7YDh9e0MWZJD0ensv249en/+lu0JZb8z5qzbc3fM93kfYI8R
         sdLqWD21Lny5Vx9KzrcO4uvl0uaGtItx91lwGnWUAjHQAAXUQUmwZPmwPJU/DmocQoZj
         xDgcMBfkiXTKVQvyW0DvKIf43vWY3cTJOGK/wFGNBUAcbH5m97KCTwM9IVOAdxdoVrl4
         /ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maagjvDsBJlC+y9OhD63kuSqb+IWdYfP9/wCJDIkyks=;
        b=prjLawnVAkJ7Gd5xEyQNRhPh+3NGk3m+6eRu/twNBEhJWzvwZWbaolbPilAquLrTlc
         mO5kBLWzXTEnjtoV28763riNmsXypdHe98K+IyfygxXxHThA3+L+7o2VaBTEwVQpNFIo
         W9XPq8AzdZEQ06vowHCAiOnXj5phEHPbNoazurF2ieFc6CWRjs3/hmdNfhbu+c7X2+BO
         iQgoPp+S9cDIrtSWhdrQs/0xft1Ggct8pPzZOungOY6QnJw0cW57zCZ8g5Cmvhwdbpwp
         Vc3Pqp38RS12zPxaBEUJVpWv1SE1zrphOEQ1GOpgx0vPva5oWV5HGQM84D63lty34MPl
         U5Sg==
X-Gm-Message-State: AO0yUKUrZ2DfQAIjDGlLSJsTqIyeOFEuKkhIUjCtSqh2sgrBfF8gknXT
        V/7HfSx+hpY7pvS+glx0fZEeji6NEdjd89H82joY
X-Google-Smtp-Source: AK7set+ZREPOoMw6DajSAew8APbcgVxrnpt18SXhM1+x+1D3I0fnsbj8wn8d+56OfafS/HPeV85zW24B5umwryYa+58=
X-Received: by 2002:a5b:f03:0:b0:a74:87b0:4090 with SMTP id
 x3-20020a5b0f03000000b00a7487b04090mr17422431ybr.3.1678831238977; Tue, 14 Mar
 2023 15:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230222200838.8149-1-casey@schaufler-ca.com> <20230222200838.8149-5-casey@schaufler-ca.com>
 <405ff748-dea0-794b-fa58-18b0a4703587@digikod.net> <a504f6e7-9c67-461c-6e0e-ae6d50623613@schaufler-ca.com>
In-Reply-To: <a504f6e7-9c67-461c-6e0e-ae6d50623613@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Mar 2023 18:00:28 -0400
Message-ID: <CAHC9VhStiDVn4_m5ye=T4sndK80VtzWmxBnsBFspyj41hDL+bQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 8, 2023 at 9:30=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 3/7/2023 3:51 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 22/02/2023 21:08, Casey Schaufler wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process.
> >> Create a system call lsm_set_self_attr() to set a security
> >> module maintained attribute of the current process.
> >> Historically these attributes have been exposed to user space via
> >> entries in procfs under /proc/self/attr.
> >>
> >> The attribute value is provided in a lsm_ctx structure. The structure
> >> identifys the size of the attribute, and the attribute value. The form=
at
> >> of the attribute value is defined by the security module. A flags fiel=
d
> >> is included for LSM specific information. It is currently unused and
> >> must
> >> be 0. The total size of the data, including the lsm_ctx structure and
> >> any
> >> padding, is maintained as well.
> >>
> >> struct lsm_ctx {
> >>          __u64   id;
> >>          __u64   flags;
> >>          __u64   len;
> >>          __u64   ctx_len;
> >>          __u8    ctx[];
> >> };
> >>
> >> Two new LSM hooks are used to interface with the LSMs.
> >> security_getselfattr() collects the lsm_ctx values from the
> >> LSMs that support the hook, accounting for space requirements.
> >> security_setselfattr() identifies which LSM the attribute is
> >> intended for and passes it along.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   Documentation/userspace-api/lsm.rst |  15 ++++
> >>   include/linux/lsm_hook_defs.h       |   4 ++
> >>   include/linux/lsm_hooks.h           |   9 +++
> >>   include/linux/security.h            |  19 +++++
> >>   include/linux/syscalls.h            |   4 ++
> >>   include/uapi/linux/lsm.h            |  33 +++++++++
> >>   kernel/sys_ni.c                     |   4 ++
> >>   security/Makefile                   |   1 +
> >>   security/lsm_syscalls.c             | 104 ++++++++++++++++++++++++++=
++
> >>   security/security.c                 |  82 ++++++++++++++++++++++
> >>   10 files changed, 275 insertions(+)
> >>   create mode 100644 security/lsm_syscalls.c
> >>
> >
> > [...]
> >
> >> +/**
> >> + * security_setselfattr - Set an LSM attribute on the current process=
.
> >> + * @attr: which attribute to return
> >> + * @ctx: the user-space source for the information
> >> + * @size: the size of the data
> >> + *
> >> + * Set an LSM attribute for the current process. The LSM, attribute
> >> + * and new value are included in @ctx.
> >> + *
> >> + * Returns 0 on seccess, an LSM specific value on failure.
> >> + */
> >> +int security_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
> >> +             size_t __user size)
> >> +{
> >> +    struct security_hook_list *hp;
> >> +    struct lsm_ctx lctx;
> >> +
> >> +    if (size < sizeof(*ctx))
> >
> > If the lsm_ctx struct could grow in the future, we should check the
> > size of the struct to the last field for compatibility reasons, see
> > Landlock's copy_min_struct_from_user().
>
> Because the lsm_ctx structure ends with the variable length context there=
's
> no way to append new fields to it. The structure can't grow.

The lsm_ctx can grow; that was one of the reasons for having both a
@len and @ctx_len field in the struct, the other being padding.  Of
course any LSM wanting to place information beyond the end of @ctx
will need to indicate that with a bit in the @flags field.

Having said that, there are probably other ways to pass other data via
a lsm_ctx struct, e.g. binary @ctx values, but I don't think we want
to rule anything out at this point.

Also, as a reminder, just because we *can* do something, doesn't mean
we will do something.  Any LSM that wants to pass something other than
a string @ctx value will face a *lot* of scrutiny.

--=20
paul-moore.com
