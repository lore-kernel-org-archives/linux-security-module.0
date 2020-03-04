Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA2AC3F2CD
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C7020848
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Og0kIOAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgCDPNH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:13:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDPNG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:13:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id r7so2860585wro.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hZJyRWg+l1EQKudArZuRb63dEwzdCahRlAsMV0GZXUw=;
        b=Og0kIOAhyFhYo3ateVctfHnwO5v/TiVer2LAVTuJ+JE681tg1mBEauXqfv73ltQLMI
         Xcu6v/I1lrQ4GzL3amoni5XrY0fVwPdqea8/iV3yOz3SW2GGIunF83E2lKzpsz/Kem2N
         TtJEWU3/NnYISird4p5efZ7QX3nJzYV9Qlpt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hZJyRWg+l1EQKudArZuRb63dEwzdCahRlAsMV0GZXUw=;
        b=bFAVQL/d5e3kPFdyWuhYB5PTnqbHJRwNPfypjUDqRDnE8exXfQZDex/LyX/BOBnNjs
         q8syg7LpD1emkgM3WQH291CfV8cJBKTf3h+w7gvloQ5/YGECgN0jTsYvpOLjhkrrPqAU
         5ItsxB92gDcq3fKzantgRciCw+Xha1tZqMwEydCdkxmTUCRvU2aqoWMObkQfDn+UtxnY
         dFmUxHlQoA9Dmawc2ysh+GtxoVg0enXFE1RqdvXFtF16eLaUWRbNlXTfnSjqpYky3UHr
         4AJhwnMrIr8vG00zswLUIOHRbn3PUIKerEamgJBIXlHhH/T17Sd34+GdSPA8SSoos3c+
         IZwA==
X-Gm-Message-State: ANhLgQ0/gPhzb/fhP5zdrml6rWc+h2D/F0gQeWWjfi3VrFsmIVafBErh
        gptFPGIMda7DcNN1T2iYgkM93A==
X-Google-Smtp-Source: ADFU+vvHG3HAkh9oCxuhuVqTYsrbfmOiHuluXZ/uTiIfc9wVHLVTyn3vt6erjUnGoxP4uO3TiM1chQ==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr2907749wrl.302.1583334784893;
        Wed, 04 Mar 2020 07:13:04 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id z131sm4420307wmg.25.2020.03.04.07.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:13:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:13:03 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Introduce BPF_MODIFY_RETURN
Message-ID: <20200304151303.GC9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-4-kpsingh@chromium.org>
 <CAEf4BzbbaiLC+-Gytwcx=i0XTniNH6YNsfOfx3nrU1oo73VsKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbbaiLC+-Gytwcx=i0XTniNH6YNsfOfx3nrU1oo73VsKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03-Mär 21:08, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > When multiple programs are attached, each program receives the return
> > value from the previous program on the stack and the last program
> > provides the return value to the attached function.
> >
> > The fmod_ret bpf programs are run after the fentry programs and before
> > the fexit programs. The original function is only called if all the
> > fmod_ret programs return 0 to avoid any unintended side-effects. The
> > success value, i.e. 0 is not currently configurable but can be made so
> > where user-space can specify it at load time.
> >
> > For example:
> >
> > int func_to_be_attached(int a, int b)
> > {  <--- do_fentry
> >
> > do_fmod_ret:
> >    <update ret by calling fmod_ret>
> >    if (ret != 0)
> >         goto do_fexit;
> >
> > original_function:
> >
> >     <side_effects_happen_here>
> >
> > }  <--- do_fexit
> >
> > The fmod_ret program attached to this function can be defined as:
> >
> > SEC("fmod_ret/func_to_be_attached")
> > int BPF_PROG(func_name, int a, int b, int ret)
> > {
> >         // This will skip the original function logic.
> >         return 1;
> > }
> >
> > The first fmod_ret program is passed 0 in its return argument.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c    | 130 ++++++++++++++++++++++++++++++---
> >  include/linux/bpf.h            |   1 +
> >  include/uapi/linux/bpf.h       |   1 +
> >  kernel/bpf/btf.c               |   3 +-
> >  kernel/bpf/syscall.c           |   1 +
> >  kernel/bpf/trampoline.c        |   5 +-
> >  kernel/bpf/verifier.c          |   1 +
> >  tools/include/uapi/linux/bpf.h |   1 +
> >  8 files changed, 130 insertions(+), 13 deletions(-)
> >
> 
> This looks good, but I'll Alexei check all the assembly generation
> logic, not too big of an expert on that.
> 
> [...]
> 
> 
> >  static int emit_fallback_jump(u8 **pprog)
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 98ec10b23dbb..3cfdc216a2f4 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -473,6 +473,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
> >
> >  enum bpf_tramp_prog_type {
> >         BPF_TRAMP_FENTRY,
> > +       BPF_TRAMP_MODIFY_RETURN,
> 
> This is probably bad idea to re-number BPF_TRAMP_FEXIT for no good
> reason. E.g., if there are some drgn scripts that do some internal
> state printing, this is major inconvenience, while really providing no
> benefit in itself. Consider putting it right before BPF_TRAMP_MAX.

Makes sense, I somehow initially (incorrectly) assumed that the order
represented the order of execution. But the only real demarcation
is the BPF_TRAMP_MAX. Updated it for v3.

- KP

> 
> >         BPF_TRAMP_FEXIT,
> >         BPF_TRAMP_MAX,
> >         BPF_TRAMP_REPLACE, /* more than MAX */
> 
> [...]
