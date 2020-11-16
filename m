Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B8C64E7A
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F6220B80
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HKbDpA8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgKPRif (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbgKPRhy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:54 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6588C0613CF
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 09:37:52 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so21101451ljh.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HKbDpA8RbHc7R9WeYnYhMYC3gxw9weFs3lMu3SDaX0XkAID5B1sf9E42rWBynbT+Sx
         yT3uEIqvHZJzSY1G2ko5rQ9hLa877Siaz6/opPHEMxfi0DtcEJEuWQQNCPcD356BV5kx
         d7ODwPPcAS09cbveKqn/VdCocdxDt/vjlquyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=FZsEh68kFKz5aYFcEzg3LonNZP2OMGnb26mDJcZgSeIoii5f07t5YGe+BVt2WH+S2M
         dGZXHoiO1aYKw3p7yxKPXLlkQKV++9YvQq2wXTs5cGdWxz4Yx0f66I+RjVMmqC0PoIJj
         be6nACbbkL+fAQVfp+AvBBNv10Ma6v4oeWi/hFFnsjiZfd1VL1PYkoTJmU7RMm1pScNj
         hOO4xXoX8u/1x6Gxv+wkP/0K4lif+tGrRc/hFfWPYPNRdF1lufGwE+uJr+DeD699qbS8
         mu8gRhAxOKgOMX2vdBG4WBLN6wkSStGybbxtd+oaojsTB6p+esSXi8gxJw6Ty3upBaUE
         6N/w==
X-Gm-Message-State: AOAM532VyCMM6pCb1ERkGJ/t19e8yB+bzF/1B38hn6mzDOdmS9yp7BJp
        RWhJHW7Gf5vVrs+9lF9FoTREcVcQgGI20w==
X-Google-Smtp-Source: ABdhPJzIZyEfykDMQCaS8wUvQlwDDKH/O1jJRZUX3pNPHz2wffH+p6aBsjvw3/rGSH5DOyVix3YJqw==
X-Received: by 2002:a2e:9848:: with SMTP id e8mr193999ljj.353.1605548270942;
        Mon, 16 Nov 2020 09:37:50 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t138sm2832070lff.183.2020.11.16.09.37.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id i17so19985737ljd.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 09:37:48 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr153620ljo.371.1605548268341;
 Mon, 16 Nov 2020 09:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
In-Reply-To: <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 16, 2020 at 8:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> This discussion seems to be going down the path of requiring an IMA
> filesystem hook for reading the file, again.  That solution was
> rejected, not by me.  What is new this time?

You can't read a non-read-opened file. Not even IMA can.

So don't do that then.

IMA is doing something wrong. Why would you ever read a file that can't be read?

Fix whatever "open" function instead of trying to work around the fact
that you opened it wrong.

             Linus
