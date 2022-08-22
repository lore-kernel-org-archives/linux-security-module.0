Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76594C3F6B0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiHVNwK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHVNwH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 09:52:07 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E0357F3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 06:52:03 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so12940534fac.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m73J0a+SpVfFWhhFyKyas6A9QyGH23phPhrWwSIkcsg=;
        b=0S3Vde4uVPpqrwPrSn1lB/BfHqxw7g0fVMQHKT61OyhdTOtVhgnuM8VKLapQrHBQ8X
         suJr5xe8z6Ty7J9guCGdAbnnjuvcV6ZhU0CHTn61GfDgO9yA7ZtWzN4BcMCzHmvYPPud
         ITtvX3vD7dU5cG6HOJZy6M/DVFJJhxNH42et5otOd1jDNZqHxLI0pUb/zQ2U7sB2lCtm
         M53lNHSrkSUJQw+w8Ag58hDIep3lLqAu1+0RnN7xgnarAtGFkwG+Hc4ARIhC1yD/Qfq9
         44u4uP2snLqRLedeJ3yaaWOnq8IdsqZsBJwHTaCUmqBXyt3NVeWSHUU3gptroo3ev4LS
         ZOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m73J0a+SpVfFWhhFyKyas6A9QyGH23phPhrWwSIkcsg=;
        b=OXPHBSZD7FTBK5OA0I0MZef3A+T05k7+oxkXMC3C3Q2kgVfUc+ZPzhHI9gqEU2uGr4
         wQ8opIbffO3Kx+PGqwU0sA+P9I1rq/Mvy+haYST37KxW6mpNTn5r/ro3CNcS6R0TVge5
         hcncOChwSiM08e7Ou3mmuRZAGlkiPXxsbfs5FzQX1Ygbllan9RcZt6HmL4ERuqh8hl8Y
         buWmVsTFq1vJwO6KOqB4MWxMmZhG64WA+7TO2LtHWaPvdnDFumsIH7tkOIh36L5iBwsl
         Bwvrdb3d8q6qzidnS41woGYFAn9oauwlyBr/0SB1IVMsOGF5zxhkPPGGzXo8DCphcaOd
         +48g==
X-Gm-Message-State: ACgBeo3++XIa6gVuESp3+2tMPyrAxzPhuNelk3PYDNgWfff4BTEYy7Nq
        +LHxTAFhX9gSvbrkHv8LiCw/C9S3JnJdND0KpkFpcMXqqw==
X-Google-Smtp-Source: AA6agR6MT2srz07bE02RPC0qNPY68niPs6ITLMH7RnLkt58V+xS6X/ZpYBYD8DSuWO6HkBAn6REe/BSbtpuhEQkhjOs=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr770914oae.41.1661176322392; Mon, 22 Aug
 2022 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <YwEjnoTgi7K6iijN@ZenIV> <YwEjy6vaFHEVPwlz@ZenIV>
In-Reply-To: <YwEjy6vaFHEVPwlz@ZenIV>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 09:51:51 -0400
Message-ID: <CAHC9VhQXbhdywdxrOmQ4J70zZo2EZBcrPsmJC0J7WWyb5Bskdg@mail.gmail.com>
Subject: Re: Subject: [PATCH 01/11] ->getprocattr(): attribute name is const
 char *, TYVM...
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Aug 20, 2022 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> cast of ->d_name.name to char * is completely wrong - nothing is
> allowed to modify its contents.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/proc/base.c                | 2 +-
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 4 ++--
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)

Thanks Al.  Based on your other email it sounds like you are going to
send these up to Linus, which is fine by me, but if that changes let
me know and I'll make sure this patch gets sent up.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
