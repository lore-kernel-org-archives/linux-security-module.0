Return-Path: <SRS0=Td4Z=WY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE7C3A5A6
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Aug 2019 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ABC22CBB
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Aug 2019 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1CWj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1CWj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Aug 2019 22:22:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A62D214DA;
        Wed, 28 Aug 2019 02:22:37 +0000 (UTC)
Date:   Tue, 27 Aug 2019 22:22:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, capabilities: introduce CAP_BPF
Message-ID: <20190827222236.297855a1@oasis.local.home>
In-Reply-To: <A95DA1BC-E2A1-4CC3-B17F-36C494FB7540@amacapital.net>
References: <20190827205213.456318-1-ast@kernel.org>
        <CALCETrV8iJv9+Ai11_1_r6MapPhhwt9hjxi=6EoixytabTScqg@mail.gmail.com>
        <20190827192144.3b38b25a@gandalf.local.home>
        <CALCETrUOHRMkBRJi_s30CjZdOLDGtdMOEgqfgPf+q0x+Fw7LtQ@mail.gmail.com>
        <20190827204433.3af91faf@gandalf.local.home>
        <A95DA1BC-E2A1-4CC3-B17F-36C494FB7540@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 27 Aug 2019 18:12:59 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> Too many slashes :/
> 
> A group could work for v1.  Maybe all the tools should get updated to use this path?

trace-cmd now does. In fact, if run as root, it will first check if
tracefs is mounted, and if not, it will try to mount it at this
location.

-- Steve
