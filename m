Return-Path: <SRS0=iWO7=Y2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C111CA9ED0
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22177217D9
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572736217;
	bh=yT2xfdk7VhanLkx0HAZLMAhJ+HGrris22TSXnZ7QnSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ugZ/r5lSTKlZvvaGzcvEJgio8NNJJTWZ72Be61e8q4ebGCN4I2JCiODdCfzcE04Bq
	 dVckax80d1VAUcueHPwJ8slWj2ke6subBf9FrXlQ2TvCHqx+7/McS1R2b1E4/Izqvd
	 viiT9U8jI3SZXHmhscHkS6TN39jxGUsdcOPGEELY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfKBXKQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:10:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36431 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfKBXKP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Nov 2019 19:10:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id k15so1664438lja.3
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=Vx52JGJ2fL2ca9BB2NXhwTThadLFJNdykQ5Qc2uEp2vn5uwNFrfyadC6EXLjhvKklV
         KXMcjJQrv3h80vcy/cZZjfo/5qqKgj2fI2pWR4TA74i3RLzoy9MP14q5tRVf25F8gLLb
         ceXpd5ICYbOD7PSidUN5wWZK5ccyx9qRkG23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=QuvHJmYfXRPKh6vKOp3lXV7JMcHE+LgY6uhtiOrlZR0p4gMufNUaafiWuQkVFzEXue
         lDLPGsHLIrf9SvVPJvhEzuGdobCl7IbtMZAB+04wDecJh2Z43wzug6LaFABd6HGD1C85
         ZL6AWFPKHp4pFA+aWe21f8wKzl9YFNkWOqaOPIxpts/4eYRJlFhIcuyiP65uMfJWxaP6
         5JtQSF30ddvV6HS1mePJlJGVmK3nAByPs1XdqPEQvi/3xOUhpS74CGpvUzlSF95xSIRD
         8DrMv0bjI0tZXnGHEaLDw/YhrtEAwcrwkVrIQyNWd0UfZmHshX3ip5W4kOAACiFcqUqi
         RIeA==
X-Gm-Message-State: APjAAAVDQ5AKhvrYeM2pB9ET65GWbDyIALWFvorQb/Raf4uMiRZhFXqa
        +3iuSkEAappFRMI/oqYXLPQ8JeLA/1I=
X-Google-Smtp-Source: APXvYqwDyS4dpk5U5q9LOKKuAdr2LS7+gAR2KL8L60xWqU7+U9yCQyDnwN3u9j3THMC6W1ukVA8b3g==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr3725656ljj.235.1572736212836;
        Sat, 02 Nov 2019 16:10:12 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u7sm2997562lfb.80.2019.11.02.16.10.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 139so13812023ljf.1
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr1543119lji.97.1572736211179;
 Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net> <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:09:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I don't think anybody actually _did_ any of that. But that's
> basically the argument for the three splice operations:
> write/vmsplice/splice(). Which one you use depends on the lifetime and
> the source of your data. write() is obviously for the copy case (the
> source data might not be stable), while splice() is for the "data from
> another source", and vmsplace() is "data is from stable data in my
> vm".

Btw, it's really worth noting that "splice()" and friends are from a
more happy-go-lucky time when we were experimenting with new
interfaces, and in a day and age when people thought that interfaces
like "sendpage()" and zero-copy and playing games with the VM was a
great thing to do.

It turns out that VM games are almost always more expensive than just
copying the data in the first place, but hey, people didn't know that,
and zero-copy was seen a big deal.

The reality is that almost nobody uses splice and vmsplice at all, and
they have been a much bigger headache than they are worth. If I could
go back in time and not do them, I would. But there have been a few
very special uses that seem to actually like the interfaces.

But it's entirely possible that we should kill vmsplice() (likely by
just implementing the semantics as "write()") because it's not common
enough to have the complexity.

             Linus
