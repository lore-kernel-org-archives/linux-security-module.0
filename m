Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262AC61DA4
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Mar 2023 07:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCRHnd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Mar 2023 03:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCRHnc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Mar 2023 03:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CE57D1A
        for <linux-security-module@vger.kernel.org>; Sat, 18 Mar 2023 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679125366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6mVZfINk95ZdjqzZMMViirbNGt17S6vuLSn4PPbgPQ=;
        b=K9ZavOOpyka77UpJOpqARipmelBF3nuzGv42MhQXNo/tDticvKxYBgqAxJM3jd+GemFtuA
        OO9wn3RlpM93B1HoxrFTmGDvS6lZ/X8UulESZ9xN89EFxsySL2J12DDwSU3a0iH88xZQXU
        MsylIxOIBc+RhO7sCSf4fGsR2Xn43LA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107--Fo2uTonO9-JRb6bq2E7Ag-1; Sat, 18 Mar 2023 03:42:44 -0400
X-MC-Unique: -Fo2uTonO9-JRb6bq2E7Ag-1
Received: by mail-pl1-f197.google.com with SMTP id a18-20020a170902ecd200b001a06dbe7d4cso3844688plh.6
        for <linux-security-module@vger.kernel.org>; Sat, 18 Mar 2023 00:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6mVZfINk95ZdjqzZMMViirbNGt17S6vuLSn4PPbgPQ=;
        b=CAYpU9CfE7MgWicU6tJfWQ0FK4EkShbQQnkL+bf02O6fnWKSUDeKsF/V9SAJ2hpeS8
         EZY9vdvWJd9F78iGqpdw7i9lodHQn6P5QaLZTYruShytlBnI1tfdbCz5qhjWxlsklagd
         5IxtSurqbuLagHy0s1WO9JnIdDk1+NE5EYD3tMG4vTb4PzVAAncvufw7kDU3qMA9oULx
         ePOILshsIkLfSsxAjNKzZlbi20wty2InbQNoLDDIShtb8KINoIM17g6oXLsdXVlGgjsG
         zZzz8PTOlwsocWaW0iUaOM9UO4wWV4+5pxHXyBytgQRLoTuDdy5QZJKfWa6krvkS7jgz
         ommA==
X-Gm-Message-State: AO0yUKX7zfhDIZXR+4jbmgHwREyjfR3AilEuHHM0jG1SUuRHZBJyYZ+X
        HZilOR92BFcodTnzJh1vfx1c+t3dmDWzwB3A6uCdiPfrPt3sBnmS2aXgrMQwq7wkY1FjsAAZNnB
        0/ooCjAhSQNxjNk2HR5GTP+YJX5tQM8EB242luvmqpaGo6+gM0Unt
X-Received: by 2002:a05:6a00:14d5:b0:5e6:f9a1:e224 with SMTP id w21-20020a056a0014d500b005e6f9a1e224mr4097822pfu.6.1679125363873;
        Sat, 18 Mar 2023 00:42:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set9mXdBfdIyAOEuFZuaD43olFB5lcDdGA3gDMCmyrb0Tec0pSnn3x7593SeIlPFYbUq1fiSEHp6D457eNcv1HBE=
X-Received: by 2002:a05:6a00:14d5:b0:5e6:f9a1:e224 with SMTP id
 w21-20020a056a0014d500b005e6f9a1e224mr4097815pfu.6.1679125363518; Sat, 18 Mar
 2023 00:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com>
In-Reply-To: <20230317195615.281810-1-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 18 Mar 2023 08:42:30 +0100
Message-ID: <CAFqZXNuzNk70yS-BuChSdaG-n3jNR4vq+bQFryLfAnWODGprfg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 17, 2023 at 8:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> After working with the larger SELinux-based distros for several
> years, we're finally at a place where we can disable the SELinux
> runtime disable functionality.  The existing kernel deprecation
> notice explains the functionality and why we want to remove it:
>
>   The selinuxfs "disable" node allows SELinux to be disabled at
>   runtime prior to a policy being loaded into the kernel.  If
>   disabled via this mechanism, SELinux will remain disabled until
>   the system is rebooted.
>
>   The preferred method of disabling SELinux is via the "selinux=3D0"
>   boot parameter, but the selinuxfs "disable" node was created to
>   make it easier for systems with primitive bootloaders that did not
>   allow for easy modification of the kernel command line.
>   Unfortunately, allowing for SELinux to be disabled at runtime makes
>   it difficult to secure the kernel's LSM hooks using the
>   "__ro_after_init" feature.
>
> It is that last sentence, mentioning the '__ro_after_init' hardening,
> which is the real motivation for this change, and if you look at the
> diffstat you'll see that the impact of this patch reaches across all
> the different LSMs, helping prevent tampering at the LSM hook level.
>
> From a SELinux perspective, it is important to note that if you
> continue to disable SELinux via "/etc/selinux/config" it may appear
> that SELinux is disabled, but it is simply in an uninitialized state.
> If you load a policy with `load_policy -i`, you will see SELinux
> come alive just as if you had loaded the policy during early-boot.
>
> It is also worth noting that the "/sys/fs/selinux/disable" file is
> always writable now, regardless of the Kconfig settings, but writing
> to the file has no effect on the system, other than to display an
> error on the console if a non-zero/true value is written.
>
> Finally, in the several years where we have been working on
> deprecating this functionality, there has only been one instance of
> someone mentioning any user visible breakage.  In this particular
> case it was an individual's kernel test system, and the workaround
> documented in the deprecation notice ("selinux=3D0" on the kernel
> command line) resolved the issue without problem.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Nice, thank you for closing the loop on this :)

<snip>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9a58971f9a16..79b4890e9936 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6769,7 +6769,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_a=
ux *aux)
>  }
>  #endif
>
> -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
> +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
>         .lbs_cred =3D sizeof(struct task_security_struct),
>         .lbs_file =3D sizeof(struct file_security_struct),
>         .lbs_inode =3D sizeof(struct inode_security_struct),
> @@ -6905,7 +6905,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *i=
oucmd)
>   * safely. Breaking the ordering rules above might lead to NULL pointer =
derefs
>   * when disabling SELinux at runtime.
>   */
> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D=
 {
> +static struct security_hook_list selinux_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_=
mgr),
>         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>         LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_bin=
der),

It would be nice to also undo cfff75d8973a ("selinux: reorder hooks to
make runtime disable less broken"), which is no longer necessary.

<snip>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

