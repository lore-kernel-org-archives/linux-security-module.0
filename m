Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A21C4321E
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Oct 2022 18:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJQSQ4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJQSQz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Oct 2022 14:16:55 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0AC74CFE
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:16:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t186so14220869yba.12
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=re4sAlYmP46Ps54s9+Rc0/9KShWmdIukkLH5HLDkCa0=;
        b=tPWuv3ZxR+juLMtYGHK/E3z9UspixPcvIArtKOZAVC4ZQibg3deOqys6XIvktWpiYV
         4C7LJnOnfzPv39C3282xe1EmiJVlNWVA2nHAesoGOLzak34O5w8gVHug5InVkqKOroTu
         8lfLFnomACkboux9iXXCjqDu0Kk+CvZZKrkQ/pHzoyqHQLPeBwZm/GrRsZ4uA6Ce77J0
         lMH0L4dDBNgSg97rTtSz+rDhSOZgpKpgncos/TodnDVJ+sA5FHLKWa4hX71KEVmbFtBS
         L98ZFnrvIgKjGW1TUQ1H/L2kellilwmpFsWlDSaNOgDct1Zwc0QfLabNJ5uDnIfYYhE4
         c4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re4sAlYmP46Ps54s9+Rc0/9KShWmdIukkLH5HLDkCa0=;
        b=3/KJwiNEthr/uccxwV+PsWT5bI5ApnCG+ZvoPTAmUmWrlrExCPG9eni2ATrD1sCb4q
         GdfE1bl5C9cW9MI6uH5eoEjm13F7/9PUGmC2Dy15ZvxmFWpdv6yb//2Y0OsEFLDbG50h
         e0Xjoh8SfRRxe58fQuDYOwLe4eiaLMKK0P9gQjAsIPrVrT++uYTgmgoGjTyMW248B9MY
         KxiiA8ryC+Gi40aaKTxtfuSVhwf3OZFPoPhqr6ID4RrZ/Mpmd5xXvMaBr5HG2C/ZDQ20
         5tmDYtRwejFA0kbDaDNvAcBbRAjz2L4nGIyvikYvuMYHH0122xHsAUTAbMfgg4IuHy9c
         MRhQ==
X-Gm-Message-State: ACrzQf37ZmHOG0w5WBIEim8zwSA9l647j1oq36vVFEqeW6nwi6yhLrM9
        vB/x88Cd5wf7lzg5ys5Ey8IzkH2aEprGj+jXsqTfTXRybg==
X-Google-Smtp-Source: AMsMyM41pBe8Y43QnorNN5T0b7wDkUfxkwGG+Ws9eGijL1DQ5ZMzKKznlMw0QwuWqcqceyjBYr56UQpyTxlvM2EjPmA=
X-Received: by 2002:a25:22d4:0:b0:6c3:6ec7:3dc9 with SMTP id
 i203-20020a2522d4000000b006c36ec73dc9mr9910866ybi.520.1666030605750; Mon, 17
 Oct 2022 11:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <166603049758.227260.3219849022705789477.stgit@olly>
In-Reply-To: <166603049758.227260.3219849022705789477.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 14:16:34 -0400
Message-ID: <CAHC9VhTy5FGpr58ZR9faqKTkURKxZcP1UU-s_1JJsDT5xd1O4g@mail.gmail.com>
Subject: Re: [PATCH] fs: edit a comment made in bad taste
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 17, 2022 at 2:14 PM Paul Moore <paul@paul-moore.com> wrote:
>
> I know nobody likes a buzzkill, but I figure it's best to keep the
> bad jokes appropriate for small children.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/fs_context.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Normally I sit on my own patches for a day or two, if not longer, to
let people review and/or comment on the changes, but this is trivial
and The Right Thing To Do in my eyes so I'm committing it now to
lsm/next.

> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 13fa6f3df8e46..6fbf49cc10e47 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -99,7 +99,7 @@ struct fs_context {
>         const struct cred       *cred;          /* The mounter's credentials */
>         struct p_log            log;            /* Logging buffer */
>         const char              *source;        /* The source name (eg. dev path) */
> -       void                    *security;      /* Linux S&M options */
> +       void                    *security;      /* LSM options */
>         void                    *s_fs_info;     /* Proposed s_fs_info */
>         unsigned int            sb_flags;       /* Proposed superblock flags (SB_*) */
>         unsigned int            sb_flags_mask;  /* Superblock flags that were changed */

-- 
paul-moore.com
