Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7785C433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Apr 2022 02:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiDFCe5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457651AbiDEQZb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Apr 2022 12:25:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1B6412
        for <linux-security-module@vger.kernel.org>; Tue,  5 Apr 2022 09:23:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m3so24115917lfj.11
        for <linux-security-module@vger.kernel.org>; Tue, 05 Apr 2022 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FELPvFz/6oaJHsU4oc1kXTcQ26iC0/VrCF/XPlp17+4=;
        b=XJkkA3b9tMj2Oywq65L1XLPGe9r4EWP4QonCvPcAvNQC7lH+KZKOjbWEjEmxm1w9l6
         GTCCy3sUV5mOUios3pbc+w2xyA02qNafDjyGesSqpIRyz7QCRPbAT4MAOjeJ/i8sDPPr
         JM8yRVTKDHALD8dV/vRION3fkiPh4VLXV0D9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FELPvFz/6oaJHsU4oc1kXTcQ26iC0/VrCF/XPlp17+4=;
        b=2Z8dHehaNXt3o4+LQYotTpgECPusk66u33HIcEsCesa+V+ekOOfDYndCVnA/WGd8Lu
         kgHM5KUJR/QXjgEpWmAZDSdMIrYC9f24IJUCBAbvL7l6pj0NIS7W+k4I/d01bE0eV2i6
         JvPoxeXeAsObNNFn3CeMgKwdHPVYxwsZPQB6/ewLmBrL41HcuLs1xw3EwUcmu+y5xMvr
         Grlvub3sTmfJPx8bzWCTjm6/pq/mFwhB/pcDlO25XVzfYzoMrPSpG70C5o+awaMznZRJ
         qNFGjouFY12TKC17kJyaJeFWint5l8oYld0m8p7Ga2M5PhBTNeRW3e3i8Vh3LbJiMQcO
         d57w==
X-Gm-Message-State: AOAM530ZcLfh04Ssrccn++qYSb4NGs2U2D9P7PwZqGw4qdVwmB89LtrJ
        Ef6qmI9PIRWMpH2YnsBXDp8VslghdAZxDafxivE=
X-Google-Smtp-Source: ABdhPJxc3wz6LaJS0Oe5w4hoVBEoQzRWx/WqFkWOk1AiLZ2Dz8PUMZlOdXQss2RnbRH8jrRQp6eBMQ==
X-Received: by 2002:a05:6512:2345:b0:44a:33e4:d68 with SMTP id p5-20020a056512234500b0044a33e40d68mr3064495lfu.480.1649175808329;
        Tue, 05 Apr 2022 09:23:28 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512340e00b0044ade91cf51sm1440512lfr.267.2022.04.05.09.23.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 09:23:28 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id g24so17786958lja.7
        for <linux-security-module@vger.kernel.org>; Tue, 05 Apr 2022 09:23:27 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr2641943lji.176.1649175481210; Tue, 05
 Apr 2022 09:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook> <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
 <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
In-Reply-To: <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Apr 2022 09:17:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com>
Message-ID: <CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
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
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 5, 2022 at 9:08 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> I think we don't. I think the only corner case that could be different
> is for files that are executable, SUID and non-readable. In this case it
> wouldn't matter because userspace could not read the file, which is
> required for interpretation/execution. Anyway, S[GU]ID bits in scripts
> are just ignored by execve and we want to follow the same semantic.

So I just want to bring up the possibility that somebody wants to just
implement execve() in user space for some reason - not just "script
interpreter".

It's *doable*.

Don't ask me if it's sane or useful, but people have done insane
things before. Things like "emulate other operating systems in user
space" etc

Such a user can trivially see the suid/sgid bit on the file (just do
fstat() on it), but wouldn't necessarily see if that file is then in a
mount that is mounted nosuid.

Now, I think the right thing to do is to just say "we don't support
it", but I do think it should perhaps be mentioned somewhere
explicitly.

Particularly since I can well imagine that a security policy might
have some "no, I don't allow suid exec" and return an actual error for
it, and then the access() call would fail for that case.

(Ok, so the security policies would look at the actual bprm data on a
real exec, not the inode executable, so that's kind of made up and
theoretical, but I just want this issue to be mentioned somewhere so
that people are aware that the "it's the same basic file checking that
execve does, but a _real_ execve might then have _other_ issues going
on, including suid bits etc")

               Linus
