Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A16C43461
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C683A206B2
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2Hj5td9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgIPS5q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgIPRxQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 13:53:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C046C0086CC
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 06:36:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so2810556wmi.3
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EuybQW1ppgraVX2hyVMItjUmNmGySBlnG8NYJPKbe6Y=;
        b=K2Hj5td9hRQJlq9cZQMOd0rL1V6z3mZ6tZf9w51k8KdcFw3MfhJhPkGbhF5voBiHZh
         kuuG21Crm28GsJEofOzgRwWAZ6uz8F9jaUVsitplAs/9fOc+RSGM2Cwd3v4GQlNtpqhH
         9MicZTQzCvZPUF70s4OpKrJNE9a0TWoYwETCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EuybQW1ppgraVX2hyVMItjUmNmGySBlnG8NYJPKbe6Y=;
        b=BaGxhVrxW+1JWcZ+4IAsWAmbAc+KWGCGZS2sWrWzJlp9tf18XPrc5H/yOVPm44c2nH
         XPX9Hhlkz8zpR+ItMtOpwOkDBjTa4wv0OrwfEXNRxGJJ77hsbPC5MUIQ9wnoNHe+OMAT
         f5lYBtduv9dMgYxDSnlAIDs3JAoG1Pcpuul9QIHpXVhGjFisk1hJsRw+tbhTJHTSQRbm
         pI6V7Caz8TEYFXFo5g0tJkXm7HdzwtufyqPUqiCfmeMD9ATKp0IlMEvfb4mgm7vC0Xnj
         lTByzw/ZM8nQ7/kKKOAI+e6u/p4QhJMKC+nrZZG20eK1f0dzU9/r9H0MsNdr5QNOeu0T
         Tm8w==
X-Gm-Message-State: AOAM531v0nFHMriYmvovAf3HttaS3TGaamlbtJqCj9lV7jw+TMBsKnid
        uPBs9UHecmDJGJAEJT3IprKsze7cFkCYoas6U+noMGmwbAWxDg==
X-Google-Smtp-Source: ABdhPJwpiRMEHptDkWxRYKi7J+MHnmVxz9p/SfaITmzRUMrOT4EeKLdDYS6q3yW9oBcmMHBgwhxHCH0/mGyiYVXEOv4=
X-Received: by 2002:a1c:1902:: with SMTP id 2mr5114867wmz.26.1600263376685;
 Wed, 16 Sep 2020 06:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200916124931.1254990-1-kpsingh@chromium.org>
In-Reply-To: <20200916124931.1254990-1-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 15:36:06 +0200
Message-ID: <CACYkzJ45nu=WZeQ0uwL+QxsCxhgkvSmXtme08q60GG_M0rzW8A@mail.gmail.com>
Subject: Re: [PATCH v2] ima: Fix NULL pointer dereference in ima_file_hash
To:     Linux Security Module list <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 16, 2020 at 2:49 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>

[...]

Another attempt to get this on the lists.

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8a91711ca79b..4c86cd4eece0 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>                 return -EOPNOTSUPP;
>
>         mutex_lock(&iint->mutex);
> +
> +       /*
> +        * ima_file_hash can be called when ima_collect_measurement has still
> +        * not been called, we might not always have a hash.
> +        */
> +       if (!iint->ima_hash) {
> +               mutex_unlock(&iint->mutex);
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (buf) {
>                 size_t copied_size;
>
> --
> 2.28.0.526.ge36021eeef-goog
>
