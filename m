Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F587C433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6992619A2
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCVTAf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhCVTAV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 15:00:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2141BC061574
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so4844517ejz.11
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=BXYAJLxcuRH5oRxtxWbWiwktazlO44A9TZdXp1vfkDadW39IR7NVnIrDUnd6T0Qaji
         EtwUiSq2UG16VbRUQ0XTNgDUAacWsdIEnqm+XH5AFtEHAoOVuEi2tT21lsrvlfCFxZR/
         qesIrifile3JvJuxIPu0B6x18zI/590KMOT2p2/gbXI2gJose0KUowKt1m7SLHtldSid
         n8j43mDxdjsaun5LdVJ3BhKptlOb+vxL+2CtFCMp4G0kIUK/6KoIMlP72x+d+qs3I/p9
         p2GGj2MC0Id3zKXhkLqe7fa6zORB6MuoYV7Oe5odCKdP6AR0H1BAOn7OaI7cpFzzrOPy
         QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=ASpU9BR0DVQhwuE8xTYtuPAj8+dOvLWKeQ/JL6ugGkb2oH4dgckdaUb4xGQDqp2YTO
         RfE2ZitOEYMtJU4Dh8+wvtIG5e41TynwVvxqMgPiTwH3GOOf8AbkZl+WT4fzkZe6otnu
         e7iYbUdYe2KCn54TLNCHuzV3FaKYQUN4ln2eV3QPq9EykmQ1VGxAM7MmYVe9DXyYm1f/
         6Ixl5JUEKuKRAgPjPJQ/9inCi3JeH+O1/h1ltJQbrUdLxruYB6LL34GNu7oyo6/eJP/c
         ch9HtURLFHDeAdsBpi9txcvnN9ky02+CaVD1CDYi7iHrhX9zYt9ChGkz+h77SS2L/91y
         yw+g==
X-Gm-Message-State: AOAM531GS5nYNlA6tQ5BxVYHwe61+KSpLjQdiX8oKBap59gNiXb17pZa
        BjOwls9UShjByt9/LSWSlYgeWkUvftsynP3zoKTg
X-Google-Smtp-Source: ABdhPJxBI9nbqYYbiPbcQlRK4x4a8SAUrhThaao+Dq6D5/vgzjJrsU2iVFjFs3ELvrxMxHUuvdn/YbbxerWQ9SLaIYI=
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr1221686ejb.542.1616439619771;
 Mon, 22 Mar 2021 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com> <20210219222233.20748-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20210219222233.20748-2-olga.kornievskaia@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 15:00:09 -0400
Message-ID: <CAHC9VhRFSZyKcT8XxW00QwFvbeC8iB7PpaDifrenuZk2wdAqfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] [NFS] cleanup: remove unneeded null check in nfs_fill_super()
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 5:24 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> In nfs_fill_super() passed in nfs_fs_context can never be NULL.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
