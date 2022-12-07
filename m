Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E85EC3A5A7
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Dec 2022 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGAWE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGAWE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:04 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768143ADA
        for <linux-security-module@vger.kernel.org>; Tue,  6 Dec 2022 16:22:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so15541424pld.7
        for <linux-security-module@vger.kernel.org>; Tue, 06 Dec 2022 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=edSzeXolpnKR8kADHnUK5zDys8w7c/jQPn2qCC6ekRSfaXbFtqBwv0XoZxBORA0zTl
         ChqrF6t4xh14HtTCdCUDCNhISCwfi/5unLVxR43QJ9F4+06QN81+fejH9KA76DnF/GcK
         SiQk4RONCboetv53VudXNWYOI9arbADgrCvt1c/z0xcGdj9k7pyXNFrWlMW9ICDAaOey
         otqVF9lR2b5yofFVCsI10JLo3NZU9eqHGlbKkUsvFpHBHXpuvKWVAl6ipTmhgIgp336s
         0G+bm6I69oD22pqtkxqRrnnBcnYLrrlrc7WAm0MqWDyxEbOfQgALUIRQtRyh4v3ucelw
         HZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=xJ3hfcC0OQGliW4zqSWOKQKNAMlmxjg6/KbzqsSs3aprwEauUXkhF+aFx0/bvAKHho
         yR3QMFiHi1tbocID3S7Sin2tm5vhAkXITWPMjv8IiyTYPneKpVYb6Tvllt4CceF5Q0Zj
         x2MwoEh7d2swU0iEWgXjdAUUeICWmcCRF3I3tTXOLDAarj4ug//IHTvMJpoIwhe5JTXY
         pzXTEUZM4fqlnJt76uuXzNck6twW9DfR/azP0U4yoZN0aSYyfnvRv2PMGDgM1Ve3drRK
         He7J9mAZNysSiDduT8MtV8lYRwXi8m22Sd8O69r0kx5tZkD3rPQ6pwxRi/K3NXlMz0TW
         xFMA==
X-Gm-Message-State: ANoB5pmFDgkdt3NY6arqoIkHPjH1g78UQRuSE7gIxJ+zlP8LELgtKjRN
        cZ6MOlr0yaj5CotOsgxdaq+JdsssWqoFTIasQ7kKbhwumyOy
X-Google-Smtp-Source: AA0mqf6cvEPgX23p93rWiv3bSVkuS1vJ7qoNkXPGDUutb2voDjMTIY23GZ6EZ4OWKfWGlLTZ9MT0ToagGrwU5HpQmL0=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr73317153plp.15.1670372522573; Tue, 06
 Dec 2022 16:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com> <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 19:21:50 -0500
Message-ID: <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Ensure that for non-void LSM hooks there is a description of the return
> values.
>
> Also, replace spaces with tab for indentation, remove empty lines between
> the hook description and the list of parameters, adjust semicolons and add
> the period at the end of the parameter description.
>
> Finally, move the description of gfp parameter of the
> xfrm_policy_alloc_security hook together with the others.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
>  1 file changed, 138 insertions(+), 83 deletions(-)

Thanks Roberto, I've merged this into lsm/next with one small tweak (below).

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c35e260efd8c..6502a1bea93a 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -677,7 +695,7 @@
>   *     indicates which of the set*uid system calls invoked this hook.  If
>   *     @new is the set of credentials that will be installed.  Modifications
>   *     should be made to this rather than to @current->cred.
> - *     @old is the set of credentials that are being replaces
> + *     @old is the set of credentials that are being replaces.

Might as well change "replaces" to "replaced".  I'll go ahead and fix
that up during the merge.

-- 
paul-moore.com
