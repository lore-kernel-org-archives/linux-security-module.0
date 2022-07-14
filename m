Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F3C43334
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 02:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiGNCeP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jul 2022 22:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiGNCeO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jul 2022 22:34:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2124960
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 19:34:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i204-20020a1c3bd5000000b003a2fa488efdso1969042wma.4
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 19:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3TrDmoW9oBN2ZfcS9931eEvANmE2rrBTqfquIYx58Q=;
        b=DXcK0Aum+xKmbAuTwl+9oNeJFU+tW5NF1N3L7fYgw76YX4A0B15FmGo5dgqQd1/OAK
         i3vj8TFtn2P7EaMRkYYjhBlbubxDOma6XzCHiQaVXZKP6c216oZ+o0c3dl019+Onh4OT
         jbsMq031SNd+eGysp55kpYxeaILouGSIhN9v2hfJJFOdUxAU1g7AT+FRQyshLskKuCO/
         2yZ3gHeQ8FCoiMDAGTPFIflefBZENjYE/OYylHqE/sfMRJuxj0DBTSpk0QtB0w82Rkzl
         f72ZDN7Na0ZgVQVCnVOWqwXlWcYJMytQZetRnlUsBPZgatSwaA2SWwTHOvH4d4ctX3hU
         aqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3TrDmoW9oBN2ZfcS9931eEvANmE2rrBTqfquIYx58Q=;
        b=czdchOWP7+OF7zjsXIBV8vC2fMFAQCVeN3nZu76KNOe9CqjOb4tHuXHDd0qDvhxKEl
         b9rskX6gtzUonzVrrWJHvD3a++yIu4ax85sgyZRwDyHuDEQVRpYUSn3kuMfGY5UJh5yI
         McrAEkxJPzJPRpbOzODkq9LSX5rkPbKJkySXp9MP8x1Vm/SznjZevaIvZ5YbO6GUu7s5
         vaih1EtNezXu10JJZSOwmdhdzWldpj13MkRlEjwxrvwNsX6fVT9puwRdyKS7uCw03ctB
         xpQOFsuchSYF/fyZr5Voz5Ym/Jbyi7JxVKR4v7JRjHssBzvo3+g2GPf2oFmWi8coYPo0
         TpmA==
X-Gm-Message-State: AJIora8udxql+8YHmmCCU59GkvsW+zJH1Bd9sQfz0KP1Ai05HtRQyaMh
        KTf+y3Q5E7cxuViBtfJF1V1tBBcnRCCgtV7hUAfV
X-Google-Smtp-Source: AGRyM1tDKJim+CxDW2bY+R0tUKURKfcZpGwJ5c5Rtrh4kviPSM9+GSsLBHW6KJ8aQVCDtLlWxtDW8900w0celVYD+W8=
X-Received: by 2002:a05:600c:4f95:b0:3a2:e2af:2090 with SMTP id
 n21-20020a05600c4f9500b003a2e2af2090mr6697106wmq.158.1657766050246; Wed, 13
 Jul 2022 19:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220714012421.55627-1-xiujianfeng@huawei.com>
In-Reply-To: <20220714012421.55627-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jul 2022 22:33:59 -0400
Message-ID: <CAHC9VhRM8_Eo9rCL88LLgY7e=soKpSSRK2Zftt9e24GC3A_yMQ@mail.gmail.com>
Subject: Re: [PATCH RESEND -next] lsm_audit: Clean up redundant NULL pointer check
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 13, 2022 at 9:27 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
> they will never return NULL, and elsewhere users don't do the check
> as well, so remove the check here.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/lsm_audit.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Hi Xiu Jianfeng,

We just changed LSM maintainers earlier this week, and while I haven't
forgotten about your patch (I reviewed it previously), it is too late
in this current release cycle (-rc6) to merge non-critical fixes.
This would go into the LSM tree after the upcoming merge window.

Thank you for your patience and understanding.

-- 
paul-moore.com
