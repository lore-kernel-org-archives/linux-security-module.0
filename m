Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAEAC4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Apr 2022 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiDDWEf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379699AbiDDV6l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Apr 2022 17:58:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38033419B0
        for <linux-security-module@vger.kernel.org>; Mon,  4 Apr 2022 14:40:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so19878328lfb.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=A9tjEjTQxL5uzMyZiDMZsByK+whBGLSB6qHE+uZRK7pVJilQTKdEsI9cEjxGRejl5b
         J71jC7xcvbNYqvYxcPtUkqcG/jeaBVt1hzrA68i4S37/iSwMfqtVSRk8JDPuGGLw6XZI
         nrysu96epRGW5riZujfcbHCnjDbtfn5ZsZrfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=7283DqqSiIC9UMR2IJ3a0JqA6vbqcx7LPyP/dN63juRhDja7wLjAkQR5LGbOeN8l8G
         F0v9yHyj+t8BvmyNVnvu2nhGJdYw/4ZAFRigOPRlPUK7ocEugmlV8kifB8wc/aTWPlm/
         ZxZtG6KdQW+otWJTR/qa6fRreuZT5m0Yhhjd7zXVUBbP0ZKFULWcgYaMQHd3jtYCbEnN
         5DKa3kCBdcSQyeEUIiz/V0h6H8aNo7qZ7a7DgnuP+Rq/3xeXxDxckJVJJc0mr9X1NS2/
         X2tFqbDXllrI0rJY4TJTNbNv86NWf7qIVBVX8APUEmoswCtkWuI20txoeUqwFM/iq8CV
         hqog==
X-Gm-Message-State: AOAM5310UKtm+cmjCyLo38uuHKoDq81QZaHcjGw3gDUPSpb3xIpYX1Sl
        /kdM8NqzLUAf5UemvVrff6I5PiKss/vbqpEbQpE=
X-Google-Smtp-Source: ABdhPJzbRDq7Ce8+thqVbMnyV/8/sTm9LTlrymZKnjCmrLfHVw8OLnWsdTzhdNO3uggBQ7EDOdbF/w==
X-Received: by 2002:a05:6512:3094:b0:44a:3851:f185 with SMTP id z20-20020a056512309400b0044a3851f185mr272632lfd.28.1649108442236;
        Mon, 04 Apr 2022 14:40:42 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h15-20020a2e9ecf000000b0024b0f17f790sm843573ljk.21.2022.04.04.14.40.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 14:40:40 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 5so19828083lfp.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 14:40:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr239017lfb.435.1649108438583; Mon, 04
 Apr 2022 14:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 4, 2022 at 2:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (4) maybe we want to add a flag for the "euid vs real uid", and that
> would be in the "flags" field, since that changes the actual *lookup*
> semantics

Duh. We already did that long ago, and it's there as AT_EACCESS.

I should have just looked at the code more closely.

But that "you didn't even check what we already do, Linus" thing just
makes it even more obvious that all of this makes perfect sense in the
confines of access() already, and a new "check _these_ protections"
should just be a new mode bit.

                 Linus
