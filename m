Return-Path: <SRS0=rme9=2Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2403FC32767
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Jan 2020 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05372464B
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Jan 2020 00:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PHUCh4j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgADAJo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:09:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40388 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAJo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Jan 2020 19:09:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so9959943wmi.5
        for <linux-security-module@vger.kernel.org>; Fri, 03 Jan 2020 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mZInC9bs1GJK5S1VRMG9W+fYRlRD1KYZ+adhd929at4=;
        b=PHUCh4j9bv3MKh2xfjtcFmyZPOA3I2o+KBPzt0Jx1fHilzZND1yoG4A7yvL+xajEHS
         DKPU9P0CLYeuuqAMZhY8alWdplYKY0hPPq3fK4bntBjH8LZ5twRVgtrsumRyr28J4YKG
         +XjFsHxPW1qK1FtBgxtXqNzMmzCao0EZQXNKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZInC9bs1GJK5S1VRMG9W+fYRlRD1KYZ+adhd929at4=;
        b=lHQyAMYQqcwynmjzDk94gNeZk17Dbj6Tavgtdo3tnkc1kRfcCZ7ujlLPPKVhxZ2p6S
         czpajugVgJgnFF2xPZqTPUApYvMXBO1q6BZw3aGeM6JRBIBAQzVncy61LGHK9jrhiE/9
         moJIC57gLrn+uNeONJFaNRrTlGDCYjzSpACeIDr+CnlygpWTcPkO+X21fqggSVMWFb/Z
         rWZtn0ygeNxnGlWID5YJ7/03zcBuX5uBli/DtkioTqulDGLLQ/SI77YqTVfai48RbPBa
         4C+3IVem0BB+4l5nwquhkcdtScjchPqJahktTvNaf+1cdIBD/q1sBWC134L9yi5JEwD4
         EecA==
X-Gm-Message-State: APjAAAUf6Yk7MF28r3/tfZDVCTl0UZ1UwNGlQpQoIP5jEdz20iN/g9F8
        Qsy4pG/QX6AlB9cBPq3YgQoImw==
X-Google-Smtp-Source: APXvYqwMmCiD0+WJwcnZm25fm/1OAl56Bg4Nr1noDCgQyldoAVRlb8EgCcoHwGIqndJRh6n+BeoO4g==
X-Received: by 2002:a05:600c:2c7:: with SMTP id 7mr21039287wmn.87.1578096581662;
        Fri, 03 Jan 2020 16:09:41 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a1sm14047106wmj.40.2020.01.03.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:09:40 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 4 Jan 2020 01:09:55 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 12/13] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200104000955.GB23487@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-13-kpsingh@chromium.org>
 <CAEf4BzY4K-vgSFPjV=pn3quc5DT1+eGkJnZfSw4+b0fERzPVfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY4K-vgSFPjV=pn3quc5DT1+eGkJnZfSw4+b0fERzPVfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-Dez 22:49, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Load a BPF program that audits mprotect calls
> > * Attach the program to the "file_mprotect" LSM hook
> > * Verify if the program is actually loading by reading
> >   securityfs
> > * Initialize the perf events buffer and poll for audit events
> > * Do an mprotect on some memory allocated on the heap
> > * Verify if the audit event was received
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  MAINTAINERS                                   |   2 +
> >  .../bpf/prog_tests/lsm_mprotect_audit.c       | 129 ++++++++++++++++++
> >  .../selftests/bpf/progs/lsm_mprotect_audit.c  |  58 ++++++++
> >  3 files changed, 189 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
> >
> 
> [...]
> 
> > +/*
> > + * Define some of the structs used in the BPF program.
> > + * Only the field names and their sizes need to be the
> > + * same as the kernel type, the order is irrelevant.
> > + */
> > +struct mm_struct {
> > +       unsigned long start_brk, brk, start_stack;
> > +};
> > +
> > +struct vm_area_struct {
> > +       unsigned long start_brk, brk, start_stack;
> > +       unsigned long vm_start, vm_end;
> > +       struct mm_struct *vm_mm;
> > +       unsigned long vm_flags;
> > +};
> > +
> > +BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> > +           struct vm_area_struct *, vma,
> > +           unsigned long, reqprot, unsigned long, prot)
> > +{
> > +       struct mprotect_audit_log audit_log = {};
> > +       int is_heap = 0;
> > +
> > +       __builtin_preserve_access_index(({
> 
> you don't need __builtin_preserve_access_index, if you mark
> vm_area_struct and mm_struct with
> __attribute__((preserve_access_index)

Cool, updated!

> 
> > +               is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > +                                    vma->vm_end <= vma->vm_mm->brk);
> > +       }));
> > +
> > +       audit_log.magic = MPROTECT_AUDIT_MAGIC;
> > +       audit_log.is_heap = is_heap;
> > +       bpf_lsm_event_output(&perf_buf_map, BPF_F_CURRENT_CPU, &audit_log,
> > +                            sizeof(audit_log));
> 
> You test would be much simpler if you use global variables to pass
> data back to userspace, instead of using perf buffer.
> 
> Also please see fentry_fexit.c test for example of using BPF skeleton
> to shorten and simpify userspace part of test.

Thanks for the skeleton work!

This makes using global variables easier and the tests are indeed much
simpler, I have updated it for the next revision.

One follow up question regarding global variables, let's say I have
the following global variable defined in the BPF program:

struct result_info {
        __u32 count;
}; 

struct result_info result = {
        .count = 0,
};

The defintion of result_info needs to be included before the .skel.h
as it's not automatically generated or maybe I am missing a
trick here?

For now, I have defined this in a header which gets included both in
the program and the test.

- KP

> 
> > +       return 0;
> > +}
> > --
> > 2.20.1
> >
