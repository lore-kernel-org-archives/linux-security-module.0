Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A36C352A3
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 18:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EE82086A
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyplU89Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgBKSof (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:44:35 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46770 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgBKSoc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 13:44:32 -0500
Received: by mail-oi1-f180.google.com with SMTP id a22so13749493oid.13
        for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2020 10:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF3YzYTi/Ks+MTJab6l7yP1LaB89T8PPJLlG/hEhges=;
        b=EyplU89QVtIzl2H6+9ficfFQTF1vZAYEN53+R6TJ5NCz3uz+jNHjSriM366bGhUzpQ
         Zqu994vE7Ze0ZYuEQN+YncFcuvFWd22BHgpjgI4rzGNAff3PgSsRdZkRd1EU7hAwHhok
         EergH+heTb+5qyBgqhjOajSmFD6w7sQnCRuileRb1hqPKOy7Lj5M89WKOurMpOVx5Kw7
         7JV8hn3fVoJ5dqsp8HNRhPrWJirRS0wVrXcSgpNr8GrMKB52gFh9IV3OzFSOiu7HFQFZ
         zqUltX9NxqOHdAZ7z8iYAtiXoAzWJb24IPffAR9NYGmEI2bAYv4NbV8fVhpJOueAfmws
         Uk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF3YzYTi/Ks+MTJab6l7yP1LaB89T8PPJLlG/hEhges=;
        b=ludViFrLXjuvLpnFeDdLsMqQEpTWuuOS0hugdtWgU6dOA41DFPNxS6Gsbpt4jWhhEf
         r5mERqI5CGVUGBSZA6HDE1vX/RE/F8hbB/ppwWEzHSEzM+YEjrxVsKnO56kLa9x/LbZf
         IaSyulC8rh4FQN1p49kKDmjdpJNRY0KaWFjkWA/pLo3gpKY7T4x5qOj1u8JixY4qpmWu
         fg1Xpjb1Klyl2Fg7mip6zq9BDGFHll9CVUd5rg09i+RJ8BO7/Wi5wcdFKzivdChmmILl
         u+TS8E1BQD0OCeTKbQhb5/pvfPu7+s/gl15ec1BKunm8LwKgB6acaX+vPMTpxuxMeyUu
         cwPg==
X-Gm-Message-State: APjAAAX44EdIPb16cG89HyMRUpSJChBaLQEs1LHIlqHUq8j4Rj2vhZAf
        +BHwJtRsHEcWesfJU8IQbwgNUQKkbXFFdxfq+SxNeg==
X-Google-Smtp-Source: APXvYqxHhXtlnOfOnI+BNvZnfjjqdMwYbXF59ItzBGD1eUVpXRkHk2uJzd3UrlTykBUbQaQX8quldC+S030QTR/sgO0=
X-Received: by 2002:aca:b187:: with SMTP id a129mr3807804oif.175.1581446671435;
 Tue, 11 Feb 2020 10:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com> <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
In-Reply-To: <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 19:44:05 +0100
Message-ID: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
Subject: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
[...]
> > * When using the semantic provided by fexit, the BPF LSM program will
> >   always be executed and will be able to override / clobber the
> >   decision of LSMs which appear before it in the ordered list. This
> >   semantic is very different from what we currently have (i.e. the BPF
> >   LSM hook is only called if all the other LSMs allow the action) and
> >   seems to be bypassing the LSM framework.
>
> It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> trampoline generator specific to lsm progs.
[...]
> Using fexit mechanism and bpf_sk_storage generalization is
> all that is needed. None of it should touch security/*.

If I understand your suggestion correctly, that seems like a terrible
idea to me from the perspective of inspectability and debuggability.
If at runtime, a function can branch off elsewhere to modify its
decision, I want to see that in the source code. If someone e.g.
changes the parameters or the locking rules around a security hook,
how are they supposed to understand the implications if that happens
through some magic fexit trampoline that is injected at runtime?
