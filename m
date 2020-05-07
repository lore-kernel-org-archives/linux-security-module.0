Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52FC38A2A
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1871207DD
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="nGZT+7wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEGRFo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgEGRFn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 13:05:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C0C05BD0A
        for <linux-security-module@vger.kernel.org>; Thu,  7 May 2020 10:05:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so2365476ile.9
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2020 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhMdI68GxmM2/TpI4f24ZbSehXjdI3UOoYDFkcvNus8=;
        b=nGZT+7woblZD8e8jFW2CJzEmOJ5BFpEdBvnaR5LRXjqJu2xRQTeUeJ5zXQPoQBv3OE
         2ZZ5s42uP53sUUlFc9l4BT/xibKJfb4X5aViZjInG9k7iYrAFrBKulzKotIIf7ZPNV82
         P/MreQjfGerW608Ii3/3QoUdE92RHrso8akpm6bR+AWbik7A5CU2Jdm9fIQrwwyniHOp
         AnbND53KOc/oGT/S1P/EIlHU6mgKzwRBUPdaKzDsWlf29lfMi9lXTnnuq9t2qVYlbl93
         QaUyZNdEujB6Jl6bdF+34vivxcPemyCnxwmOwQW8QMgkEpJG2xUVM/cFx4kzxs6Gz0Ya
         fvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhMdI68GxmM2/TpI4f24ZbSehXjdI3UOoYDFkcvNus8=;
        b=rrZtp3XPqaJhfB0jCMv/0rmdCCXChhhmQNanza/Up/fikz2rOiirpEh8gggXvRRQx/
         JbhFE7PNHDIEeX1EjZpnRxDHhJZdGn2EmMXUMgNRyhUM9Rhgru8Jx50N2XreIr92v8lm
         B3NyJ5QPbsbbnR2SpY1GZ7J8TgyingfN3zrSkclPRyetampPiAjuC87EMqYv7E/1zafu
         GK7bpRzfP7unj45jVt0glZgx6P73og9zBMXY5A121dspbB22f2ajPbWxW61Yo/krSSaK
         LSrSzOo44IPODU/Q011tS18RQ1GFEBQnYye0HoCNJsbXyPD1yrrnpXES5NG4NpqNF+9y
         Tt2w==
X-Gm-Message-State: AGi0PuadOApkxDPDdQhtkDyAeVyN/835zZnlYtDn6Iz9jomziIYExAuC
        zzMO3kuUkLfCQ0DuEwu63/4SDeE9OpzYCasZw7BaDdIuF7s=
X-Google-Smtp-Source: APiQypIEaxEPlu5s2U+5cAac/7UBCSdL/etDNK33LN2FlOhkvR23aOObctkvLIc2pQFBDrAA7Vpj4EHpHQ4Tnjy9jMg=
X-Received: by 2002:a92:ddca:: with SMTP id d10mr16285146ilr.166.1588871142871;
 Thu, 07 May 2020 10:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
In-Reply-To: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Thu, 7 May 2020 19:05:31 +0200
Message-ID: <CABxcv=kTL_grDUL00c_e2jyPD4hTtFS8Jze6pQBEz_arR6TPVA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Richard Hughes <hughsient@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Richard,

On Wed, May 6, 2020 at 5:52 PM Richard Hughes <hughsient@gmail.com> wrote:
>
> Export standard LPC configuration values from various LPC/eSPI
> controllers. This allows userspace components such as fwupd to
> verify the most basic SPI protections are set correctly.
> For instance, checking BIOSWE is disabled and BLE is enabled.
>
> More cutting-edge checks (e.g. PRx and BootGuard) can be added
> once the basics are in place. Exporting these values from the
> kernel allows us to report the security level of the platform
> without rebooting and running an unsigned EFI binary like
> chipsec.
>
> Signed-off-by: Richard Hughes <richard@hughsie.com>
> ---

The patch looks good to me, I just have some small comments.

> +config INTEL_SPI_LPC
> +       tristate "Intel SPI LPC configuration"
> +       depends on SECURITY

Maybe "depends on SECURITYFS" instead? I would also add ||
COMPILE_TEST to have more build coverage.

Another option is to not even add a dependency here since the
securityfs_*() functions are still defined if SECURITYFS isn't
enabled. They just return -ENODEV.

[snip]

> +       spi_dir = securityfs_create_dir("spi", NULL);
> +       if (IS_ERR(spi_dir))
> +               return -1;
> +
> +       spi_bioswe =
> +           securityfs_create_file("bioswe",
> +                                  0600, spi_dir, NULL,
> +                                  &spi_bioswe_ops);
> +       if (IS_ERR(spi_bioswe))
> +               goto out;
> +       spi_ble =
> +           securityfs_create_file("ble",
> +                                  0600, spi_dir, NULL,
> +                                  &spi_ble_ops);
> +       if (IS_ERR(spi_ble))
> +               goto out;
> +       spi_smm_bwp =
> +           securityfs_create_file("smm_bwp",
> +                                  0600, spi_dir, NULL,
> +                                  &spi_smm_bwp_ops);
> +       if (IS_ERR(spi_smm_bwp))
> +               goto out;
> +
> +       return 0;
> +out:
> +       securityfs_remove(spi_bioswe);
> +       securityfs_remove(spi_ble);
> +       securityfs_remove(spi_smm_bwp);

I don't think this is needed since if smm_bwp was successfully created
then it will never reach the error handling.

> +       securityfs_remove(spi_dir);

The convention is to remove these in the reverse order that were created, i.e:

securityfs_remove(spi_ble);
securityfs_remove(spi_bioswe);
securityfs_remove(spi_dir);

> +static void __exit mod_exit(void)
> +{
> +       securityfs_remove(spi_bioswe);
> +       securityfs_remove(spi_ble);
> +       securityfs_remove(spi_smm_bwp);
> +       securityfs_remove(spi_dir);
> +}
> +

Same here. It makes it easier if in the future other entries are added.

I wonder if these new entries should be documented in
Documentation/ABI/. Or maybe that's not a requirement for securityfs?

Best regards,
Javier
