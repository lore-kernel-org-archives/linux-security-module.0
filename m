Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE0C41621
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0716E2080C
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9CiRgGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCXOuO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:50:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43021 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgCXOuM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 10:50:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id b2so21766077wrj.10
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oGbi1kK4rZ5Jg0cdOf4BlknnOlqmymkgqgzxdZFk9xc=;
        b=A9CiRgGuc0FzDG8Jea7fRV9it5TL0VjdcTyRfjSQ7U6FCuWl+0j9LmRVYnApg12iUa
         2FrYHGgTGEObTGVfsbzvatv/yw//8Y8xyP7ubTh8hHoCVdlpsnSjckPtRjenc1x0QOhd
         n3PsTLkaVT6G+ohUiS6sU/8kAAkOTJj4oFtkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGbi1kK4rZ5Jg0cdOf4BlknnOlqmymkgqgzxdZFk9xc=;
        b=shVq5I6gelxGh8eth3cOcbNXmhtb2jq1ZIjBIreCyFKkbvxl/91aWegDh1NFd197LU
         Q9bIuNe7MteeG9zTs//Lzy0QZm41aSjiD20sSd8OWHWp1eY/n8NIEP8vdO47AZ0kzh3i
         kgh4LARbxxeaY7JLWi2XbW5Xs+dLfdSWl8cTzeKyAWbGQhBMW1ETwwyNTJXR8yjxlkFo
         pjTTBww89MECS0nZUZyN6HDU11cRu/soQNJ3sX9dcZi87PROaMsDHV0BNaRvv68KvGMx
         FikZZJciXZO3BfY0STH8r+vXj3MTzP4i+u6xtQct3tEvK8eQZfvnkhjhrEbc9Dcno/ab
         U7lw==
X-Gm-Message-State: ANhLgQ39x+9XdViBMTPyI/h3HBvfnItcF2JTsE9Vd+HURS/i1aRh4kOB
        t3QyY60+U/+00OTnztDjrYTfgw==
X-Google-Smtp-Source: ADFU+vtsBplmFb4Y6HIsHkRuws6sb8YO/62KkZdxsazEbdRgj7TzX90VeMndzuqAH2a1dHAS+iNnog==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr10031231wro.415.1585061410761;
        Tue, 24 Mar 2020 07:50:10 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id y7sm6619108wrq.54.2020.03.24.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:50:10 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 15:50:03 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200324145003.GA2685@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-Mär 10:35, Stephen Smalley wrote:
> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > JITed BPF programs are dynamically attached to the LSM hooks
> > using BPF trampolines. The trampoline prologue generates code to handle
> > conversion of the signature of the hook to the appropriate BPF context.
> >
> > The allocated trampoline programs are attached to the nop functions
> > initialized as LSM hooks.
> >
> > BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> > and need CAP_SYS_ADMIN (required for loading eBPF programs).
> >
> > Upon attachment:
> >
> > * A BPF fexit trampoline is used for LSM hooks with a void return type.
> > * A BPF fmod_ret trampoline is used for LSM hooks which return an
> >   int. The attached programs can override the return value of the
> >   bpf LSM hook to indicate a MAC Policy decision.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> 
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 530d137f7a84..2a8131b640b8 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -9,6 +9,9 @@
> >  #include <linux/btf.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/bpf_lsm.h>
> > +#include <linux/jump_label.h>
> > +#include <linux/kallsyms.h>
> > +#include <linux/bpf_verifier.h>
> >
> >  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> >   * function where a BPF program can be attached as an fexit trampoline.
> > @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> >  #include <linux/lsm_hook_names.h>
> >  #undef LSM_HOOK
> >
> > +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > +
> > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > +                       const struct bpf_prog *prog)
> > +{
> > +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > +        */
> > +       if (!capable(CAP_MAC_ADMIN))
> > +               return -EPERM;
> 
> I had asked before, and will ask again: please provide an explicit LSM
> hook for mediating whether one can make changes to the LSM hooks.
> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.

What do you think about:

  int security_check_mutable_hooks(void)

Do you have any suggestions on the signature of this hook? Does this
hook need to be BPF specific?

- KP
