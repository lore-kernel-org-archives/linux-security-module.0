Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F3C4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Apr 2022 21:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiDDVyo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386483AbiDDViu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Apr 2022 17:38:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62935DFC
        for <linux-security-module@vger.kernel.org>; Mon,  4 Apr 2022 14:29:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so4461948lfa.6
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1bAt6TBAHHEmy348lJLTOOvTLaiSv+TPTdYgy4I0MYg=;
        b=E1NpQ4P1JCYLIm1H9ndx7S+bR3N92nar4xieVmugUkT6Cx5jg1i6+kdx6U9ToEInPx
         DlMzWwsy0K1TW1TUuLGfn9IByiIXEgm4qoKAaF9cTvDdVu4Py81nrFtW2CvjxbTluuDS
         cQcatiB/Kd2loHgbmaSShiD8lq4pMIa5yFk/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1bAt6TBAHHEmy348lJLTOOvTLaiSv+TPTdYgy4I0MYg=;
        b=lvXfO5IxJWCjbhPrhNIm2f7kzpM2TzRKW+QyvnQ+VazI4Orfv+Jmpr8dRwyKJ8lV/Q
         wyXprfmYP23OpPHwsLRftZXo6Fb0Ad5ShWnOf1AGcSCzAEyllPEQghC99cWzOOf+D/dS
         z2tScy71QOC2NqpdewcvBmQU8XJWElUTzjTCBc1hP0TQyQZIRvq4J3ubXYKAUj4S7U4K
         z5gnRTEXzUVOLHwslbzcGx16ThY7TdPAaCw9hGbQBfFYNcSEhFm7BpKA7AziVw6HiWIl
         0sky0BkX78que+UoSMdLH4nvOPw2rM3W+6M1lbt64yrj09/w/TPMwQYsUy7gVbUqd4jr
         9YLw==
X-Gm-Message-State: AOAM531G2+mrtdOCOcDXi83YrY5l4/xQWfTVIpCGXs3oeG2TeOVJ3rby
        ICqaq4isbOm6QqUgRQ3LH6DJM6NES/+zrEI9zpM=
X-Google-Smtp-Source: ABdhPJxiqSIwd1xOpuHXCcbZh94eZPgHkFwLT9tRdbs0nVZNUYBbaYvXODD41cgMcKOvqXI/uc4SOA==
X-Received: by 2002:a05:6512:3b90:b0:450:829f:6047 with SMTP id g16-20020a0565123b9000b00450829f6047mr236986lfv.418.1649107717831;
        Mon, 04 Apr 2022 14:28:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j3-20020a196e03000000b0044a6e47c27esm1267995lfc.48.2022.04.04.14.28.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 14:28:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t25so19711772lfg.7
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 14:28:36 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr195601lfh.687.1649107715765; Mon, 04 Apr
 2022 14:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com> <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
In-Reply-To: <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 14:28:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
Message-ID: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
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
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 4, 2022 at 1:29 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> This initial proposal was using a new faccessat2(2) flag:
> AT_INTERPRETED, see
> https://lore.kernel.org/all/20200908075956.1069018-2-mic@digikod.net/
> What do you think about that? I'm happy to get back to this version if
> everyone is OK with it.

I'm certainly happi_er_ with that, but I find that particular patch
odd for other reasons.

In no particular order:

 - what's with the insane non-C syntax? Double parentheses have no
actual meaning in C:

     if ((flags & AT_INTERPRETED)) {
         if ((mode & MAY_EXEC)) {

   so I don't understand why you'd use that strance thing.

 - why is this an AT_INTERPRETED flag? I don't understand the name, I
don't understand the semantics.

   Why would that flag have the same value as AT_SYMLINK_FOLLOW?

   Why isn't this just a new _mode_ bit, which is what I feel is
sensible? We only use three bits (with no bits set meaning
"existence"), so we have *tons* of bits left in that namespace, and it
would make much more sense to me to have

        #define EXECVE_OK 8

    which is the same as the "group exec" bit, so it actually makes
some kind of sense too.

 - related to that "I don't understand the semantics", the
"documentation" for that thing doesn't make sense either:

    +         The
    +    main usage is for script
    +    interpreters to enforce a policy
    +    consistent with the kernel's one
    +    (through sysctl configuration or LSM
    +    policy).  */

Now, what I *think* you mean is

 (1) user-space executable loaders want to be able to test the *same*
policy as the kernel does for execve()

 (2) access(path, EXECVE_OK) will do the same permission checks as
"execve()" would do for that path

 (3) if you already have the fd open, use "faccess(fd, NULL,
F_OK_TO_EXECUTE, AT_EMPTY_PATH)"

 (4) maybe we want to add a flag for the "euid vs real uid", and that
would be in the "flags" field, since that changes the actual *lookup*
semantics

Note that that (4) is something that some normal user space has wanted
in the past too (GNU libcs has a "eaccess()" thing for "effective uid
access").

And yes, we still need to talk details:

 - no backwards compatibility issues, because we've happily always
checked 'mode' for being valid, so old kernels will always return
-EINVAL.

 - POSIX namespace issues for EXECVE_OK means that the name probably
needs some thinking (maybe we just need to call it __ACCESS_OK_EXECVE
internally or something - the kernel actually doesn't even export the
existing [FRWX]_OK values, because we "know" they map tho the usual
"owner RWX" bits, with F being "no bit set")

 - I really want the exact semantics very clearly defined. I think
it's ok to say "exact same security check as for 'execve()'", but even
then we need to have that discussion about

    (a) "what about suid bits that user space cannot react to"
    (b) that whole "effective vs real" discussion

So to recap: I'm very much ok with some access() extension, but I
think even that very much needs clarification, and the existing patch
is just odd in many many ways.

                  Linus
