Return-Path: <SRS0=PFxj=WK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F62C32759
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D62206C2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+RJ4YZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfHNRSU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:18:20 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37815 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfHNRSU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 13:18:20 -0400
Received: by mail-oi1-f174.google.com with SMTP id a21so814237oie.4
        for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2019 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRQCsPcTpX5yRUIeFvdSARBVTlIiAlejL67+Yf8xjVg=;
        b=i+RJ4YZ15TO+HN8duwbWS743QimszN9Wm8pGxdOfNKTpNfk/bLHgeUyMR2laUaSwNC
         jkH92f8hGxvou8/kRTOKuzkFwgOkSEPym8fJ9uVwPtFQLIo+MRHf8U10FEAQTU65YBLG
         mQrh+u6/r0av9IScMa02QDnTBiKrdAZbS3wJdgiL4XOn4GhgziP4smrvoOgnL8FIvQ83
         quHr9xVJbWaomkXQht1sYMrPA/wK5XtvV2BS2lAo9vBWhx6JVX0KdI8b6y++/aT/1Frx
         e3B6mzLvuE0aH/8n4qB04UlDXcVbAcqNRv3fr54uvuFKYcP7eacbyCM2r14L+ssvjJYm
         ZecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRQCsPcTpX5yRUIeFvdSARBVTlIiAlejL67+Yf8xjVg=;
        b=nOF9QBhb7ZpBv9eY0KaUdYs3FUWeCP3kqJ4jw/IRw1Jgg0vwON8UI2Sb2gg3/2R0gx
         REZcPBGf1lbOCHPBkpTQx9ywxJVWd7i9rq0zddpCULDRhHY31OAwmG4ztrxnhMmz/zc1
         iJlrP3BvG0EpFwy0j+mTgZ/eVFKwrKq4ppTRQl9eiMVssGjKy83d0hxd5fI4njYanGor
         LVhVeselDfFJeWIY5IY4ZRiXrhREzZtPjcDcwzNsO1so5Pd0elXFAIr7PxbwOyPBdB83
         h63r7k6iElfgoSwClQMuXgV/RoITU8unmiqXUOwpjACgCopuZGcJBmPzkYd4Fz41yOXP
         em9g==
X-Gm-Message-State: APjAAAWeajktAsMF4OwWMH3Xm3KfGg8h6tZl3IRLu+ycQhfoQHYZPyo/
        6N4YsiKzOKwWaP5uzntzdAF7mGGNeeN9Et537c/qZXp9G0I=
X-Google-Smtp-Source: APXvYqxO6hrvW6O3ywX1sNo7cI2Ev1FZZfK/oM5JhFKND6LvgRn/TFsa/h0pFjgEsTxR/Ax/nKGU78JXDTSLCAv4Igs=
X-Received: by 2002:a02:cc8f:: with SMTP id s15mr395071jap.53.1565803098994;
 Wed, 14 Aug 2019 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
 <20190813192126.122370-4-matthewgarrett@google.com> <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 10:18:07 -0700
Message-ID: <CACdnJuuG8vy37KaoXHU-bzr-VLEwnUWWiCH_zKWuvYdGDDAV5A@mail.gmail.com>
Subject: Re: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        kexec devel list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 13, 2019 at 10:24 PM Dave Young <dyoung@redhat.com> wrote:

> I can not get the whole thread, also not sure which tree it should
> apply.

This should be against -next.

> Also I think it should be good to split the preparation piece of kexec
> and send them separately.  Since it is improve the signature
> verification logic, they do not necessarily depend on the lockdown
> series.

Sorry, which preparation piece? There shouldn't be any logic change in
this patch.
