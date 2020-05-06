Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDCDC28CBC
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E16208E4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnCudEWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFQjo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729443AbgEFQjn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 12:39:43 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98371C061A0F;
        Wed,  6 May 2020 09:39:43 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so702469vke.4;
        Wed, 06 May 2020 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zy/oOkiEHruN5SLP7ztMLZrg3ivLhVuxkqiM/tXvWKU=;
        b=gnCudEWGDEfNQvFWvYrc8/nA1XzuJ1cEDKuRKnHXbCqvD/3H+MEBUWwxPjMRikNenH
         pKZdjsGkNZ9OvcYGtdhayFbdKbHc/vb3WIHEpb/i1FEP399ohWXakpLDECR/NjX6OrsR
         6Lw0lf6x/DsajiVifZz8/RwSdp/jrtRFR9TM6ZDcnuu7i3pABxD4xA3Jsp26VK8pzIp1
         BwXb9InyfCkrA11Bz7oU70fa16aF8Va44Tih5VLKRn5LRS3X1aFPLWh/osBq2FNVciFn
         3ZKUB64E8Oe4YLG4vW/BQRwgEoDXzbQLk85MKPtxcuO0hiJMNOs16J/QV80u6raB1R8M
         Vh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy/oOkiEHruN5SLP7ztMLZrg3ivLhVuxkqiM/tXvWKU=;
        b=n3v0KsvNaRRExvkQJdQVhCx54FDJw1/Zgxx/WpOlC2/Y08pjEVM4l7ghjAvO+9SroN
         tF6lazTkBIwHgW2Lqmt7M4pBLPU9gWyt189QsjeU5OYMbrtokfB7JwvBeNixcXl3U9Wq
         beqpNlFirWX/64GljnfWXHgsJixxKti3kpwNFmuDTkRh++GlVqosbia8DuwUtElWbeof
         D2lwUg8wc21X6opSjWTVGUoYLKH4PDUwMvoXJU//1Qf+tzbnL3tWR9pBxEnEHaZCE0fl
         /5wLIa+B2nyV7jHqsckVTZ237KTvUadeTZ5K6q7aCK86SkzFNojVjQknLtWwd/dtm1FC
         iaug==
X-Gm-Message-State: AGi0PuaJOoIY3DGqykS5Q3WT4o7c9HVlIkxrLCEo1kK9KcnQ61+j0Mmg
        XLkld+CXuh4ypbly5p7R/k6aQbEmA8SyZGFH1Ag=
X-Google-Smtp-Source: APiQypKK2tzUcUD+6+G5WgBhOph4THsQynmQLRdo8nINym5gYNjwr6q7NMuxHge6UyQhqq5QU/i5mQ3TiguNDgwosEU=
X-Received: by 2002:a1f:e4c3:: with SMTP id b186mr7748376vkh.34.1588783182806;
 Wed, 06 May 2020 09:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com> <CAHp75VdD_3CxtwT_07R8Cc=SE6Uw+FDpom5YxTX4Adq4DPjKkQ@mail.gmail.com>
In-Reply-To: <CAHp75VdD_3CxtwT_07R8Cc=SE6Uw+FDpom5YxTX4Adq4DPjKkQ@mail.gmail.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Wed, 6 May 2020 17:39:31 +0100
Message-ID: <CAD2FfiE38TOKfVdSvPCq6z=QS1efANc2epZ+W3xTqe-GQA+Bqg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 6 May 2020 at 17:29, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> Isn't it covered by Intel SPI NOR driver?

No, I don't think so. The Intel eSPI controllers don't operate at the
NOR level. This patch really just exports some PCI configuration (LPC)
registers to userspace.

Richard.
