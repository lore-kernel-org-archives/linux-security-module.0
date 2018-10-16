Return-Path: <SRS0=VoYI=M4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CBC04EBD
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Oct 2018 11:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3962098A
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Oct 2018 11:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3962098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJPTeo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:34:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbeJPTeo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Oct 2018 15:34:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D2CEAEE4;
        Tue, 16 Oct 2018 11:44:06 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:44:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jann Horn <jannh@google.com>
cc:     Casey Schaufler <casey.schaufler@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
In-Reply-To: <CAG48ez1OiAvqqtLXpBjxz-=9X+YdtR9iF7fA_pXhu2GfBt5osw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810161343110.23511@cbobk.fhfr.pm>
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-3-casey.schaufler@intel.com> <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com> <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
 <CAG48ez1+9Bfadu4y4TzPYJfFpLk+N8w7GdCE+xwNCM5TfQ8W8Q@mail.gmail.com> <nycvar.YFH.7.76.1810040942110.14430@cbobk.fhfr.pm> <CAG48ez1OiAvqqtLXpBjxz-=9X+YdtR9iF7fA_pXhu2GfBt5osw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 4 Oct 2018, Jann Horn wrote:

> > Well, we can't really call out into audit from scheduler code, and the
> > previous versions of the patchsets didn't have PTRACE_MODE_SCHED, so it
> > had to be included in PTRACE_MODE_IBPB in order to make sure we're not
> > calling into audit from context switch code.
> >
> > Or did I misunderstand the question?
> 
> If I understand Casey correctly, he is saying that your patch
> (https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm/)
> doesn't include PTRACE_MODE_NOAUDIT for IBPB, but the previous v6 of
> your patch (https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm/)
> did include it, and therefore Casey thinks that there is a specific
> reason why you removed PTRACE_MODE_NOAUDIT, 

Quite honestly, I don't remember. I dont't think there is any deadlock 
that'd be triggered by this.

> and therefore Casey is adding special-case logic for PTRACE_MODE_SCHED 
> to Smack when simply using PTRACE_MODE_NOAUDIT would also work.
> 
> I think that Casey should change ptrace_may_access_sched() to use
> "mode | PTRACE_MODE_SCHED | PTRACE_MODE_NOAUDIT".

Agreed, that should work.

Thanks,

-- 
Jiri Kosina
SUSE Labs

