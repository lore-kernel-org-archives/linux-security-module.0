Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A37C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5917A20707
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kZswaULy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFOK0y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:26:54 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:42585 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOK0x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 06:26:53 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c812bc21;
        Mon, 15 Jun 2020 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=lRN
        65Oo0mc0F8r+DDWtw/MlluDk=; b=kZswaULynlWF7sUmn/S+Wf4vXyg4TwnY3od
        O5GhovqKcyRqGHxIJOJ9yNFmfnGMaWiNoKv6xs8QbvIwLDczGT6+CNi5gIgdtoX+
        qXfw+1VIROj31TKltcGorCqGsPNqevrneEZ/hFSwXlgoXpfdeJUKGqovJzsCTzzf
        I4gpHOJyES9f1nNEs00hqCwRXkuH8NPSHJwx8L5/shr1v/Vwi4weme+9OBZki7rO
        Mzu7YaruKWBmwypPdCcglUaOTNs5FBZaLLO9WSbnf7LAD7qU52LlGX71+/Cg7qAd
        vzqWdsmXG5jAw1t/Hh+PUCOh8Sma1rc4vELqQNkHUmFssGEmfRA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 14d73c66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Jun 2020 10:09:00 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id p20so17165270iop.11;
        Mon, 15 Jun 2020 03:26:49 -0700 (PDT)
X-Gm-Message-State: AOAM530ni9Vpspm5CvRsac43zgg5KKZHzyUVMB7qdpjRX1ZEaE8jGu9I
        /XbMAtVhz+XNkgwmzzmvtaS/n96/oREfe1mOY4k=
X-Google-Smtp-Source: ABdhPJzSj8LwcKc9aY9w/6THuVZEOYoB+hlUyjHk6QP5O7EW9Yn2eEdLsBKYY2DjP/t7jJbqHTBjUDx25k5Bw9yRChs=
X-Received: by 2002:a6b:5a07:: with SMTP id o7mr26860787iob.67.1592216808485;
 Mon, 15 Jun 2020 03:26:48 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 15 Jun 2020 04:26:37 -0600
X-Gmail-Original-Message-ID: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
Message-ID: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
Subject: lockdown bypass on mainline kernel for loading unsigned modules
To:     oss-security <oss-security@lists.openwall.com>
Cc:     linux-security-module@vger.kernel.org, linux-acpi@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        kernel-hardening@lists.openwall.com,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi everyone,

Yesterday, I found a lockdown bypass in Ubuntu 18.04's kernel using
ACPI table tricks via the efi ssdt variable [1]. Today I found another
one that's a bit easier to exploit and appears to be unpatched on
mainline, using acpi_configfs to inject an ACPI table. The tricks are
basically the same as the first one, but this one appears to be
unpatched, at least on my test machine. Explanation is in the header
of the PoC:

https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-language-2.sh

I need to get some sleep, but if nobody posts a patch in the
meanwhile, I'll try to post a fix tomorrow.

Jason

[1] https://www.openwall.com/lists/oss-security/2020/06/14/1
