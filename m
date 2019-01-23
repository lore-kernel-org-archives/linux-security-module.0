Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EBC282C0
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 19:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5EE21855
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfAWTiP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:38:15 -0500
Received: from namei.org ([65.99.196.166]:48108 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAWTiO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 14:38:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0NJcB3J030375;
        Wed, 23 Jan 2019 19:38:11 GMT
Date:   Thu, 24 Jan 2019 06:38:11 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] tomoyo: Swicth from cred->security to
 task_struct->security.
In-Reply-To: <1547907100-10438-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1901240637430.28095@namei.org>
References: <1547822987-9401-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <1547907100-10438-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 19 Jan 2019, Tetsuo Handa wrote:

> TOMOYO security module is designed to use "struct task_struct"->security
> in order to allow per "struct task_struct" tracking without being disturbed
> by unable to update "struct cred"->security due to override mechanism.
> 
> Now that infrastructure-managed security blob is ready, this patch updates
> TOMOYO to use "struct task_struct"->security.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

