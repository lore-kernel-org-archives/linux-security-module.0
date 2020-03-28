Return-Path: <SRS0=+cyb=5N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A1C2D0E5
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA912073E
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rq3TMeuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC1Vw6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:52:58 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54071 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgC1Vw6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 17:52:58 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so5680945pjb.3
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCEn6jiYkuBInipnn6zCj3DDSQcSKN3aqUSzXbErLKE=;
        b=Rq3TMeuPbUxxPHxnu2HIoc61sTFjgLQaNuXNOiePL7aKZf69jQ+dFmmXivkyriybNW
         vgQPzAGLknpxdaaBjXnKSMKfGascpAM2sveRdm1tiga7RQ5eBW5zwWegcXEF3OuBmBHO
         GYik2IFuQR2m0KTYbl2FbSa8Eqyejs4hrgep4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCEn6jiYkuBInipnn6zCj3DDSQcSKN3aqUSzXbErLKE=;
        b=uVMMp4q8ZBkKJTZNK03wJX7E50ORuO8qXOFyzMUtgedctxBY8A7/uTp1CkpRa7QRbI
         UAYmXoSGy982MeGugTmicxTXTvUg2zfSf5Kk/mNFjeZiQTiOmyO42kC8+OuQmApftwTG
         w5u72B3uYLAG/tptqEpLJvH7pZdqUwPT9Is1IQ8lpbtl4Rn/G6iz7Z9lPz2nJ/ngnq5l
         ujQ42zWElA2B1cUb+5xX3IU0Si+gFnHxyeHG6LhfqQBF1kFuMtPSiocL5eIJ1kj5hDd6
         Ghpb3lY6tyLOTeR4oQGLgv9AiEXX4InZvBqvAgQvNlYoLi8QFhZ5umgsYbjOtcyFm+M6
         6jfw==
X-Gm-Message-State: ANhLgQ2JYx1C+BfDdpEO9tfodKpG6LJxKLH8W+k20CAY8AYJ3jiNfUq0
        i2kurj929dPfVqUc5pU4K5dmdQ==
X-Google-Smtp-Source: ADFU+vuQs9Pb6Y6ncTb5sBNwy1tSr0+fCbtZKLnv4G2coXixK0YG2/jVjP1gF9qzdCIgU8SdYOki7g==
X-Received: by 2002:a17:90a:368f:: with SMTP id t15mr7297208pjb.23.1585432376997;
        Sat, 28 Mar 2020 14:52:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i189sm6840804pfc.148.2020.03.28.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:52:56 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:52:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
Message-ID: <202003281451.88C7CBD23C@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-9-gladkov.alexey@gmail.com>
 <202003281321.A69D9DE45@keescook>
 <20200328211453.w44fvkwleltnc2m7@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328211453.w44fvkwleltnc2m7@comp-core-i7-2640m-0182e6>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Mar 28, 2020 at 10:14:53PM +0100, Alexey Gladkov wrote:
> On Sat, Mar 28, 2020 at 01:28:28PM -0700, Kees Cook wrote:
> > On Fri, Mar 27, 2020 at 06:23:30PM +0100, Alexey Gladkov wrote:
> > > [...]
> > > +	if (!kstrtouint(param->string, base, &result.uint_32)) {
> > > +		ctx->hidepid = result.uint_32;
> > 
> > This need to bounds-check the value with a call to valid_hidepid(), yes?
> 
> The kstrtouint returns 0 on success and -ERANGE on overflow [1].

No, I mean, hidepid cannot be just any uint32 value. It must be in the
enum. Is that checked somewhere else? It looked like the call to
valid_hidepid() was removed.

-- 
Kees Cook
