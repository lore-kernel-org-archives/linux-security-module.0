Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86FC61DA4
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Mar 2023 18:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCESRs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Mar 2023 13:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCESRr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Mar 2023 13:17:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742861117E
        for <linux-security-module@vger.kernel.org>; Sun,  5 Mar 2023 10:17:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so29827682eda.7
        for <linux-security-module@vger.kernel.org>; Sun, 05 Mar 2023 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678040264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0UA/7lZ63JFeoLOmQNO6i8Dnq6C2Xq3iYWWB1kja+U=;
        b=HZnF5dA8oOl+6Jlnkwgm3b1GR0uPuOeNeWpITcsq/Y922X60lZICne2mJfDliiEyZQ
         2z8fXZ7/KrhDTby4Oexr6bKDrXR7L3PfZFuUG6MOZQjuNiPggxitWxU7FySg3p0xbZZo
         B/VX77vk0etI7dKqL93YlzMMyYsfVn8I6ROh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678040264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0UA/7lZ63JFeoLOmQNO6i8Dnq6C2Xq3iYWWB1kja+U=;
        b=TkBHNzo0xEs0aMNVqQieFx7O/QtYJECO8t3w1/9xvZPgbbi+WdXjMj3HsOUWv588L1
         vVp0PtJuBYBDT0w7fuLiYd9YDDvHbVs8siAiY8tBGAf4Y6WXw0mfQfzVNq7Qsqj6B7bb
         wS/eaiWoblnJblF7d0nyQofsu9heOgyqs2aBndo1QC+7XIIW2fcdxsUlo/7D2wE69v4P
         uJ1r/rXJV6Nf+MQ+RjE0lwsyRtSB9f31cHSYx7qJAvkXdFOcPeM92ZkXhK9JH05WMntU
         //3svQw7UPAgcIhv18cy8fR2sjza20ZvjZ3508oCr3FQNBVzreU0c5k50UWbtsfQH2xi
         Bd2A==
X-Gm-Message-State: AO0yUKWrsN11UghhKQ774W4wKsD9xlQ75rPeT2ea6sWZ/Owixjfp+W9C
        zUvj+l0KejYHBGDuvEU2ZEiB2B++a5FCnMOegOkUmg==
X-Google-Smtp-Source: AK7set8u6zWZMPfiE6WQO676l+/8FvCTYYRWleBSaj3aHrVM4sxub1rrom8VZakDBf4YKvA0vNLdMQ==
X-Received: by 2002:a17:906:fd8c:b0:8f7:d5c0:c71d with SMTP id xa12-20020a170906fd8c00b008f7d5c0c71dmr11280773ejb.60.1678040264369;
        Sun, 05 Mar 2023 10:17:44 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id j17-20020a50d011000000b004e48f8df7e2sm526482edf.72.2023.03.05.10.17.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:17:43 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id cy23so29711704edb.12
        for <linux-security-module@vger.kernel.org>; Sun, 05 Mar 2023 10:17:43 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr3913520eju.0.1678040262904; Sun, 05 Mar
 2023 10:17:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
 <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com> <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com>
In-Reply-To: <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:17:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
Message-ID: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     sedat.dilek@gmail.com
Cc:     Yury Norov <yury.norov@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Mar 5, 2023 at 1:26=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> can you share your "normal config", please?

Well, I just have CONFIG_NR_CPUS set to 64.

That happens to be the number of actual cores (well, threads) I have
on my desktop, but it's what I use for my laptop too (that has 8
cores).

Basically, I consider CONFIG_NR_CPUS=3D64 is likely the "sweet spot" for
code generation and still covering 99+% of all machines out there.

Now, MAXSMP is great for (a) coverage testing and for (b) being able
to handle pretty much *anything* out there, but it really was
originally meant for the SGI kind of hardware: not exactly
off-the-shelf.

So I use MAXSMP for compile testing (by virtue of "allmodconfig"), and
it's great for that. But unless you have more than several hundred
cpus in your machine, you should never use it.

There are a few main issues with MAXSMP:

 - the simple ("common") embedded cpu masks end up being big (ie any
data structure that has a "cpumask_t" in it will be huge, just because
the static size of 'struct cpumask' is 8192 bits, ie 1kB)

 - the fancy case of using a "cpumask_var_t" will use a pointer and a
dynamic allocation (which is then sized to be appropriate to the
*actual* number of CPU's, so that you don't have to allocate 8192 bits
for everything).

 - the code generation ends up inevitably being about variable-sized
loops, because nobody wants to traverse those kinds of data structures

In contrast, if you use CONFIG_NR_CPUS=3D64, both the embeddeed and
"fancy" version will be just a single 64-bit word. No extra pointer
overhead, no indirection through said pointers, and no need for loops
(ok, there will still be loops for walking the bits in the word, but a
lot of them will actually be about using instructions like "bsf" etc).

So you end up with better code, smaller data structures, and less
pointer chasing.

So those two situations are generally the two "sane" configurations: a
good reasonable NR_CPUS that works for just about everybody, and then
another extreme config for the 1% (or - more likely - 0.01%)

Now, it's not like 64 is somehow magical. Picking something like
NR_CPUS of 192 is perfectly fine too - it will use three words for the
bitmap, it will still avoid the pointer indirection, it will have a
few small fixed-size loops. It's certainly not *wrong*. It will cover
bigger HEDT machines, but I feel like the HEDT people probably are
special enough that they could probably just use the MAXSMP case, or -
if they care - just build their own kernels.

So you *can* certainly pick other values. We used to have special UP
vs SMP kernel builds, and that clearly no longer makes sense. Nobody
cares about UP on x86-64.

But I do feel like MAXSMP is simply not a great config for 99.9% of
all people, and if you are willing to have two configs, then that "64
or MAXSMP" seems to be the sane split.

And with that split, there will be *very* few people who actually use MAXSM=
P.

               Linus
