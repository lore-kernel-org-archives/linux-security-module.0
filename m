Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D878BC678D5
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCDTUQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 14:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCDTUP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 14:20:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD33199C3
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 11:20:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o12so23070419edb.9
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677957612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3SyI5wgA+xTVIyMgqXNDzGyf+k3DO/lHNaL5moHRgg=;
        b=RtrdNdmwppd9PqREjuePmZHy5pNVGjWi1Ynlau5TanW6fWKPwF9qAg2tDhMYKIVhoY
         DNYeEQSlejDm+8rT4i5Y/JCrioXCI3SygY0B7tt+4F6jDOneJ0gscynyvhU67iEFNC7l
         CfHt5msG7rw4wrTP9li7FkuLCc4ehHn930BxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3SyI5wgA+xTVIyMgqXNDzGyf+k3DO/lHNaL5moHRgg=;
        b=ZEfRZWeg3KjjIayljb65RfVQJdWEp4HL2IItg9lB9TTWrbnsq21GjRs8FP2r5OwwYM
         t7VvBXiYF+kjay+jWu5JbQ4mERsjZBaGNPF0ZMuVhFqzUxKJh+SGxAbwBqMQ+NS6Qkrt
         y31P4gzUgeVVTNHd20C1UMEY+j7doKM5yEwlu5fETFcUUGRkzEAvdmMr291lXroUqXlo
         xiFHWjHiJHxg/ZhMpm0eO5b52taixYezhLo4V0x6tbDd2KuDAu17VYzqEnzPy1I1F4m5
         qyylSHe+IbX3TnCLru0aaVkqBCB+Nyrmuh7alzeAkh9Zv/EsmHPwka0qYg1h0U02Ifjl
         q1tQ==
X-Gm-Message-State: AO0yUKVAf4UmLwGOSnNMdLO1yRcokH6fCMyRnBQAYutTUIm5AAkrLJpb
        1hJ4SozZwPAzNDKFvaMkNb+plSs35U2VIltFoOstMg==
X-Google-Smtp-Source: AK7set+ck3ub5mkcAT4AjGlkJ5MbhWMJfJDqSOz4IEqE5mv05sKoI/SxRH1//nP8iAoHLUGbeUxKcw==
X-Received: by 2002:aa7:cd55:0:b0:4bd:11d3:e86f with SMTP id v21-20020aa7cd55000000b004bd11d3e86fmr5653594edw.6.1677957612550;
        Sat, 04 Mar 2023 11:20:12 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 19-20020a508e13000000b004acbdf23cd2sm2747942edw.29.2023.03.04.11.20.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:20:11 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id g3so23228202eda.1
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 11:20:11 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr2610583ejf.0.1677957611299; Sat, 04 Mar
 2023 11:20:11 -0800 (PST)
MIME-Version: 1.0
References: <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
In-Reply-To: <ZALcbQoKA7K8k2gJ@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 11:19:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
Message-ID: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
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

On Fri, Mar 3, 2023 at 9:51=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> And the following code will be broken:
>
> cpumask_t m1, m2;
>
> cpumask_setall(m1); // m1 is ffff ffff ffff ffff because it uses
>                     // compile-time optimized nr_cpumask_bits
>
> for_each_cpu(cpu, m1) // 32 iterations because it relied on nr_cpu_ids
>         cpumask_set_cpu(cpu, m2); // m2 is ffff ffff XXXX XXXX

So  honestly, it looks like you picked an example of something very
unusual to then make everything else slower.

Rather than commit aa47a7c215e7, we should just have fixed 'setall()'
and 'for_each_cpu()' to use nr_cpu_ids, and then the rest would
continue to use nr_cpumask_bits.

That particular code sequence is arguably broken to begin with.
setall() should really only be used as a mask, most definitely not as
some kind of "all possible cpus".

The latter is "cpu_possible_mask", which is very different indeed (and
often what you want is "cpu_online_mask")

But I'd certainly be ok with using nr_cpu_ids for setall, partly
exactly because it's so rare. It would probably be better to remove it
entirely, but whatever.

              Linus
