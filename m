Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD7C47089
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 20:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8037B613E6
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 20:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhEZUrW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 May 2021 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhEZUrV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 May 2021 16:47:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AAC061574
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 13:45:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gb17so4547235ejc.8
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hZCAUoXKrRadFb+irPhIRNvSXLD3efh4ids+GIhWFs=;
        b=nfVoX9KAdt7r7/foZ9VUfr+6B2RB3P+vNbWffWRDMtH3ewh4p/A6WYnqQh5ph9o1ue
         6kkuFTas+P+LKDp1/e4pj0M59SPIfmSm6YcnB3iUOwBY5cs32OMJHePg4mZCpskhdqfJ
         fIYCHHyfSpJj6IgN7OIzrFYlKPjYW3UtIxoV93hflXID48f9jidwBRepPFXui4ocXJ5K
         Uvelq/osd8B67DZsrfguILWWp1vlsSDCkNhQ1tFCPijAlVeALSef8HQaRGvDKA5zjI4F
         vZYgPWAKtL4J4p5FBDZbEv4BkvEKl3PJBqMbmJp7qUjUzjWuVW5MEArxwg02ldyLGQwd
         zNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hZCAUoXKrRadFb+irPhIRNvSXLD3efh4ids+GIhWFs=;
        b=kLoKz01XZHpbblBnNwb1xkcDrHVpUT0jk+V+O7oWGHcnwAg8mfOaOztyqVD00wj3Nf
         sud3mnfVVX8BRrVPEJCx0isGjYp9i4kUOeCRzY2Wk/h1V3NKg00Nu/2czsZH7a2s5win
         /GOp2obr/Hpsg7j98fE5q8j33GoZ3cCkCfJJoPcLaIUY6YzntEpyNRCqZH6gi/zazh99
         ezdO/9wCNgJc4fubKTtD9fx9oDdSj6JuPOF3KUp6HXJCmB27wmFfo4Mw+t5LWXA4xADg
         y88dSaZaXjbRxq1f4uixIuZugvWSJ2hA/UJbOcTpQduFwKgNQKmRIV9GxMnBGUMVMTxz
         pW1Q==
X-Gm-Message-State: AOAM5313zsA9Cr/qoVkRtZ8K4XNx2c4PXFLB9RfDKAndyi1LIlbr+y52
        HaFA8e8A08kylVnf7IKcFl4c+C1Qnb8MAyoM+Z8I
X-Google-Smtp-Source: ABdhPJz6iVOIuh44Mmqdysb7jNsGhoP9gYEuVrlzxw4kHHE84xFgHtv1QtgrqYjZoQKXQGBkRyDa8YES+ONshv3QTv8=
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr149899ejx.431.1622061947628;
 Wed, 26 May 2021 13:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163382536.8379.3124023175473604584.stgit@sifl> <00bede98-1bea-e3bc-b0a6-f038dc75c08d@samba.org>
In-Reply-To: <00bede98-1bea-e3bc-b0a6-f038dc75c08d@samba.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 16:45:36 -0400
Message-ID: <CAHC9VhRSsRj6e0LmSqGfWk3cEvfC1c6CyN2EZeYL0vB_5Nz7CA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] lsm,io_uring: add LSM hooks to io_uring
To:     Stefan Metzmacher <metze@samba.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 26, 2021 at 10:48 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> Hi Paul,

Hi Stefan.

> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/io_uring.h>
> > @@ -6537,6 +6538,11 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
> >               if (!req->work.creds)
> >                       return -EINVAL;
> >               get_cred(req->work.creds);
> > +             ret = security_uring_override_creds(req->work.creds);
> > +             if (ret) {
> > +                     put_cred(req->work.creds);
> > +                     return ret;
> > +             }
>
> Why are you calling this per requests, shouldn't this be done in
> io_register_personality()?

Generally speaking it is more interesting to see when user alice tries
to impersonate bob and not when bob registers his ID as available to
use by others.  We could always add a LSM hook to control when bob
registers his ID, but I think the impersonation is the critical code
path.

However, if I'm misunderstanding how this works in io_uring please correct me.

> I'm also not sure if this really gains anything as io_register_personality()
> only captures the value of get_current_cred(), so the process already has changed to
> the credentials (at least once for the io_uring_register(IORING_REGISTER_PERSONALITY)
> call).
>
> metze

-- 
paul moore
www.paul-moore.com
