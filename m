Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F3C00140
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Aug 2022 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiHBWLt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiHBWLj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D432DBB
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 15:11:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so19253682edd.9
        for <linux-security-module@vger.kernel.org>; Tue, 02 Aug 2022 15:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k6pIxoS6xr69cL31tnJGd/edjv23VUk7urmVJKHeHw8=;
        b=FwrSh8M2yilbskdsO4gXxUoC2Ed+FeryminZgruVH00UecbUpXqRgNsVHrZfOtz6xc
         ib05vYtYPKWhkIqV87INC126FLDR+3Wl/KgQ7OB87pUtFbUh3h4sX0GHaJUVqmIocbuN
         5gXLQkyeN80KnkVUepMPBUS/nqR8X4BXEHwZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k6pIxoS6xr69cL31tnJGd/edjv23VUk7urmVJKHeHw8=;
        b=ZWaWuWLPR/q960E+7s7pUjN1Ba8O7vA0N/5mCcJinXYFxiHUEHYKjWqOGJdE4qX3Qu
         vBYQuUuCN6IG9xyb46i7J/sYl2AseQWRc/Teb17QxDMpmcqEI1ZkzAJZoMhX7ni3Osp4
         JJADYmDead9hyW4907hEkByV1K5MI/StmHv0RTUbfGJXwIngWfKA5KtZ74yzjWXUqNhv
         10+X0IbTpEgAe82QioSNlRpdtOjNjJfkcP5LhGwXXcWsW2LCdrjvX+zzTEdfUL0MTbEd
         dvH5/unRyGaD8DHFV3ASlcwHX3ke0CCfckjdiJPJYAuz0jhkaTBxVGEud7lzd0szZFqg
         rubw==
X-Gm-Message-State: ACgBeo0e7ua7By+3VrJEw1DaqLEJCsyotQNHe0yk1DqcDxipR0HyHS9W
        +3jH8lHHEe669gN9sSJJFT0WjWybHROIPVhG
X-Google-Smtp-Source: AA6agR6Pw51t+Ehto9QWHVHITizbGU6L8LDW2/IoBFWCzlGboemRaF8h1D9/TmA8LZvSbxmbFHL+nQ==
X-Received: by 2002:a05:6402:190d:b0:43d:f64f:9a0e with SMTP id e13-20020a056402190d00b0043df64f9a0emr4974297edz.346.1659478296041;
        Tue, 02 Aug 2022 15:11:36 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b0043cf2e0ce1csm8709202edx.48.2022.08.02.15.11.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n185so7835069wmn.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr843858wmj.68.1659478294886; Tue, 02 Aug
 2022 15:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <827a0fe0-03a3-b5ca-db34-daff17095b8f.ref@schaufler-ca.com> <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
In-Reply-To: <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:11:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsM9cUHfmGMcco5zCuBqMpM-97hBkBX5_vzoRLm5SvJw@mail.gmail.com>
Message-ID: <CAHk-=wjsM9cUHfmGMcco5zCuBqMpM-97hBkBX5_vzoRLm5SvJw@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v6.0
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 1, 2022 at 1:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> There are two minor code clean-ups. One removes a touch of
> dead code and the other replaces an instance of kzalloc + strncpy
> with kstrndup.

Hmm. That second one looks like it really should have just used
"kmemdup()" (and a zero termination) instead, since it has already
done all the string length calculations.

Oh well. I guess the strndup() works too, but it seems kind of odd to
do a strnlen() there when you have literally limited 'len' to smaller
than the string you are going to duplicate.

                   Linus
