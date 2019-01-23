Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B86DC282C2
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D680D21855
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CcoD2MHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfAWSnw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:43:52 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46656 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWSnw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 13:43:52 -0500
Received: by mail-lf1-f46.google.com with SMTP id f5so2334975lfc.13
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/RbVbIy1FrX9DKc2Qqyjxp8i9MW2OC3m2BAaX40i8g=;
        b=CcoD2MHx0BvVMq6cIIxGh/1KI/w8wHbGAPvZi+nBqv6bfrYAiHSST+ubmM28mlEPiY
         C0m623qguRpczs1DEIwcwJWtJ/FcwUSxIZ8sJUHWcwUCas0oFX0qugq4pfjS5/FxflnY
         zDZwJpYyY5EIrcACE+fT15Sf8W3X7ocmxX61o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/RbVbIy1FrX9DKc2Qqyjxp8i9MW2OC3m2BAaX40i8g=;
        b=cciPUYwqDHatrlJ6L18/46s3GriTOajXMJAZvd5g0zb8kamcho4pggtYD9Ww+Odznb
         d35mOb4aw2tgQYF1SiGITXrJdeKPi5+ao6xzWsi2EWMZTM3uqCort4nfFKUKZcHb+v4X
         7wQf4AunCr5UEiF4KwtoC9jt+1igPi/2255CqtDfvsSeHbFZuoD9e4xG1ODKUAUQnysU
         ivgOQ2hxTCpq6dYZ4YN+YzgsTt8JP1pF5VH5nw9QGYT+6SDDdGGklOxl/cqJqVrZ25Dw
         eVQ3D8zr9CXUraT+diNK8puwl9bAn++3LAKdklp7vI0XCCUbNCYRhY7w3LNczshdSqal
         RkXA==
X-Gm-Message-State: AJcUukfciyUMIj58BcXOecwYb0ItcQ919uqpytg1cZd77T4bTsF1oZJR
        FQlWK9V/soo6VNCiFpzQHViSrNdqq/IeGQ==
X-Google-Smtp-Source: ALg8bN4odIs042EY0U4P39xkDfg0EP2nBXtXwR34od5nm8ymEUV5X1PggXDKQmf7BAdW0toL9MZkTg==
X-Received: by 2002:a19:db82:: with SMTP id t2mr2720074lfi.130.1548269029345;
        Wed, 23 Jan 2019 10:43:49 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e13-v6sm635831ljk.53.2019.01.23.10.43.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:43:48 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id i26so2397755lfc.0
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 10:43:48 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr2693766lfa.1.1548269027896;
 Wed, 23 Jan 2019 10:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20190118142559.GA4080@linux.intel.com> <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com> <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com> <20190123153638.GA8727@linux.intel.com>
In-Reply-To: <20190123153638.GA8727@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jan 2019 07:43:30 +1300
X-Gmail-Original-Message-ID: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
Message-ID: <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
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

On Thu, Jan 24, 2019 at 4:36 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Is it just that this particular hardware always happened to trigger
> > the ERMS case (ie "rep movsb")?
>
> This is the particular snippet in question:
>
> memcpy_fromio(buf, priv->rsp, 6);
> expected = be32_to_cpup((__be32 *) &buf[2]);
> if (expected > count || expected < 6)
>         return -EIO;

Ok, strange.

So what *used* to happen is that the memcpy_fromio() would just expand
as a "memcpy()", and in this case, gcc would then inline the memcpy().
In fact, gcc does it as a 4-byte access and a two-byte access from
what I can tell.

Which is actually exactly the same as memcpy_fromio() should do, just
using a different code sequence.

> memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);

This one gets turned into an out-of-line "memcpy()" in the old world
order, which depending on size will do different things, but might be
a "rep movsb". Or it might be the software expansion that does
overlapping accesses and/or backwards copies.

In the new world order, it's the "memcpy_fromio()" that willdo first
4-byte accesses for the main bulk of the copy, and then end up with a
two-byte and single-byte move to pad out the end.

> I guess it did in the first memcpy_fromio operation since it is less
> than a quad word, right? Not sure why the 2nd memcpy_fromio() operation
> has worked, though.

The first one seems to do the same thing now as it used to do, so I
don't *think* it should have mattered.

The second one looks like it is unaligned (offset 6) and doing the
4-byte io reads would fail if that device needs aligned accesses. The
old memcpy() *might* have done it with a "rep movsb" that would just
work (?).

                 Linus
