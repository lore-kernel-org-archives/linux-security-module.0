Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE52AC64ED6
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Feb 2023 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjB1TwG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Feb 2023 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjB1TwF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Feb 2023 14:52:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7D34C24
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so44737976edb.9
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=EGqXWGb6FO9oqjBg/RjdN/86icRC1mPJ3oftK9FFQmtW1fgTuj/zmUleWUKUiXp25b
         c6AlQmcV0atsC/y67K5zu2wXxvzhbGCaOD7syFHQ9VXJzRYz6NH2pn9up0dOx+dWjEbu
         VnxtlH/hlKeQ5BYQrPpt5FLATZFI06UDFf424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=PjCy1I9Pdd7DGDkTzpxdm5LJ77mAw5bYjhMXiU4tcv1s0Gk7WbEVpxKKJA5/MmeYca
         kb+RMwFuG32s5ksJZhBb2viOoGd4ZqEmKrwWDtjHV4ZtDvdrad4E2TTV3YuyuT99T4xB
         N2ogB3xMt62HFp5bsOd92xl5kAm9OrugJCsqd/CHm39Slryen8HAZ9482qmVt2257gLZ
         I95ozpKplapJ07rt8yZpqXRGlpO3hXtrev9t5w/6fSE3K5hpvruFzh98KLJmXsJdvY49
         Xdm2XioIyfZcAJmTDWAOzCRMWlmtFRVgugUAZcb0IcGgKmEFJFs1N7tq2XJOYAWWEVsa
         6TRA==
X-Gm-Message-State: AO0yUKW0vu2R0ujb9jYqUyCEJDUTvAZWhRCcWvqkZJsv84fldgE36Q05
        b4JgRYfFUnX8kOaEJDzMxQOvl4qjkaqGiAEEQ0o=
X-Google-Smtp-Source: AK7set+f9OZG1gsKdZab5IGVzeD/k3wAYTejzG2B8Onr6ynE4wg5mGfp9QCdZ9Dn+x8wkwV6jUCaxQ==
X-Received: by 2002:a17:906:2350:b0:8b1:7e88:c20e with SMTP id m16-20020a170906235000b008b17e88c20emr4048615eja.41.1677613915195;
        Tue, 28 Feb 2023 11:51:55 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id jl9-20020a17090775c900b008b17de96f00sm4834530ejc.151.2023.02.28.11.51.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:51:54 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id i34so44761175eda.7
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 11:51:54 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr1947231ejz.0.1677613914258; Tue, 28 Feb
 2023 11:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 11:51:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

Oh, and while I haven't actually booted it or tested it in any way, I
did verify that it changes

-       movq    48(%rbx), %rax
-       movq    56(%rbx), %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13
-       shrq    $32, %rax
-       shrq    $32, %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13

into

+       movq    56(%rbx), %rax
+       cmpq    48(%rbx), %rax
+       jne     .LBB58_12

because it looks like clang was smart enough to unroll the silly
fixed-size loop and do the two adjacent 32-bit loads of the old cap[]
array as one 64-bit load, but then was _not_ smart enough to combine
the two 32-bit compares into one 64-bit one.

And gcc didn't do the load optimization (which is questionable since
it then just results in extra shifts and extra registers), so it just
kept it as two 32-bit loads and compares. Again, with the patch, gcc
obviously does the sane "one 64-bit load, one 64-bit compare" too.

There's a lot to be said for compiler optimizations fixing up silly
source code, but I personally would just prefer to make the source
code DTRT.

Could the compiler have been even smarter and generated the same code?
Yes it could. We shouldn't expect that, though. Particularly when the
sane code is much more legible to humans too.

                 Linus
