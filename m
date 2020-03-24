Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC21C41621
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380EC20789
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDPahvsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgCXSUV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:20:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37668 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCXSUV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:20:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id w13so19439983oih.4;
        Tue, 24 Mar 2020 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QAsNqo91AZeBDE6F+SBZ53GrNbBmODwiTL6H1PjXDaY=;
        b=nDPahvsxANLN/fCqy3jJsk5S4SDwZAZh3QOv6ulH4PESbA0kR6J5qkTP7HWSy6BEW1
         X/Q32jC3wNDPfa7iFm7XMtXwwBXIO39cxoJBgpREBxAZFrZ6g5vCBcOBRCtMaAQUjJIn
         PUeMNR1ubkrzX7LcAq7KtJ7OeU2GbHdTsckA2Q9MxLHxrF+gPePvSccJvifd2GA/EnZD
         jA5CEWRHRUsLjBB4VH7Rz+CDALpVQVgVHxg2y0xqqE38hmor/aPO5hxziFl54TucYtIA
         C0LAU/7IW+PF3nWO4ttq3MjfJgEUYxf5pOI+/2YzOTkuMg0fZu4YDGF2B8KTrX/hzepO
         qsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAsNqo91AZeBDE6F+SBZ53GrNbBmODwiTL6H1PjXDaY=;
        b=VCNRplK3b88b7x2YP4if3u9/AnsBQ01QZfUWa5OpMVVnA0OwYuFVktaKfL4Ge7GqER
         fRFoQzVYzhrx6CWR1/aqGa6jTLO97qgJto/Y9ur//PqFJkipeF9h1f0D7dSAGZu1CuMD
         wb919KzkYLyiHnAhopNKjd3XUEfWgjHagWjwreZE/AUQ34vbUyyW7Rxh6NuVgvTaFcjH
         eIboDgoqA8jBLu7HNlnw08JAmGZsFlgJLgDhw7wzox3eX/EFzmsNhDCeLBQbVsgwJn6Y
         5GC2un04U13NHHMOdbbuaGCH8CB44vUu61xPy5wceJRNV/6qYVSBv0Zk9DuSnsyTtYVm
         17TQ==
X-Gm-Message-State: ANhLgQ13o9RuLvVeTohxa6rfYbs0TYrVteox7MHjoZlRz3of9etyiI8a
        Vwqj7D6CAczwZOvmWfR/9euPUBekaGTBHklO1z4=
X-Google-Smtp-Source: ADFU+vsTTzOBEbslZ/jOchNxTsXwqzLL2kJQC2QNM2a0aY01y0dTE5CfqmANuyu7O3+wSM4ccC7AALy8hhTlaiFk5oo=
X-Received: by 2002:aca:b803:: with SMTP id i3mr4303855oif.92.1585074020348;
 Tue, 24 Mar 2020 11:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org> <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com> <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook> <20200324180652.GA11855@chromium.org>
In-Reply-To: <20200324180652.GA11855@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 14:21:30 -0400
Message-ID: <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and execution
To:     KP Singh <kpsingh@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 2:06 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 24-M=C3=A4r 11:01, Kees Cook wrote:
> > On Tue, Mar 24, 2020 at 01:49:34PM -0400, Stephen Smalley wrote:
> > > On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> > > >
> > > > On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > > > > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> =
wrote:
> > > > >> On 24-M=C3=A4r 10:35, Stephen Smalley wrote:
> > > > >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org=
> wrote:
> > > > >>>> From: KP Singh <kpsingh@google.com>
> > > > >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > >>>> index 530d137f7a84..2a8131b640b8 100644
> > > > >>>> --- a/kernel/bpf/bpf_lsm.c
> > > > >>>> +++ b/kernel/bpf/bpf_lsm.c
> > > > >>>> @@ -9,6 +9,9 @@
> > > > >>>>  #include <linux/btf.h>
> > > > >>>>  #include <linux/lsm_hooks.h>
> > > > >>>>  #include <linux/bpf_lsm.h>
> > > > >>>> +#include <linux/jump_label.h>
> > > > >>>> +#include <linux/kallsyms.h>
> > > > >>>> +#include <linux/bpf_verifier.h>
> > > > >>>>
> > > > >>>>  /* For every LSM hook  that allows attachment of BPF programs=
, declare a NOP
> > > > >>>>   * function where a BPF program can be attached as an fexit t=
rampoline.
> > > > >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_AR=
GS__) {}
> > > > >>>>  #include <linux/lsm_hook_names.h>
> > > > >>>>  #undef LSM_HOOK
> > > > >>>>
> > > > >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > > > >>>> +
> > > > >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > >>>> +                       const struct bpf_prog *prog)
> > > > >>>> +{
> > > > >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make change=
s to LSM hooks
> > > > >>>> +        */
> > > > >>>> +       if (!capable(CAP_MAC_ADMIN))
> > > > >>>> +               return -EPERM;
> > > > >>> I had asked before, and will ask again: please provide an expli=
cit LSM
> > > > >>> hook for mediating whether one can make changes to the LSM hook=
s.
> > > > >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this =
for SELinux.
> > > > >> What do you think about:
> > > > >>
> > > > >>   int security_check_mutable_hooks(void)
> > > > >>
> > > > >> Do you have any suggestions on the signature of this hook? Does =
this
> > > > >> hook need to be BPF specific?
> > > > > I'd do something like int security_bpf_prog_attach_security(const
> > > > > struct bpf_prog *prog) or similar.
> > > > > Then the security module can do a check based on the current task
> > > > > and/or the prog.  We already have some bpf-specific hooks.
> > > >
> > > > I *strongly* disagree with Stephen on this. KRSI and SELinux are pe=
ers.
> > > > Just as Yama policy is independent of SELinux policy so KRSI policy=
 should
> > > > be independent of SELinux policy. I understand the argument that BD=
F programs
> > > > ought to be constrained by SELinux, but I don't think it's right. F=
urther,
> > > > we've got unholy layering when security modules call security_ func=
tions.
> > > > I'm not saying there is no case where it would be appropriate, but =
this is not
> > > > one of them.
> > >
> > > I explained this previously.  The difference is that the BPF programs
> > > are loaded from a userspace
> > > process, not a kernel-resident module.  They already recognize there
> > > is a difference here or
> > > they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
> > > problem with that
> > > check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
> > > privileged with respect to
> > > SELinux, which is why I want an explicit hook.  This gets a NAK from
> > > me until there is such a hook.
> >
> > Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> > SELinux's need here? I.e. it can already examine that a hook is being
> > created for the LSM (since it has a distinct type, etc)?
>
> I was about to say the same, specifically for the BPF use-case, we do
> have the "bpf_prog" i.e. :
>
> "Do a check when the kernel generate and return a file descriptor for
> eBPF programs."
>
> SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
> providing a callback for this hook.

Ok.  In that case do we really need the capable() check here at all?
