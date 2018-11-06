Return-Path: <SRS0=j9HE=NR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C5C32789
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Nov 2018 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8632083D
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Nov 2018 20:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8632083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeKGG07 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:26:59 -0500
Received: from namei.org ([65.99.196.166]:51520 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbeKGG07 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Nov 2018 01:26:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wA6KxgPJ003720;
        Tue, 6 Nov 2018 20:59:42 GMT
Date:   Wed, 7 Nov 2018 07:59:42 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
In-Reply-To: <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1811070757390.2649@namei.org>
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com> <20181101060737.GA7132@mail.hallyn.com> <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 1 Nov 2018, Micah Morton wrote:

> > Can you give some more details about exactly how you see SafeSetID being
> > used?
> 
> Sure. The main use case for this LSM is to allow a non-root program to
> transition to other untrusted uids without full blown CAP_SETUID
> capabilities. The non-root program would still need CAP_SETUID to do
> any kind of transition, but the additional restrictions imposed by
> this LSM would mean it is a "safer" version of CAP_SETUID since the
> non-root program cannot take advantage of CAP_SETUID to do any
> unapproved actions (i.e. setuid to uid 0 or create/enter new user
> namespace). The higher level goal is to allow for uid-based sandboxing
> of system services without having to give out CAP_SETUID all over the
> place just so that non-root programs can drop to
> even-further-non-privileged uids. This is especially relevant when one
> non-root daemon on the system should be allowed to spawn other
> processes as different uids, but its undesirable to give the daemon a
> basically-root-equivalent CAP_SETUID.

Please include this use-case in the kernel documentation.



- James
-- 
James Morris
<jmorris@namei.org>

