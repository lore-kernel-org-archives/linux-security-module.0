Return-Path: <SRS0=1b+D=5V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C4C2BA15
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268A520678
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586107923;
	bh=WpVA+C7vY7ZVNEVxy8nsxNGVkHzZ1oU9MJa4TwpeCX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HrN1Fkgf6u+GhQcL+l+NlA32/NQyftId+NzqUSXisXa+vDSXnKkpNq2g0akO3AxVZ
	 71Z8sS/ZXscdEu6L/GQ2cTMGA1ZGwU7wPHwOZ7TNA0VTz2y1sEiladQee4MnJUhul1
	 QvRvxnzaY4gs9li8ahft0VS3VLSOOpxRAeFhjXzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgDERcC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:32:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34367 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDERcC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Apr 2020 13:32:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10so12193549ljn.1
        for <linux-security-module@vger.kernel.org>; Sun, 05 Apr 2020 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcbh6sH9SJBGE+Cjk3XFguwEqI2IKXqqQBtRFq6gvFQ=;
        b=R07dbyu7Y0eMKVM4FedC3n/xof3lreuns2KIRBmYuFzNApajuKhjO7x1wg1aWKkMhh
         dwTz+7LXu6F7lM4s5hAWcEoHMHg14h+cQpmTR9fdFNXDCp6e2xdLcSoC3KXYyqK/QeGu
         RsK9JhsA+jl8afkEI+uxGrG60T2A4hCuJEIG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcbh6sH9SJBGE+Cjk3XFguwEqI2IKXqqQBtRFq6gvFQ=;
        b=oms/Q6m7gATN7kvsSriZ2RWbYRUesBed1LmvnfgUagcKM32ZAaYa9DjbliKDQ4xgPP
         pYpXFBY4AeaVLp8mVI/53FrxdgUqZfMCIoHw+j7cmf8RuQfm6Z/UmdiqorqtluOCsGJv
         N3kJA9vZQyWjYJmkKX1Sxh7cvTxQi/2a4M41JfRqcCsg/tXh4q9htVCm2WBP32wfyXYK
         SUJMNgQs/gUiBfxNn6pHNz9mxJZTb6pL2TtIdnRky7Jw+1isY/bRjInw2DLoV3ASp8+S
         IEQ9uSy5g14EMQoMgkBm2Dpy+t1hGvgBJ/cht2SYatUFWq4ADV6V1twMR84dM0g8dH1b
         0DJQ==
X-Gm-Message-State: AGi0PubkucY6xvgAiMCFmddQplTaWHEXJEcWVhOTC0nhp1DYdqPd7Cpl
        ukEfJ2QIKU57R9U3/VxQHrOE7OOT8gU=
X-Google-Smtp-Source: APiQypJo5ifN+RLvi+ss0sT8cy4Yd5NNXGVt4lnN1jsI4o6P2m52CIXX3dejWEN3miUo05pX+s+hBQ==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr10060156ljn.151.1586107919532;
        Sun, 05 Apr 2020 10:31:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j13sm355833lfb.19.2020.04.05.10.31.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 10:31:58 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id s13so9854192lfb.9
        for <linux-security-module@vger.kernel.org>; Sun, 05 Apr 2020 10:31:57 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr6564163lfo.152.1586107917356;
 Sun, 05 Apr 2020 10:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <1437197.1585570598@warthog.procyon.org.uk> <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
 <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com> <3567369.1586077430@warthog.procyon.org.uk>
In-Reply-To: <3567369.1586077430@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Apr 2020 10:31:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
Message-ID: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 5, 2020 at 2:04 AM David Howells <dhowells@redhat.com> wrote:
>
> Should this be moved into core code, rather than being squirrelled away in
> security/keys/?

Yes. I do think that that __kvzfree() function makes sense in general
(the same way that kzfree does).

I just happen to despise the name, and think that the implementation
isn't great.

It also probably makes no sense to make it an inline function. It's
not like that function is done for performance reasons, and it might
only get worse if we then end up making it cause barriers or something
for CPU data leakage issues or whatever.

           Linus
