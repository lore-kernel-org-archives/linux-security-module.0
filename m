Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C2C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E912332A
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 14:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgLWOyk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLWOyk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Dec 2020 09:54:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD77C0613D6
        for <linux-security-module@vger.kernel.org>; Wed, 23 Dec 2020 06:53:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b2so16495693edm.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Dec 2020 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PY00W/i1n6Aklem6QSYfOghVnm24ydrQ5/AC2MoArE=;
        b=CW57V8TSEGONPWcsjBDmW3JEMl9IUbNymKqp8XIPAq3rNzWR3e0F9kLo4Ml+By0tUa
         cz6k5BRshrMMFuZf9FxMr4KYQNhgsag9ViVvbZb2XJCnri74Ua3rolFgK+9ma8LcfA+S
         ReckV0ETPU6F1JrN5xtmsv7rw6ecy7hU9q6GWVdl3Azb2/DajmwKWyQsLSepru5QhO/P
         iAlPf2v97EL8/eSCgmPWoxwG/I9dfKNKWyn7hh7xj+AGBF2gkc5QogqoXTIsQjSDl5Q8
         yMzyo0RJToJYxDBdw76pyqGDCHCXh11Z4b7m5rqwHj0gb30emsR1dlkia/Nim2raM/BT
         PyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PY00W/i1n6Aklem6QSYfOghVnm24ydrQ5/AC2MoArE=;
        b=ExcgaXYc5iaiu7SHY9iDgGG4u0Fs1N8/w+4jOBXevbdRgxdzp+MlxSL/tXLcU7OfGG
         0CiC9dyaxLUWCuL2jeNPvyH1FsDFPBRzup0peS5JE47kh12gGquYAK/Z3J8NhE6/dxI7
         jjSAFdKCMWGrm4EcFGCcDMFKfgRFK2JjX1T3Cimgpa6LPfOR/8fx+KTYQAsLjqLabeYD
         cxshIOojqPsSPZE4tz7CXi0/lENTxcaLcvxmLmblkAQzzrhV2VqGAy97pZSJ4tm4n2mP
         LSb3hAJQUefL8dmQ7Y78g9tUJ0rA+NO+40PWc9nvA1eeuL/UwDkrainIIsNiBg5s6yR8
         ndiw==
X-Gm-Message-State: AOAM533zKyqzC+1IQwW7SdoqOIHtpBVHRPTx5d3MA+T16045323914fM
        Nyc974WHBXSq4TQjSAuUpMHpqQHFOhkWXI1ccTA6
X-Google-Smtp-Source: ABdhPJyiuNRSUi1asl4sBfe8wegrjokhMSz8GElPAs++s9xc9NLRg2RaXgwSRWM6LXEBCmJXq9Q8aJMD7qDtsCkRzxs=
X-Received: by 2002:a50:e719:: with SMTP id a25mr24992642edn.12.1608735238054;
 Wed, 23 Dec 2020 06:53:58 -0800 (PST)
MIME-Version: 1.0
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
In-Reply-To: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Dec 2020 09:53:47 -0500
Message-ID: <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> The MPTCP protocol uses a specific protocol value, even if
> it's an extension to TCP. Additionally, MPTCP sockets
> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> support and available resources.
>
> As a consequence of the specific protocol number, selinux
> applies the raw_socket class to MPTCP sockets.
>
> Existing TCP application converted to MPTCP - or forced to
> use MPTCP socket with user-space hacks - will need an
> updated policy to run successfully.
>
> This change lets selinux attach the TCP socket class to
> MPTCP sockets, too, so that no policy changes are needed in
> the above scenario.
>
> Note that the MPTCP is setting, propagating and updating the
> security context on all the subflows and related request
> socket.
>
> Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Based on our discussion in the previous thread, the patch below seems
fine, although it needs to wait until after the merge window closes.

Paolo, it sounded like there was at least one other small MPTCP fix
needed, likely in the stack itself and not the LSM/SELinux code, has
that patch been submitted already?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6fa593006802..451bded67d9c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
>
>  static inline int default_protocol_stream(int protocol)
>  {
> -       return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
> +       return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
> +               protocol == IPPROTO_MPTCP);
>  }
>
>  static inline int default_protocol_dgram(int protocol)
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
