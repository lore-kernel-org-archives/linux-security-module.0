Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2BC433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1441D61163
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhJFT5V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJFT5U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Oct 2021 15:57:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2234C061760
        for <linux-security-module@vger.kernel.org>; Wed,  6 Oct 2021 12:55:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so15070268lfa.9
        for <linux-security-module@vger.kernel.org>; Wed, 06 Oct 2021 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O34eH0EHa4dBMbkzaLgHHRId8l/MAEnDKw9FowvQGtw=;
        b=edyHFq+vsfJFiZd8DhlRrAHySi3AsFfIcOaBRsKAK4GAw+GqH/Tkncskp+ehkhkvMJ
         Rh2FRF9TCAYHNO5g5j8g+lb0xmVeKVhFZ6ypCqlHS/CxvSsbDGbiIdCrJ50GYAkgoDXB
         9Sb4DaPWafxMxih6hnxJnEqkQX8cOODs1n7pML6RNkqDaOBKUqN94bTbsnZO0ZrfyTxW
         KCcWG4t1IUhi6fL2HVsgpiA8yXyKm+j13sKaJOdS8iGg9UAZdGzrE87+cCGOZt/dupST
         xw5XIxspcb5yhHEaZRQmQCmulymMeghKLzA/lGlYMS9Fz+fSqOmBElUx5g8238R1pbbB
         Evyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O34eH0EHa4dBMbkzaLgHHRId8l/MAEnDKw9FowvQGtw=;
        b=N4mcS0T2TVBLpcorJG90MYi1QdxV4llyOSK/sTTR5T4UHJSBbio3ZihvT6j7DIKt8D
         oXEvZPjupUp8BcQUJbeRH3WiWvsCi7WbC0awx2APMLe4j1wqWYBugtrG2sU3Yk5dCcJJ
         WfzoZAhrhEWbqV7EBQdjeFF6ks2+0zKxrfo/XCHXmdAeH21Uh5BryUcWs+N03t3L8/OT
         AgoIxmU3J4UB+pvvrXq2DcxxKDuTp15qfg8pzMnR6RPO9xZgsL9wGmbYVo1+LFnfKJFv
         zazbEsfxuLIfTWikrsgfleZhXSohSB2Z9a7v4o3bbHtaUEDfz9BojZZhZBs4NeRuYMCU
         K7NQ==
X-Gm-Message-State: AOAM532HCffkC+UmDjROkj+YRx7/DEjQv/hXWY06G2EJDFKFSmhqUStQ
        WBLaZsoi4LjES9M6elpa5OWrQgoEl54xldSh4hNS7g==
X-Google-Smtp-Source: ABdhPJxvYTzX1/2a+GZtvlTtfbjZ2f1aHuPdE1JLzkl2Tf4YIk/gPLeLtgxyWjoSngDOiqBUv32ywAZBk6mznY+UUkI=
X-Received: by 2002:a05:6512:2290:: with SMTP id f16mr11688585lfu.668.1633550125028;
 Wed, 06 Oct 2021 12:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211006194610.953319-1-tkjos@google.com> <20211006194610.953319-4-tkjos@google.com>
In-Reply-To: <20211006194610.953319-4-tkjos@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 6 Oct 2021 12:55:13 -0700
Message-ID: <CAHRSSExN4g0qubjjLhdGx5DA7njT5ZwPkAzCY1OEdR1dbscLVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] binder: use euid from cred instead of using task
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 6, 2021 at 12:46 PM Todd Kjos <tkjos@google.com> wrote:
>
> Set a transaction's sender_euid from the the 'struct cred'
> saved at binder_open() instead of looking up the euid
> from the binder proc's 'struct task'. This ensures
> the euid is associated with the security context that
> of the task that opened binder.
>
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Stephen Smalley <stephen.smalley.work@gmail.com>

This should have been "Suggested-by: Stephen Smalley
<stephen.smalley.work@gmail.com>"

> Cc: stable@vger.kernel.org # 4.4+
> ---
> v3: added this patch to series
>
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 989afd0804ca..26382e982c5e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2711,7 +2711,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 t->from = thread;
>         else
>                 t->from = NULL;
> -       t->sender_euid = task_euid(proc->tsk);
> +       t->sender_euid = proc->cred->euid;
>         t->to_proc = target_proc;
>         t->to_thread = target_thread;
>         t->code = tr->code;
> --
> 2.33.0.800.g4c38ced690-goog
>
