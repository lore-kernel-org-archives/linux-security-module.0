Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D4C07E9A
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jul 2021 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA00611B0
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jul 2021 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhGLPGE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhGLPGE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jul 2021 11:06:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F2C0613E5
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jul 2021 08:03:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec55so3634589edb.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jul 2021 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1cRp1VWHZe1p2M78fCVodbc0nQVrykOATx459rHnfg=;
        b=2SK+S5tCOVGYy34JELKrYSvjyivDlFptBxUOgGUP6ayfifklBOtmpfjQFzXzn5gP2c
         RohYGrmiihMozczcGIsJCMW+h4bDnTRafPmryc99DiJy3/YMhujbydnlD6VUIuU4jpkf
         J5P+iLBj9C6PCrctj2YJ6Ak3fc8AZTdREx/X+7UIfE9Nasc9ynos4CoBSvALkb4XSpi8
         HZv4LALQf2ASBc/DHEV3IJNHRbQE1NuHRtDK3d7T7aoM3/kbzTR4OHJ2VKt6haRIVQTd
         Zpg8ltNKKx6wZziX4BmA6/DtSVVCgUgJ6/29txsaXv95FX71/iVVOBAeBELIS7+HNfg/
         UPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1cRp1VWHZe1p2M78fCVodbc0nQVrykOATx459rHnfg=;
        b=fA61M61zYIeBWT7QaYIhTRJtHSbFnt6ET/Aui9Pzib9QRvu1VF1eJXcE9RM9ob/x0m
         uZlEib/x1HmOELkqHVcPqCpl7buMDBrrkwmSkP26xn+gMjXXWZ8z/0yC2/Re89SLTMCd
         SfpE+MIXh6ToOthdslB3a+mPcJi0F4mCYhpsnzcbqNm5QgL5LsCiBQQCuldCCGcX85A9
         X+bdIfGR+NdPineI9djRSeX4exDQgLFkQUo1o7aEmjHT1stFM3X4VGzc/y/b2WoIdddy
         N0wjY5/u9g43ggA43Xl32eAdmhTwv7uDoS7nVQHJDjJkMgOj9BxYscDxXAqq3uS73m2M
         882g==
X-Gm-Message-State: AOAM5326asX6wwYxSkwA1F4u1PSaCdvZSMG9xooUucskFo3RwweHWuwV
        KErUDXomxglKq5Y3SBzXYQCDvHGlUNb1mG74+lAK
X-Google-Smtp-Source: ABdhPJzcVKQ+at0A9nCuq8G+Bhgagor5un7zhKC1jZz6V691bOQeaUhB54EowXP3K4xo+95lyINwu3+N+EZg21m3YTk=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr5334758edo.31.1626102194142;
 Mon, 12 Jul 2021 08:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625900431.git.paskripkin@gmail.com> <53de0ccd1aa3fffa6bce2a2ae7a5ca07e0af6d3a.1625900431.git.paskripkin@gmail.com>
In-Reply-To: <53de0ccd1aa3fffa6bce2a2ae7a5ca07e0af6d3a.1625900431.git.paskripkin@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 11:03:03 -0400
Message-ID: <CAHC9VhS-bhpsKAhFwvQzkfAupbffKcb4sR6EDa1kMgdurnOiEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: cipso: fix warnings in netlbl_cipsov4_add_std
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cdd51ee2e6b0b2e18c0d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jul 10, 2021 at 3:03 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Syzbot reported warning in netlbl_cipsov4_add(). The
> problem was in too big doi_def->map.std->lvl.local_size
> passed to kcalloc(). Since this value comes from userpace there is
> no need to warn if value is not correct.
>
> The same problem may occur with other kcalloc() calls in
> this function, so, I've added __GFP_NOWARN flag to all
> kcalloc() calls there.
>
> Reported-and-tested-by: syzbot+cdd51ee2e6b0b2e18c0d@syzkaller.appspotmail.com
> Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  net/netlabel/netlabel_cipso_v4.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This seems fine to me, callers will get a ENOMEM error code too so it
isn't like the failure is going to be a mystery, especially in the
case where an obscenely large translation mapping is being attempted.

Acked-by: Paul Moore <paul@paul-moore.com>

As an aside, I see no reason why this patch can't be merged and 2/2
simply dropped as already in-tree.  As has already been pointed out,
patch 2/2 is a duplicate; the in-tree commit is d612c3f3fae2 ("net:
ipv4: fix memory leak in netlbl_cipsov4_add_std").

> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
> index 4f50a64315cf..50f40943c815 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -187,14 +187,14 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
>                 }
>         doi_def->map.std->lvl.local = kcalloc(doi_def->map.std->lvl.local_size,
>                                               sizeof(u32),
> -                                             GFP_KERNEL);
> +                                             GFP_KERNEL | __GFP_NOWARN);
>         if (doi_def->map.std->lvl.local == NULL) {
>                 ret_val = -ENOMEM;
>                 goto add_std_failure;
>         }
>         doi_def->map.std->lvl.cipso = kcalloc(doi_def->map.std->lvl.cipso_size,
>                                               sizeof(u32),
> -                                             GFP_KERNEL);
> +                                             GFP_KERNEL | __GFP_NOWARN);
>         if (doi_def->map.std->lvl.cipso == NULL) {
>                 ret_val = -ENOMEM;
>                 goto add_std_failure;
> @@ -263,7 +263,7 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
>                 doi_def->map.std->cat.local = kcalloc(
>                                               doi_def->map.std->cat.local_size,
>                                               sizeof(u32),
> -                                             GFP_KERNEL);
> +                                             GFP_KERNEL | __GFP_NOWARN);
>                 if (doi_def->map.std->cat.local == NULL) {
>                         ret_val = -ENOMEM;
>                         goto add_std_failure;
> @@ -271,7 +271,7 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
>                 doi_def->map.std->cat.cipso = kcalloc(
>                                               doi_def->map.std->cat.cipso_size,
>                                               sizeof(u32),
> -                                             GFP_KERNEL);
> +                                             GFP_KERNEL | __GFP_NOWARN);
>                 if (doi_def->map.std->cat.cipso == NULL) {
>                         ret_val = -ENOMEM;
>                         goto add_std_failure;
> --
> 2.32.0

-- 
paul moore
www.paul-moore.com
