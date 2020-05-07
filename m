Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7DDC38A2A
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2B24956
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 18:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDjKI/Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGSrn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGSrn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 14:47:43 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187DC05BD43;
        Thu,  7 May 2020 11:47:42 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id t8so2249775uap.3;
        Thu, 07 May 2020 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2ikyjGhw2rR2iPMulc4f1heClpMqmZd1g3/5pqeR6k=;
        b=GDjKI/DfxExlbG4L/Ac/ivjSr1U+ABCagqQwj89GxmbDWPYx9xJY34Cu/6eok4LHlS
         C6mG8QbVsdmOdQcOvAz9LVaN919XehcpzLp76V3ddrrsm70cSRheKwN5oRF9dUyZkk6p
         gp2o0+cEbP3k+nT1f7yW2X063HFew8TbJUxaIXHDC0iEXEYNm/i/6t7kuWs8ThTvlOl8
         wkRe7poFEV3pOPqv3yUZ5HT+rer7eah8c01m/dLtdClXk1JsMDeaqBB0IYu2kPXjCs2K
         nv030TgpXgfbyZ8h/GUbRieCJBWFeseqhTOTMy7GGokQyOdsjvpf9S6FYmSi4HBZkxZ2
         7XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2ikyjGhw2rR2iPMulc4f1heClpMqmZd1g3/5pqeR6k=;
        b=DbEKw3QAeC4KoRj1cfwvMwMwA6dJ8WtA6YLKOJTQsCR/KCMU6KBevI4+In5MjsliQM
         9990oAqmQbhXR5Yq5d3PBbGtgWlN508cC4vclSQTGLaInRLnCXYE9Teposq5IzNaZFKl
         83+AoWABTBW+BC9R0acZ62tGbYo4lsYGmHT2YNHwe0fAlPhAmep1gmUVvUeSP/TzmoHM
         eZmv9uKTWyPA3pK5YQMK6EcOU5PEjbdMKVXMLAoi+EZd9IdfXkAhtag0fnNe7lzDYuxN
         WWCmczg6Ex2NAuM3JEGlpuI5ck1oT3F9vICgHjtYKlYaD+T+Gbux0IeBBJobTRP0U0ms
         ygqw==
X-Gm-Message-State: AGi0PubLkJs5u4ii3mIygOHUm1ZtPVQN0N5iPx5c0ESslp/zmvtgC2Aw
        uMu+aeCTlQse+svRxJQcdKTv0QTEJ8wd8MiSuCA=
X-Google-Smtp-Source: APiQypJWoOgZalFDnFzbemb8et2QJQFW0HQjXTPdVW+4zeix6UTdhn2m68W+Vjwx64ZKq2fn+rDyFybZZheH9wSYb6g=
X-Received: by 2002:ab0:3250:: with SMTP id r16mr12702214uan.61.1588877260976;
 Thu, 07 May 2020 11:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com> <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 7 May 2020 19:47:29 +0100
Message-ID: <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 7 May 2020 at 18:45, <Mario.Limonciello@dell.com> wrote:
> To echo Andy's question, I would wonder if it makes sense to just export
> these attributes in securityfs directly from the intel-spi-pci driver rather
> than to have another driver in platform-x86 to get the information.

The "DANGEROUS" in the SPI_INTEL_SPI_PCI and SPI_INTEL_SPI_PLATFORM
worried me somewhat. I'm guessing this is why most distros don't
compile it as a module by default. If the module isn't actually still
considered dangerous, and we can remove the warning I can of course
respin my patch on top of that instead.

Richard.
