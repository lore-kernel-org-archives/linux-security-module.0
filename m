Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23785C38A2A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50A921473
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiV4iQB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEHQPV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgEHQPU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 12:15:20 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB1C061A0C;
        Fri,  8 May 2020 09:15:19 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id r2so840287uam.7;
        Fri, 08 May 2020 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H08VnS9yN+xKAafxps5tOXIHVVVEZEkeV+pHeOLCkUs=;
        b=IiV4iQB351V0o3+/IKLjE0pv+/BiItjXAYjBM/9voZElcUGdNR0JeqV3AnL1NgNhZ9
         E3arqywo9Kf8Vfba4EF9iZhxeZsKTxNuZLAOCe5jzTokJEWHGzE2nt4yHD6IcBzj7aOV
         liV0RLORYaLYQP0CsqxgEqV+zyW+KdVEXUGCEfyt8BsuRqGNRjosez9qxsEZW9/W3w+Z
         RWAaA0aahrDtgR/UWMDVdSWow9SHdq7ilE5Noc+XS9bcgxWrONjCTv2659njp4pGtTXB
         DtbHT3RKUO4wRivAwBxXC84dYt0s8jLt8Ve1I+xmIuOU8xCAb6lPXArWRGmo9dzBZ/8D
         2LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H08VnS9yN+xKAafxps5tOXIHVVVEZEkeV+pHeOLCkUs=;
        b=CTfDRwx0yGLvjvHloJJIBYHbL5CxZY8KZRF5bL4QedUVUPyrTRNt2dJkihvmc88Bdf
         rgcS43RE13RlzQMJFh2dGmDdcsHtQrCeGOMn5OR62eX9tOHuXzrmt12XdnqjVvDfkzHP
         cgeb5tjdMCSJoDkqoWiS2xPNn+81iN+eJ+/j0h9/BoL1Hyg4E2Fr4kARWI6LVOpk9tJ8
         apj71xkHzNf/5qonWQSJpqsjw/qMiJ4Qe1hZiXdHuONS1BioCxN9HQIbEBnj0emD94ng
         K+BY2YZ/vmf3CAtDj5Qbs6b64SQRBpwPH/8IJx2Qk07Yx7ojMQlq3k0M3Ptt+9HwWFMn
         cH4Q==
X-Gm-Message-State: AGi0PuZ4lRmq+NGu2Sg/cS+iDqbDXlqhNK9l8WYGR9HFWNN00RumP9tc
        EpUECUNop5l8N9ckdLITU9HN/rS04iPmw7wwS6ALWScfJBg=
X-Google-Smtp-Source: APiQypLcwuh8PghrglYPTSth/y/LPBsSdzEwa2RZm4Nk+O5Ht4lYsKlluPFmebTLSbgM3Wqv8H4P3tW1UqmMKpxpws0=
X-Received: by 2002:ab0:7298:: with SMTP id w24mr2880926uao.95.1588954518198;
 Fri, 08 May 2020 09:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM> <20200508082028.GP487496@lahna.fi.intel.com>
In-Reply-To: <20200508082028.GP487496@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 8 May 2020 17:15:07 +0100
Message-ID: <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 8 May 2020 at 09:20, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Thanks for the information. I actually prefer that this would be in a
> separate driver because I do not want distros to enable intel-spi just
> for this. It is really only meant for special setups where firmware
> upgrade/access flow has been thoroughly tested.

Do you think the driver should be part of mtd (e.g. something like
drivers/mtd/spi-nor/controllers/intel-spi-pci-lpc.c) or be something
like I proposed in drivers/platform/x86? Ideas very welcome, thanks.

Richard
