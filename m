Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F7DC678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCBTyG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCBTyF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 14:54:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303C16ADF
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 11:54:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so405989plf.10
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677786844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPgYLv6lYLGlNO2NPrtA30mIkNmqpF6DOGQTD6NOI2A=;
        b=WKq6nYU84T2GjPSgPjLMj9ONaPARuYK2Ad1yuOY9DGsrWGFj4WkxocR+EUW8FzXS3b
         gRhB85J69pU6QwBznfn2qrPRqHCBWvVviIwWCquS8XE50Qj43ZRvtcwrIPd85CbMEmST
         /F27/4fHRumBexB2mG/pPQnN/EtVFvZMzZlFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677786844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPgYLv6lYLGlNO2NPrtA30mIkNmqpF6DOGQTD6NOI2A=;
        b=o8Mhp71YHNwKe1QybTkD3NNOAWpa49cKQzoGJEYNKs9QNrepAVzFr+JoTELyWQwACO
         oFVe/fdl+eHfxXytmP7VzCrOjKDVwj/W/B/P5pq6jlE4Br0FP9rEi30iTwxAX//bER/z
         UkG55/LdAQTHIfeHnATT843apC9F7Yewb443uAxhg81pD9DkjLnavvtFxTC70lAR2Ji7
         oRV6NtDT67JmECpJXl0xCVvJGNoHLt96ZamwwukM4Cj8jX0+RUuw3XIiNBErAKu7sTdH
         dFJbMwh8hT5x0BpH4GUgYpOQWWyUTztYRy3kYOKnj+Qp/OA1b6+IOCeY5UaKiTK39VDY
         n9KA==
X-Gm-Message-State: AO0yUKUtlX89LGw3sFJqKfhaxLWK41ifSB0CyLX0mf6evOVRc6B7trVp
        bh6U8oBw/50PA7zDh98oCKbIiQ==
X-Google-Smtp-Source: AK7set8cMneRnOzUf9HmSOrEyAAAr/zXjrTqsx0CeaOdpGYWa/1YP+GHIynAJwhigY5dwhd8TZ5YQA==
X-Received: by 2002:a17:902:c946:b0:19c:d401:ecb with SMTP id i6-20020a170902c94600b0019cd4010ecbmr12199825pla.63.1677786844233;
        Thu, 02 Mar 2023 11:54:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b0019c13c4b175sm72200plf.189.2023.03.02.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:54:03 -0800 (PST)
Message-ID: <6400fedb.170a0220.ece29.04b8@mx.google.com>
X-Google-Original-Message-ID: <202303021147.@keescook>
Date:   Thu, 2 Mar 2023 11:54:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
References: <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAD21ZEiB2V9Ttto@ZenIV>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 02, 2023 at 07:19:49PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> > On Thu, Mar 2, 2023 at 11:03 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> > > just to make it possible to say - exactly in situations like this -
> > > that this particular slab cache has no advantage from pre-zeroing.
> > 
> > Actually, maybe it's just as well to keep it per-allocation, and just
> > special-case getname_flags() itself.
> > 
> > We could replace the __getname() there with just a
> > 
> >         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);
> > 
> > we're going to overwrite the beginning of the buffer with the path we
> > copy from user space, and then we'd have to make people comfortable
> > with the fact that even with zero initialization hardening on, the
> > space after the filename wouldn't be initialized...
> 
> ACK; same in getname_kernel() and sys_getcwd(), at the very least.

FWIW, much earlier analysis suggested opting out these kmem caches:

	buffer_head
	names_cache
	mm_struct
	anon_vma
	skbuff_head_cache
	skbuff_fclone_cache

Alexander's analysis more recently[2] of skbuff went a bit further,
I think, and allowed opt-out for non-kmem cache page allocations too.

-Kees

[1] https://lore.kernel.org/all/20190514143537.10435-5-glider@google.com/

-- 
Kees Cook
