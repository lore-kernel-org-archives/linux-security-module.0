Return-Path: <SRS0=1/E3=Y4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9361CA9ECF
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Nov 2019 06:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F04B2245D
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Nov 2019 06:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvdCJc1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDG7B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:59:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40522 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDG7A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Nov 2019 01:59:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so9746417ljg.7
        for <linux-security-module@vger.kernel.org>; Sun, 03 Nov 2019 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef40HtgLagkWmNMc93ySVU+8+raGbvhremm/3vIkPJs=;
        b=vvdCJc1RINMcL5JoJz312DaAniIDfMzCcnwAI/nzlhioj8GGGYgW5khIKfb5WKPoih
         qMp+vCbDbemdWq8i0Mf58v3uh/mu8EhKBMgRhulZLShXtK+MNVeAUm7PQ2aQiAtYd/+j
         Jg6nmlI9XTaqFYG/d/qIJDVf1ikfm6/i0iK1k912esWDVF1151DSFoBkdr1dAOlWvfmC
         jsn+40LPewRJA3SIUnwPlyony4u564JLgwa29HfMy3fBdaUY2d1amOC0D3N4Y4FXSyEs
         uXfrP9qkdne00KhZwEYKvXolsJ2gV5a0/Mi5PvdRJEwJ90Nr/tnHijeE3ql/YqVMQM1K
         AvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef40HtgLagkWmNMc93ySVU+8+raGbvhremm/3vIkPJs=;
        b=ZXgcWxkAOiAttKaLW3GOtOcpvQXdr1CgSSEBULnE+ea8x4T/zKTpbm4djdshJfUwL0
         XXy2klPF08oBxRPRakTZxCyhoRBcNF8u5dFHDwjzKhZEBodlKRRxlSQBFh0G6gZbz5SZ
         fhd9/CyPoxc+xjV+GIVOvXC011EaonvlLUxAXZ8qSOl15VJpcKtfi3pezYeJfgPj1jeK
         0hjRx0ot25YkdYQk3KReKJqjD/8WIkxkp2k4FUoXMIR2pWUdcyD3Xj+/Gt5bQvpaDYJV
         62xwMyRSUTpcSfEB8HnOlxT3NasU1T7aEgw8sU6CetJZlLptiwQYZHp1GtU9/7mCX3Ay
         m9EA==
X-Gm-Message-State: APjAAAV6/agb5andIXpsUx7Qv+OsU0dFwrXfaEzED+EGaZ2S80D0f7G7
        1+VQZihTvvZpAucZtFHAU/OxiFq2TM0bJa3qI9WU0w==
X-Google-Smtp-Source: APXvYqwDEcaV1wOC5X14ad1vPw2VW4B5zXbZYrai12akzfGxkCIeR+UrJYYWYChUz2q1aw4cIzuU9bUsn4PO7ZkCq3g=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr9966567lji.191.1572850738786;
 Sun, 03 Nov 2019 22:58:58 -0800 (PST)
MIME-Version: 1.0
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org> <20191031214745.GG10507@linux.intel.com>
 <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com> <20191101201957.GA8369@linux.intel.com>
In-Reply-To: <20191101201957.GA8369@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 4 Nov 2019 12:28:47 +0530
Message-ID: <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, dhowells@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 2 Nov 2019 at 01:50, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2019 at 03:04:18PM +0530, Sumit Garg wrote:
>
> > Isn't this statement contradicting with your earlier statement
> > regarding the right order would be to complete TEE patches review
> > first and then come up with documentation here [2]?
> >
> > [1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
> > [2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/
>
> With the intersecting issues, namely key generation and conflicting
> keyctl parameters, that was not a well considered statement.

Okay, let me work on documentation first, but I think resending whole
patch-set just for documentation review and rework would be an
overkill. Would minor revisions of this patch only like v3.1, v3.2
etc. work for you? And later I could send next version of this
patch-set once we agree on documentation.

-Sumit

>
> /Jarkko
