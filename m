Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732EC282C3
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E83720866
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 22:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfAVWl3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:41:29 -0500
Received: from namei.org ([65.99.196.166]:47930 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfAVWl2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 17:41:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0MMfJXE021331;
        Tue, 22 Jan 2019 22:41:19 GMT
Date:   Wed, 23 Jan 2019 09:41:19 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: Adjust offset when accessing task blob.
In-Reply-To: <201901210125.x0L1PAwO046352@www262.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1901230941090.20393@namei.org>
References: <201901210125.x0L1PAwO046352@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 21 Jan 2019, Tetsuo Handa wrote:

> AppArmor will no longer be the only user of task blob
> after TOMOYO started using task blob.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

