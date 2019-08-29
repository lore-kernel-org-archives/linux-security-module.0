Return-Path: <SRS0=+AtZ=WZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85221C3A5A6
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20822CF5
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfH2RtK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfH2RtK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Aug 2019 13:49:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F9321726;
        Thu, 29 Aug 2019 17:49:08 +0000 (UTC)
Date:   Thu, 29 Aug 2019 13:49:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, capabilities: introduce CAP_BPF
Message-ID: <20190829134906.7ecae4e2@gandalf.local.home>
In-Reply-To: <20190829172309.xd73ax4wgsjmv6zg@ast-mbp.dhcp.thefacebook.com>
References: <20190827205213.456318-1-ast@kernel.org>
        <CALCETrV8iJv9+Ai11_1_r6MapPhhwt9hjxi=6EoixytabTScqg@mail.gmail.com>
        <20190828071421.GK2332@hirez.programming.kicks-ass.net>
        <20190828220826.nlkpp632rsomocve@ast-mbp.dhcp.thefacebook.com>
        <20190829093434.36540972@gandalf.local.home>
        <CALCETrWYu0XB_d-MhXFgopEmBu-pog493G1e+KsE3dS32UULgA@mail.gmail.com>
        <20190829172309.xd73ax4wgsjmv6zg@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 29 Aug 2019 10:23:10 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > CAP_TRACE_KERNEL: Use all of perf, ftrace, kprobe, etc.
> > 
> > CAP_TRACE_USER: Use all of perf with scope limited to user mode and uprobes.  
> 
> imo that makes little sense from security pov, since
> such CAP_TRACE_KERNEL (ex kprobe) can trace "unrelated user process"
> just as well. Yet not letting it do cleanly via uprobe.
> Sort of like giving a spare key for back door of the house and
> saying no, you cannot have main door key.

I took it as CAP_TRACE_KERNEL as a superset of CAP_TRACE_USER. That is,
if you have CAP_TRACE_KERNEL, by default you get USER. Where as
CAP_TRACE_USER, is much more limiting.

-- Steve
