Return-Path: <SRS0=Eu+3=PE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD8C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18693208E4
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UaGiHvxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeL0UHy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:07:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39119 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbeL0UHy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Dec 2018 15:07:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so13339499lfh.6
        for <linux-security-module@vger.kernel.org>; Thu, 27 Dec 2018 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9biiqvLbgan2M46fa2TUhhLk+1qVcVSm4lWGhiXXsls=;
        b=UaGiHvxfgHhXTMzRdYdPWkujV7fyZp8Z9l/RUSrpnI1ibbiSS7XNLuDIODv63jL9s3
         6K3ltSCVnDIoH1dJ/abUlVT6+eHQMW3QJc75ICzRorku2hmccoJHDkNjD/HJR+wI78CS
         DDBbioR4W6QZqjq+TDWeitaykezcwhxfYPero=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9biiqvLbgan2M46fa2TUhhLk+1qVcVSm4lWGhiXXsls=;
        b=tLYwvCf7iPs58NBnKXIhiGS+2YSK51X7rn9EHkGPukS9rWkPpmSaofzET5iTi0/Mk5
         HaYvKIlHlLFwuYJQyCbbjK88VxtqLpW8UrTfzddGh3xphbLgPcQre9Pn/QUHF0etDDri
         RL2eQ0uYWQA0ixnJRWr0xcbaPV1KA3dctCu8+GkhzXkgdRE+SqgDjzMeWgSxUgU/6iWS
         tUHHPwqCR35a9j5vJvlk60XGYBuiwd4kgQkUHY1EgbFByi8JlY1Rcvo/kJFpetLtvL7v
         BTERngbltk8ab+/mcgC2jbski1AbZHFpEse0YaVz24CA0z0zmJTaSkGeHmLV42W+eH7z
         T6GQ==
X-Gm-Message-State: AA+aEWbIAm7UKuyD7NI7n8+B21N3m0mNfGBazyjAgtEDysnpMfGWwA6s
        Vjg7KDPnd37rE7oliWTXg/d8fymMkz8=
X-Google-Smtp-Source: AFSGD/WFtZ+OvCHZ25x5z61QrF3YMtpmT5oTEDN+ihmnqQaOT7p+JAv6yoVwt0JrAKIrkvASE6N9GA==
X-Received: by 2002:a19:280f:: with SMTP id o15mr12193564lfo.0.1545941271966;
        Thu, 27 Dec 2018 12:07:51 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u26-v6sm8064867lji.22.2018.12.27.12.07.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:07:51 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id v5so13326489lfe.7
        for <linux-security-module@vger.kernel.org>; Thu, 27 Dec 2018 12:07:50 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr9006323lfc.147.1545941270513;
 Thu, 27 Dec 2018 12:07:50 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812250652420.2714@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 12:07:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
Message-ID: <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 24, 2018 at 11:55 AM James Morris <jmorris@namei.org> wrote:
>
> The main changes here are Paul Gortmaker's removal of unneccesary module.h
> infrastructure.

I will point out a merge with a horrible commit message:

    "Sync to Linux 4.20-rc2 for downstream developers"

that tells nobody anything.

Why was that merge done? If you can't explain the merge, just don't do
the merge.

                 Linus
