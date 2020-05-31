Return-Path: <SRS0=UHBo=7N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED70C433E1
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D070C2077D
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 12:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHbHd5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgEaMjl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 May 2020 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaMjk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 May 2020 08:39:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD8C061A0E;
        Sun, 31 May 2020 05:39:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so6600907qka.4;
        Sun, 31 May 2020 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ytuLH2YFJqhgNC0YAOhhBpDl+RVdv94cxkA1tYXSK98=;
        b=DfHbHd5RvKWEiGAFGtDsk/9Vby/uswg7Uo4d6tsRKI+eWnKP2OClBPjwyQO1z55fds
         OEEr0bfEqZnh2UXbGKO1m8t0PzbeYHBrk4+gND0ullfk0SI09C/wU0Pvgw98EXQumNv2
         P/9s4NX5jeQ02vyQMe8CmCqKlOFyjBM3jei25+JXoLli0rt6DeVKRm/Vcsbtv43mP9xn
         w/hsbMOlwi0/nO8XnUz0qkFY9WOaKDj5HwjkTozQSF+KcRG7EfzF2KKxdKjo3odc8jpq
         UWyd5fsUc0ojGZLgtezVxJ1KrsIWqjcniZXvm6qenuYJGLKgwC6+gM30AH0ZfaNbUtxQ
         djWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ytuLH2YFJqhgNC0YAOhhBpDl+RVdv94cxkA1tYXSK98=;
        b=m45y9XYIs6j8cjgCcd+Ezduaie9BDVZVUafZLy92zq2QcKF/8wVwwvSbh7SHjuWdsG
         XoNk9S7HkaXsGgKAIniLe4Vhs6drYLQP0W4IqN31TeXeVDPjIu6Mk8oslVgzVN9GmuIl
         BpqybY6S8c1Z+Wje3asPUE8Df9oNELNFtzgBCotCYbQkOttUIfiPIfZoXMrugzlaA7FL
         eTfjUtdz8wAIBMXrP0AE/Y+NwWybbONPd802pd5cs9pVzsOOzTM5nLwMWODeSn8SaTJq
         mJ5HoxTV8JaIyYUgqMY+GPwpBEMEHBH0lw4IDhcOrSqp64J0hVm9sapAxKfM/qEZA2BI
         E0+Q==
X-Gm-Message-State: AOAM532jPF66rqhoT41+2xsRhUS7ZAQHNBmFYcguydUBt+FyCVs9rhs3
        fhFraVmbrJExnerd703lpNI=
X-Google-Smtp-Source: ABdhPJyccATvNwOhgtHmBwyg8W3eFSqZU2yx1IU6xyHfisyDq/SuHxSB2r3SbHrVHfPpZphbeGG4cQ==
X-Received: by 2002:a37:8c81:: with SMTP id o123mr15207834qkd.162.1590928778939;
        Sun, 31 May 2020 05:39:38 -0700 (PDT)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id l9sm11944037qki.90.2020.05.31.05.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 05:39:38 -0700 (PDT)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-security-module@vger.kernel.org,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20200530055953.817666-1-krisman@collabora.com>
 <202005300923.B245392C@keescook> <851rn0ejg9.fsf@collabora.com>
From:   Paul Gofman <gofmanp@gmail.com>
Autocrypt: addr=gofmanp@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
Date:   Sun, 31 May 2020 15:39:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <851rn0ejg9.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

thanks for looking into this.

On 5/31/20 08:56, Gabriel Krisman Bertazi wrote:
>
>> Is it possible to disassemble and instrument the Windows code to inser=
t
>> breakpoints (or emulation calls) at all the Windows syscall points?
> Hi Kees,
>
> I considered instrumenting the syscall instructions with calls to some
> wrapper, but I was told that modifying the game in memory or on disk
> will trigger all sorts of anti-cheating mechanisms (my main use case ar=
e
> windows games).

Yes, this is the case. Besides, before instrumenting, we would need some
way to find those syscalls in the highly obfuscated dynamically
generated code, the whole purpose of which is to prevent disassembling,
debugging and finding things like that in it.

Ultimately, even for the cases when it would be technically feasible I
don't think Wine could ever go for modifying the program's code (unless
of course this is the part of what the program is doing itself using
winapi calls). Wine is trying to implement the API as close to Windows
as possible so the DRM can work with Wine, modifying the program's code
is something different.

>
>>> [...]
>>> * Why not SECCOMP_MODE_FILTER?
>>>
>>> We experimented with dynamically generating BPF filters for whitelist=
ed
>>> memory regions and using SECCOMP_MODE_FILTER, but there are a few
>>> reasons why it isn't enough nor a good idea for our use case:
>>>
>>> 1. We cannot set the filters at program initialization time and forge=
t
>>> about it, since there is no way of knowing which modules will be load=
ed,
>>> whether native and windows.  Filter would need a way to be updated
>>> frequently during game execution.
>>>
>>> 2. We cannot predict which Linux libraries will issue syscalls direct=
ly.
>>> Most of the time, whitelisting libc and a few other libraries is enou=
gh,
>>> but there are no guarantees other Linux libraries won't issue syscall=
s
>>> directly and break the execution.  Adding every linux library that is=

>>> loaded also has a large performance cost due to the large resulting
>>> filter.
>> Just so I can understand the expected use: given the dynamic nature of=

>> the library loading, how would Wine be marking the VMAs?
> Paul (cc'ed) is the wine expert, but my understanding is that memory
> allocation and initial program load of the emulated binary will go
> through wine.  It does the allocation and mark the vma accordingly
> before returning the allocated range to the windows application.
Yes, exactly. Pretty much any memory allocation which Wine does needs
syscalls (if those are ever encountered later during executing code from
those areas) to be trapped by Wine and passed to Wine's implementation
of the corresponding Windows API function. Linux native libraries
loading and memory allocations performed by them go outside of Wine contr=
ol.
>
>>> Indeed, points 1 and 2 could be worked around with some userspace wor=
k
>>> and improved SECCOMP_MODE_FILTER support, but at a high performance a=
nd
>>> some stability cost, to obtain the semantics we want.  Still, the
>>> performance would suffer, and SECCOMP_MODE_MEMMAP is non intrusive
>>> enough that I believe it should be considered as an upstream solution=
=2E
>> It looks like you're using SECCOMP_RET_TRAP for this? Signal handling
>> can be pretty slow. Did you try SECCOMP_RET_USER_NOTIF?

We are not much concerned with the overhead of the trapped syscall in
our use case, those are very rare. What we are concerned with is the
performance impact on the normal Linux syscalls when the syscall
trapping is enabled. When I was measuring that impact I've got the same
10% overhead for the untrapped syscalls (that is, always hitting
SECCOMP_RET_ALLOW case) with the filters Gabriel mentioned.


>>
>>> +
>>> +	if (!(vma->vm_flags & VM_NOSYSCALL))
>>> +		return 0;
>>> +
>>> +	syscall_rollback(current, task_pt_regs(current));
>>> +	seccomp_send_sigsys(this_syscall, 0);
>>> +
>>> +	seccomp_log(this_syscall, SIGSYS, SECCOMP_RET_TRAP, true);
>>> +
>>> +	return -1;
>>> +}
>> This really just looks like an ip_address filter, but I get what you
>> mean about stacking filters, etc. This may finally be the day we turn =
to
>> eBPF in seccomp, since that would give you access to using a map looku=
p
>> on ip_address, and the map could be updated externally (removing the
>> need for the madvise() changes).
> And 64-bit comparisons :)
>
> that would be a good solution, we'd still need to look at some details,=

> like disabling/updating filters at runtime when some new library is
> loaded, but since we can update externally, I think it covers it.
I am afraid that for a general case the filter add / update / removal
should be done not just when a new library is loaded or unloaded but
pretty much any time new (executable) memory region is allocated or
deallocated, or PROT_EXEC should be changed on allocated pages . But I
am not sure I've got enough details yet on the suggested approach here
and might be missing important details. I guess maybe we could discuss
the details separately with Gabriel first.


