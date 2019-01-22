Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7CC282C5
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C3B20823
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CMl+ODFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfAVS1E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:27:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44668 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfAVS1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 13:27:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so18820498lfe.11
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jan 2019 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUBcaPRcuqOLEl2SYy/Q6oqpj8zeKWGuZM5V88FmHF8=;
        b=CMl+ODFKCfVLcBaWLY/tCSTTxYCbhG1V/NxINTD3f7ytfFq5M59K9J2K6RH2Pm/OSn
         q7GCuvuWVGKVYV62U5nCjKlbBy782E6y+co8/T6PIdApkhHe0go43LUfYd6CwWmR5Ef5
         WvkZWSVRmstQbxD52e4AK1z18Q87hMRWG808E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUBcaPRcuqOLEl2SYy/Q6oqpj8zeKWGuZM5V88FmHF8=;
        b=Ru799ErJaoFzurQ26ah9KqvY7ZTHBKNFLHLO/XAfAHTOnnByBO64cs3wIbZDvPfvc9
         74fktMHhhgbCK20QoSD1cJ5YrnUOZKQdECJ77+2GdGT6J/Hr/D7dMP0Hd9npN3eCcDZ7
         U68MK9ZM4Ny0AaAfdrhEsEJ1IBLNL3E8dXllgTDG6hWwfhn/pr47BRhhaqqEl8EvT2YF
         DmI+uDptxuk6MtZLRn3bR9CCaUUbu5vXp6ZoLKDWXJt5wOhG6vAITVi/k0UURCPC0AH1
         0DAFl+C0PK39I+0zByyWmIAo+ccD0AOzxmsI99TGQC9DWLkh+5Sk3KRVn6lZnbspfkhj
         qwAw==
X-Gm-Message-State: AJcUukdhlnRKWB5Nl9xvgeE3oKB5msc/YMpOHo7WJGmfB8J8OqUWcHwI
        Hgw1l0G1KRZq042XVESrZpzvuyhqS8wJBw==
X-Google-Smtp-Source: ALg8bN6ont+pHc0MRfPtj6u9qFihSEbTtlMKb8i2Gm/BTNMZBf1wsCwrlFo/xuonboU8CeEJlo/sgA==
X-Received: by 2002:a19:c954:: with SMTP id z81mr20751548lff.150.1548181620156;
        Tue, 22 Jan 2019 10:27:00 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q21-v6sm122692ljc.5.2019.01.22.10.26.58
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:26:59 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id c16so18809855lfj.8
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jan 2019 10:26:58 -0800 (PST)
X-Received: by 2002:a19:980f:: with SMTP id a15mr22707685lfe.103.1548181618431;
 Tue, 22 Jan 2019 10:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118142559.GA4080@linux.intel.com> <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com> <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
In-Reply-To: <20190122132910.GA2720@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Jan 2019 07:26:42 +1300
X-Gmail-Original-Message-ID: <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
Message-ID: <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 23, 2019 at 2:29 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> > >
> > > Fails on commit 170d13ca3a2fdaaa0283399247631b76b441cca2. Still works on
> > > preceding commit a959dc88f9c8900296ccf13e2f3e1cbc555a8917.
> >
> > This changes the IO access pattern in memcpy_to/fromio.. Presumably
> > CRB HW doesn't like the new 4 byte move? Swap each one in crb to
> > memcpy to confirm..
> >
> > If the HW requires particular access patterns you can't use
> > memcpy_to/fromio
>
> Did not have time to look at the commit at all but your deduction
> is correct. I know it without testing.
>
> Memory controller will feed 1's on unaligned read from IO memory,
> and as we can see from the TPM header, this change causes two of
> those:

Funky. But how did it work before then?

The new memcpy_fromio() is designed to have _predictable_ access
patterns. Not necessarily the best, but at least consistent.

Prevously, we used whatever random "memcpy()" implementation we
happened to pick, which *could* be aligned (particularly "rep movsb" -
absolutely horrible performance for MMIO, but by doing IO one byte at
a time it was certainly aligned ;), but most of our x86 memcpy
implementations don't actually try all that hard to align the source.
And the manual version will actually copy things *backwards* for some
cases.

Is it just that this particular hardware always happened to trigger
the ERMS case (ie "rep movsb")?

Anyway, Jason is correct that if a device has particular IO pattern
requirements, you shouldn't use "memcpy_fromio()" and friends, but
it's interesting how it apparently *happened* to work before.

             Linus
