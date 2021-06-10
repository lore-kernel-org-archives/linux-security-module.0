Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC75C47094
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D91D613BC
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 15:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFJPUP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFJPUO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 11:20:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED6C061574
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 08:18:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6795003wmh.4
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEizWV9pqKWtA3I5Lx6+foWFKHfovLYz8YJh/nQGyU4=;
        b=TFqIO+3MbdpOkGxMHxhf2SMlQfMu8eqMvfqrW1sYdwpXawEhQH5qQtIWG2wJ+NtGOZ
         +GLTcPsWzCM9GbR48Q0mfrkrlulZmsBB0hA4rIQoX8JG7heVNOK6M7+by/eWfKjZaBh0
         JiQhpN2tJ02ztr3eq3TnHdM/r8TLl5blt/S5wRdb1E1wI/UzvzNOgCl/HQXLmC+a4Qgd
         K9eYU4gvoJXUpNroAn3DU+nFDM188KF+CJvS8vUNlqtYJWao4KPfiwaVRpPoQS+49kI2
         rZ2EzPEsGsKRzd2083lRUCIPP35YD3UOKqx3ecQ2dIkZxoscTkkKqPEjGfduyjLtGbvh
         Tuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEizWV9pqKWtA3I5Lx6+foWFKHfovLYz8YJh/nQGyU4=;
        b=fITUzwNVsJPsWRBO5d8meLZz+ojc+HzrotTsYi/lZIFBGiTgfenhDNAsghy8bocU4V
         jfyMKhb8/H8GlmrbYnY7Qkt6DSPxRtzutUMj/s7u10TA+HnmyGqQktLjNjNv+KexRnjG
         QqIs6bay2vfvUK/BgUZNfpipVWV1Vi4WiwhsHxubcfk6zoB1aV2Ju2vXWAQJQHj9CGpM
         hDW0EUmC/mAnUjM+uOxd2AV1Fdi5gprCVIisgj4qo9amTOLXXXLY8rj9taI1Q6Qi+Xl2
         ynN7lJ2smTEH4Bp/6s1JqqpVLm237ehsJ49XZpZ51p0vjzBNw8EE5LAaxXjd+OG72UDG
         zVgw==
X-Gm-Message-State: AOAM533ELIfrC+ceuk0pX4Y5jem64/oSdt8w0BAvFJSZeGUbUfsKelcH
        9q48A8tNKrjENnZvSVcNJ5NiUA==
X-Google-Smtp-Source: ABdhPJzynRmYYLsE07cE4IrH1eJB2NV4sziNEvi4rO5rP72ty1783TeIcwOygbWysK8ka+DMFrBoOw==
X-Received: by 2002:a05:600c:5112:: with SMTP id o18mr5396432wms.15.1623338283125;
        Thu, 10 Jun 2021 08:18:03 -0700 (PDT)
Received: from trex (138.red-79-146-80.dynamicip.rima-tde.net. [79.146.80.138])
        by smtp.gmail.com with ESMTPSA id n18sm3584960wmq.41.2021.06.10.08.18.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jun 2021 08:18:02 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 10 Jun 2021 17:18:01 +0200
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: ima - wait for tpm load
Message-ID: <20210610151801.GA19687@trex>
References: <20210610071633.GA30216@trex>
 <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/06/21, Mimi Zohar wrote:
> [Cc'ing Jarkko]
> 
> On Thu, 2021-06-10 at 09:16 +0200, Jorge Ramirez-Ortiz, Foundries
> wrote:
> > I am enabling IMA on a ZynqMP based platform using an SPI based TPM
> > from Infineon.
> > 
> > The SPI TPM driver is built-in but since the IMA is initalized from a
> > late_initcall, IMA never finds the TPM.
> > 
> > Is there a recomended way to work around this issue?
> > 
> > fio@uz3cg-dwg:~$ dmesg | grep tpm
> > [    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> > [    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
> > [    3.430406] tpm tpm0: starting up the TPM manually
> > 
> > fio@uz3cg-dwg:~$ dmesg | grep ima
> > [    3.525741] ima: No TPM chip found, activating TPM-bypass!
> > [    3.531233] ima: Allocated hash algorithm: sha1
> 
> Lengthening the TPM timeout, executing the TPM self test have been past
> reasons for the TPM not to initialize prior to IMA.

right, I can understand this.

The problem in this case is that tpm_chip_register() is taking too
long so by the time it executes tpm_add_char_device(chip) is called,
ima has already given up.

The way I am working around this is just by adding a new flag and
providing the chip in idr_alloc (so ima can find it).

Then add an 'enable' flag to the chip structure that ima can use to
wait on.

@@ -333,8 +345,13 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,

        chip->ops = ops;

+ if (ops->flags & TPM_OPS_SLOW_STARTUP)
+         chip->flags |= TPM_CHIP_FLAG_SLOW_STARTUP;
+
        mutex_lock(&idr_lock);
-   rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
+ rc = idr_alloc(&dev_nums_idr,
+                chip->flags & TPM_CHIP_FLAG_SLOW_STARTUP ? chip : NULL,
+                0, TPM_NUM_DEVICES, GFP_KERNEL);
        mutex_unlock(&idr_lock);
        if (rc < 0) {
                dev_err(pdev, "No available tpm device numbers\n");


> 
> (Missing from this bug report is the kernel version.)

um, didnt think of it as a bug report - the feature is clearly not
synchronized so there can be no guarantees about available TPMs being
used. 

but yes, this is happening on 5.10.42 using tpm_tis_spi to connect to
infineon SLM9670

> 
> thanks,
> 
> Mimi
> 
