Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CFBC63777
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F131924686
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PEkPOajt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgKQSYW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgKQSYV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Nov 2020 13:24:21 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E56C0613CF
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 10:24:19 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so25390220ljc.9
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvUf4J0DFW1w2WtJ3V6+jniQAPhY7yyvFEspsD/tJmg=;
        b=PEkPOajtdsc4vIPnzM9bVRVqYkht1WKu9HytymEE8l1JV5LOIEPq4BZ4U++e/c0KUw
         gwT0H1upKqxmypmrqpI9U3ggwpq1tCugR4BokqmJbZUSWy5UvZT3kY0Gec7Lk89ev35b
         zSUKO3Tk9zzocvLF3Nc/ui5aJ3U1f2I/TBi5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvUf4J0DFW1w2WtJ3V6+jniQAPhY7yyvFEspsD/tJmg=;
        b=sMYpiKPaOl3zEK5/7dJFRGhskRsVv+or6c2k/QkNbyDbwnYz47OrAfL9IvIo1YWgjK
         Nq+81F1y8L3GlndRM9mE/tByDLtPht4Q16o9AZejy3elOVG2hi8D2bVUNzTISDMbZnuF
         wKmJ3KJjDPCEwogPHukREN20+LXoVq9UQzwOSHRmv5QrcrU4lGrBVvKQP2P30OToAuJ/
         eO0Ki2GEz2MNxTJOj0Odqg12PEaVHboqtNZo447gPS80eeshyOXT3M1ZH51CrHS8QReZ
         wJzpQndMFzqm3ZSHZAhpZBJwdC6rAuaq+Eh2G4BNxsMVIYXRUN0uySR+G4J8P+R8FKDR
         YpHA==
X-Gm-Message-State: AOAM530nI7UQsynTuUdtRzwem05ocrMjyIoO8ARxTLtzzx0r3voUmzhW
        2LmYx/oY7IZRHjQOL1Q46X1grVtS5Xztqw==
X-Google-Smtp-Source: ABdhPJyT5i0uD8sDgpbqg+KBzRpYgXLvQKTm8weV30a/memPd4OKkHlaOmOE3sCUmjRM5o4w+16xAw==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26mr2498928lju.223.1605637457306;
        Tue, 17 Nov 2020 10:24:17 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i9sm225757lja.56.2020.11.17.10.24.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 10:24:15 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id v144so31387752lfa.13
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2020 10:24:15 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr2049940lff.105.1605637454918;
 Tue, 17 Nov 2020 10:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
In-Reply-To: <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 10:23:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
Message-ID: <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
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

On Mon, Nov 16, 2020 at 10:35 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> We need to differentiate between signed files, which by definition are
> immutable, and those that are mutable.  Appending to a mutable file,
> for example, would result in the file hash not being updated.
> Subsequent reads would fail.

Why would that require any reading of the file at all AT WRITE TIME?

Don't do it. Really.

When opening the file write-only, you just invalidate the hash. It
doesn't matter anyway - you're only writing.

Later on, when reading, only at that point does the hash matter, and
then you can do the verification.

Although honestly, I don't even see the point. You know the hash won't
match, if you wrote to the file.

           Linus
