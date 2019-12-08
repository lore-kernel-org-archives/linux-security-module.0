Return-Path: <SRS0=8RRK=Z6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C32FC43603
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Dec 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD73205F4
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Dec 2019 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575829171;
	bh=6D2BLjT1MjmYJi5BZ3eUc40zDPEQHm5kYxiP0y9flB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IkgpWTOYbeLLYG1rKjWJL+BXGJ191QTy03jWDnIQw/LyjCz7wvgPfcfOOtMH2WXcW
	 MGxSgikAAkp5fefWnqTlTU+bqjx3p3KwcYewcRpYAHln/6jfoGFzioLO4iHLDe8OKV
	 IHz7XDLQBbEH3ZNePkVjxiRD+g4Z98ZphY43tEN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfLHSTa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:19:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35439 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSTa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Dec 2019 13:19:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so13085428lja.2
        for <linux-security-module@vger.kernel.org>; Sun, 08 Dec 2019 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=H0B9voLfv9AYLRDixmAeg/5DRF8QLotazZN/4owvkzDMXfPsktWaen4Q3k9MedABQL
         0pB2E+DsxZ88pf8Iftm8Zpi/eUzhjTeP2HrbKUH1z9La6YaZoUY5Mc7J6SV7VX3rGun9
         NOn+0S2wMJe3ABAu0HEETzU4Av3UFzbmNvuFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=lj0q86SiWyP6PbLIa6+LA4TDBs4zAb9K88uYyU8dVagXpHZjgazmQklTHFIZPH83yF
         4Kq824eJjS8EUyOFFigR7bzKLukYQxSFABQfSf0DWhWV5UKEJ3UQbN3gMxmpCWYA/Ewa
         6YV3nBgbY6xdEO0QPbhh+NYzs/T3UrSAYmp1SQ22ru/brUn7Ivmla522qz0WAMfUrI0E
         Tqx7e0N95jMxl8dxzZ6bVSi9iNQJUi/6o8F1A520uPKp3QYoFGTSm0xP7RrtFNoY4185
         iaHR+3u4ytCA+87Dvl2CZemoO2FjmlfkShquknJ5i2LsjUnbFYfImQfqTnA1RYd27MR5
         DfJg==
X-Gm-Message-State: APjAAAXaUL/Qo/5tkgfLRKNug3zpr7e//tKzhcLZ+C9HVDJeyNX1V8eI
        1ALoT5Oa3qnvyzEtGrnSw6bpu8rJwAg=
X-Google-Smtp-Source: APXvYqwjlowbU++FPt8ZggMqj7xuRQRBm2xwSGQ7eEiwhQtEQJNafwcdQlBsnnJPdnjc7PVMloBChw==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr13770899ljj.206.1575829168201;
        Sun, 08 Dec 2019 10:19:28 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e20sm9785564ljl.59.2019.12.08.10.19.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 10:19:27 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id r14so8933843lfm.5
        for <linux-security-module@vger.kernel.org>; Sun, 08 Dec 2019 10:19:27 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr10244080lfo.134.1575828667708;
 Sun, 08 Dec 2019 10:11:07 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude> <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
 <20191208175602.GA1844@latitude>
In-Reply-To: <20191208175602.GA1844@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 10:10:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
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

On Sun, Dec 8, 2019 at 9:56 AM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> whereas with a fresh cloned repo I get:
>
> v5.4-13331-g9455d25f4e3b
>
> I assume the later is right. With this version the bug seems to be
> fixed, regardless of the commit count. Tested with different websites
> and firefox works as expected again.

Ok, good. It was almost certainly the select/poll race fix - Mariusz
Ceier reported a problem with youtube hanging, and confirmed that the
poll/select fix seems to have cleared that one up. I suspect that your
hang on fb and spiegel.de were the same thing.

So I think the pipe code is stable again with current -git. Thanks for
reporting and testing,

             Linus
