Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01915C678D5
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 23:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCDXxD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 18:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCDXxC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 18:53:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD2CDEF
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 15:52:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so24556971edb.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 15:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677973978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElKyCAEjKYln0Oxdnu5/kmS5Su22bI0nBFZvKG/ppQ=;
        b=Mz12nkJ4bIXW/C0RGxPomknBYLueaQk0xxMYxDJP+4/DBtsnbzyfqO5FI1cBiegC91
         9cT1ToMsAjoZDl4t3LYEqOh/DtNpD60JiIwDKXNIEmxXsZyiQaXJOisBq6l5NGxQCZP4
         KeTLlF4f21yVt5OYcYkb1eCB5jvGjcJhQfNXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677973978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MElKyCAEjKYln0Oxdnu5/kmS5Su22bI0nBFZvKG/ppQ=;
        b=KlqWaAJQoMVIM7m0B/R+CMydvbG/QQ7eLVQxjz6+NAnGWvdpPelFhHvMHPAgOdF3b8
         wxga+q5orLbasAcQm4E3W6cxepQlPbFqENYc3qAdjwMLtJHufX6fZzvGtLtVmiKrGF/1
         jqs+Hz07DXkKryqDaWz0aqiITvRFdnvmvv2h34KaAa0UXegkrZ07P1n8ksdx94PXZubN
         EfSL1z4ZSzi7kCFFnRo5nyT9YF7C0vDaNhnE+DF/eqMN+TXO+Zprbh94dFuMI+DOV9AA
         6t++GIVwN1nW9e9TkbfLUa+NiMBf8mOatd+HR9+v2Inh8+KzFYYPddr/mEVHXPyw7oY5
         mklw==
X-Gm-Message-State: AO0yUKUryZACPQ9rRgaGU4T6cJtfqMbr0y00cPHmtSgCfkAZV4Y0ku/z
        1djTKv5dtlDuc7slL6UAEBuhmZWiTtr72pnQ6fqqoA==
X-Google-Smtp-Source: AK7set/7X1iAyOBi4zjDd4tBTQFtKTKnMNavng2YhMHo/wQsZsUSUQH6NnETYRRn6Y8xsc7DRrlRcw==
X-Received: by 2002:aa7:d856:0:b0:4af:6e95:861b with SMTP id f22-20020aa7d856000000b004af6e95861bmr11420027eds.2.1677973977850;
        Sat, 04 Mar 2023 15:52:57 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 6-20020a508e06000000b004bf7905559asm2973598edw.44.2023.03.04.15.52.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 15:52:57 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id ay14so20781950edb.11
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 15:52:56 -0800 (PST)
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr3409593edb.5.1677973976346; Sat, 04 Mar
 2023 15:52:56 -0800 (PST)
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
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com> <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
In-Reply-To: <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 15:52:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTO-VwB2ARhL9jg1k63L26YR0sfnpOKaGsEi=Va5zVtQ@mail.gmail.com>
Message-ID: <CAHk-=whTO-VwB2ARhL9jg1k63L26YR0sfnpOKaGsEi=Va5zVtQ@mail.gmail.com>
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

On Sat, Mar 4, 2023 at 3:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, this particular patch at least boots for me for my normal
> config. Not that I've run any extensive tests, but I'm writing this
> email while running this patch, so ..

Hmm. I enabled the KUNIT tests, and used an odd CONFIG_NR_CPUS to test
this a bit more.

So in my situation, I have 64 threads, and so nr_cpu_ids is 64, and
CONFIG_NR_CPUS is 150.

Then one cpumask KUNIT test fails with

     # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c:70
                  Expected ((unsigned int)150) =3D=3D cpumask_weight(&mask_=
all), but
                      ((unsigned int)150) =3D=3D 150 (0x96)
                      cpumask_weight(&mask_all) =3D=3D 64 (0x40)
              &mask_all contains CPUs 0-63

but I think that's actually a KUNIT test bug.

The KUNIT test there is

        KUNIT_EXPECT_EQ_MSG(test, nr_cpumask_bits,
cpumask_weight(&mask_all), MASK_MSG(&mask_all));

and it should *not* expect the cpumask weight to be nr_cpumask_bits,
it should expect it to be nr_cpu_ids.

That only matters now that nr_cpumask_bits isn't the same as nr_cpu_ids./

Anyway, I still think that patch of mine is fine, and I think this
test failure only ends up being about the test, not the patch.

            Linus
