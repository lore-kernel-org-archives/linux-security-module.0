Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC5C433F5
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Apr 2022 23:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiDDXeJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiDDXeJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Apr 2022 19:34:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE2517D6
        for <linux-security-module@vger.kernel.org>; Mon,  4 Apr 2022 16:32:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a6so12248044ejk.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jx5P7yX3O5pX2LqkyeQfqU0tlbRjJjmmZeKsgU5FQa8=;
        b=X33eVsWc7Y7k1gT/g4zGwLZX8IMd0zDiGeq+SNK556d+FRB/nBPgAmF91Jc2ZewIkm
         ZVSXfO5pzStwMUuGMJ8Wv3wH7WLkU4AEEqTy2TzSWZE+Lyew31d9KVPVL8zsXNSVCGzB
         iZj8spgT2H19hxodlQ23EHu0IDi3xox/PKjik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jx5P7yX3O5pX2LqkyeQfqU0tlbRjJjmmZeKsgU5FQa8=;
        b=qDLRThzRFgxrMhf4xIx3SrYUPxsKKUlYxmIF72Fp/AyjSHVD+e7LjGC+gUlSLh0tsS
         Mb5XND0QCpPoqENlCeP2WooK4baW2WGhx5o9Lp2cArD+NU+MKD4ni7mTKP0hm87B5mco
         Aj2Jq1eF4V9aBwwHnVU/RXzFAHKuQhjB65uwgLUY7xPD+vHY8ZGcpnBzHuDisNaG0jdF
         4tmWa2YgsM7Qyt4sRBrk0V9VwLe6dAETkQjPzXn0Nz4HcmkDlQptadtiBD05Lcatjt7A
         Z587yi2auxT8oBCT7NY9ti9yg9ykDpAqYcOzvrtu3SYwewQPtCH75h6Ah9ZhSDVKD/Ez
         1xsQ==
X-Gm-Message-State: AOAM533Mnpr/efJwzYCtLtcq4IVebXofe7LI2u6Vmti57NrLTTEtP8ox
        j11C9Ugme0s9UAy/qmY8DJ2foxdkT+xbpL8cFww=
X-Google-Smtp-Source: ABdhPJx87MxytfWBiZDyQdobR4fKLFvyGrPMs7nFu+1PEtq4FQ/IgD0BJjCflm61EVcwu//Y8S3SRg==
X-Received: by 2002:a17:907:c06:b0:6e0:9149:8047 with SMTP id ga6-20020a1709070c0600b006e091498047mr589370ejc.765.1649115128662;
        Mon, 04 Apr 2022 16:32:08 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm4856120ejc.61.2022.04.04.16.32.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 16:32:08 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id d29so10751652wra.10
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 16:32:08 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr496667lfu.531.1649114820779; Mon, 04
 Apr 2022 16:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
In-Reply-To: <202204041451.CC4F6BF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 16:26:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
Message-ID: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
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
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 4, 2022 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:
>
> Maybe. I defer to Micka=C3=ABl here, but my instinct is to avoid creating=
 an
> API that can be accidentally misused. I'd like this to be fd-only based,
> since that removes path name races. (e.g. trusted_for() required an fd.)

Some people want pathnames. Think things like just the PATH thing just
to find the right executable in the first place.

For things like that, races don't matter, because you're just trying
to find the right path to begin with.

> I think this already exists as AT_EACCESS? It was added with
> faccessat2() itself, if I'm reading the history correctly.

Yeah, I noticed myself, I just hadn't looked (and I don't do enough
user-space programming to be aware of if that way).

> >     (a) "what about suid bits that user space cannot react to"
>
> What do you mean here? Do you mean setid bits on the file itself?

Right.

Maybe we don't care.

Maybe we do.

Is the user-space loader going to honor them? Is it going to ignore
them? I don't know. And it actually interacts with things like
'nosuid', which the kernel does know about, and user space has a hard
time figuring out.

So if the point is "give me an interface so that I can do the same
thing a kernel execve() loader would do", then those sgid/suid bits
actually may be exactly the kind of thing that user space wants the
kernel to react to - should it ignore them, or should it do something
special when it sees that they are set?

I'm not saying that they *should* be something we care about. All I'm
saying is that I want that *discussion* to happen.

               Linus
