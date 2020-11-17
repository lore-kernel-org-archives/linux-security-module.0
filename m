Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D169CC63697
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 23:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9562463F
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 23:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HeuQ3NoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKQXaR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgKQXaR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Nov 2020 18:30:17 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D07C0617A6
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:30:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id l10so274276lji.4
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=HeuQ3NoSPHMV5vKQqErsUpbPU0jCzVO1YYw049IBFq1aeufNNpzqJb5qaTS2ZHfFe+
         WcUWdn6RMYtlbpqWvhE+FKQgR+SjxTvXaBlD3AxqZuA+NUcWqZcWsAHAfKnyuWsrg+Kw
         I+44mfRUd+9oWmJWHMV2sPLHW/pUwKHciZkoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=gGpRDQyEHrefQDVvlUPNj0IVpYTSQKv0MQQDamiA3rCc3QfGDS/uceeqvJciAgYdIL
         qThjkezV8ctGFT3GTkxR6zvUR8vuflA8tmSMBUUTnSLgHCwjlnnfpzqxuDIgoSVNIv/q
         NhdAZi9EBULrCJtX3BM9DVB3CFU8WrZSjT/r7s6WtZ+ATv/WKWnFlE7KtWrCrhyKqixD
         40zUcg8Ms7vUWQfc9bjrockKfdoEBMnYGJmcKc/7/UCj8/G5mw29Sslruf1Wu25TzgNM
         TF+T6StAq+TDENmn3mOZFfUA0CjtrgH8Mu0u5/8DoBuIQa2I8I69TYjg39wYG/+uKM6g
         1A5Q==
X-Gm-Message-State: AOAM530JAh5SMHRQvzcEkYQTtb/QAPILHDRAcN+5zqF/SJUZ3L1NtoBR
        g0rtDam9wimsF78iUvGLixL76T6iNsNs6g==
X-Google-Smtp-Source: ABdhPJxenB2ltuVDofqrYxAGgKit3dJ4Eor/darTMaCVvuTr7AJyKvBIwMPPf8bbDMVasAEjqoc2mQ==
X-Received: by 2002:a2e:97da:: with SMTP id m26mr3047190ljj.149.1605655815354;
        Tue, 17 Nov 2020 15:30:15 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w4sm3193772ljd.28.2020.11.17.15.30.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:30:11 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id y16so291629ljk.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:30:11 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr2679618lji.314.1605655810863;
 Tue, 17 Nov 2020 15:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com> <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
In-Reply-To: <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:29:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> I really wish it wasn't needed.

Seriously, I get the feeling that IMA is completely mis-designed, and
is doing actively bad things.

Who uses this "feature", and who cares? Because I would suggest you
just change the policy and be done with it.

            Linus
