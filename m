Return-Path: <SRS0=9GoG=7D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B8C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 02:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FE520709
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 02:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgEUCC2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 22:02:28 -0400
Received: from namei.org ([65.99.196.166]:38560 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgEUCC2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 22:02:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04L2288V031690;
        Thu, 21 May 2020 02:02:08 GMT
Date:   Thu, 21 May 2020 12:02:08 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
In-Reply-To: <CAADnVQL_j3vGMTiQTfKWOZKhhuZxAQBQpU6W-BBeO+biTXrzSQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2005211201410.2368@namei.org>
References: <20200520125616.193765-1-kpsingh@chromium.org> <5f540fb8-93ec-aa6b-eb30-b3907f5791ff@schaufler-ca.com> <CAADnVQL_j3vGMTiQTfKWOZKhhuZxAQBQpU6W-BBeO+biTXrzSQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 20 May 2020, Alexei Starovoitov wrote:

> On Wed, May 20, 2020 at 8:15 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >
> > On 5/20/2020 5:56 AM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > > hook by default, the call_int_hook logic is not suitable which
> > > "bails-on-fail" and casues issues when other LSMs register this hook and
> > > eventually breaks Audit.
> > >
> > > In order to fix this, directly iterate over the security hooks instead
> > > of using call_int_hook as suggested in:
> > >
> > > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> > >
> > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> >
> > This looks fine.
> 
> Tested. audit works now.
> I fixed missing ')' in the commit log
> and applied to bpf tree.
> It will be on the way to Linus tree soon.

Please add:


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

