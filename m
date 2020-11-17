Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37608C2D0E4
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 23:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E4E20B80
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 23:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZfCK9fE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKQXgw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKQXgv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Nov 2020 18:36:51 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A1C0617A6
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so335560lfg.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=ZfCK9fE5KEx2c6LJVDvCKbk18EHOGfANhut79KLdPiY11VCpPSw0vPYJaLCzYbWfN7
         rxR97+wOKkrhlTSFjVmx0Ens33MZNx+ydmyDkcSx3o5aSc4rS+WnAeqjoTEjOy+8p4IX
         mcTfZ1lbMzrFtnx5GPNlU5oqnxJmpNU4bc8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=VNW8C1fsUzyz4b3veFvjp8QpWmNhZOr65vp8GqT8ntynZ3AM5gp/xpdazk3J7fmLaA
         ++LEmDszh2oMkL6C89g3UGd5OrsPJmUd1R3YoNxbrX1rvfJByCOgKLKZL2+68qFOjIBI
         DeGiwhwlaE/skpfjgEo/URFePm9/Ozs/FY7q3HUNZyMUCwaHRahyBmedzyV2MXYlbACJ
         XNd7CCejRm3lr4M+I3pTOjDCt9Dh+i0P0KYJYz9M16WVWQMp8SY8r8niSh+JtG9Uu3Cp
         E+xzoaLOmA1L73zmky40ixPJrL8tZ4qczQ2iX5M+OAiYVdqPENb+MT9NG5lrS2K48/Yl
         +0zA==
X-Gm-Message-State: AOAM533QCEgjM02gmsbcmeZ0yCWsvOrlyP60RyzJF/Kx/0TUdohwYLkK
        X5Poi7FdtaDcit90NBMmRv6U5IBge9Gj8w==
X-Google-Smtp-Source: ABdhPJw1WrrC0IARiJlchW+MJ3lMQqvCu10eq+RxYR/hW+oEK6c8wa6cRN4JVfnCFi29pynA5E68hw==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr2539445lfy.549.1605656209491;
        Tue, 17 Nov 2020 15:36:49 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j2sm3327504lfp.256.2020.11.17.15.36.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:36:47 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id l10so288853lji.4
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 15:36:47 -0800 (PST)
X-Received: by 2002:a2e:80c7:: with SMTP id r7mr1059615ljg.285.1605656206837;
 Tue, 17 Nov 2020 15:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
 <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com> <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
In-Reply-To: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:36:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 3:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > I really wish it wasn't needed.
>
> Seriously, I get the feeling that IMA is completely mis-designed, and
> is doing actively bad things.
>
> Who uses this "feature", and who cares? Because I would suggest you
> just change the policy and be done with it.

Another alternative is to change the policy and say "any write-only
open gets turned into a read-write open".

But it needs to be done at *OPEN* time, not randomly afterwards by
just lying to the 'struct file'.

Why? Because the open has told the filesystem that it's only for
writing, and a filesystem could validly do things that make reading
invalid. The simplest example of this is a network filesystem, where
the server might simply not *allow* reads, because the open was for
writing only.

See? IMA really does something fundamentally quite wrong when it tries
to read from a non-readable file. It might "work" by accident, but I
really do think that commit a1f9b1c0439db didn't "break" IMA - it
showed that IMA was doing something fundamentally wrong.

           Linus
