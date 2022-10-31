Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D32FA3741
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Oct 2022 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJaTWu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaTWs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Oct 2022 15:22:48 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB313D05
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 12:22:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id e15so4139857qts.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sciERuMLNoW/sQvWoRQ/tsCXdcXQIXsZ9vYLgBntz0s=;
        b=PRwNE+r/CecIAk6SsdRE0zAYb5VIWHJOUdwJPZGYrHEikyM2x2cWKL19AfuzpMpYah
         tvlSiLkCpXdKtms6gHrNBQS3dYEs6kJ08xwGpB/o8ZOi2aV7agzVKttckPIAWWGIJsIt
         eMEEyEXkV3CMMjMCzuTbtiXbV2AAF8rr0FpW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sciERuMLNoW/sQvWoRQ/tsCXdcXQIXsZ9vYLgBntz0s=;
        b=wAOhgK0BfoM9TpmNPW5jktw8lXN8UvV0ROurIQ3MjzwblYFcEi2vUWrHBKj4TiharC
         57ZLEbQDVBL475u3cAywG6fqSvUNgFmaT9obF016dBKl3J2bAl/wH/6T2QUDffPPkAYQ
         fGEblEXThu4neT6yDOROtj0cnbjVlG6pP2b7Ac5IY2gXGI2fIH6oZw2zoQDFa3zsJz9t
         /tiapZWXyz+I1f6rXosZzWMyQP+VRH2X88EJJmjuzqRauWucxf1QUXNHFfU/QO5T0RPP
         XLidBmCRsPx0V6fYG5HYezXuCyNGAQxZYNmbGRHheLOS2Ya/0zd0ZoWuvJmv2EazAvht
         tGuw==
X-Gm-Message-State: ACrzQf0Ss7XQ9Js0/0o6+qEPfbqi5Xt2Yz3lmJEMTSnjTpvJ6dnKEIeh
        Ae2L+yX0A5AV+jcKvKt/N7oaKq0yiWDarQ==
X-Google-Smtp-Source: AMsMyM4MAtovuC22Lc/Zwndx3KTKvHM7/AmCQEYVBOgBxGwGpS1LfDdR+WaGA4AWrovYfgMoArQanQ==
X-Received: by 2002:a05:622a:147:b0:39c:dc0d:7d0f with SMTP id v7-20020a05622a014700b0039cdc0d7d0fmr11818473qtw.281.1667244166935;
        Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ga19-20020a05622a591300b003a5172220dbsm3890044qtb.8.2022.10.31.12.22.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3691e040abaso117154407b3.9
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr15021131ywr.58.1667244165839; Mon, 31
 Oct 2022 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 12:22:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
Message-ID: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
>
> A single patch to the capabilities code to fix a potential memory leak
> in the xattr allocation error handling.  Please apply for v6.1-rcX.

Pulled.

However, I react to the strange test condition. Sure, it's
pre-existing, but does it really make sense?

It does

+       if (ret < 0 || !tmpbuf) {
+               size = ret;
+               goto out_free;
+       }

and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?

I think that's not only impossible in the first place, but if it *was*
possible, then that

                size = ret;
               goto out_free;

would be wrong, because this function would return success even if it
wasn't successful.

That whole "cast to int, and then cast back to size_t" also smells of
some serious confusion in the return value handling. It looks to me
like vfs_getxattr_alloc() fundamentally returns an 'int', not a
'ssize_t', just by looking at the ->get function. But it just all
looks weird.

So this code has all kinds of oddities.

               Linus
