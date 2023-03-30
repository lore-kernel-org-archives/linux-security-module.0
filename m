Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E755C74A5B
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Mar 2023 01:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjC3BNL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Mar 2023 21:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjC3BNK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Mar 2023 21:13:10 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA34558E
        for <linux-security-module@vger.kernel.org>; Wed, 29 Mar 2023 18:13:03 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z83so21716869ybb.2
        for <linux-security-module@vger.kernel.org>; Wed, 29 Mar 2023 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXJuH4+zi+/MMgrdfkbLfVL94s0Gkym3lpLnVhFgnPI=;
        b=Ya57IjZqn3R/knpdkFDNWTnpqO1nF9sa9ZtXoRj3N9gyG3h6UOysD16RMv4WcS/QN7
         qnNA3Mkr+uPa5bzE7TylZb63MxWB2+rJyzmetuCVHJyb+306IA2zr0cXgbdYNENVj5dY
         aq1YBAbDb+o4XT3xBqvTIx1ZpdcehR2vXkhqok4rGf913AFv0bYJ7WJEF+7tih3qOE1+
         8XA3FL6MuU0Ndr2Vh8fJ0j3m0yU9uF+gnJIAspxx3KqubipTJIP1S6E3Dxe0daROawsD
         O6ut/OBesdTxPwkwBNhXnEH5KgHfNG65Yj9wxq99xvukBXZgkBM9Yl2X2X72x+XzDgzB
         BZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXJuH4+zi+/MMgrdfkbLfVL94s0Gkym3lpLnVhFgnPI=;
        b=ITJanyxLp7S5TDe+VLTlZKls/KgtnXKBwhxI4aa5k59deYHKUfuOGA2KaSus5oHhRx
         Z1dvnVFpSAHDIMnNsNUbKGpKCw96+Zhus6rFyqfO48eFTxTkIQg6KBlcIM9bGaU+GOeW
         Q7mi7CzcHOnjGS2Fw91I5FFNXD2jTob94DOTODtKMF8P2Pi7mIo77HqUTRsfHHcwxNAB
         EjJihuWKkiHRdji8lnLp5qVTwEgccrrvE86dtlFSmnkhTUXIS6Efyl3WBU24lU9TRw4o
         PKR2fQUf6aG2mvxt+1V0Ml6+1UDzUcWdrPw8G4LaVlQFj4I3oyBO2xadqB7I3cqqvOr3
         1mHQ==
X-Gm-Message-State: AAQBX9eewp0f8ooIN6VZrdR4iHbaX4DneYXEf/QM4LSL0t9L656D/u7w
        rG0jRSNmTspkplHNu9PFuQy6GEE6lWqoulCTpaR1TZxl4LGlceo=
X-Google-Smtp-Source: AKy350Z2yN4kbSDx95+6XZH60LES+XR6Emn1TIIxi2Oa1YE8MnNCgKw3ExsdxuD7KyItixgjDglwUMX+dwrjl/3PAPM=
X-Received: by 2002:a05:6902:72e:b0:b6c:f26c:e5ab with SMTP id
 l14-20020a056902072e00b00b6cf26ce5abmr14718432ybt.3.1680138782566; Wed, 29
 Mar 2023 18:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-6-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-6-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:12:51 -0400
Message-ID: <CAHC9VhR8WycNQ_mxeB9icN6ddQKtNCkkzTPtdJJKDW-qQXL3ug@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 15, 2023 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
>
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/userspace-api/lsm.rst |  3 +++
>  include/linux/syscalls.h            |  1 +
>  kernel/sys_ni.c                     |  1 +
>  security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index feee31600219..6efbe244d304 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr,=
 struct lsm_ctx __user *,
>  {
>         return security_getselfattr(attr, ctx, size, flags);
>  }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, si=
ze,
> +               u32, flags)
> +{
> +       size_t total_size =3D lsm_active_cnt * sizeof(*ids);
> +       size_t usize;
> +       int i;
> +
> +       if (flags)
> +               return -EINVAL;

In other patches in this patchset you use 'if (flags !=3D 0)'; I don't
care too much which approach you take, but please be consistent.

Actually, I guess you might as well just go with 'if (flags)' since
I'm pretty sure someone later down the line will end up wasting
reviewer time by changing '(flags !=3D 0)' into '(flags)' ...


> +       if (get_user(usize, size))
> +               return -EFAULT;
> +
> +       if (put_user(total_size, size) !=3D 0)
> +               return -EFAULT;
> +
> +       if (usize < total_size)
> +               return -E2BIG;
> +
> +       for (i =3D 0; i < lsm_active_cnt; i++)
> +               if (put_user(lsm_idlist[i]->id, ids++))
> +                       return -EFAULT;
> +
> +       return lsm_active_cnt;
> +}
> --
> 2.39.2

--
paul-moore.com
