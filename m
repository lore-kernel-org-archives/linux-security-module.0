Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD40C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Nov 2021 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE4636F8
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Nov 2021 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhKOTJr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Nov 2021 14:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243959AbhKOTHR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Nov 2021 14:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637003060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/SBXUx2gshVEpRR5lkDqOIRh1bD4WZmOak2pzCj75s=;
        b=CI+RBIVCNAGb7wL9M+nRNMMmRAezEua6e/g7R20OS0FeZQTCD2CC1A6rYMFkFJw3Lk5GFv
        e7sU5mUq5yW3DnnKwdkblnkjpJrelGP34BXl1Mw6pEaTLTfr7qrsvLetiklzFaJyzgVXlC
        a9aF434o1u198t13DZSymtSjfAgGT6I=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-dgdJAD8lMk6johiJsWFcAg-1; Mon, 15 Nov 2021 14:04:19 -0500
X-MC-Unique: dgdJAD8lMk6johiJsWFcAg-1
Received: by mail-yb1-f199.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso27921987ybj.18
        for <linux-security-module@vger.kernel.org>; Mon, 15 Nov 2021 11:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/SBXUx2gshVEpRR5lkDqOIRh1bD4WZmOak2pzCj75s=;
        b=yqCFP+pHppfmyG1DDWVA6C/RIhxbMLzedVQz6aiT4OfKBfvRjcEjaSWxSTf1HG4LUe
         UwOhxjN6XP2Ts2Gk7vdlsFefJJYiUBX95g1TXJFOLFnIRPxUZuwML/8uvIueqb4LPOmI
         6IYLkHyD9JV8a4eF73+qmd3cr7F2qDf3hkYO8ml+t61Sdiy4JOz0cwthKJ5zckYhq+0X
         cgjM9Km4DSxdRHaiP0v+n30gfDRyMZYnhaGbIMPHA9HoAKFxKW0whz0NAgan9ijf4/8t
         IRej4obzZkMXkSr9cBjLi6pIuOG/WXHeyQcg+DSbGnisQwBNw4XG4ZS7RZEpOZo3iNIc
         +Hfg==
X-Gm-Message-State: AOAM5316tmve6XJVQ8oNFVvlzp7iPd3/x5La427ITQjASmNBtDaHmvvP
        Qmdirc2sydlcVNDcOKSTkcvg8FW2kJbg7cOA3I8AyNmZ4W5TS68E4bqLm7i98pEndw0vP2pP4hO
        kjS+tt1TUuAFQZg71NqwAyHTpDqA73bbfacOUgM8nrj6zvi+pRN0z
X-Received: by 2002:a25:3283:: with SMTP id y125mr1233685yby.479.1637003058346;
        Mon, 15 Nov 2021 11:04:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDg/2EKuxykc6+iQIz1Ve049nNfAryXwGXOETwxe8O1IwCanztgTBfr04ISJwL8oujwWmHkrKy78vI+kFMlCQ=
X-Received: by 2002:a25:3283:: with SMTP id y125mr1233623yby.479.1637003057823;
 Mon, 15 Nov 2021 11:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20211115173850.3598768-1-adelva@google.com>
In-Reply-To: <20211115173850.3598768-1-adelva@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Nov 2021 20:04:05 +0100
Message-ID: <CAFqZXNvVHv8Oje-WV6MWMF96kpR6epTsbc-jv-JF+YJw=55i1w@mail.gmail.com>
Subject: Re: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
To:     Alistair Delva <adelva@google.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Stable maillist <stable@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 15, 2021 at 7:14 PM Alistair Delva <adelva@google.com> wrote:
> Booting to Android userspace on 5.14 or newer triggers the following
> SELinux denial:
>
> avc: denied { sys_nice } for comm="init" capability=23
>      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
>      permissive=0
>
> Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
> better compatibility with older SEPolicy, check ADMIN before NICE.

But with this patch you in turn punish the new/better policies that
try to avoid giving domains CAP_SYS_ADMIN unless necessary (using only
the more granular capabilities wherever possible), which may now get a
bogus sys_admin denial. IMHO the order is better as it is, as it
motivates the "good" policy writing behavior - i.e. spelling out the
capability permissions more explicitly and avoiding CAP_SYS_ADMIN.

IOW, if you domain does CAP_SYS_NICE things, and you didn't explicitly
grant it that (and instead rely on the CAP_SYS_ADMIN fallback), then
the denial correctly flags it as an issue in your policy and
encourages you to add that sys_nice permission to the domain. Then
when one beautiful hypothetical day the CAP_SYS_ADMIN fallback is
removed, your policy will be ready for that and things will keep
working.

Feel free to carry that patch downstream if patching the kernel is
easier for you than fixing the policy, but for the upstream kernel
this is just a step in the wrong direction.

>
> Fixes: 9d3a39a5f1e4 ("block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE")
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: Khazhismel Kumykov <khazhy@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: selinux@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: stable@vger.kernel.org # v5.14+
> ---
>  block/ioprio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 0e4ff245f2bf..4d59c559e057 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
>
>         switch (class) {
>                 case IOPRIO_CLASS_RT:
> -                       if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
> +                       if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
>                                 return -EPERM;
>                         fallthrough;
>                         /* rt has prio field too */
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

