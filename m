Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210CC432C0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BBC2071E
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq+rdPof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLBUkP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:40:15 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46519 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBUkO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 15:40:14 -0500
Received: by mail-yw1-f66.google.com with SMTP id u139so335022ywf.13
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 12:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qsE7c9ZgxOSQwoJyGpg9QsvPMFkct0qAMYbSmWFxIV0=;
        b=Qq+rdPofQKdeXwZ00qSaFE+DEqSZGM7GRqAhD6uSWxZ1JscIqcI7V1hvG5ovS+gZq8
         foE3OgdyaJRORgT/uhDMficm2F+yyK6gWHQ3u8czXqjO+wWaptqjHsFWcPVsBQf0+VcZ
         KiNl5AZeIj9IeXiaIPHC33kKx12u4V5A+lpI5NRTNUZWPUNAGvgvdh3ngC9cH+oEGHVx
         pQbOjZ0cMC2hfq2Mvko7vdUGgJ8PnP/T38g616J1ORCHUWI/qYx5CJ/9Nxtm/r5j6oRF
         WbL8LXTuxp54j4guxGRk3bz2FaxlrOvIgnPdbW1KIVh1dOmaftcYChPEoYfYYj57iHJ5
         HY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qsE7c9ZgxOSQwoJyGpg9QsvPMFkct0qAMYbSmWFxIV0=;
        b=ZpXuBiAUOyG64WTo3q7T003L1prQ96sozYoV0w9H7/xnP9+AurF2Ibra/qFtHPMSad
         tStx4nb5Fl4sAZkZ0O+yU2HiIbYreeeD1ryVrsvYaCbHoU+OsZSdbL7rlM+SIEbuI+mw
         B4JhcqCCfjQqcwXPt5ozFBjHiUzlowbjPiDbhfNs1jQflQa8RvgtELRKrWdSRUDFK8mY
         yNcnmjO44SISzTf6Ng3GSrfudRsAKbHquuSXiPvC6GtObf08RAkZAUKnG4/3n9zBzhN0
         mJ9iouM0OAVFiCm/wFD/V/mLIluUloApOWBReoLLy1ZbEMoyJHR9c+/MVfzRS9B+rV3i
         LsNg==
X-Gm-Message-State: APjAAAU5QqNfKenrIAEnrKtkI9TXpJfLgOKRxMavX1kgmSPPaTwR8Hiv
        2+9KTca3kODrriKzoZKPCdg=
X-Google-Smtp-Source: APXvYqzVAwW2I32B/0xAxPyd/hpN3BBL+eKT4AVQ4l4H+N3Lwjb8UH+pAZdMslVt5hcN+nevt+rhOQ==
X-Received: by 2002:a0d:d50d:: with SMTP id x13mr530885ywd.431.1575319213281;
        Mon, 02 Dec 2019 12:40:13 -0800 (PST)
Received: from [10.77.0.2] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id d138sm370719ywe.102.2019.12.02.12.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 12:40:12 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Matthew Garrett <mjg59@google.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        matthew.garrett@nebula.com, Kees Cook <keescook@chromium.org>
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <CACdnJus-CQPKgL8cW1TAH3u_SSWHBk608tJsx8Uc-dMDPHyRqg@mail.gmail.com>
From:   Matt Parnell <mparnell@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <38d18a24-c580-d56b-f0cd-91e8184e1f0d@gmail.com>
Date:   Mon, 2 Dec 2019 14:39:41 -0600
MIME-Version: 1.0
In-Reply-To: <CACdnJus-CQPKgL8cW1TAH3u_SSWHBk608tJsx8Uc-dMDPHyRqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Agreed.

That said, if we don't mind working with what already exists, this
whitelist addition (I have trouble calling it a module) exists. I wonder
if it could be reshaped into something that ties in with the lockdown
functionality?

It looks like a mixture of commits from Intel engineers and Lawrence
Livermore engineers (GPLv3) :

https://github.com/LLNL/msr-safe

On 12/2/19 1:43 PM, Matthew Garrett wrote:
> On Fri, Nov 29, 2019 at 10:50 PM Matt Parnell <mparnell@gmail.com> wrote:
>> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
>> while this isn't something normally used in userspace, it does cause false
>> positives for the "Forshadow" vulnerability.
> The msr interface is pretty terrible - it exposes a consistent
> interface over very inconsistent CPUs. Where there's CPU functionality
> that's implemented via MSRs it makes sense to expose that over a
> separate kernel interface.
