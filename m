Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75690C7EE23
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Feb 2023 01:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjB1BPC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Feb 2023 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjB1BPB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Feb 2023 20:15:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF313DE9
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 17:14:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ck15so33757238edb.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 17:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677546897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4foDmOd0TidPkdLCFMkrpX/LFzdbPkgPT38RIetMiw=;
        b=WirmihFyrrVXSGptd2y2j1cn22O/wCwpjUfVO4nVTGBhhF/yulKPyU/gJZzLJrwBct
         dXHy3G1t5CuCUB36+n1AuYqeQGvhtYQGgNHOfcb0JYS9Et31ltZPDmWl2vTaXnbSQHV6
         F+1mO8KvPU75JUXQHIOj1uMYsAcBxdSUFHEm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677546897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4foDmOd0TidPkdLCFMkrpX/LFzdbPkgPT38RIetMiw=;
        b=qsiKJTpecXATaavlTBNPiunRq2EBeTRXEWemvaoLTuhW6GELBRCX8iTzYfIYTQ9YWh
         omtSsb1RQ2dvLJg3dzbKwNn7Nj3ml2AMZ9mPxtcWxBZgmoZpWu5RRmE3vRpiRFXUdA0T
         DxsMz8XPLRWYaHkV3i/EVTFIozrTILGW782CG3RZST9a2ZGlglF5Wd1eWcoFlQ8WJ9mR
         qFbu4rZo//gd9Inv6nAeJNCu4xWo3Qo5VLRqxHW4kXXdLVw4NUy9xO2Eekd5X6MrYq9H
         9I39llQQSjBwMEAsfUTgAbvF5aKM1xMIyfIM7/OABWd1y4AXn1FqbJwaEJ+4oeiA/0hz
         YKEA==
X-Gm-Message-State: AO0yUKX3kkxjlo0ggS8GxG5Z/No0PlTazjazW2WSiU4LK+Wz+IpoVXhA
        TX7p3j5Ex26K1oik4SEBRF/+h4C5cNZcpbBJGMs=
X-Google-Smtp-Source: AK7set+0352uftHVd9tt20vY/M43Q+fpa6tXfKWUd4v9yJmFNdCSqJSSiR6BtrL77Jc/fc+X82C5tA==
X-Received: by 2002:a17:906:1601:b0:8b1:2998:6474 with SMTP id m1-20020a170906160100b008b129986474mr618376ejd.16.1677546896906;
        Mon, 27 Feb 2023 17:14:56 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170906b0c500b008f0143dfa65sm3843452ejb.27.2023.02.27.17.14.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:14:56 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id da10so33580335edb.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 17:14:55 -0800 (PST)
X-Received: by 2002:a17:906:79a:b0:8b8:aef3:f2a9 with SMTP id
 l26-20020a170906079a00b008b8aef3f2a9mr323832ejc.0.1677546895540; Mon, 27 Feb
 2023 17:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com>
In-Reply-To: <20230125155557.37816-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 17:14:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
Message-ID: <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>, Serge Hallyn <serge@hallyn.com>
Cc:     viro@zeniv.linux.org.uk, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_ca=
p_t b)
> +{
> +       unsigned __capi;
> +       CAP_FOR_EACH_U32(__capi) {
> +               if (a.cap[__capi] !=3D b.cap[__capi])
> +                       return false;
> +       }
> +       return true;
> +}
> +

Side note, and this is not really related to this particular patch
other than because it just brought up the issue once more..

Our "kernel_cap_t" thing is disgusting.

It's been a structure containing

        __u32 cap[_KERNEL_CAPABILITY_U32S];

basically forever, and it's not likely to change in the future. I
would object to any crazy capability expansion, considering how
useless and painful they've been anyway, and I don't think anybody
really is even remotely planning anything like that anyway.

And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
of that size:

  #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3

which happens to be the same number as the second version of said
#define, which happens to be "2".

In other words, that fancy array is just 64 bits. And we'd probably be
better off just treating it as such, and just doing

        typedef u64 kernel_cap_t;

since we have to do the special "convert from user space format"
_anyway_, and this isn't something that is shared to user space as-is.

Then that "cap_isidentical()" would literally be just "a =3D=3D b" instead
of us playing games with for-loops that are just two wide, and a
compiler that may or may not realize.

It would literally remove some of the insanity in <linux/capability.h>
- look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
historical oddity.

Yes, yes, we started out having it be a single-word array, and yes,
the code is written to think that it might some day be expanded past
the two words it then in 2008 it expanded to two words and 64 bits.
And now, fifteen years later, we use 40 of those 64 bits, and
hopefully we'll never add another one.

So we have historical reasons for why our kernel_cap_t is so odd. But
it *is* odd.

Hmm?

             Linus
