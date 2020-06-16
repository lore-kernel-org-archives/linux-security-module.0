Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CBC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5309A2071A
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RMe1EOF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgFPPtA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbgFPPs7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42242C061755
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 08:48:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so9678582pfw.10
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aH/epTbtusDwdVV/kmnk+gLwl4nwhM0mg4o9WDdCqyA=;
        b=RMe1EOF/QbamaW1pKPoBlac6ekdFsLU6mz3tWml5zqb7Z7Uujg9yC1sk7chzVhvyVA
         sLDAvg0ARkYWCLwsNMrtTTAD8UMmfyaR/ZMzpg8PIYbdq5v157fkg2dRK2ZbWmeIjWFQ
         S3gviQeWP5HFbvl3bpwsFl/6aB6LZ4cW2zpAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aH/epTbtusDwdVV/kmnk+gLwl4nwhM0mg4o9WDdCqyA=;
        b=VJz0djt7Alxkw73FLSFAVTkFvQZQEYyPDyA7HayTwXdIDa74MF4NY/AB8rz7heEnaO
         Y+Jhg+jxGKtVuE9sQBu1ZPkayr2/i9oCW+39RcEAELeZmKIDKK1o97/lYw+DX7HvVlW0
         BoBmv+d9EzXXpn3NGUxlgmXHIC/QnWTzZJRrMI+Ypeb8+r7oq2TwPFBHM04uIzT3MtSb
         rLZO6e6jECdU3D37vvtQUABFnyCqe+bU8eod3SJdNF2wo46FDJkjOdE98/B3DqRlIfx3
         NMUPxUi5FrGOYJP1JB3fUHluSG/YjWMMpPixbe/fYnOyPP7BJkJzjnnKskYQWelnY86P
         xC3g==
X-Gm-Message-State: AOAM533vgL75u1x24ujeG752b/3ty7aWih7t9zWDxVfC+zPFVPws8t/z
        00TJahoi8kL8KS2V6YVTW5yJe1Fqnz+0ZQ==
X-Google-Smtp-Source: ABdhPJwiF2EGmCauQgmbrFK+BPdWWaiX4E7rH2Evt8OuhdmgMlvqfRGFBs5IfXJQ2kBCqUyaSrpS7w==
X-Received: by 2002:a63:690:: with SMTP id 138mr1514366pgg.122.1592322538740;
        Tue, 16 Jun 2020 08:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w24sm17371351pfn.11.2020.06.16.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 08:48:57 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:48:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
Message-ID: <202006160757.99FD9B785@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-5-keescook@chromium.org>
 <CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 02:14:47PM +0200, Jann Horn wrote:
> Wouldn't it be simpler to use a function that can run a subset of
> seccomp cBPF and bails out on anything that indicates that a syscall's
> handling is complex or on instructions it doesn't understand? For
> syscalls that have a fixed policy, a typical seccomp filter doesn't
> even use any of the BPF_ALU ops, the scratch space, or the X register;
> it just uses something like the following set of operations, which is
> easy to emulate without much code:
> 
> BPF_LD | BPF_W | BPF_ABS
> BPF_JMP | BPF_JEQ | BPF_K
> BPF_JMP | BPF_JGE | BPF_K
> BPF_JMP | BPF_JGT | BPF_K
> BPF_JMP | BPF_JA
> BPF_RET | BPF_K

Initially, I started down this path. It needed a bit of plumbing into
BPF to better control the lifetime of the cBPF "saved original filter"
(normally used by CHECKPOINT_RESTORE uses), and then I needed to keep
making exceptions (same list you have: ALU, X register, scratch, etc)
in the name of avoiding too much complexity in the emulator. I decided
I'd rather reuse the existing infrastructure to actually execute the
filter (no cBPF copy needed to be saved, no separate code, and full
instruction coverage).

> 
> Something like (completely untested):
> 
> /*
>  * Try to statically determine whether @filter will always return a fixed result
>  * when run for syscall @nr under architecture @arch.
>  * Returns true if the result could be determined; if so, the result will be
>  * stored in @action.
>  */
> static bool seccomp_check_syscall(struct sock_filter *filter, unsigned int arch,
>                                   unsigned int nr, unsigned int *action)
> {
>   int pc;
>   unsigned int reg_value = 0;
> 
>   for (pc = 0; 1; pc++) {
>     struct sock_filter *insn = &filter[pc];
>     u16 code = insn->code;
>     u32 k = insn->k;
> 
>     switch (code) {
>     case BPF_LD | BPF_W | BPF_ABS:
>       if (k == offsetof(struct seccomp_data, nr)) {
>         reg_value = nr;
>       } else if (k == offsetof(struct seccomp_data, arch)) {
>         reg_value = arch;
>       } else {
>         return false; /* can't optimize (non-constant value load) */
>       }
>       break;
>     case BPF_RET | BPF_K:
>       *action = insn->k;
>       return true; /* success: reached return with constant values only */
>     case BPF_JMP | BPF_JA:
>       pc += insn->k;
>       break;
>     case BPF_JMP | BPF_JEQ | BPF_K:
>     case BPF_JMP | BPF_JGE | BPF_K:
>     case BPF_JMP | BPF_JGT | BPF_K:
>     default:
>       if (BPF_CLASS(code) == BPF_JMP && BPF_SRC(code) == BPF_K) {
>         u16 op = BPF_OP(code);
>         bool op_res;
> 
>         switch (op) {
>         case BPF_JEQ:
>           op_res = reg_value == k;
>           break;
>         case BPF_JGE:
>           op_res = reg_value >= k;
>           break;
>         case BPF_JGT:
>           op_res = reg_value > k;
>           break;
>         default:
>           return false; /* can't optimize (unknown insn) */
>         }
> 
>         pc += op_res ? insn->jt : insn->jf;
>         break;
>       }
>       return false; /* can't optimize (unknown insn) */
>     }
>   }
> }

I didn't actually finish going down the emulator path (I stopped right
around the time I verified that libseccomp does use BPF_ALU -- though
only BPF_AND), so I didn't actually evaluate the filter contents for other
filter builders (i.e. Chrome).

But, if BPF_ALU | BPF_AND were added to your code above, it would cover
everything libseccomp generates (which covers a lot of the seccomp
filters, e.g. systemd, docker). I just felt funny about an "incomplete"
emulator.

Though now you've got me looking. It seems this is the core
of Chrome's BPF instruction generation:
https://github.com/chromium/chromium/blob/master/sandbox/linux/bpf_dsl/policy_compiler.cc
It also uses ALU|AND, but adds JMP|JSET.

So... that's only 2 more instructions to cover what I think are likely
the two largest seccomp instruction generators.

> That way, you won't need any of this complicated architecture-specific stuff.

There are two arch-specific needs, and using a cBPF-subset emulator
just gets rid of the local TLB flush. The other part is distinguishing
the archs. Neither requirement is onerous (TLB flush usually just
needs little more than an extern, arch is already documented in the
per-arch syscall_get_arch()). The awkward part I ran into for arm64
was a header include loop for compat due to how unistd is handled for
getting NR_syscalls for the bitmap sizing (which I'm sure is solvable,
but I just wanted to get the x86 RFC posted first).

-- 
Kees Cook
