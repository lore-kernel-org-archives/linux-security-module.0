Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5792C32771
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 22:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIZWlg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIZWle (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 18:41:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5F9413F
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 15:41:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j188so10107562oih.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tz2cEwqQBI5KOid9Ym3jdh1CtIss2mqT+yeVpI5D5SM=;
        b=5WMM3Qo+EagYcdk/4XzPR7M1Nkp26RLOWPb1x61inBt4ynUprqDGH/n2uKScMC+AV0
         EcFTOsJ5mdWcraZ1soCsfLi7zx5w0vD/VBx5UsNCU5hsv98jWYpXFxAnSq162zbHwfMx
         iqLiAf99fvx4Bmp4Z2Bt3Tz4f+c4u0SJditYcS0saNoVVvvEDIiw4VAuTOXVoOpURqDs
         l5S/Xz9djK88fduZ+aQgRsHpuZF3xxnJwOqhpcVPGQ3n7OUFOqtY0lcurwbzfVsrLbco
         vxExn+Zqc/jBXo9VBrKMIPYnRCffnj/oBxm1X3GS0LIglmabtIgcE8YOTyR+w1dDwro1
         YTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tz2cEwqQBI5KOid9Ym3jdh1CtIss2mqT+yeVpI5D5SM=;
        b=qxfHh6QgLglNgs3GO+0TtEh7olxJXY5xJ+Bcxw++GeQgGzXPltfechtuRuzcmLbjeO
         ABql408rTfLGkdaBH7VaAh4iKyH2YYJ59QdY2jqz/ltp9dAp1Lx82hmIGDQljg5DJOA5
         XNPuaByzxUxQe/CGUlqvuO9sF05qrY2L73Baig9kLQT+szWrD55Ka8IeeuLJJ7ZBpqGs
         gUbAxNg//OJQnvYGinBWPNr399ubBs+wLGgSY3St7SiRKU5AFG8xZu4+G3ognE/qPsD2
         +Pmn1LF0ApZYAam4H/bvQUc0RHtME12YL+R/af2ufCRrr31YnXa+L49GIECLStFFOD86
         k+lQ==
X-Gm-Message-State: ACrzQf0NjPS9b1c9fEkkvUtLv7ukXGMRtV3sEsYizJx6JKm+tioptSZW
        7RA74ilEq6+3j+c1cGWdm6CwuB4GVl/amOPCZxIm
X-Google-Smtp-Source: AMsMyM4w8nRvJwif6MuQV1Y60DIJ5t08oIJfRG7hIO1WM7+Mw7vUvSGUBu9AGMzwflSnF4bjdKW2wOh01hwIbLeR7Ws=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr488080oiv.51.1664232092411; Mon, 26 Sep
 2022 15:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220926131643.146502-1-nathanl@linux.ibm.com> <20220926131643.146502-3-nathanl@linux.ibm.com>
In-Reply-To: <20220926131643.146502-3-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 18:41:21 -0400
Message-ID: <CAHC9VhS9kJ4aEp_Y_imcsj_0JOn523Au=ct6uQEPjNDVVjYxVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/rtas: block error injection when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 26, 2022 at 9:18 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The error injection facility on pseries VMs allows corruption of
> arbitrary guest memory, potentially enabling a sufficiently privileged
> user to disable lockdown or perform other modifications of the running
> kernel via the rtas syscall.
>
> Block the PAPR error injection facility from being opened or called
> when locked down.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
>  include/linux/security.h   |  1 +
>  security/security.c        |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)

The lockdown changes are trivial, but they look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

-- 
paul-moore.com
