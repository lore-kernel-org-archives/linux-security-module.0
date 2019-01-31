Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACE1C169C4
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE67218AF
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cxIgLqno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfAaSvY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:51:24 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38926 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfAaSvY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 13:51:24 -0500
Received: by mail-lf1-f54.google.com with SMTP id n18so3135547lfh.6
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8TmXOKugmPf5PKjfFSY0+MtEECnoWuXrcfZ9WYj7sQ=;
        b=cxIgLqnoURQzhPPQoVzTc3kGLEAW/JP1u2P5ucV1ZsVNhsd3LvJloBpP/vyQF0CN2i
         cEyNMJhJx+4Bj+X64xrwKUVfdSW8NoNLeyWe/CvYWmSzGchNlYE6pA1qZdrp0ZetciRM
         2Wox7w7BfbHIL5MET5xcChhZL9rFMbfTEYOJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8TmXOKugmPf5PKjfFSY0+MtEECnoWuXrcfZ9WYj7sQ=;
        b=sCUTg/bjv+bkRHxJtVuiqfIdr57VMG79G3w1EUORrayK7rEdRV5oAoqxDq7SY4+sls
         e1zf4fmFWpqKMuAM8RFp/yaNIP9qGcCwCsRf5oJbo9Iyd+V8wlPNE4dASu17ONjP7+25
         ywZ1mGbYEentxHPwo8FW2+nOhi1V9ftQ9JnqqgreT7Fz0nGcWb0o3iYjaNEnU6OuI+wH
         n8Qa3+0r6AVt83Ay1qvtibCYSt253YG0uEYqbUv0CH8+b7yTSCSpL6wwvpxBOECX/3Mf
         09RzLFSVzGuMaRDr9LMeuw0aZYBDmMLW2uY0/4k6Agl3sCiJE1HVWDNIc65NRjkAU+u+
         +Izw==
X-Gm-Message-State: AJcUukeH5xBxS08s5vPS8XgXtTFC6S1OVYgyTOgi/spFwqGlLoFXMqlU
        h51h0LxuGoLi3gObKpRUE29G/NY+rzg=
X-Google-Smtp-Source: ALg8bN5NnPea0Vwu/hW/X8n5bA5O8WqwGGOMaTJtRI5sftePXQOoJ4+CNQpbz+N/SuivuH4Ja7TbWA==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr29813900lfg.13.1548960681762;
        Thu, 31 Jan 2019 10:51:21 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y24-v6sm902519ljd.20.2019.01.31.10.51.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:51:20 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u188so1183214lff.4
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 10:51:20 -0800 (PST)
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr28892472lfk.78.1548960680075;
 Thu, 31 Jan 2019 10:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20190122010218.GA26713@linux.intel.com> <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
In-Reply-To: <20190131183530.GA27112@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 10:51:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
Message-ID: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 10:35 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> OK, so the length of the response is not trashed, but only the error
> code. The attached patch fully fixes the issue.
>
> Here's the header again:
>
> struct tpm_output_header {
>         __be16  tag;
>         __be32  length;
>         __be32  return_code;
> } __packed;
>
> The first to fields *are* read correctly and the last field get 1's
> (thus TPM error -1).

Ok, so this makes sense, even though that patch is (I think) completely wrong.

What happens is that the 32-bit fields are mis-aligned: the "tag" is
obviously properly 16-bit aligned, but then both "length" and
"return_code" are 32-bit fields that are only aligned on a 16-bit
alignment.

What happens is that first you copy the two first fields:

        memcpy_fromio(buf, priv->rsp, 6);

which copies "tag" and "length", but it copies them by reading then as
a 4-byte and then 2-byte value (in that order). So it actually reads
'tag' and 'first two bytes of 'length', and then the second access
reads the last two bytes of 'length'

And it all works, because the accesses are aligned by address of
access, even though they are *not* aligned in the 'struct
tpm_output_header' fields.

But then later on, when you read 'return_code', and do

        memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);

you now do a 4-byte memcpy at offset 6. So it does a 4-byte access,
bit it's not 4-byte aligned.

Honestly, memcpy() itself shouldn't have worked *either*, but you
lucked out. Gcc doesn't know that it's a 4-byte access, so it actually
calls out to the memcpy() routine. And that one happened to be "rep
movsb" on your machine. And that happened to work.

But it's really not supposed to work, and it really *wouldn't* have
worked if somebody disabled the rep-string functions.

In fact, we have another patch (that isn't applied) that makes even
the memcpy_erms() just call the sw version of memcpy() for short
copies (because "rep movsb" is slow for those cases). That would also
have broken your driver.

               Linus
