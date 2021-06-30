Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A7C11F65
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C8261449
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhF3TU2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhF3TU2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 15:20:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE8C0617AE
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 12:17:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q4so4757838ljp.13
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=OsGeYpUKTFPyN5n360XNZX8s/aqdMHN9tQztcumkZMUEG0EKEgHA2J/bHBhbdu8wiR
         ClWnoPCQmYWxP2n/dlnN1fE0QB/HOvPEfl0TYUAdfEux0/vvSPpQzzuxcD9wpjOUwDnm
         ODKvHI15ym8cJPnCdDXTIIdO883VCyNE7rJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=TyhjhbLiszZSa+kiIL5nadpxka++U4SBq/Qi4CTNX2GQS7yJtg1ON8EZwpJmjoCmJ7
         M5OWxGxlFkinp2cw2/gzDLVuizbt7TkHUl07MII86TH+FrYNU8/qNU/RHc6xzjMoZ7W3
         rSfj4S/XeSog9SPM3KoTuf63W4by2HhLhV5jR3/KzZPN6NQUNn4EWr7DiR9Jluou7usB
         bgEuy6tK0tleHWWyp6wa0dFWYfHubeB5dMnwCkV/bWcsRQ/dIML1DtRQgnJ9tMe4B+Ie
         WIEiD98XZMEQ3X/TF/YfQnbSSEq+iPrPDs9BV9mPyybQ75HdMBrqrkOKtXA9ZxC1GpIt
         kv1Q==
X-Gm-Message-State: AOAM5337K2s+Yo8/SD5YD5anCtZugzzyhhibAvSmMkyI67IuEbF8BtaZ
        59c8wWn+XDVda0aluIzh6KqWsRXzmukhSE/CzmM=
X-Google-Smtp-Source: ABdhPJwPjLlfllVP9rM5PwmuMZ75Y5zE2kWOVSKm9RbR7q1GhCjzrFwR+r+8LduWIQanbU5MRYp7cQ==
X-Received: by 2002:a2e:9e95:: with SMTP id f21mr8719783ljk.137.1625080677107;
        Wed, 30 Jun 2021 12:17:57 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id bq4sm1998556lfb.97.2021.06.30.12.17.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 12:17:56 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a18so7083312lfs.10
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr27583898lfc.201.1625080675538;
 Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com> <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jun 2021 12:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 29, 2021 at 2:34 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.

Thanks, these two don't confuse me any more.

                Linus
