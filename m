Return-Path: <SRS0=oQDc=XN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA7C4CEC9
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Sep 2019 06:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136921906
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Sep 2019 06:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv6lI474"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfIRGbe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:31:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38173 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfIRGXU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Sep 2019 02:23:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so4168952otl.5
        for <linux-security-module@vger.kernel.org>; Tue, 17 Sep 2019 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wK9VKPT5PALGow0s1AD18j7lV+EvX5g7BMBWsTpeIng=;
        b=xv6lI474DYSgaSu5RV4eJEBRp8AAJwvehRoTTpWaCo2J8ub7oPk4fmWmvkg1ZEyHq+
         TtxFAJNA+CkO15cIf36iqqP9X57G/JNY3Jb2I187WuFFnZsD/6zxHIOCkgH6EgYA1jfH
         YFSSbCekS/IoziCPiLuxaZHnZq5wzOhwRethzETOZxKFgUsGwW/D4ZLudka0rLN2bOSj
         SAypaAGTp5bpQL5XY1Q813yX/HmVuGih8Q5wEvBX1r4lbpI+8QupHhP+fcbRFrASg2mL
         7pMs60vrA8DXbpmTG++BM1jE99VkeCVDR9xwYrqoLW/I0P3yuAd+Xz5+qsRpoB02XtZC
         WfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wK9VKPT5PALGow0s1AD18j7lV+EvX5g7BMBWsTpeIng=;
        b=XXeCz1G8WVyU+4wtC9uUKfii4Ej99F7nfjHYFCiCH6I6HwcRkTVlg8ZYFh089Uc5Gj
         dGRonHMY59pHAwIZPYvkcXhm9QsuHKmQUGqgMRVHpfWEi9Wrh5o8OIDKQhXVKmZlAJYG
         uuCXoPMGYEw4yEB89p5SOgSSnaP1c2PS8oBH3UeaP6B1chy3spG2UlZ4RFquOXVkcsyX
         SsftWDOyA4Ta5+gYb068dhbI7B6qGm0VKhl2QmuZHoZRCcS4tjLF5lsrQkyPLHPiQM1L
         3R88mjohFoV8JOjuuSl3DIXebEL+cVjSsmhyGq/kUlHqjXmbuIBK1owd7YwHbkTcEmq5
         cbVA==
X-Gm-Message-State: APjAAAWLWpdefMrg+0U5Xe27XHErD2/WdeH+zLu6G6xwsna3uFh7ZgFs
        vX2VZ2Tw9eJHu+0c8OGOMiJ3ufXD5dB2m7pR/3PVCUAg29c=
X-Google-Smtp-Source: APXvYqyy689jL78FRCBaToum4k1f1kK7Ku7U2vf7SNBEYUwL9xj0w29sOcLAmo488CIy0XySfEE42rIulH1rHL8wJvo=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr1722754ota.41.1568787800000;
 Tue, 17 Sep 2019 23:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
 <1568630064-14887-5-git-send-email-sumit.garg@linaro.org> <20190917181415.GA8472@linux.intel.com>
 <20190917181507.GB8472@linux.intel.com>
In-Reply-To: <20190917181507.GB8472@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 18 Sep 2019 11:53:08 +0530
Message-ID: <CAFA6WYMbUGQ6+-XvR9_qSc=oVe1QSTg4kB-+y6rBmQLq+B6skg@mail.gmail.com>
Subject: Re: [Patch v6 4/4] KEYS: trusted: Move TPM2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 17 Sep 2019 at 23:45, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Sep 17, 2019 at 09:14:15PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 16, 2019 at 04:04:24PM +0530, Sumit Garg wrote:
> > > Move TPM2 trusted keys code to trusted keys subsystem. The reason
> > > being it's better to consolidate all the trusted keys code to a single
> > > location so that it can be maintained sanely.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > This commit has couple of issues that I only noticed when looking into
> > bug reported by Mimi.
> >
> > Right now tpm_send() is the exported function that is used by other
> > subsystems. tpm_transmit_cmd() is an internal function. This commit adds
> > two unrelated code paths to send TPM commands, which is unacceptable.

Makes sense, will update.

> >
> > You should make tpm2 functionality to use tpm_send() instead and remove
> > tpm_seal_trusted() and tpm_unseal_trusted() completely in this commit.

Okay.

>
> The consequence is that the result needs unfortunately re-review. Sorry
> about that, just took this time to notice this glitch.

No worries :). I will send next version of patch-set.

FYI, I will be travelling for Linaro Connect next week so you could
expect some delays in my responses.

-Sumit

>
> /Jarkko
