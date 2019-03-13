Return-Path: <SRS0=LsZi=RQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1BC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84FD2075C
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCMUAd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:00:33 -0400
Received: from namei.org ([65.99.196.166]:56954 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfCMUAd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Mar 2019 16:00:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2DK0Do1023082;
        Wed, 13 Mar 2019 20:00:13 GMT
Date:   Thu, 14 Mar 2019 07:00:13 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Edwin Zimmerman <edwin@211mainstreet.net>
cc:     "'Tetsuo Handa'" <penguin-kernel@i-love.sakura.ne.jp>,
        "'Stephen Smalley'" <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: RE: [PATCH] tomoyo: Add a kernel config option for fuzzing
 testing.
In-Reply-To: <000001d4d91e$68837940$398a6bc0$@211mainstreet.net>
Message-ID: <alpine.LRH.2.21.1903140657440.22528@namei.org>
References: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp> <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov> <201903042359.x24NxJwx065719@www262.sakura.ne.jp> <alpine.LRH.2.21.1903051431540.20560@namei.org> <72b3b8e1-fc34-f312-de12-cf42992bceb8@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1903130418580.24386@namei.org> <770d8413-bd57-c379-21a0-acbbdf82241e@i-love.sakura.ne.jp> <000001d4d91e$68837940$398a6bc0$@211mainstreet.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 12 Mar 2019, Edwin Zimmerman wrote:

> On March 12, 2019 5:15, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote
> > >> Yes. As long as upstream can't accept all LSM modules, and some people cannot afford
> > >> utilizing upstream LSM modules, LKM-based LSMs will be needed by such people.
> > >
> > > What do you mean cannot afford ?
> > >
> > 
> > Some people have to set SELINUX=disabled in /etc/selinux/config or pass security=none from
> > the kernel command line.
> 
> If you specifically don't want in-kernel LSMs, and you specifically do want an out-of-tree LSM,
> there are other options. For example, you could just livepatch the security_* hooks you need, 
> since you already would using an LKM-based LSM.  That would give you your
> out-of-tree module and would also disable selinux on the hooks that got livepatched.
> 

Ahh, ok, this is about out of tree LSMs.

This has been discussed many times over the years and the answer is always 
the same: we will not add infrastructure to the kernel to support out of 
tree code.  This is a long-standing tenet of the Linux kernel.



-- 
James Morris
<jmorris@namei.org>

