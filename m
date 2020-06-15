Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00442C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3E320739
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMwR/d96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgFONdv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgFONdu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 09:33:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C16C061A0E;
        Mon, 15 Jun 2020 06:33:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g5so13094323otg.6;
        Mon, 15 Jun 2020 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqmttIKDv0CjLA+NO+HgmwFUY3hsIX4ea9REGpMDxTM=;
        b=sMwR/d96SkC8pPPjhsxJCmWF490809kPW2Tgd0DAqdk0yhj0iosebr7yKJhVJ4jYo8
         Pi7smhYVMepAT6rBbXSY3A3WCmyBcwCZGX6sr3pnP7looBEBq7gI3biTwrbRYLyZzgRn
         ZPC/UqifZldp29cfHa/I2vlDc/U07ndI37ZMxsT5mCMgYDDUg1FPvlX2Oyi43fnI6eXz
         dfDA6jzn27vDNnSRXoaBzvA0V4/EVPpipEKB/X3gsE5fnqmtTtAoHd0Lgi/UlG1+Jpak
         VMpk5YmiHW8PgUI5coQBoAmTkF+5OozDvCYFf60zTnnhZxGuxos8p8+mBNU1lY3AEy7g
         l99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqmttIKDv0CjLA+NO+HgmwFUY3hsIX4ea9REGpMDxTM=;
        b=N6IAAo2BmTB87Ii6C2IPAXTrdCFGyJhhTHtyV8srkcjxY/XFLfWlb51N69LdBf9mUU
         Bh/zanogLbYGipljKnd7m1f2nyDM680e7XKS9knrMRMGKeYoEj2t1iYnxu0UpJUHiBaz
         HxRnvk+frYXxdK9DHNGk9s+6WqauXbNUqeJFGgxCyfHmaGM0Q2076T1z8rUGRW0MWMaf
         au2hUbs4pvCvrl9+UQrcZBLTF/zVy9AY4g0KxttABX8IfSB00wNAvHxm+dkF7JAi0wDY
         FmGJ9HpAcyfCYmVYA2C5PDg8MphkDfYS0PIz8lDtqb+FgINYsxJPynryYCLX4ZEM7HVj
         Fh0A==
X-Gm-Message-State: AOAM533v9jR3QsobmuWFkHX7Hp3nVYPI7e85Bf3vWCHWzkwRaqHOx8vb
        jHsQI9j9qNk5dZxn1Xvx6a2BIDxnlw3sVONyoQI=
X-Google-Smtp-Source: ABdhPJxXDP3gox9eDujaSteeOhmnftxfu9fMErF+5NLIINlVuLstQB9q2UdduCCvhxJnaxIbX9TEDRSUj0UCqYE1WV8=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr20375240otp.89.1592228029199;
 Mon, 15 Jun 2020 06:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200613024130.3356-1-nramas@linux.microsoft.com> <20200613024130.3356-6-nramas@linux.microsoft.com>
In-Reply-To: <20200613024130.3356-6-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 09:33:38 -0400
Message-ID: <CAEjxPJ7v5Lu-vzqg0ZVh8zJ9uZ=odN3jt_5+9d9x+RydsNWK0g@mail.gmail.com>
Subject: Re: [PATCH 5/5] LSM: Define workqueue for measuring security module state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 12, 2020 at 10:42 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> The data maintained by the security modules could be tampered with by
> malware. The LSM needs to periodically query the state of
> the security modules and measure the data when the state is changed.
>
> Define a workqueue for handling this periodic query and measurement.

Won't this make it difficult/impossible to predict the IMA PCR value?
Unless I missed it, you are going to end up measuring every N minutes
even if there was no change and therefore constantly be extending the
PCR.  That will break attestation or sealing against the IMA PCR.
