Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892ABC2BAEE
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B20220714
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xa/tyAr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXS2F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:28:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgCXS2F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:28:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so19385772wru.13
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D3nFxIBa0F0SX5qVW91rkLveu0dFlgh41jMm3Zwi3k0=;
        b=Xa/tyAr6jGWzt6I2Bb2Q+sC/2sFN0hVz6PEXnAqyS1+K6Kp/ishBg8/NVLLrGCIqii
         j6TY5w33gEzSYDWyeoozUUBX9wcFiwXqc3AZr9h24tkRYSn7XjxNpwGoJrdSKUl294jf
         zIzho2IFsTd+d0+/PlcJX1DMHhdptXoWenqFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D3nFxIBa0F0SX5qVW91rkLveu0dFlgh41jMm3Zwi3k0=;
        b=q0GaGx9oiMUIyKuB/GZHUaLZAGYN7JNR2E3lBShoLKwUJXZNZ11+voMaVKguxliZ86
         q4jXfgG/gOoq90HOhCttiYu4Uc+LVSMcjzCESQNyloP5Mmh+jKkUICjsFbVb794MSD30
         Rb81b7B8nv3yIJ1UllXviiLTICh1Fqx2+Wu/LkmvtR23A97NRnXfi6MJScSuTg5yqwp6
         aXQtWeHRPGGhYCLp81du9R1G2GtYRucPClgc5FO3yPdEafWZI9B6iFSCCHccrvMNx/CO
         sWGilAuXPx0KDTJ5ZIcmW3ep3xUtH54+LT5+mQ8eKITbFGLs6t+rE1DB6SjWMFQ85Nns
         b4RQ==
X-Gm-Message-State: ANhLgQ2+zkkGycq3M3ij1dZzoRnTuLfuqRx4k1pBl2kFrHDMhaimWYdU
        i0s0XQh54PexxqO+pmovtv2OQQ==
X-Google-Smtp-Source: ADFU+vs+vUVGDl9kzh0LKDtKfc7LbxrqRWC/dqEqtC75PZeNETIdsKvLR1xs8B2/GPevtFWtiqCZ9g==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr30101022wrm.153.1585074482960;
        Tue, 24 Mar 2020 11:28:02 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id d21sm29806627wrb.51.2020.03.24.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:28:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 19:27:59 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200324182759.GA5557@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-Mär 14:21, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 2:06 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 11:01, Kees Cook wrote:
> > > On Tue, Mar 24, 2020 at 01:49:34PM -0400, Stephen Smalley wrote:
> > > > On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > >
> > > > > On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > > > > > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
> > > > > >> On 24-Mär 10:35, Stephen Smalley wrote:
> > > > > >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> > > > > >>>> From: KP Singh <kpsingh@google.com>
> > > > > >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > > >>>> index 530d137f7a84..2a8131b640b8 100644
> > > > > >>>> --- a/kernel/bpf/bpf_lsm.c
> > > > > >>>> +++ b/kernel/bpf/bpf_lsm.c
> > > > > >>>> @@ -9,6 +9,9 @@
> > > > > >>>>  #include <linux/btf.h>
> > > > > >>>>  #include <linux/lsm_hooks.h>
> > > > > >>>>  #include <linux/bpf_lsm.h>
> > > > > >>>> +#include <linux/jump_label.h>
> > > > > >>>> +#include <linux/kallsyms.h>
> > > > > >>>> +#include <linux/bpf_verifier.h>
> > > > > >>>>
> > > > > >>>>  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > > > >>>>   * function where a BPF program can be attached as an fexit trampoline.
> > > > > >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > > > >>>>  #include <linux/lsm_hook_names.h>
> > > > > >>>>  #undef LSM_HOOK
> > > > > >>>>
> > > > > >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > > > > >>>> +
> > > > > >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > > >>>> +                       const struct bpf_prog *prog)
> > > > > >>>> +{
> > > > > >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > > > >>>> +        */
> > > > > >>>> +       if (!capable(CAP_MAC_ADMIN))
> > > > > >>>> +               return -EPERM;
> > > > > >>> I had asked before, and will ask again: please provide an explicit LSM
> > > > > >>> hook for mediating whether one can make changes to the LSM hooks.
> > > > > >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.
> > > > > >> What do you think about:
> > > > > >>
> > > > > >>   int security_check_mutable_hooks(void)
> > > > > >>
> > > > > >> Do you have any suggestions on the signature of this hook? Does this
> > > > > >> hook need to be BPF specific?
> > > > > > I'd do something like int security_bpf_prog_attach_security(const
> > > > > > struct bpf_prog *prog) or similar.
> > > > > > Then the security module can do a check based on the current task
> > > > > > and/or the prog.  We already have some bpf-specific hooks.
> > > > >
> > > > > I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
> > > > > Just as Yama policy is independent of SELinux policy so KRSI policy should
> > > > > be independent of SELinux policy. I understand the argument that BDF programs
> > > > > ought to be constrained by SELinux, but I don't think it's right. Further,
> > > > > we've got unholy layering when security modules call security_ functions.
> > > > > I'm not saying there is no case where it would be appropriate, but this is not
> > > > > one of them.
> > > >
> > > > I explained this previously.  The difference is that the BPF programs
> > > > are loaded from a userspace
> > > > process, not a kernel-resident module.  They already recognize there
> > > > is a difference here or
> > > > they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
> > > > problem with that
> > > > check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
> > > > privileged with respect to
> > > > SELinux, which is why I want an explicit hook.  This gets a NAK from
> > > > me until there is such a hook.
> > >
> > > Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> > > SELinux's need here? I.e. it can already examine that a hook is being
> > > created for the LSM (since it has a distinct type, etc)?
> >
> > I was about to say the same, specifically for the BPF use-case, we do
> > have the "bpf_prog" i.e. :
> >
> > "Do a check when the kernel generate and return a file descriptor for
> > eBPF programs."
> >
> > SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
> > providing a callback for this hook.
> 
> Ok.  In that case do we really need the capable() check here at all?

We do not have a specific capable check for BPF_PROG_TYPE_LSM programs
now. There is a general check which requires CAP_SYS_ADMIN when
unprivileged BPF is disabled:

in kernel/bpf/sycall.c:

        if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
	        return -EPERM;

AFAIK, Most distros disable unprivileged eBPF.

Now that I look at this, I think we might need a CAP_MAC_ADMIN check
though as unprivileged BPF being enabled will result in an
unprivileged user being able to load MAC policies.

- KP
