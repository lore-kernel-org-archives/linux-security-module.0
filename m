Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B3ECAAD3
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Sep 2022 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiIIOIM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIIOHf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Sep 2022 10:07:35 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B961103065
        for <linux-security-module@vger.kernel.org>; Fri,  9 Sep 2022 07:05:42 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127f5411b9cso4150958fac.4
        for <linux-security-module@vger.kernel.org>; Fri, 09 Sep 2022 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I6ADPzEiooQjq05+LtdvGJfr2nP2w0nBmCIYS00kkYc=;
        b=kUgpmFBISpZIoFjqAY4L2SPWwEpbSIUzkb62MRHQ2x64jn9IBodtg7iSYSCxQkZoaj
         xA5Xnpzd6TrRT7DBmBJAhaTM0vcLKJ8IlKpD/PJq1qT4YniqkUm0nU4NWnH8Iq/fe2NI
         Y0rstic3BlGoJphrtBmAUeBwfH50iabgOVFlNU49j+BnToMuYiXuzXxN4HDAOMsT4Vj9
         7ZLeq38bqo/1Yx1QVFCZpyXNm2Rj2YGb+ZuW+/gz0r4uDxazaYExHCjXH48NPDJJzYTr
         17teuZV5PvfIa6//QADbabH+fbrAbj7wnpfCXQRwRFD7s7RjPSxLZHbCLf2DBkswR9Uu
         yzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I6ADPzEiooQjq05+LtdvGJfr2nP2w0nBmCIYS00kkYc=;
        b=7w1VkXNtiAfsMxcRI7ydOCAwIlZH3x/h7GmcnmAa4GSDpP2bjZtmzwrrABfnwkeiSN
         QOztNem/IotRI6ZsK9WyXpCq7p8XhVqddOvRDrw3+BI2RtU9VQkmG3TNcN1SO1D4G3Qd
         pZNdmXbgCu/iiB5bHyv5g2g8AgbhaVzg0ihP/HPNSwSy9BnJVVZ7s8Wd19qx564RIxpv
         T2UkrJyOTDF6xhqjSCt5Xs2mg7MbEDFZKP8c84bX5Aj71EFpaW56kjvubqYtZazSFzmj
         Jp1oypqj7rS2tvwc9D8cGEC1IXcm2BpbJQbIMqWtxuR2T15sqwqpoix4/L3QeHNuLaBU
         cm+A==
X-Gm-Message-State: ACgBeo3oppNPsifJZ7r7H9GsWJzz/qflqlYjKMnDAM70qwbaDzfU2r/V
        H/K3Swgno5k7w/vG+baCGzTrgw8cQiLbnFkUBeDJ5Ohi/g==
X-Google-Smtp-Source: AA6agR53AZ40atMarXdqAH5ACA3XpzH6OGafmmoN3e93leai1NOximUNW9oVLsBDAl8qK85HlaUVw0Z7WKHbR8hIXxw=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr5130175oap.136.1662732341451; Fri, 09
 Sep 2022 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220908220222.267255-1-nathanl@linux.ibm.com>
In-Reply-To: <20220908220222.267255-1-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Sep 2022 10:05:30 -0400
Message-ID: <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
Subject: Re: [PATCH] lockdown: ratelimit denial messages
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 8, 2022 at 6:02 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> User space can flood the log with lockdown denial messages:
>
> [  662.555584] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.563237] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.571134] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.578668] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.586021] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.593398] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
>
> Ratelimiting these shouldn't meaningfully degrade the quality of the
> information logged.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems reasonable.  While the last visible lockdown message to the
console might be incorrect/old, I think it would give the user a good
indication that lockdown is being hit and hopefully preserve the start
of the denial storm.  It is also worth noting that this does introduce
a spinlock to this code path, but since it is only an issue on error I
doubt it will have any significant impact.

I'll leave this until next week to give people a chance to
comment/object, but if there are no further comments I'll plan on
merging this into lsm/next.

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 87cbdc64d272..a79b985e917e 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -63,7 +63,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
>
>         if (kernel_locked_down >= what) {
>                 if (lockdown_reasons[what])
> -                       pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> +                       pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>                                   current->comm, lockdown_reasons[what]);
>                 return -EPERM;
>         }
> --
> 2.37.1

-- 
paul-moore.com
