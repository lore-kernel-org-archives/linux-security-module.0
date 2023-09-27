Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ABDE7F14B
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Sep 2023 02:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjI0CCq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Sep 2023 22:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjI0CAo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Sep 2023 22:00:44 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7353599
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-351265d0d67so5547265ab.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695777510; x=1696382310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSK45h5LTS9VqkVC57gaj2Wd82aeyGKZrEYe4dJCVic=;
        b=bxVM6N7U4F+Ynjj38INwi6ASqm3IBKUZ2yJDT7Ckbee+wq9E3UZNBRzyGfQcYS34Zm
         390zUF6zyX1jXsJs0qezpAIk0Fh/LHYP2jTC2k9Oekg0LvZ2uiw1Xok3H/KHren2K1Kj
         zuzTpI7pO+/1KMER6qwgrgRDhYD6SZbd/b9wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695777510; x=1696382310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSK45h5LTS9VqkVC57gaj2Wd82aeyGKZrEYe4dJCVic=;
        b=wlALNW2u7RRDK1I1FqxLpN/xsTcKJRz9vNQhBSSp9ZLETxntH0bHbCTvOrc0kBqq65
         Y7YLrzedBowK728kkR4MAO1ajRR06bVFXkrfdvyAT4fK8MJLKejfzW/fHyIqXj8aAFfk
         vHwPykMBHLAZ8e4udFgZSSF407zGsZnLOHUmRjteJTMR9ENcqLFIicZfcwEN1gDiwUxZ
         srGYX0pHgqucLxtLbZSwtWpC0bIA/JBmWkm5vITtRmFZQt+CDOj8f+f8Ncfphbrlgzeh
         YBRFTuknA4Erq2kxcJuv08BRXhMqjPmhEzKKY8bwKaQ5MISftL9HwaasMAWzA/I0IFbl
         SOag==
X-Gm-Message-State: AOJu0Yzxkj0lEK9E4bwSRK5KOvq3A/w3nFNvT4y0wnc2vGknjiQY5jAS
        v9X9ASM9kOgqduesx0gybEeuMg==
X-Google-Smtp-Source: AGHT+IE2jaCutfBvakslg8GPNafee+TlzK+8frCnXrODTVfbk9z1YRbburEMP7cvS9iSP7ZFw0fvlQ==
X-Received: by 2002:a92:cc46:0:b0:350:f353:4017 with SMTP id t6-20020a92cc46000000b00350f3534017mr614948ilq.0.1695777510062;
        Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y3-20020a92d203000000b0034f3220c086sm2389624ily.12.2023.09.26.18.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 18:18:29 -0700 (PDT)
Message-ID: <fc915b30-5842-5851-bd76-71c2133685b9@linuxfoundation.org>
Date:   Tue, 26 Sep 2023 19:18:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: Fix wrong TARGET in kselftest top level
 Makefile
Content-Language: en-US
To:     Juntong Deng <juntong.deng@outlook.com>, shuah@kernel.org,
        mic@digikod.net, brauner@kernel.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <VI1P193MB0752596147F224B9F921C85199C3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <VI1P193MB0752596147F224B9F921C85199C3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/26/23 12:03, Juntong Deng wrote:
> The 'uevents' subdirectory does not exist in tools/testing/selftests/
> and adding 'uevents' to the TARGETS list results in the following error:
> 
> make[1]: Entering directory 'xx/tools/testing/selftests/uevents'
> make[1]: *** No targets specified and no makefile found. Stop.
> make[1]: Leaving directory 'xx/tools/testing/selftests/uevents'
> 
> What actually exists in tools/testing/selftests/ is the 'uevent'
> subdirectory.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---

Thank you. Applied now to linux-kselftest fixes for the next rc

thanks,
-- Shuah

