Return-Path: <SRS0=6rCu=4A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E5FC352A4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E9E21569
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GANCPNe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBLQEd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:04:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgBLQEd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 11:04:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so3019596wrd.9
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KiqSA/av2ZNWBE7nJHGVa6/1LBWU3I7cZAwdWxWzGmE=;
        b=GANCPNe9XjsbmeyJHI+SqNuFhFhrU5no91yuB/KbQIxyRrRL2oqnecs84I6PI/QFGs
         0tOu2a8IbgyAQNajlvF4iGbdZkTzztqH1wn352I4W+zIv3zTlm73NfMid12H8TlJlTz/
         q4VKWsBQ4W3eQD87vL2C3NiCwHrFZGuhegr5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KiqSA/av2ZNWBE7nJHGVa6/1LBWU3I7cZAwdWxWzGmE=;
        b=F1Z62akyaxm00uOFR3Qfb18CGoSvwv/DuE87UQ0LH7EEXNI1zkeIOK5/HbUGpqiCyp
         fITsY7/IzRM4KAvqUret0FMXykWlJpzWXbZnwV+DS/qzhUnJ8r9RFYsAusqVM6mpDQ65
         IDySa6idfY7tYZb6AgYEpXJtgnwziPoJGeZ3ryHOH04sC4f2xFuVJNAG9c003CU5pWnU
         I3xL8lhEFHmBaudZIpizFEGJXcxOV5Gka9nnk1Ng7VbC8kqKnCDnxi2uZ5E1IvcVhAlV
         bf9ZuPIFSPx9o4bxzPdUqpFQLzL66IpwVJEKPT8WQvpiF2LhYOPkgTPRKO3Qiv+Qf62y
         TUgA==
X-Gm-Message-State: APjAAAWEKvCHxXEZyK14Cvp67twxQ6jm4QorDBXCh2gq/Do/ULfGjirI
        66hcM3prjIxeo4DezPNY7qeMBw==
X-Google-Smtp-Source: APXvYqwiFlaR/PcLMnFrEko6dVuZAo41bD1fmgeH/VsTsTT+BFsSRrriqlqG425HJ7hspZN+2aM0cQ==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr16010468wrt.343.1581523470287;
        Wed, 12 Feb 2020 08:04:30 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id b21sm1346559wmd.37.2020.02.12.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:04:29 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 12 Feb 2020 17:04:27 +0100
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jann Horn <jannh@google.com>, KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200212160427.GA259057@google.com>
References: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
 <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
 <20200212024542.gdsafhvqykucdp4h@ast-mbp>
 <ff6dec98-5e33-4603-1b90-e4bff23695cc@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6dec98-5e33-4603-1b90-e4bff23695cc@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12-Feb 14:27, Daniel Borkmann wrote:
> On 2/12/20 3:45 AM, Alexei Starovoitov wrote:
> > On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
> > > 
> > > Another approach could be to have a special nop inside call_int_hook()
> > > macro which would then get patched to avoid these situations. Somewhat
> > > similar like static keys where it could be defined anywhere in text but
> > > with updating of call_int_hook()'s RC for the verdict.
> > 
> > Sounds nice in theory. I couldn't quite picture how that would look
> > in the code, so I hacked:
> > diff --git a/security/security.c b/security/security.c
> > index 565bc9b67276..ce4bc1e5e26c 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/string.h>
> >   #include <linux/msg.h>
> >   #include <net/flow.h>
> > +#include <linux/jump_label.h>
> > 
> >   #define MAX_LSM_EVM_XATTR      2
> > 
> > @@ -678,12 +679,26 @@ static void __init lsm_early_task(struct task_struct *task)
> >    *     This is a hook that returns a value.
> >    */
> > 
> > +#define LSM_HOOK_NAME(FUNC) \
> > +       DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##FUNC);
> > +#include <linux/lsm_hook_names.h>
> > +#undef LSM_HOOK_NAME
> > +__diag_push();
> > +__diag_ignore(GCC, 8, "-Wstrict-prototypes", "");
> > +#define LSM_HOOK_NAME(FUNC) \
> > +       int bpf_lsm_call_##FUNC() {return 0;}
> > +#include <linux/lsm_hook_names.h>
> > +#undef LSM_HOOK_NAME
> > +__diag_pop();
> > +
> >   #define call_void_hook(FUNC, ...)                              \
> >          do {                                                    \
> >                  struct security_hook_list *P;                   \
> >                                                                  \
> >                  hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> >                          P->hook.FUNC(__VA_ARGS__);              \
> > +               if (static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> > +                      (void)bpf_lsm_call_##FUNC(__VA_ARGS__); \
> >          } while (0)
> > 
> >   #define call_int_hook(FUNC, IRC, ...) ({                       \
> > @@ -696,6 +711,8 @@ static void __init lsm_early_task(struct task_struct *task)
> >                          if (RC != 0)                            \
> >                                  break;                          \
> >                  }                                               \
> > +               if (RC == IRC && static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> > +                      RC = bpf_lsm_call_##FUNC(__VA_ARGS__); \
> 
> Nit: the `RC == IRC` test could be moved behind the static_branch_unlikely() so
> that it would be bypassed when not enabled.
> 
> >          } while (0);                                            \
> >          RC;                                                     \
> >   })
> > 
> > The assembly looks good from correctness and performance points.
> > union security_list_options can be split into lsm_hook_names.h too
> > to avoid __diag_ignore. Is that what you have in mind?
> > I don't see how one can improve call_int_hook() macro without
> > full refactoring of linux/lsm_hooks.h
> > imo static_key doesn't have to be there in the first set. We can add this
> > optimization later.
> 
> Yes, like the above diff looks good, and then we'd dynamically attach the program
> at bpf_lsm_call_##FUNC()'s fexit hook for a direct jump, so all the security_blah()
> internals could stay as-is which then might also address Jann's concerns wrt
> concrete annotation as well as potential locking changes inside security_blah().
> Agree that patching out via static key could be optional but since you were talking
> about avoiding indirect jumps..

I like this approach as well. Will give it a go and update the
patches. Thanks a lot for your inputs!

- KP

> 
> Thanks,
> Daniel
