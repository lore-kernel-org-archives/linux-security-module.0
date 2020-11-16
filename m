Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A25BC63697
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F242227F
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="baew2Ozn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgKPSJw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbgKPSJt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Nov 2020 13:09:49 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF85C0613D3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 10:09:48 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so21139845ljo.11
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu5++/kJeVjJEiUxVlOBfldGtXXjOObK0j9yLP+sNSY=;
        b=baew2OznxixMFWwa8rFtZDjYndGY/BNHPjeYN+gAEWyL0FCL+lP2R5/6+0IMTekE1b
         99wN8eBTB1s9tBaULqn1FTc9kugWtNBBn5NM7/2LqHdal6yjEeyuRb3cbNiHh8OnolhC
         Fji9oRMYFO1DUSacVg94h0YAeOGP8+oDGNNXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu5++/kJeVjJEiUxVlOBfldGtXXjOObK0j9yLP+sNSY=;
        b=M2xewC57MxDMx33Rd3XySyX03HCYBhiYmUPTMlWjrBQjy9dN2Mm7RRnH8dG0ttbGHm
         QzZIkQJnySbjJ0gqRk3LTj1HaiA3C3fCCAlZIRw4fEsrkWTQB+R2X0tA/CRTV0YWx9RO
         vqw0aaarETVnjjgl5hlJOzWvQOpgAePpYAOSE2nQx++u5Il+Nc5MtsWfoGaufgBvSezB
         kdPdE8yTH0Khf5c0pKFe/pYWmnf308k9Zj5SO2dzvBB5kP15VYZORZxe4hTcTYC67K5c
         qxsHBFgPFVLb9TSrug833CXeo3Bqh3qnpw998iRBXRaVDjkp2hcmrzfD+4K9KqH4PdeR
         +Exw==
X-Gm-Message-State: AOAM533upMbBsEn3IZGOi0BXIJifgXZCrn+alHpyH3oJxHfcsqPrS2K+
        igh7i1/K0/GGj8CBPQpUivSCSPtlj4A2nA==
X-Google-Smtp-Source: ABdhPJzjZ6HOyUPiaXTu/udlEaKczb9A+AqXEC2geHRcfClqcVM2zGa/HnGWd3LwEh9/L77i7FjC2A==
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr250051ljo.310.1605550186939;
        Mon, 16 Nov 2020 10:09:46 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w6sm2825374lfn.64.2020.11.16.10.09.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 10:09:45 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id o24so21182657ljj.6
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2020 10:09:45 -0800 (PST)
X-Received: by 2002:a2e:3503:: with SMTP id z3mr240954ljz.70.1605550184840;
 Mon, 16 Nov 2020 10:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com> <20201116174127.GA4578@infradead.org>
In-Reply-To: <20201116174127.GA4578@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 10:09:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
Message-ID: <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
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

On Mon, Nov 16, 2020 at 9:41 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> The "issue" with IMA is that it uses security hooks to hook into the
> VFS and then wants to read every file that gets opened on a real file
> system to "measure" the contents vs a hash stashed away somewhere.

Well, but that's easy enough to handle: if the open isn't a read open,
then the old contents don't matter, so you shouldn't bother to measure
the file.

So this literally sounds like a "doctor, doctor, it hurts when I hit
my head with a hammer" situation..

         Linus
