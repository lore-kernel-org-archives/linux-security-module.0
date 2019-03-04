Return-Path: <SRS0=S0ZR=RH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E6C43381
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278672070B
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 22:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nbj5ObLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCDWLA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:11:00 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:39566 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWLA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 17:11:00 -0500
Received: by mail-io1-f49.google.com with SMTP id x3so5284002ior.6
        for <linux-security-module@vger.kernel.org>; Mon, 04 Mar 2019 14:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vj49IZmp1GrMY1xTUuQD9hq4RsIb2liKzZRRfy2CemA=;
        b=Nbj5ObLWXYNVo6Hp3tJm7ii+yuZsP68jytnydqgfDdBl07K9iHRa7a4EX7EJne4Wfo
         Q1K7PV7cWgKFi3UCLJc3RZIK43tPJbZxpslt151hqYk2lykff15TjqP2loLu7H/FFxfw
         nGuuVGJuqNEjIUfV9CvwoO0ce5q/JvCm0IqJzmFIqi8ejFaY6Qt6M9uc8nBtMs81gd3b
         VH65fm0dYVolbqvJPgVu9/nWOSIZmRhfZbvSZxgUcdGCw3UqsVB8pd1IAbBhfVi0OwX2
         tletcFGKc0CQFKY755YyQVIKzH4ZQPFq/eokga0XGJoqUSp6rYo70BZlatNHtdad1WQZ
         Beng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj49IZmp1GrMY1xTUuQD9hq4RsIb2liKzZRRfy2CemA=;
        b=Ph5amTsFjqUgnTud1ql6KT3rjiJzRzb6ZJQRRtYsiCgdiE96ZaXMMELGVGsNDPrKTe
         B1O5+PXZvRVPvVUCD3UdKDfgoWLU//KKNpp11HjqRrkYGtZmei1VVHWHUg0w5n7vRF19
         AYl/GsOUHu5klRnfHQ1vtrTfZC3tCaubIDZT246i2XDS1AcM/utwrmcM5XyDnjijmBdG
         FBG9GW5uxsTNtrNh/bfBOtb0TpaVds/3jJKfU0CpKH1Bq1p4DbEwR76jqfB4IXSSieHs
         2CsNdFpOLB9HnvDNXWSpRKVa17WO2Z9kJ8a4qNLwrUrupuED/9ghunWPaIR15NEmFaFU
         Y7QA==
X-Gm-Message-State: APjAAAXsfvQ/KrrmK5jtG7qdDp5nc2Mk2Vhw6i6hPn39ILnd+oCJnsqk
        hPSXgjp+bV9PMh1kdvkJnKfU5QC2f79O8Kwut9Q1RzKOJ+k=
X-Google-Smtp-Source: APXvYqwQrbFA5IlzK79qgPvlqYG+LyP4Ti+jgRCZ0sxsPgNpfnqXCIA2fvjkbvGSlTf7XawzfrnDhBbL038Gk9J0IaI=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr11205078iol.88.1551737459461;
 Mon, 04 Mar 2019 14:10:59 -0800 (PST)
MIME-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 4 Mar 2019 14:10:48 -0800
Message-ID: <CACdnJut3ix5nGOZ94KjxXPTdLWL1myi8rZcBv+0H3Gg2kAA5yg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Lock down patches
To:     jmorris@namei.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

Based on feedback, I'm going to make a couple of small changes to this
patchset and then resend.
