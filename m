Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968AC5517A
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E04208B3
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 20:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6lI2X8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKKUAt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgKKUAt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 15:00:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07CC0613D4
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 12:00:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so2306583pfl.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUj5Ux6T0pAvZX6aMMGDC3TkMnjTVY1hpdEEFVZyifc=;
        b=u6lI2X8lX1/O15vgA1f7CK1H9a9YEcN+4UrDGICzNhQevAW7YiUdk9ZtClLxZ/fqzD
         4ygBaK6iPZ69ujXTrxDYGXozxaVMAWBjiX+PDclhR1b6k2cEl5HeQTeT5fuI/aQPws3S
         K0lGtFYGItBfxecSZk1TKRH49FHut34zzwrjb7myLQ64Z+/vSXx96dPi65y+X/y7W/vl
         tcxxISeKHvlPkZpoPIQAKgsmIU3Y8Rga8jS9x6jwj2hHdLGxQx2CCcGzpofIKH7NEVeq
         pamBM3liI3N47uoT9EmPfwh5BPHYfd6C2iYE1w1U2p9aAyCeqmdYn/yr++3zYUHqc3He
         kFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUj5Ux6T0pAvZX6aMMGDC3TkMnjTVY1hpdEEFVZyifc=;
        b=GSo00Whjs6EaJ5RnF+K27jWUekoyhA/p16OX+R04yFgBwGXYmmxwbMaxhWU0K2Vb/N
         96ZZmQNTsejtZmzTcPC8akBhGf+nBRYca5z/dSwNuoneIgG2sWA3PaQZ88bzBzj4zhbA
         qlP1XTDfTCndH2ISMM4N/jn6o7l3QIyL2oDNn1DRV69wiwdZpck64g5A5z09NoHQb9IZ
         HtgV6o2hvgwH6hhKKHWjmjLX/FhaPjIPWW8X/YgfaycPDJToAu3OaXNDC5E0vU7c4q92
         XeI9M86bnbaog3FmsEQJVrMhoj7c7prLhWhY2WlVo20OT6m1yA1eiMv/duNdmGCEIZ+B
         ttQQ==
X-Gm-Message-State: AOAM533of0haa6BbZot049/dskymsuhTgiISp4Ln5Isr2C9ieNr3dofU
        NcGlomiTe4C7B2kDCbqfuPW23LgcG+XMUWTYohj2TQ==
X-Google-Smtp-Source: ABdhPJwkUcYBtbuvz0wA+LPzuXGAy0FVPrRT5hucnF0lm1Je0RMJAtXomFgUQEXCakldEHfeFwvTAEmtCuGpTw9Jwwk=
X-Received: by 2002:a65:4b81:: with SMTP id t1mr24128814pgq.263.1605124848749;
 Wed, 11 Nov 2020 12:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20201026215236.3894200-1-arnd@kernel.org>
In-Reply-To: <20201026215236.3894200-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 12:00:37 -0800
Message-ID: <CAKwvOdnHWYXieOPbOWzXxC_5vLdQdW4FsLZyiMmtzfj6JH4UWA@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: fix clang pointer arithmetic warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Toshiharu Harada <haradats@nttdata.co.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 26, 2020 at 2:52 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about additions on NULL pointers being undefined in C:
>
> security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
>         securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
>
> Change the code to instead use a cast through uintptr_t to avoid
> the warning.
>
> Fixes: 9590837b89aa ("Common functions for TOMOYO Linux.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/tomoyo/securityfs_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 546281c5b233..0a5f00073ef1 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -223,7 +223,7 @@ static const struct file_operations tomoyo_operations = {
>  static void __init tomoyo_create_entry(const char *name, const umode_t mode,
>                                        struct dentry *parent, const u8 key)
>  {
> -       securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> +       securityfs_create_file(name, mode, parent, (u8 *)(uintptr_t)key,
>                                &tomoyo_operations);
>  }
>
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
