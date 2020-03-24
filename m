Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF50C2BAEE
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273E208E4
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SggCZsD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgCXQMQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38429 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgCXQMP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 12:12:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so22203043wrv.5
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6s+JUpZZOeulwwQp3hTdTer/dFhcYZR33uwW9/Pdmj8=;
        b=SggCZsD1MrTRy4N8yYgCYH48EYAh1jPTaqstdjfJmC1qrv87NVo4Pg4S2ZxTvxznBP
         1et1wVMZn2T1Va6fNb9fpoMZOF9c4yGcHHrHTIO9FIakp+uewzN24xryCxMz8BpF0A5k
         Wxu82j5SMx2RDgnEf0rvZHa9ZB+onHB2wwcGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6s+JUpZZOeulwwQp3hTdTer/dFhcYZR33uwW9/Pdmj8=;
        b=FhVWnfS+F9hw4LW49pT23WfV/2NOLGGKIikUgwMEDTk/13QE1eXarCUSQQZNr3PnCy
         /ixX+TJwTv0McBpdpF+66ygpb4YyLsH2gjyi/X40pCM6ouzltGzZ6V5C4V3MrSMKII0X
         Ivtm82tgrFviOKqLSIDBuJy9Tw2zYu7rHX1oyLSo8Os0mWCY544Acj0WFWkWi12kvYHV
         LVdfQuICcHigyeEtRQSvM7jeHcSHrYTQxphTWsOYRS7iSu7qs89xrJc9n4V9odcy+dn1
         QPXUrY8PHCqqPuZheJTV8kWFNkq1uERdd7UN5YuuyHn0Kv9Si4NW1uzSs/aEqKRT7UA5
         YYVg==
X-Gm-Message-State: ANhLgQ0ilNHoAgyH8v5O5lbMQU8+RFI3/bTaqaB2A6VRSKxXmP8Oomu3
        e0fyYZqCzVTB0PsCKZVBzBhHzA==
X-Google-Smtp-Source: ADFU+vuvN4rP+Kw/5KMx38ZbYgcOIc+Am32bNafbVVbJjxFCaDUxwfDZcgFtKLY10ged/UtQTzp9Rw==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr8491178wrn.14.1585066334052;
        Tue, 24 Mar 2020 09:12:14 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i19sm4864977wmb.44.2020.03.24.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:12:13 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 17:12:11 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200324161211.GA11227@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
 <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
 <20200324103910.GA7135@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324103910.GA7135@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-Mär 11:39, KP Singh wrote:
> On 23-Mär 12:59, Andrii Nakryiko wrote:
> > On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> > > generated for each LSM hook. These nops are initialized as LSM hooks in
> > > a subsequent patch.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > > Reviewed-by: Florent Revest <revest@google.com>
> > > ---
> > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >  create mode 100644 include/linux/bpf_lsm.h
> > >
> > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > new file mode 100644
> > > index 000000000000..c6423a140220
> > > --- /dev/null
> > > +++ b/include/linux/bpf_lsm.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (C) 2020 Google LLC.
> > > + */
> > > +
> > > +#ifndef _LINUX_BPF_LSM_H
> > > +#define _LINUX_BPF_LSM_H
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <linux/lsm_hooks.h>
> > > +
> > > +#ifdef CONFIG_BPF_LSM
> > > +
> > > +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> > > +#include <linux/lsm_hook_names.h>
> > > +#undef LSM_HOOK
> > > +
> > > +#endif /* CONFIG_BPF_LSM */
> > > +
> > > +#endif /* _LINUX_BPF_LSM_H */
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 82875039ca90..530d137f7a84 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -7,6 +7,25 @@
> > >  #include <linux/filter.h>
> > >  #include <linux/bpf.h>
> > >  #include <linux/btf.h>
> > > +#include <linux/lsm_hooks.h>
> > > +#include <linux/bpf_lsm.h>
> > > +
> > > +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > + * function where a BPF program can be attached as an fexit trampoline.
> > > + */
> > > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > > +
> > > +#define LSM_HOOK_int(NAME, ...)                        \
> > > +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> > > +{                                              \
> > > +       return 0;                               \
> > > +}
> > > +
> > > +#define LSM_HOOK_void(NAME, ...) \
> > > +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > +
> > 
> > Could unify with:
> > 
> > #define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)
> > {
> >     return (RET)0;
> > }
> > 
> > then you don't need LSM_HOOK_int and LSM_HOOK_void.
> 
> Nice.
> 
> But, given that we are adding default values and that
> they are only needed for int hooks, we will need to keep the macros
> separate for int and void. Or, Am I missing a trick here?
> 
> - KP

Actually, was able to get it work. not setting a default for void
hooks makes the macros messier. So i just set it void. For example:

  LSM_HOOK(void, void, bprm_committing_creds, struct linux_binprm *bprm)

This also allows me to use the cleanup you suggested and not having
to split every usage into int and void.

- KP

> 
> > 
> > > +#include <linux/lsm_hook_names.h>
> > > +#undef LSM_HOOK
> > >
> > >  const struct bpf_prog_ops lsm_prog_ops = {
> > >  };
> > > --
> > > 2.20.1
> > >
