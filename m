Return-Path: <SRS0=UPXR=CD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB5AC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Aug 2020 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E790E2075F
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Aug 2020 22:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkYEIrVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHYWwM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYWwJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Aug 2020 18:52:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE64C061574
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2020 15:52:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so605156wmi.3
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2020 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfOl2UQHdbCINZIldHubnmx8IVpsfXAYL83fcmtlXw4=;
        b=QkYEIrVgLfpQTJIqmhbHY5M5fM5kJic86WqU3jpgR1PUjq7Lp9fn2kZtNEe1+D+oxZ
         ulF3o5vvudoz2/UXKjoXPEelAOmg8R7YPWOaZ77xVjb+sciCMghJm9EQwHretixTnYp6
         T4RmmOq9Fda1Hh/mBcwPwM0mT2ew82EgE/agw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfOl2UQHdbCINZIldHubnmx8IVpsfXAYL83fcmtlXw4=;
        b=a1bLU18+nZ4mjxM7HayGdpLxmjYiHw2J2/QGsn1q4OQFYdomeUyLj3TVX+OFbsjjhT
         7lU5fzbHYB0hyAvFKFtD/e9w41qabGh2KaYa5ECu7g8KeO65u2Fk/EOGdFb16p93Ji6h
         9hGtAptjV1nIMYdquwDvU7SHxRJw+30QDpL5l+/FGpWDivIAZo1dDtWac4fvsFBqtb3f
         0JbvXZm+fQFiSiuXjJIzM9ZEv2vdoA8wPzfvUgOAEVVXi8iIO7IhUxt+1M6txIWV0bzV
         CR8yUXsvBDY5w4cHdiW6MG65rLOBoKNPkkHgwR7NJpMO/yqY7YpcyJTIh7H/CIukJ2Is
         TE0Q==
X-Gm-Message-State: AOAM5305dhy0lAzNjWmp90nYZZ6A2vK8qFxan2q30daYC0RjHSgwYZZy
        3HMm26CEZgW3VkDWpRls8i0fic8dH5pMJBdkpJ982Q==
X-Google-Smtp-Source: ABdhPJwpMoZqgzHr01+lgnJ9+FUckysA+/VP6wA0DAh6UJAf/MhHZjVoI3Nd3t+B0oMotoHDmAdl90MhToObkEkKQx4=
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr3938731wme.131.1598395927741;
 Tue, 25 Aug 2020 15:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200825182919.1118197-1-kpsingh@chromium.org>
 <CAADnVQJG+vMTyuNGjWTYnWX11ZqJU-EE30UC5KPJtpv1MC78cw@mail.gmail.com> <CAADnVQK0sKWa-XMUR9y28KEqMCOQhnRcAu=MDv4rU8iPwLBW1w@mail.gmail.com>
In-Reply-To: <CAADnVQK0sKWa-XMUR9y28KEqMCOQhnRcAu=MDv4rU8iPwLBW1w@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 26 Aug 2020 00:51:57 +0200
Message-ID: <CACYkzJ7fM4KEhWh1ACkJbtc+VNnN1A0CESkn3k45L5Bywae21w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 0/7] Generalizing bpf_local_storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 12:13 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 2:05 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 11:29 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > # v9 -> v10
> > >
> > > - Added NULL check for inode_storage_ptr before calling
> > >   bpf_local_storage_update
> > > - Removed an extraneous include
> > > - Rebased and added Acks / Signoff.
> >
> > Hmm. Though it looks good I cannot apply it, because
> > test_progs -t map_ptr
> > is broken:
> > 2225: (18) r2 = 0xffffc900004e5004
> > 2227: (b4) w1 = 58
> > 2228: (63) *(u32 *)(r2 +0) = r1
> >  R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R1_w=inv58
> > R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3=inv49 R4=inv63
> > R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
> > R7=invP8 R8=map_ptr(id=0,off=0,ks=4,vs=4,imm=0) R10=?
> > ; VERIFY_TYPE(BPF_MAP_TYPE_SK_STORAGE, check_sk_storage);
> > 2229: (18) r1 = 0xffffc900004e5000
> > 2231: (b4) w3 = 24
> > 2232: (63) *(u32 *)(r1 +0) = r3
> >  R0=map_value(id=0,off=0,ks=4,vs=4,imm=0)
> > R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0)
> > R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3_w=inv24 R4=inv63
> > R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
> > R7=invP8 R8=map_pt?
> > 2233: (18) r3 = 0xffff8881f03f7000
> > ; VERIFY(indirect->map_type == direct->map_type);
> > 2235: (85) call unknown#195896080
> > invalid func unknown#195896080
> > processed 4678 insns (limit 1000000) max_states_per_insn 9
> > total_states 240 peak_states 178 mark_read 11
> >
> > libbpf: -- END LOG --
> > libbpf: failed to load program 'cgroup_skb/egress'
> > libbpf: failed to load object 'map_ptr_kern'
> > libbpf: failed to load BPF skeleton 'map_ptr_kern': -4007
> > test_map_ptr:FAIL:skel_open_load open_load failed
> > #43 map_ptr:FAIL
> >
> > Above 'invalid func unknown#195896080' happens
> > when libbpf fails to do a relocation at runtime.
> > Please debug.
> > It's certainly caused by this set, but not sure why.
>
> So I've ended up bisecting and debugging it.
> It turned out that the patch 1 was responsible.
> I've added the following hunk to fix it:

Thanks for fixing and debugging it.

> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index 473665cac67e..982a2d8aa844 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -589,7 +589,7 @@ static inline int check_stack(void)
>         return 1;

[...]

> and pushed the whole set.
> In the future please always run test_progs and test_progs-no_alu32

Noted, I do run them but this test gave me a different error and I always
ended up ignoring this:

./test_progs -t map_ptr
libbpf: Error in bpf_create_map_xattr(m_array_of_maps):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_hash_of_maps):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_perf_event_array):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_stack_trace):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_cgroup_array):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_devmap):ERROR:
strerror_r(-524)=22(-524). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(m_sockmap):Invalid
argument(-22). Retrying without BTF.
libbpf: map 'm_sockmap': failed to create: Invalid argument(-22)
libbpf: failed to load object 'map_ptr_kern'
libbpf: failed to load BPF skeleton 'map_ptr_kern': -22
test_map_ptr:FAIL:skel_open_load open_load failed

I now realized that I was not sourcing
tools/testing/selftests/bpf/config correctly
and CONFIG_BPF_STREAM_PARSER was not enabled in my configuration.

Nonetheless, no excuses and will ensure these tests pass in the future.

- KP

> for every patch and submit patches only if _all_ tests are passing.
> Do not assume that your change is not responsible for breakage.
