Return-Path: <SRS0=8Njt=PS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41948C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 22:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199B0213F2
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfAJWbh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:31:37 -0500
Received: from namei.org ([65.99.196.166]:55436 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfAJWbh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jan 2019 17:31:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0AMVIJk013670;
        Thu, 10 Jan 2019 22:31:18 GMT
Date:   Fri, 11 Jan 2019 09:31:18 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, keescook@chromium.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4] LSM: generalize flag passing to security_capable
In-Reply-To: <20190108001053.235201-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901110930470.13638@namei.org>
References: <CAGXu5jKoNQJ1FNVisxr6VHD9DuUFL2eLV5pD5orHe__sDGr5MA@mail.gmail.com> <20190108001053.235201-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 7 Jan 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> This patch provides a general mechanism for passing flags to the
> security_capable LSM hook. It replaces the specific 'audit' flag that is
> used to tell security_capable whether it should log an audit message for
> the given capability check. The reason for generalizing this flag
> passing is so we can add an additional flag that signifies whether
> security_capable is being called by a setid syscall (which is needed by
> the proposed SafeSetID LSM).
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing

-- 
James Morris
<jmorris@namei.org>

