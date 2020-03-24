Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED49C43331
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2FA20719
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c6BWSWwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCXSG5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:06:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCXSG4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:06:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id d198so4288601wmd.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xhSNhInfbkhw9Tyrol6FCl+av3/YsbNLmKw2OeAtFgo=;
        b=c6BWSWwJu2NoDWhT1p3b28hnOXVHz4XHF8NEU/7/D+2zuTMXNee6qXECxllDNYLtk4
         OJXXUZjl26Ax+c2wx7B/W/Q92kUZY1FQP5WT7nRATW02tPGaOwFr3xZ5PInMbCYUiCp/
         SBYjIQ8SSx/jwyXYLIMKsBr6gLhNBJjyEO5pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xhSNhInfbkhw9Tyrol6FCl+av3/YsbNLmKw2OeAtFgo=;
        b=bUjKwmiUK4P1frsCHkg0Die3kQUL2j92F4uTGGAJ8JFqqqpLKJ59VO11eN4Zkj274q
         OrMoYHadFNgWRvOP0kL3XMSZOhQQvHSofA6i5Gf8pamdtMrMV+v9mF4XDvPuvsQhLux7
         B/BWEvXnQZ17TEZc8VMaktSHtXM/5n1Qoz3f7BOG2c9a+iYegE1K8u3K9Rxhs02tsKMZ
         Cd7/4w/2WfX4mAf03d4U+q2puYW44otj9OmWhY+/+i/f8mFcRhX04Gp/Tc/SEvAzBMqZ
         FHTWF79kWMMbwPcyGBvPQSg03GCsKUNhRQbrzpeojp/WiPEEu6AvR78BmBdIE0Gx8W4K
         XKiQ==
X-Gm-Message-State: ANhLgQ0DAK6LrIWwChC4LlwVgo3GTPUpU7Wozm8Ss45tRaHkxSiVo/+J
        1x1pXqEL2q6N2faeUNUSkcX4tg==
X-Google-Smtp-Source: ADFU+vs1zPw+UU/NOE75RDtqyDGSAbCXsLscHxEA3b7Nb9zQkxs6LqLss+95bWMKYp2q41gN3LJJaw==
X-Received: by 2002:a1c:a552:: with SMTP id o79mr7018394wme.87.1585073214731;
        Tue, 24 Mar 2020 11:06:54 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id l12sm29098026wrt.73.2020.03.24.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:06:54 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 19:06:52 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
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
Message-ID: <20200324180652.GA11855@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003241100.279457EF@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-Mär 11:01, Kees Cook wrote:
> On Tue, Mar 24, 2020 at 01:49:34PM -0400, Stephen Smalley wrote:
> > On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > > On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > > > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
> > > >> On 24-Mär 10:35, Stephen Smalley wrote:
> > > >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> > > >>>> From: KP Singh <kpsingh@google.com>
> > > >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > >>>> index 530d137f7a84..2a8131b640b8 100644
> > > >>>> --- a/kernel/bpf/bpf_lsm.c
> > > >>>> +++ b/kernel/bpf/bpf_lsm.c
> > > >>>> @@ -9,6 +9,9 @@
> > > >>>>  #include <linux/btf.h>
> > > >>>>  #include <linux/lsm_hooks.h>
> > > >>>>  #include <linux/bpf_lsm.h>
> > > >>>> +#include <linux/jump_label.h>
> > > >>>> +#include <linux/kallsyms.h>
> > > >>>> +#include <linux/bpf_verifier.h>
> > > >>>>
> > > >>>>  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > >>>>   * function where a BPF program can be attached as an fexit trampoline.
> > > >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > >>>>  #include <linux/lsm_hook_names.h>
> > > >>>>  #undef LSM_HOOK
> > > >>>>
> > > >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > > >>>> +
> > > >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > >>>> +                       const struct bpf_prog *prog)
> > > >>>> +{
> > > >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > >>>> +        */
> > > >>>> +       if (!capable(CAP_MAC_ADMIN))
> > > >>>> +               return -EPERM;
> > > >>> I had asked before, and will ask again: please provide an explicit LSM
> > > >>> hook for mediating whether one can make changes to the LSM hooks.
> > > >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.
> > > >> What do you think about:
> > > >>
> > > >>   int security_check_mutable_hooks(void)
> > > >>
> > > >> Do you have any suggestions on the signature of this hook? Does this
> > > >> hook need to be BPF specific?
> > > > I'd do something like int security_bpf_prog_attach_security(const
> > > > struct bpf_prog *prog) or similar.
> > > > Then the security module can do a check based on the current task
> > > > and/or the prog.  We already have some bpf-specific hooks.
> > >
> > > I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
> > > Just as Yama policy is independent of SELinux policy so KRSI policy should
> > > be independent of SELinux policy. I understand the argument that BDF programs
> > > ought to be constrained by SELinux, but I don't think it's right. Further,
> > > we've got unholy layering when security modules call security_ functions.
> > > I'm not saying there is no case where it would be appropriate, but this is not
> > > one of them.
> > 
> > I explained this previously.  The difference is that the BPF programs
> > are loaded from a userspace
> > process, not a kernel-resident module.  They already recognize there
> > is a difference here or
> > they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
> > problem with that
> > check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
> > privileged with respect to
> > SELinux, which is why I want an explicit hook.  This gets a NAK from
> > me until there is such a hook.
> 
> Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> SELinux's need here? I.e. it can already examine that a hook is being
> created for the LSM (since it has a distinct type, etc)?

I was about to say the same, specifically for the BPF use-case, we do
have the "bpf_prog" i.e. :

"Do a check when the kernel generate and return a file descriptor for
eBPF programs."

SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
providing a callback for this hook.

- KP

> 
> -- 
> Kees Cook
