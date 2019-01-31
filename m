Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BAC282DA
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 21:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56202087F
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 21:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nb/Osrxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfAaV64 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:58:56 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36650 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfAaV64 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 16:58:56 -0500
Received: by mail-lf1-f46.google.com with SMTP id a16so3553844lfg.3
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/scLVWcgx6b3Cc30SJ9XQoDRT3ekk9X1oHzi49xKw4=;
        b=Nb/OsrxhQM5rou4dBzXZ8nOQmk4lY3q6qfKrTMPn6RbcOsaKmrRFGsKX4c5Qst5jtf
         gJae59i2/7aaZ0a3tjA0AoJSQCtYMO3dCRwVVbjiwEIMUwKoAe0qr7iEYMxSV2Iy0PDX
         2kVcyMEPqwdqLp1FBEYbHzcOJlArED739YpaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/scLVWcgx6b3Cc30SJ9XQoDRT3ekk9X1oHzi49xKw4=;
        b=FfhFOvdH/M+zoadPrdpmbcHWRPzZhnp0tQZLhMwZuTukF9DA5em93csTwQFtPIK+hW
         LrEXTxZ7+OhS+JhfsZ4i7vF08wWDEmo+lNaWJ8w9tdJc/aWVMATk9nDQBQxcWrQPXzE8
         hbOJFWU6iert0kc9/ncVXM7FgsNSC9xUAIUfmWDuv0lipH+Frx0KsLh4vfA9nphaNZau
         OG3eUK3j0bjTDIVf3AUipy/z/huO1PUvCFjgtRw5CGNzV/BLhCzgj+7y21NceHIHz75f
         2JpE7bcOiXj2LH1leVlTBB9Pt4ptS1Hht7sfCqfjkXWMRJ0pitjUUnMkIWeUSCE78q9c
         GWNg==
X-Gm-Message-State: AHQUAuYOHyp96NLWWiYh5de2Gu+4eiifKXIE/3PZvH7jLxTLwrEwBX11
        +tXw85tHfWAPqhJ4n/zi9KXaeYtyus4=
X-Google-Smtp-Source: AHgI3Ibss3q77SfdY/F3Beo54VbVC7V+cw0ajzFKVDD/g7oHg9XJgBDmr56LN5LjhxHPA8S3uqjMMA==
X-Received: by 2002:a19:ec05:: with SMTP id b5mr2136632lfa.131.1548971933808;
        Thu, 31 Jan 2019 13:58:53 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u30sm1134239lfc.90.2019.01.31.13.58.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:58:52 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id s5-v6so3989300ljd.12
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 13:58:52 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr28403126ljg.87.1548971931875;
 Thu, 31 Jan 2019 13:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
 <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com> <20190131204710.GB354@linux.intel.com>
In-Reply-To: <20190131204710.GB354@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 13:58:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPCL9WgkwvK5ehJxg7Df1DHQqGZ0KtBxtjN93QjzUyog@mail.gmail.com>
Message-ID: <CAHk-=wgPCL9WgkwvK5ehJxg7Df1DHQqGZ0KtBxtjN93QjzUyog@mail.gmail.com>
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

On Thu, Jan 31, 2019 at 12:47 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> I'll try it first thing when I wake up tomorrow (11PM in Finland ATM).

Thanks.

> Appreciate for taking time on this.

Hey, it was my commit that broke it for you. Even if it happened to
work before, and only did so by pure luck, it was a functional
regression.

I get very upset when other developers don't step up when *their*
changes break something, and I don't consider "it shouldn't have
worked in the first place" to be a valid excuse. You broke it, you'd
better fix it.

So I had better fix my own mess too, in order to not look too hypocritical.

And I was very aware that hardcoding the memcpy_*io() access patterns
might break something. I just _hoped_ it wouldn't, because we actually
ended up going back to the very original access patterns (but it was
from a long long time ago).

In fact, while it's slightly annoying, in many ways it's actually good
that we found breakage, and could pinpoint exactly *why* it broke.
That does validate the whole "we shouldn't just depend on the random
implementation detail of 'memcpy()'" argument.

So I'll wait to hear back whether that patch fixes things for you, but
I _think_ it will, and we'll be better off in the long range with this
whole thing.

              Linus
