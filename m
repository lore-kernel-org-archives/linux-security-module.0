Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8027C004D3
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 10:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B94207DD
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 10:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SGQfsiNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B94207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJXTTA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:19:00 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38853 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeJXTTA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 15:19:00 -0400
Received: by mail-lf1-f45.google.com with SMTP id x24-v6so3595697lfe.5
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8fpNZgBwP03I04wKzss8HNVJHCepCy3mKSjCctRFao=;
        b=SGQfsiNdUWmhRlHsCHWj1khRioB9glSY+xazUQNXsbx6lTCCvwdYt06KahZq2RuJ/Z
         SI2kYi2MWXZr2585GPy5nmHhOlnTvsCprCy+tYBr6byobgYUwym6PzNirnQKppVUM4qT
         /kkoaoWzeR7TVs3DfvEmEYQDzdtCniZYucQWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8fpNZgBwP03I04wKzss8HNVJHCepCy3mKSjCctRFao=;
        b=j9t7rChUfqmfQfX6P4PvQRrzIvBmX3ifxDd3HNl2kx+n9gek5xKKQfDY5g2rzs+wwY
         SCLYQhV8Tn6yCW+kObLidqpLj6iNo3rWlrny0bQYDrmb2mQo7hDPTTFsDGTHhK+W0XM5
         s+DEZy/Nt+zApRRMmCGoUBjzJXn+P9YfVSsdmyG6p2n1M90nmsDhaR64b9Ju0mKIX0Gd
         hSwfD5SCAyfZ/ZdZkeQpfv/s6npOuc82mRX2HTER47IJ08eQ1zHStdjj+DXH9kHw4wVJ
         3lAy+cCnYdIVtCqawpNEgN3S3Gu0PgF0fayyNEtjawSz+2RB45hinOphLMUB28rLY04c
         9U4g==
X-Gm-Message-State: ABuFfohWurXrTM9QYM61z9rV9kLBqMpDCaqXghIk9JB6DBg5DcefSewg
        BtSdbK33bq0LbkanQBCiPaXozGbyaBR+NxwZ
X-Google-Smtp-Source: ACcGV62H6SSLaFDMY79b7gOSh4ynPBIqfn2FodiuBkK3guwkwKIOWR0qG5mnWgZSCUlhGXfiBeK5Xg==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr14364930lff.1.1540378281246;
        Wed, 24 Oct 2018 03:51:21 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q78-v6sm237799lfi.44.2018.10.24.03.51.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:51:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q6-v6so2853116lfh.9
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 03:51:20 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr3948781lfa.106.1540378279949;
 Wed, 24 Oct 2018 03:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810232013020.19032@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810232013020.19032@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:51:03 +0100
X-Gmail-Original-Message-ID: <CAHk-=wi8Z5tF+B+6ReZzKXLpG9Nn-91y1ahSqgvU29vaq7t=WA@mail.gmail.com>
Message-ID: <CAHk-=wi8Z5tF+B+6ReZzKXLpG9Nn-91y1ahSqgvU29vaq7t=WA@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for 4.20
To:     jmorris@namei.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 23, 2018 at 10:22 AM James Morris <jmorris@namei.org> wrote:
>
> Please pull these general updates for the security subsystem.

Thanks, pulled,

            Linus
