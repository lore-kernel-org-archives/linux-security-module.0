Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB23C07E9D
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIZVlP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIZVlK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 17:41:10 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB578BF6
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 14:41:08 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13122bfaea6so5950049fac.11
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W2AVF3IGelKGE+O6YLBHQ8tWi3g6mJkr5cv6X06x/ZQ=;
        b=6aXsPvMgfNuAhY7nf4b80qGVj30jS3GN6+kmYE+l8WxLNcXR0qp33I83B4i24lv7Fz
         mUUQ8a6tkxU788DVvVkmhUJ2hqB4SPAzLK/8pE9gGoOnaU+75R9aqgoeC7Onb4f7xaIG
         DeN9SK35Ar0bw5QWVTp7vSSOttU9an6n36B530xOwM6/seUd4yRpb/0NhSj4VFDC43b6
         KMRYUIn8Z5L/TChWIX4ob6oko2AtJSGrFkPNFp5uT0kFz7QLMZ7qbFy+kXjNeQxWZb49
         BOXd4tOe68TFTsHEZSuoMegqO829r9Cs+QjWPP2GVHRsCHM6h820rDPguTQtIgGfuDMp
         KTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W2AVF3IGelKGE+O6YLBHQ8tWi3g6mJkr5cv6X06x/ZQ=;
        b=gjIj3tCgiggKEfijO68WdohkFKwQau/50TW2r/tFVNAtPV2HVKfwE1ik9QK43sfG+H
         wO78dgZaRE2kSPrytV8OsyMz0yA/6lo6KswfeGppAr+O1jg840qvxcYg6QrIqYX3jY6k
         XZeo+R5tV0lI6h4DR0DE4H1NUmCzgqFJlutsTAhv7K3mjf1UzuFpc0qCU2+hnY7iKALV
         QWDeJoHwMjvLlRQ9+VSvKtmCgQOlR/0P2LLXyerb6WC+tFE7ZhSFF5LO1+WQwm1HzSET
         jvXoXGkamo6qhq0sej3ysrWWnMOqe1lINwJSymxvFBRrHjJ0CrPjwaknks+vI43Vzf2g
         UdTA==
X-Gm-Message-State: ACrzQf3qzpwlYo5ppAmBVkaGeHpHUHdYCGHiuee6ZnnRkmwwvkSTVHCY
        o/DgehqW9cFIkn+Qf5XzDUq/Hi/cWyvNMrbWy7Bj1WehwQ==
X-Google-Smtp-Source: AMsMyM5ddqL9vX0pfl5XNLm2esVeK5dvvP3xtrKw8QvdMX76AdtU9zEfdzazGl5PnsTx/WOg+bWyeV8Du22Q5xvJt2g=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr441021oaa.172.1664228468189; Mon, 26
 Sep 2022 14:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
In-Reply-To: <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 17:40:57 -0400
Message-ID: <CAHC9VhTGDJjFm-3abKtXia-k5jyz7ngV+ZcUkof-=Vt1toLyBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 26, 2022 at 2:03 PM Jeff Xu <jeffxu@chromium.org> wrote:
> Thanks for details about the unconfined_t domain, this is one option.
>
> IMHO: between permissive domain + audit log and unconfined_t, there might
> be room for letting each permissive domain decide its own audit logging
> strategy. The reasons are ...

I'm sorry, but I don't want to support a permissive mode that doesn't
generate denial records in the upstream kernel at this point in time.

-- 
paul-moore.com
