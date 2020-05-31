Return-Path: <SRS0=UHBo=7N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D8C433E1
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855E3206E2
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtXzKiC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaRK0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 May 2020 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaRK0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 May 2020 13:10:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA00C061A0E;
        Sun, 31 May 2020 10:10:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u17so4854884qtq.1;
        Sun, 31 May 2020 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RDQSd8wT/WGJwb5uvCrzE3OEzD02oi7ERDrzQUh3UCY=;
        b=BtXzKiC4TDiIzWZtHfOHlC1Aa4nHpc9ThwWj7n5nGbDCJRZHDDn8WPeB4EFobLU7+m
         5kLjuwESbDF/z9DRY5STypx4CSIbKbn5MhfHYFzWcU8xYsJqFUdO9DhYBP1RipE6OW08
         E7OoU7ZRFh0xHoLfbJRQqnvoi8rhh6zwZ306aE7XCBbPwBAbtfPObNUsKbTkoXBMBSWL
         W2HbTJ4VhnYPhCwOI2AWRDK+2ZCAXlsrwDz9crE+47V+ky9wGIHLBBcPAImmav6DVe7s
         5l/VrguT19iFz1oPGjpnGxCYY9JZNPne8Y8IijgWK7pXX5ZXWDZTyLSgCHk/q5fz6EwJ
         G7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=RDQSd8wT/WGJwb5uvCrzE3OEzD02oi7ERDrzQUh3UCY=;
        b=IJfhyH3PzmKOinINmd1Vi8DxccJDpqpfKvIGw7ney2uZ6dx6+s2lkEK6LjhGhewxMN
         sqzfcphIGMP3KO3Ga4R9p0cjBvuWlQERhmL4zz053nO/y6K9QbUd2Dfhda8mS5auCm/B
         s62Y9nXeUYSOaFD8LNbpxuLy4xyFqamev+Zze2yBSmA4nTvDkw0HBlm+YHh0RLlCaJzs
         nSSvnlYfPCVz2j1tebzAfLv4GZJVGFEeZsK6mXrew3NUT6IEcBFY3+rNH5jpRGe6n1hM
         SwyEJQa+t8y1h2EQX/A7AyxuD1jn7qq16ckYrwt6vykhRkS/E7gB0o0dURZZKjCocoR/
         wV2A==
X-Gm-Message-State: AOAM531V6zl32OJe/biakIkySbNJT34uNvasZPvh7ZEF8E1NPC8+/6/g
        I4jeIFtCye1TED1Yp1R6fxkdkiQwJTzA9A==
X-Google-Smtp-Source: ABdhPJzvsUZxaa9DWn0omzsk23n+GSvUI4ajQFp6XgKr3hKULInMP45+bW1x5b8bLhCB0i3U8PXcCA==
X-Received: by 2002:ac8:b48:: with SMTP id m8mr18463869qti.206.1590945023926;
        Sun, 31 May 2020 10:10:23 -0700 (PDT)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id w94sm13295959qte.19.2020.05.31.10.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 10:10:23 -0700 (PDT)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-security-module@vger.kernel.org,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20200530055953.817666-1-krisman@collabora.com>
 <202005300923.B245392C@keescook> <851rn0ejg9.fsf@collabora.com>
 <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
 <20200531164938.GF19604@bombadil.infradead.org>
From:   Paul Gofman <gofmanp@gmail.com>
Autocrypt: addr=gofmanp@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c007e3e9-e915-16f3-de31-c811ad37c44c@gmail.com>
Date:   Sun, 31 May 2020 20:10:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200531164938.GF19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/31/20 19:49, Matthew Wilcox wrote:
> On Sun, May 31, 2020 at 03:39:33PM +0300, Paul Gofman wrote:
>>> Paul (cc'ed) is the wine expert, but my understanding is that memory
>>> allocation and initial program load of the emulated binary will go
>>> through wine.  It does the allocation and mark the vma accordingly
>>> before returning the allocated range to the windows application.
>> Yes, exactly. Pretty much any memory allocation which Wine does needs
>> syscalls (if those are ever encountered later during executing code fr=
om
>> those areas) to be trapped by Wine and passed to Wine's implementation=

>> of the corresponding Windows API function. Linux native libraries
>> loading and memory allocations performed by them go outside of Wine co=
ntrol.
> I don't like Gabriel's approach very much.  Could we do something like
> issue a syscall before executing a Windows region and then issue anothe=
r
> syscall when exiting?  If so, we could switch the syscall entry point (=
ie
> change MSR_LSTAR).  I'm thinking something like a personality() syscall=
=2E
> But maybe that would be too high an overhead.
>
IIRC Gabriel had such idea that we discussed. We can potentially track
the boundary between the Windows and native code exectution. But issuing
syscall every time we cross that boundary may have a prohibitive
performance impact, that happens way too often. What we could do is to
put the flag somewhere, but that flag has to be per thread. E. g., we
could use Linux gs: based thread local storage, or fs: based address
(that's what Windows using for thread local data and thus Wine maintains
also). If Seccomp filters could access such a memory location (fetch a
byte from there and put into the structure accessible by BPF_LD) we
could use SECCOMP_MODE_FILTER, I think.


