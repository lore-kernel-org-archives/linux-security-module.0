Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685CC4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 18:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLMSAC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 13:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMSAB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 13:00:01 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF6423E99
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:00:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id i20so467104qtw.9
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbRAnoqymAJfC3zXHkWF5bbjiGJlFTBQeIItWXOJas0=;
        b=U08O6w0iGNcFlw4uzxsh16PLz3Tcq/00MpL2G94L81w0985I6T9RfhMThVC5y/56l+
         PmNnIduXpbypaPgRTjZnxEf+CR/gawJa3UmVYv2ce5L8L38dUK6BMrikv/525YL58TXY
         yXGn0D1Si/ormMDVmNHmkJFzz6IYhR9KHkQuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbRAnoqymAJfC3zXHkWF5bbjiGJlFTBQeIItWXOJas0=;
        b=NdathzqQ38QHZcy4iHYjSlrri7PfyAPQKboanSCYXgy35X7p+79aR7tpfv8LwDNUoe
         eEy6lhvGTdocJGL+c3hlvz1QobunpDTrbIov03m3Nnk3o+MlsB7ROhIBs7MM8/LTonpP
         AKH1PY2VHA3AkxFVjda626d1RpOgOoWJ1n/YSrltDBV6S0sM5D5R7Fcep4la71Wii6Tf
         iIVwfT+1detYnrKfdFDIC9Ct3GyQeDXY5T4xzDcaOc0PijHpsecyeguL5wtajkBqQb7D
         yEaMeKsrMopyj9d0lpZRKBosigJtCINrBxCi6rQXecW+SGboMIoU6/x84aNg8xqGsJ0V
         oNhw==
X-Gm-Message-State: ANoB5pmXgp9B8+h2os9GgX3rMJLBwlRFcm0IzPzMhf9rHinZQdlAI+wD
        F8LRlzK6mhDvSP0CTpu8ZWUY6V1LSUrY9wL8
X-Google-Smtp-Source: AA0mqf4AdjdgetkSECwOg+b2+UjLEQspWN9EdJFbyxlgQXh2260ajCCt7Itq2Xrv2EOl3l4XXqh0bg==
X-Received: by 2002:ac8:6687:0:b0:3a7:fd7e:7db4 with SMTP id d7-20020ac86687000000b003a7fd7e7db4mr24273905qtp.57.1670954400086;
        Tue, 13 Dec 2022 10:00:00 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id s17-20020ac87591000000b00398ed306034sm234922qtq.81.2022.12.13.09.59.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:59:59 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id j26so234582qki.10
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 09:59:59 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr84435150qkd.697.1670954399159; Tue, 13
 Dec 2022 09:59:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
In-Reply-To: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 09:59:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK_Ocw+Xmeq=XTQATV_MDwj+kE+F2jyPg+2=jc3hzH8g@mail.gmail.com>
Message-ID: <CAHk-=whK_Ocw+Xmeq=XTQATV_MDwj+kE+F2jyPg+2=jc3hzH8g@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 12, 2022 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
>
>  You can fix those up yourself or you can pull the tag
> below which has the fixes and has been sanity tested today;

Thanks. That was a particularly trivial merge, but I always appreciate
just being able to double-check my end result that there wasn't
something I missed.

                Linus
