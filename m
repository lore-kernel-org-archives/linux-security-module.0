Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F1C433F5
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Apr 2022 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382473AbiDDVaF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380057AbiDDSts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Apr 2022 14:49:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D731232
        for <linux-security-module@vger.kernel.org>; Mon,  4 Apr 2022 11:47:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q68so2117540ljb.3
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gE1myDBwoMMXv/sqmeeTtdtKANbFnGzqW1O8e9pC9SM=;
        b=Yw1ZNqApekZ8AeL0PldgD9VjhOHOy85q4fAqhpYMwGIKsvyjwUgV3+tfYqgx/Hct6n
         jD5U2/G9z45ZzVG+RK48MiJA/vGEl6/n1PrVgO3E4okVxoNB71vm3JXzkpG1pNnI8dPy
         LprtMmSxkZJ8rgeVf8rwgvz2/P8kEtbmNFRow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gE1myDBwoMMXv/sqmeeTtdtKANbFnGzqW1O8e9pC9SM=;
        b=C+I5fNpkN0M+RkvWNGYcF/FkQggtqYEI0MMDTfqAlm7mGUk5xU7HEa1Wkqe/jS4qkF
         7tCKYw7XvBTkUVKNop0UAdHwgIRXtuqKe3uihiI/jerrNIaE39TFtMWmmOWcFng/yomw
         TZVxE/pSJAX2XaXZhxQUHmxgO9tDTAianpJHnX8IidKJq7rBX/EKowHygtAPNxz/KG8N
         qauloTCLbSWVTxp9RqWhDkXiP1KEdM9ae3oYCCvoPURPM0kHTn6Hx1dm9nwngf/4vmSK
         QFoxQI5Tk1TUTS/c29+LOEIaQGdHuUsxiTXxfRrYPGIXnc2r25tTtVB8WqzEEdrk4JY8
         K5uw==
X-Gm-Message-State: AOAM533D3x76YlGiCiE4RxDrk5yEUxhx+oJciqgvMmNyB2FUm1gemA07
        dXhHg64nnLq7tnwaPF6xZnDblQ0SW6uXeSgZ
X-Google-Smtp-Source: ABdhPJw5KkIyF3R4J+NahNdbBLIEsrOrCMmHvaAyzsKgYUf2mzJTAK+E5q1alEBCNuB4ZZV83nyuiw==
X-Received: by 2002:a2e:a903:0:b0:24a:f39a:88e9 with SMTP id j3-20020a2ea903000000b0024af39a88e9mr617464ljq.394.1649098068883;
        Mon, 04 Apr 2022 11:47:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t25-20020a2e9c59000000b0024af7b8fac2sm1118362ljj.6.2022.04.04.11.47.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:47:46 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h11so14162799ljb.2
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 11:47:45 -0700 (PDT)
X-Received: by 2002:a2e:a790:0:b0:249:906a:c6f1 with SMTP id
 c16-20020a2ea790000000b00249906ac6f1mr638041ljf.164.1649098065631; Mon, 04
 Apr 2022 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
In-Reply-To: <202204041130.F649632@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 11:47:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
Message-ID: <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 4, 2022 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
>
> It looks like this didn't get pulled for -rc1 even though it was sent
> during the merge window and has been in -next for a while. It would be
> really nice to get this landed since userspace can't make any forward
> progress without the kernel support.

Honestly, I need a *lot* better reasoning for random new non-standard
system calls than this had.

And this kind of "completely random interface with no semantics except
for random 'future flags'" I will not pull even *with* good reasoning.

I already told Micka=C3=ABl in private that I wouldn't pull this.

Honestly, we have a *horrible* history with non-standard system calls,
and that's been true even for well-designed stuff that actually
matters, that people asked for.

Something  like this, which adds one very special system call and
where the whole thing is designed for "let's add something random
later because we don't even know what we want" is right out.

What the system call seems to actually *want* is basically a new flag
to access() (and faccessat()). One that is very close to what X_OK
already is.

But that wasn't how it was sold.

So no. No way will this ever get merged, and whoever came up with that
disgusting "trusted_for()" (for WHAT? WHO TRUSTS? WHY?) should look
themselves in the mirror.

If you add a new X_OK variant to access(), maybe that could fly.

                Linus
