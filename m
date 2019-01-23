Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421DC282C0
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 20:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB7021872
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 20:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8GygvYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAWUnC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:43:02 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34034 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfAWUnC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 15:43:02 -0500
Received: by mail-ua1-f65.google.com with SMTP id c24so1213754uak.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFCkOF2gK3wr1UB995eD+/CTWS4iazBBfFIZUEffwxc=;
        b=L8GygvYwk5FYD+Ce0ML1TRQbDfEIv0oR+ZZMDgwVJntrdffAzAT1EMjtnCS4Vm7kGF
         9dyJBTPuJm07cjZsS/xzizI42KQnMArMr2N3CLtPSslUeR/3lApJBdvCmKdyWI0HKF0C
         Vq7eIyo8gjyd5kPrv1YhbaPvpYIMVU0STBBf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFCkOF2gK3wr1UB995eD+/CTWS4iazBBfFIZUEffwxc=;
        b=Ai4BeujcBwbtpTHDqyyvGvI2C0ma1S5q0sJ4Vvr+TuRjMZKNl6Sw6lDE1eJyH/Cpsu
         1GyyqXMX0WP9cW4SUJXbzkzIVpp/1hOWggypaqoo0INVzfxn1kPL3XJkO8wtx95xrEKX
         QKxq6Jnmv3vfN7AE4KoM+FpzHdytpfP8WV4VvePZAJhsAhtCUfqkfqWqVlAQMQ3tm1P+
         VZeeuWKkMsj6dLAi/OIB5ZrBylM0rhcPicnlhgV2UTGS5m6p9LvRtuQ8j4BrcA691+TI
         fDNr9pVYdVAhbw9bnDMpmtQ3CsHd8CJTjm87HfR7IJsvgZ5JPhsIGSd79tk5B+W5rDRs
         O2eA==
X-Gm-Message-State: AJcUukdrOXvsmbT2KAqdx35oFJFUcGSsfsMOzicUqmVx9ZnuEEBV/ira
        iHDZD+OyC5Q+ENEJMaSRD5F3DF9OOBI=
X-Google-Smtp-Source: ALg8bN6VKeCIowVb1uI/BVN+FoXF8MPL+r36DdU66o6DkFnDjgKcrydEv1tMBPyUIkaTmFKJFe9JVw==
X-Received: by 2002:ab0:2385:: with SMTP id b5mr1568218uan.73.1548276180669;
        Wed, 23 Jan 2019 12:43:00 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id g195sm49862555vka.5.2019.01.23.12.43.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:43:00 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id p74so2185893vsc.0
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 12:43:00 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1560245vsl.188.1548275782895;
 Wed, 23 Jan 2019 12:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com> <20190123191802.GB15311@bombadil.infradead.org>
In-Reply-To: <20190123191802.GB15311@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 24 Jan 2019 09:36:11 +1300
X-Gmail-Original-Message-ID: <CAGXu5jLNvHVhbyr5Cbyoe8o0ARv52sU-NEpD+u2UYfESM3ofCw@mail.gmail.com>
Message-ID: <CAGXu5jLNvHVhbyr5Cbyoe8o0ARv52sU-NEpD+u2UYfESM3ofCw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of switches
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, dev@openvswitch.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        intel-wired-lan@lists.osuosl.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 24, 2019 at 8:18 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 23, 2019 at 04:17:30PM +0200, Jani Nikula wrote:
> > Can't have:
> >
> >       switch (i) {
> >               int j;
> >       case 0:
> >               /* ... */
> >       }
> >
> > because it can't be turned into:
> >
> >       switch (i) {
> >               int j = 0; /* not valid C */
> >       case 0:
> >               /* ... */
> >       }
> >
> > but can have e.g.:
> >
> >       switch (i) {
> >       case 0:
> >               {
> >                       int j = 0;
> >                       /* ... */
> >               }
> >       }
> >
> > I think Kees' approach of moving such variable declarations to the
> > enclosing block scope is better than adding another nesting block.
>
> Another nesting level would be bad, but I think this is OK:
>
>         switch (i) {
>         case 0: {
>                 int j = 0;
>                 /* ... */
>         }
>         case 1: {
>                 void *p = q;
>                 /* ... */
>         }
>         }
>
> I can imagine Kees' patch might have a bad effect on stack consumption,
> unless GCC can be relied on to be smart enough to notice the
> non-overlapping liveness of the vriables and use the same stack slots
> for both.

GCC is reasonable at this. The main issue, though, was most of these
places were using the variables in multiple case statements, so they
couldn't be limited to a single block (or they'd need to be manually
repeated in each block, which is even more ugly, IMO).

Whatever the consensus, I'm happy to tweak the patch.

Thanks!

-- 
Kees Cook
