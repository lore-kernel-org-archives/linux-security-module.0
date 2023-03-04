Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029BBC61DA4
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 03:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCDDnC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Mar 2023 22:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCDDnA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Mar 2023 22:43:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6E6A4F
        for <linux-security-module@vger.kernel.org>; Fri,  3 Mar 2023 19:42:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d30so17882598eda.4
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 19:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=gOk0r7IRyae11l5C54SWiNiUvgkha+5UOxrFtkZuCOq5WzJBwVOKijP66ljuIoVkMx
         OgBLbxOMIQM6b5q0q40eiJtRBjqVkHEcxVbohaNPqvci2K/m+zuK0VJWL7uN4XlbAgw+
         xOiDFKE8EoNI8PDeqzIG4PT5dQQoYmga5jmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677901375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRI2r+nGaYoc/6DC9g4x/BneKMapCVAkn7Icxvx9UyE=;
        b=yEXdz5FbJe2hOyInL34P5Na1QJAsrOCXy/uDuUDPEBZfem36ifkPewWq6ZQL9xAYpt
         xdrpPPMjQlGxTJWintVcHEQAczHrWtqSNcPP8q+G7xlx2Vq+RBA1kAelLORI4oxEAk5U
         fh9V7YI1xTpYw09txD8sE6IXZUx+i1517Rn+ktkdrSaRi9qLVgNwtqFuhZG0K1drwxAc
         puDtRg1E3c8UYmNQcfvxwfdUM3VFWt6T9xQqNba6zj63hVvLK07KFy4SMGuLtzQ/aEsM
         M/BjEZYiVppjgiqps4/6ELLkYJAgBVw4oHOIFyNQdQB+oG4LrUz2pzb6qTIlXJirvzMH
         gYtA==
X-Gm-Message-State: AO0yUKVs0iq2clXBARlZcB3+y1QruIos4Xf9DeT+FwDKX11u24iTxcrh
        /B0fRLoYsd7gMlbkpNxrSV1oKb69xTY4Pv9RpHLfKQ==
X-Google-Smtp-Source: AK7set/ZNe9TbMverXcKifDqHHZG6nLWQF2dmR4yG5t53paFuVauqaalBuQ6zXl7BhftIERleXGq7A==
X-Received: by 2002:aa7:d850:0:b0:4aa:a4ea:cdc9 with SMTP id f16-20020aa7d850000000b004aaa4eacdc9mr4559458eds.16.1677901374662;
        Fri, 03 Mar 2023 19:42:54 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id q10-20020a50c34a000000b004bda465da32sm1933775edb.1.2023.03.03.19.42.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 19:42:53 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id x3so17707450edb.10
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 19:42:53 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr2310202edf.5.1677901373386; Fri, 03 Mar
 2023 19:42:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com> <ZAK6Duaf4mlgpZPP@yury-laptop>
In-Reply-To: <ZAK6Duaf4mlgpZPP@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 19:42:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
Message-ID: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 7:25=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
> bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
> should disappear.

I do not believe CONFIG_FORCE_NR_CPUS makes any sense, and I think I
told you so at the time.

This all used to just work *without* some kind of config thing, First
removing the automatic "do the right thing", and then adding a config
option to "force" doing the right thing seems more than a bit silly to
me.

I think CONFIG_FORCE_NR_CPUS should go away, and - once more - become
just the "is the cpumask small enough to be just allocated directly"
thing.

Of course, the problem for others remain that distros will do that
CONFIG_CPUMASK_OFFSTACK thing, and then things will suck regardless.

I was *so* happy with our clever "you can have large cpumasks, and
we'll just allocate them off the stack" long long ago, because it
meant that we could have one single source tree where this was all
cleanly abstracted away, and we even had nice types and type safety
for it all.

That meant that we could support all the fancy SGI machines with
several thousand cores, and it all "JustWorked(tm)", and didn't make
the normal case any worse.

I didn't expect distros to then go "ooh, we want that too", and enable
it all by default, and make all our clever "you only see this
indirection if you need it" go away, and now the normal case is the
*bad* case, unless you just build your own kernel and pick sane
defaults.

Oh well.

                   Linus
