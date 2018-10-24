Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A7C004D3
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBAB207DD
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBSaw3I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBAB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJXTQv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:16:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37460 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeJXTQu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 15:16:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4-v6so4308587lja.4
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=gBSaw3I7jd1fjqCzFEJsk8Mqy5gaVU9+uJD6jxVsIXdQcyE4Ihc5eV6NJTF4is7xjT
         OjcSjwQLwU8Ieug4JML6Z5isEHZFFv2dKfbvPmJ599/Ob+7Gq10PuuKCm7R6+qBp0q+q
         6ayotGuv7IVj35Te+FuIHehp/sTrE3WYPdnao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=rdHPjTxXHzqP7Dgqbb5v0Yb2lt2fXfCczoc41yK/VZkdIuYzmXisBPv3oDUxdPo9pS
         Yyu4oq2TQbcyLL5TvFEWBpq563hp4CoQLpTiKPc8HS+zNuHDtF1Vv9/lbGhiiMkVDpGM
         RepJsxQet7DJxQ5F1F3WMzLKncSDgP+Nie3C2rkQWlNGsdbhJw5fAhw9LwWEYFymhAMh
         n+QvIK64PlGC4Z8tqXu1bj2W55ryI9NjkEAAs5MmEE1jg9Y8TI4oxZspme+pSczTu9M/
         zzL+ZGNlDcMlBb4+ToIUvr+e5iwd/x5+JUsCLBdXnIO40ouVGcQxKybU1HClYSIQCRu9
         GUUg==
X-Gm-Message-State: AGRZ1gJWaPZTUe1n2fjcdhevUOi4OYHB3ecXm7eyN7C1hNwhs3CcS3xL
        KYB1g6+dQtr2lxxrPRMiGKE6hcYjHSyGm7hs
X-Google-Smtp-Source: AJdET5ezsHkSLYqbbwRsvHcOvqKHo810uGeA7TKMT3PiWeEqV7AGvwsd3RnHLKFmx3tBusLo1bdcjA==
X-Received: by 2002:a2e:29a:: with SMTP id y26-v6mr1405252lje.62.1540378152295;
        Wed, 24 Oct 2018 03:49:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y9-v6sm599350ljk.35.2018.10.24.03.49.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v6-v6so4288614ljc.11
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr1423488ljh.118.1540378150673;
 Wed, 24 Oct 2018 03:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
In-Reply-To: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:48:54 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.20
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 23, 2018 at 1:55 AM Paul Moore <paul@paul-moore.com> wrote:
>
> Three SELinux patches for v4.20, all fall under the bug-fix or
> behave-better category, which is good.  All three have pretty good
> descriptions too, which is even better.  Please merge this for v4.20.

Pulled,

               Linus
