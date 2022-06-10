Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B40C43334
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jun 2022 21:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350850AbiFJVMf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbiFJVMd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jun 2022 17:12:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE936E17
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g186so301206pgc.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLh8UWaxnG0XK4ejvWk5/7UEox62WuaIhi58ed8ZfqU=;
        b=oOOlocAR4BVT+CnGqmu5nFRQMD1z12qGrPh1buMTIuQt0LNbf3DZw0xZbNVlhc2y8n
         FYgbC30cstY+yvj2do6UDu46k7Vn5VFACCt0OQI1llYzuP3t8TKupeqiOl0mKnB7mEpx
         GBoXMrfeGKfVaH95mQ0aAmGMQl6kRSoID0l58jpYnm3rtiS1dksHi2ylQ1VCEV4L44Kk
         UDUm0pt38qW8TufTPezTvFPQNn59gduH4kJYvkmStSEnxU5vdWZHSf7q147zlIdmvwUs
         QtRPWAHObALA+wYaEq6Hz5Sjniu8RYXrZmOBthtCEfkCX7c09rysGegcLy4dFk/63PZR
         Ubxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLh8UWaxnG0XK4ejvWk5/7UEox62WuaIhi58ed8ZfqU=;
        b=r7aElMC07/cQVyALkBnKAYKkI2eMWunOrfP+rVbZ+PUPAXLhJD5SbKMqly13671tAx
         VwnLNte3CFT8OyzXGVeTv1IRb3RSYrBwgflkulaQIr8mkkyosuY9I6Yt8ZjdSXObXbRd
         CDl1wCnHay89q/6oGp5AfhEPQPXMwZ9Fci/uCUVJ1paCr3loStsOqv7m0fikbbTp+6Ul
         OvFh6jk3D5+ik5iagj5ztUZNZ1p5Q9W1zo7qFK5bodaejhqIoZoEY6GZebgs95gQ42cu
         jank6SWO+AkOmiCrVGs/ddAaJUc9bucPizj/4+bGJRH2/XaRlm6JnYwh8lke91J54mE0
         KFFg==
X-Gm-Message-State: AOAM53036odRb2kfLBYSO9AO5XRwrQKj+cyTq708xswocR3/j4z04Fe4
        NlvSSPtqzu6vNZLT0MPcQMxCaXYxEAZRal1KqlbT
X-Google-Smtp-Source: ABdhPJwOyrpg1AqxhhST810M59Pif6MyGpe2uAsQzlGWQ8QXwysQpCn4KgUWCSY2xql44klzbHEzPc92Valgmk5MxIw=
X-Received: by 2002:a63:8449:0:b0:3fc:85a5:5b69 with SMTP id
 k70-20020a638449000000b003fc85a55b69mr40873314pgd.261.1654895552080; Fri, 10
 Jun 2022 14:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-31-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-31-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:12:21 -0400
Message-ID: <CAHC9VhTraB9D962b9j8J0HxUE9RPbAp6ATNFuvucdccTHx_xmQ@mail.gmail.com>
Subject: Re: [PATCH v36 30/33] netlabel: Use a struct lsmblob in audit data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 9, 2022 at 7:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Remove scaffolding in netlabel audit by keeping subject
> lsm information in an lsmblob structure instead of a secid.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/net/netlabel.h            | 2 +-
>  net/netlabel/netlabel_unlabeled.c | 4 +---
>  net/netlabel/netlabel_user.c      | 4 +---
>  net/netlabel/netlabel_user.h      | 6 +-----
>  security/smack/smackfs.c          | 2 +-
>  5 files changed, 5 insertions(+), 13 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
