Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80557C433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Apr 2022 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiDDXEc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiDDXEQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Apr 2022 19:04:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03E4B1F4
        for <linux-security-module@vger.kernel.org>; Mon,  4 Apr 2022 15:25:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b15so10313740pfm.5
        for <linux-security-module@vger.kernel.org>; Mon, 04 Apr 2022 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gk7YExpjD17yvmNb1YnkwGsNAfvivwtdanWcpr+eU8Y=;
        b=b4kGzhYdOOBuJA+ydGgqp1rlD/EHbApMFe6NjPa2BcD1b0AjYblro2TW6cHiJwXv1j
         cIHnWLN+29p+1lVvytOTxUDuVRYGoz8mHzrqWSCMqfa4dNIB3FqIE70xRvHTuuJ9+Prg
         IMeR3KfPWdMGhvmBnaqnoUY8yhUtgAAzPiOJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gk7YExpjD17yvmNb1YnkwGsNAfvivwtdanWcpr+eU8Y=;
        b=Cm9dxu/QKxbAXd5D3J0PcE+xlKa6LreGc5q8tExkILo9d8Wo0D8ZnyIF6Ai93h+0k1
         cjx2XdNMY9wDwHnpKH+u+qD0M75TML2HXUj17w+DjKS1fty5a7F3UrcFpGSYFaccBYew
         PrwFm+9Z1q/MOAi9ZgTVIO0tqx5oE/kxfswM45D/voJHwm4FWu/8X1ZpAkamofVJhHVE
         w+dUguDxD/OYsD3aFvhxFcYhvCeG9zXJKuXrjl+sj1GPj3Q9vhCD6OhRMM4Ka+410TDQ
         g++5ms3BIjlzrVFn+kaGoWbxB3RN1x03GEKcpkoGWuV9VBVxQi8tomIWEDzemncIMHAb
         COdw==
X-Gm-Message-State: AOAM5328gBc2A6GYKiT+/d1vfdqwxOiw9as9ywa0OQylYeulNQXqf70R
        SfizLga+jBfF5Qt++WDtXufCYTesRXvOLw==
X-Google-Smtp-Source: ABdhPJxRptxXnfZI/YYw0ccjtfFSL+7+tWY8HL5HqZoAtkFBK4XdlYUkLt5bpzJtf2Kd+v7xUr+vhw==
X-Received: by 2002:a62:7b43:0:b0:4fa:6936:6986 with SMTP id w64-20020a627b43000000b004fa69366986mr318150pfc.13.1649111121830;
        Mon, 04 Apr 2022 15:25:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a0002a900b004fde4893cf8sm8710271pfs.200.2022.04.04.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:25:21 -0700 (PDT)
Date:   Mon, 4 Apr 2022 15:25:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
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
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202204041451.CC4F6BF@keescook>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 04, 2022 at 02:28:19PM -0700, Linus Torvalds wrote:
> Now, what I *think* you mean is
> 
>  (1) user-space executable loaders want to be able to test the *same*
> policy as the kernel does for execve()

Right. The script interpreter wants to ask "if this file were actually
an ELF going through execve(), would the kernel allow it?"

>  (2) access(path, EXECVE_OK) will do the same permission checks as
> "execve()" would do for that path

Maybe. I defer to Mickaël here, but my instinct is to avoid creating an
API that can be accidentally misused. I'd like this to be fd-only based,
since that removes path name races. (e.g. trusted_for() required an fd.)

>  (3) if you already have the fd open, use "faccess(fd, NULL,
> F_OK_TO_EXECUTE, AT_EMPTY_PATH)"

Yes, specifically faccessat2(). (And continuing the race thought above,
yes, there could still be races if the content of the file could be
changed, but that case is less problematic under real-world conditions.)

>  (4) maybe we want to add a flag for the "euid vs real uid", and that
> would be in the "flags" field, since that changes the actual *lookup*
> semantics
> 
> Note that that (4) is something that some normal user space has wanted
> in the past too (GNU libcs has a "eaccess()" thing for "effective uid
> access").

I think this already exists as AT_EACCESS? It was added with
faccessat2() itself, if I'm reading the history correctly.

And I just need to say that the thought of setuid script interpreters
still makes me sad. :)

>  - I really want the exact semantics very clearly defined. I think
> it's ok to say "exact same security check as for 'execve()'", but even
> then we need to have that discussion about
> 
>     (a) "what about suid bits that user space cannot react to"

What do you mean here? Do you mean setid bits on the file itself?

>     (b) that whole "effective vs real" discussion

I think this is handled with AT_EACCESS?

-- 
Kees Cook
