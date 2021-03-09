Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F2FC433E9
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 09:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A1865149
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 09:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhCIJKt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCIJKV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 04:10:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E6C061761
        for <linux-security-module@vger.kernel.org>; Tue,  9 Mar 2021 01:10:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k9so25795831lfo.12
        for <linux-security-module@vger.kernel.org>; Tue, 09 Mar 2021 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKD+yQjGrl7OUNRHRyxFsQZJDZyYo41ddQeYWHD+EP0=;
        b=HTohe6xlqSsa9ysdqGaDx/LKiLgeY77hqdlLI5nZOMc7bJyltab5PD7dPzX7NKciVI
         CiR0s2nUBmoC8xS7Fx4FxibTJ6bZfsYvhj45Fgg3+IADOfkL5vNu6q4PmCDEYnN4eGiW
         MVh2GdGnAqFUnHDgWXCDI/GUauwAnCR8CqsK+Y5A1lu3sqYOd1P63aWs0Sw6kQRAlQ/J
         sWj1qF4z5PALe45obJIuGKem1TrGlbvLr2Lvd6d2kEnUqnjaIjdQeR3PBK9qMETa/XGv
         w1WiD1gwAN6H+FW6uZfkVLEnlnB+w9D61pMvCAVVj5ZrgusV7trTi5Pt3J0lrw8Igz5m
         MzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKD+yQjGrl7OUNRHRyxFsQZJDZyYo41ddQeYWHD+EP0=;
        b=MzB868YtfDI+hjC+V4sq67ppOFh6yyLn4C8rfnFiNBBauvJphsplDgOPfN0uFQNsNu
         Ra/kAmpJB3oFhMOgRv3p6uZ088H0HanydD3XNH5WPEUGJ6C1Klhy9/ZIpPSHHBZUpjKV
         +yIETQxatcRCUUcn3Sq2WAC7wPW5J3nIYfF93YneITB/artQx/gg246/JOizucRI+Xiv
         MTyamJQOhONI+Y45igmJC9yc3yYZti6aJcxY35ihqmtgzs2UGr+FmgnZcN72W2+FDEOj
         cLnzXNSpH6wrBWVowaaM2Ut58aLKyfVEfshGIqlNd129d54Nx7lmzeZwMhrY58hvlOTv
         IVZw==
X-Gm-Message-State: AOAM532rZ49l9arBcgiO9Ps2XlzH+Z0teYaZc4wgz7mgvVb745uqqi2p
        VI8RDyfxCGfjPsN8MtuyHk9HKi6PbxCmfCpJtdie5w==
X-Google-Smtp-Source: ABdhPJwsYPinGD4rPMc2OYJcBuXtSZFtl07YktW+xNb1utv1lOShAxTn8gj6iLPahmv3R1yl8oBj1yKfBXITAAXQeCU=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr16853964lfo.396.1615281018970;
 Tue, 09 Mar 2021 01:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20210301131127.793707-1-sumit.garg@linaro.org>
 <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com> <YEEANW+khw3nJtcQ@kernel.org>
In-Reply-To: <YEEANW+khw3nJtcQ@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 9 Mar 2021 14:40:07 +0530
Message-ID: <CAFA6WYOxsYin8wBB_yU=S-bnqM-g5TFnTU_KXxc3wSBfx_N_6A@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 4 Mar 2021 at 21:14, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Mar 04, 2021 at 03:30:18PM +0530, Sumit Garg wrote:
> > Hi Jarkko,
> >
> > On Mon, 1 Mar 2021 at 18:41, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This patch-set has been tested with OP-TEE based early TA which is already
> > > merged in upstream [1].
> > >
> > > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b
> > >
> > > Changes in v9:
> > > 1. Rebased to latest tpmdd/master.
> > > 2. Defined pr_fmt() and removed redundant tags.
> > > 3. Patch #2: incorporated misc. comments.
> > > 4. Patch #3: incorporated doc changes from Elaine and misc. comments
> > >    from Randy.
> > > 5. Patch #4: reverted to separate maintainer entry as per request from
> > >    Jarkko.
> > > 6. Added Jarkko's Tested-by: tag on patch #2.
> >
> > It looks like we don't have any further comments on this patch-set. So
> > would you be able to pick up this patch-set?
>
> I'm cool with that - I can pick this for 5.13.
>

Thanks.

-Sumit

> /Jarkko
