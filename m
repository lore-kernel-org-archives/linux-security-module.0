Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E541C47094
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 07:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326CE6124C
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 07:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFJHSd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHSc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 03:18:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D2DC061574
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 00:16:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so2621144wms.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3FKf2+gkMWIhlRbcIHR68ePBWDdt54bok6Q03a/gikU=;
        b=MUG9lRTWFssDqV6Jfp/9MhtqN3eDPBZhN4PYQUvQkGYJ8fIRx30Tn+87YBoy1m2wm3
         DTKhwAwVKYoUvxFYSuAS5bRfyPVzBBH9CGIh1Ag2hHdgSCrpgLFWcezZC6Axer/1KWMT
         BVxMPHMTzJlHxt00s3BdQWv5MgjvFjTED5ckdEqVcSOUIlfYv5Bj7rg9eCGd+XObIArh
         HyL2g9wNRMHuXxgOveplHjUFK6jB1i5o91FVp+a0LkjjkQF5S7+Wfy+kqZ52bLYXHkDs
         iq3Ersrh1/iq5uQvRNGnwgUvATgkSNbPu4n4dvLCASNPCPbQa8nATBA77W34A8z4xVfO
         kiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3FKf2+gkMWIhlRbcIHR68ePBWDdt54bok6Q03a/gikU=;
        b=H7+waC3AgzB8Rjb3hNqeiBgpTK3RZScOArpNxgDgSydeowyhR4M9CqtqR71ZCm2Ewj
         i2qRRriuaLVGbugJSh/N13ul2/a0Jkm76wnSS8CrnmV6A6M7JckpT/SSnURsXmxtCT9t
         7dshDFHab0IHfp0TSybAhk0RGHQMzoN6jq6r6PPUDkBEeEWIXQWAWUX4rd8zBLLQX6lC
         XcAyIstUVZ266qrPtC12JFMDXhySQcKkpb2duOj6xyn6vxBiKkMIZOvzBKcPGSKQ8W4m
         e9EkTZzXXbrmKOxtpk80OC5xrGQS83mQu0KM4Lk9qjdmUWotsG7+VbkMp6Z+Aiime+9+
         81vA==
X-Gm-Message-State: AOAM531bmk92DJrV4dCLRtMQzyThGT78lnXIGGgsKjiHg6P6omIFFY71
        r1i1pOXjmScqdhOEaI+VGyPRHg==
X-Google-Smtp-Source: ABdhPJzajlyBEFmkfPc4QpDBXyGS2DoZ3n0rGa+jAjMCVHOCmlhZIn3rUP9QN06Z326tVRqf8SersQ==
X-Received: by 2002:a05:600c:1c8e:: with SMTP id k14mr3586505wms.61.1623309395407;
        Thu, 10 Jun 2021 00:16:35 -0700 (PDT)
Received: from trex (138.red-79-146-80.dynamicip.rima-tde.net. [79.146.80.138])
        by smtp.gmail.com with ESMTPSA id v7sm2348769wru.66.2021.06.10.00.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jun 2021 00:16:34 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 10 Jun 2021 09:16:33 +0200
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ima - wait for tpm load
Message-ID: <20210610071633.GA30216@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I am enabling IMA on a ZynqMP based platform using an SPI based TPM
from Infineon.

The SPI TPM driver is built-in but since the IMA is initalized from a
late_initcall, IMA never finds the TPM.

Is there a recomended way to work around this issue?

fio@uz3cg-dwg:~$ dmesg | grep tpm
[    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
[    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
[    3.430406] tpm tpm0: starting up the TPM manually

fio@uz3cg-dwg:~$ dmesg | grep ima
[    3.525741] ima: No TPM chip found, activating TPM-bypass!
[    3.531233] ima: Allocated hash algorithm: sha1

TIA

jorge
