Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58186C678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCBTjW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBTi4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 14:38:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB21EBCF
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 11:38:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3863691pjg.4
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677785932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4s1PB0aDKExEegP9jlohCN7POU8aMDSrP9HExeQX7hE=;
        b=PDwrHB+wGAdVzxzh75ThVl/h+cmP6p1si7veW3AAIKwCIO3UEkxX9+U45yDNqu6b2K
         MoZQy6HdF7M5G3YZw5E9QldquMwEJy5BroncERHgeG83qG6I5pLKQvsbHTgcjn+2ddop
         NX6kzzmXhsdobsAQGPaC1LbvkYW5AedmhRY6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s1PB0aDKExEegP9jlohCN7POU8aMDSrP9HExeQX7hE=;
        b=Y1zbwrGApDnga3RNjypjxI0HnhXJl5sTy8Ryu+21irkhGzQ2lf6MU/xipJ2Hlv/3+o
         +G/hvs+wXlCtC/+dsUGHG9937mLZuo+WUiHSyeHC0/dYZcLu2C6FV3qsSZKvo3O/imYW
         JG+BxFmw4MaF8j9OtkCGMkYRYqxOt93YcncoTw3UX0jw2e/l8quXq+EFHCTpG8Q3/2l0
         G3FJgKkxju4anlzheAMu6KbxHIDylV/OCPfWPr6g19AOM9YWkUckqqOzJj8LwqSBU8Qe
         fD+0gCJshtN1HsK4ZxqR5iAzU8CxEy4FpPBnNjsLEiE/eQu9DbtTRwCE9b3zZ8zS2qrv
         BN2g==
X-Gm-Message-State: AO0yUKVQd/fjr4iMwMzTAPx7tWGRru+3+yK6XGwNuPidzvDnlJXDBtdi
        y1lN70mppndGOQdLSVM0skOvlg==
X-Google-Smtp-Source: AK7set8ZFHS1yuQhcmnpgyrHR8bfbE/pwCOzBeXngxgWgAjy+v7kcD0MAWpsfDqJo/89d6UfZ2E4RQ==
X-Received: by 2002:a05:6a20:6605:b0:cb:c276:58d6 with SMTP id n5-20020a056a20660500b000cbc27658d6mr10116611pzh.34.1677785932135;
        Thu, 02 Mar 2023 11:38:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b005d6cb790c35sm63736pfn.119.2023.03.02.11.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:38:51 -0800 (PST)
Message-ID: <6400fb4b.a70a0220.39788.048e@mx.google.com>
X-Google-Original-Message-ID: <202303021127.@keescook>
Date:   Thu, 2 Mar 2023 11:38:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> On Thu, Mar 2, 2023 at 11:03 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> > just to make it possible to say - exactly in situations like this -
> > that this particular slab cache has no advantage from pre-zeroing.
> 
> Actually, maybe it's just as well to keep it per-allocation, and just
> special-case getname_flags() itself.
> 
> We could replace the __getname() there with just a
> 
>         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);
> 
> we're going to overwrite the beginning of the buffer with the path we
> copy from user space, and then we'd have to make people comfortable
> with the fact that even with zero initialization hardening on, the
> space after the filename wouldn't be initialized...

Yeah, I'd love to have a way to safely opt-out of always-zero. The
discussion[1] when we originally did this devolved into a guessing
game on performance since no one could actually point to workloads
that were affected by it, beyond skbuff[2]. So in the interest of not
over-engineering a solution to an unknown problem, the plan was once
someone found a problem, we could find a sensible solution at that
time. And so here we are! :)

I'd always wanted to avoid a "don't zero" flag and instead adjust APIs so
the allocation could include a callback to do the memory content filling
that would return a size-that-was-initialized result. That way we don't
end up in the situations we've seen so many times with drivers, etc,
where an uninit buffer is handed off and some path fails to actually
fill it with anything. However, in practice, I think this kind of API
change becomes really hard to do.

-Kees

[1] https://lore.kernel.org/all/20190514143537.10435-4-glider@google.com/
[2] https://lore.kernel.org/all/20190514143537.10435-5-glider@google.com/

-- 
Kees Cook
