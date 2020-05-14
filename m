Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCADC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 11:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97B0207DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQB8AjMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgENLXt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENLXt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 07:23:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC15C061A0E
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2020 04:23:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so1556908lfd.7
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2020 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52Rzrrj4E2al2tTGlHFyR6M/8l4BjJi9pTbsEHvkafw=;
        b=AQB8AjMyAZSGOL4e97UU90oVl9kAMguV5p4dTDDqcw0/yek+GT5FWuN2tscAVlKFEs
         EGzg8HjoW6dtHzhFbCevirz+96qH21ZW9fHpy2kzigcrKVJlygWbNXwPaiOUs6uFh063
         aPAdVZthuA7Y6Oqs1VLm4MDl2Ymqdb56dcWwjCBZ0og7DZpzl8xsqkqa05M1swjos7Gz
         BvCnthOJZ3OAhbZMPq0iz6CbKdHXINgpBnT6TT6KscyzM/JwxVG6ZXzKdHQmih4z9i43
         mHHs4GZHjvk6LTACjAngtXARfd2tJBCvG7KpSeW1akMKIkbng2rYc0JDaLTV5N6BoPB4
         oObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52Rzrrj4E2al2tTGlHFyR6M/8l4BjJi9pTbsEHvkafw=;
        b=rS3gdbq5/HrhOsiRb4Ff0sTxPiY1c9H+fF99q5foDtndt61a6/6f3eUsHA8J8xne7m
         xhGSVyYaRYV/pK1c129u7iAAZkQbIPZ5XB8JaRdr61cD254sYqGSrswJkCyYRL7cmOFj
         WdtxrUCtHzn1AvC6TOA0+whU+4YBPOF76j3OcTessCmFXqTfGBt7+otbhS3npSmc04U0
         WH+uMpxExTYOwB9LCiQ+R6dXD07hnJL9MYbOZ+aYJY8NwEFOscq2Szx3DBHXE4fQ672B
         0t8cEUqI+1LRA/TAzCwQKQ2LMeQu+SeEpOXwKhboePuMQNIXCtHQyyFmuudULHrhDbXG
         eQWQ==
X-Gm-Message-State: AOAM531xIK70OpzeuBmJvskeOj9hDQmVnJ+f1ZW1tNZ9nEdCnXTXpykG
        tu2/szCoKd0r05NyV2xGGfEiX5mA+qELsWH1ny2qDA==
X-Google-Smtp-Source: ABdhPJyJHVIeFpsuP6hWyR4T3t3i5l95UvM1ck7qhqVExGI1lWc37GndFTYXCpQQGciey+GLFpqutzOT/FYhOL3syjg=
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr3095483lfm.40.1589455425658;
 Thu, 14 May 2020 04:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org> <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
In-Reply-To: <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 14 May 2020 16:53:34 +0530
Message-ID: <CAFA6WYMciZ=qkG3N_9YWzt_DJr2dGwdAy9diMXCJSNjr2o5ONA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 14 May 2020 at 05:55, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > support in case platform doesn't posses a TPM device.
> >
> > So this patch tries to add generic trusted keys framework where underlying
> > implemtations like TPM, TEE etc. could be easily plugged-in.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I tend to agree how this is implemented and could merge it as such.
>
> I'm just thinking if we could refine this patch in a way that instead of
> copying TRUSTED_DEBUG macro we could just replace pr_info() statements
> with pr_debug()?

AFAIU, TRUSTED_DEBUG being a security sensitive operation is only
meant to be used in development environments and should be strictly
disabled in production environments. But it may not always be true
with pr_debug() with CONFIG_DYNAMIC_DEBUG=y which allows the debug
paths to be compiled into the kernel which can be enabled/disabled at
runtime.

IMO we should keep this TRUSTED_DEBUG macro, so that users are aware
of its security sensitive nature and need to explicitly enable it to
debug.

-Sumit

>
> /Jarkko
>
