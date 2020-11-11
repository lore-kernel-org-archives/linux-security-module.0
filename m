Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B65AC5517A
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013522072C
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0hJSJOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKKQDb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKKQDY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 11:03:24 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFAC0613D1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 08:03:23 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p10so2440078ile.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1jRZwSuuEQg/bscnGGcsBqPGqmw90tTjNeAiADGZWQ=;
        b=J0hJSJOtZ8cKp8g+AeRYn4zxI0z474RogLJ5yTPblSThyhiNsosQswbzULN0LbKveR
         X0HAP1BB/hEjAalzEOtQYXHKBPj76Ny52sSHtoN3iZ+Hs8inttTe9EdPQNaO01FSCro6
         PYFW08h9SJjByeNV57EQfbTW7Znk7xIl6IRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1jRZwSuuEQg/bscnGGcsBqPGqmw90tTjNeAiADGZWQ=;
        b=iZqrCH+/TkqjkbCrAAZZtusiTGH+ASMcGwU/JywaZP1NWxZVraAOdEXKf4qfVtvIPE
         DgJS6lx+WG2P8WWneMoY+dXTcEc5PMOjxbeNXqRnBaJekTmE1qq/Ix+Y1uzcznBNRrLg
         nUIQRNoqMkS2GeHLckwauws4Oi2JhMz3hOEEO+L7XVPEIXzBjQ4r/vtkb/Jef/hOyKpe
         UAgm3ICVKIaf1DqAmQB0/ugpKKKG2GRWz6PUZ9Lo5/H4T7kfUUy+qpnyLvCnZA6NvL0U
         wJU4hVOREsLcQZyBztM4h3XRTGwIGlNXETt3Fj2RM7T5ir1A0US9apuKwcb9RoKacU61
         hlQg==
X-Gm-Message-State: AOAM532bYE7t2N4ZsfhUtVzlVr166/sz+xnYWRxvpXe8wepelhFsAemP
        BL+1m3TuiSVjAxLG6DV7hsrd9g==
X-Google-Smtp-Source: ABdhPJzfuPKbLPy0S959f+cmN74uBmhaZrB/aTXCrRPM53UdGcZ4oGHwyut2AWmWt1ZgJZjUJccyXg==
X-Received: by 2002:a92:6c11:: with SMTP id h17mr12292757ilc.270.1605110603170;
        Wed, 11 Nov 2020 08:03:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x14sm1533054ior.7.2020.11.11.08.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:03:22 -0800 (PST)
Subject: Re: [PATCH 00/13] Introduce seqnum_ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, skhan@linuxfoundation.org
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <20201111043304.GS17076@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e84de5d0-f2b2-5481-eb8e-47370d632c4d@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 09:03:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201111043304.GS17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/10/20 9:33 PM, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting sequence numbers and other statistical
>> counters and not for managing object lifetime.
> 
> We already have something in Linux called a sequence counter, and it's
> different from this.  ID counter?  instance number?  monotonic_t?  stat_t?
> 

No results for monotonic_t or stat_t. Can you give me a pointer to what
your referring to.

thanks,
-- Shuah
