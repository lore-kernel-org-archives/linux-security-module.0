Return-Path: <SRS0=l2r+=TA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0644C43219
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B75F20835
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfD3QI1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:08:27 -0400
Received: from namei.org ([65.99.196.166]:36630 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3QI1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 12:08:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3UG8LKJ028694;
        Tue, 30 Apr 2019 16:08:21 GMT
Date:   Wed, 1 May 2019 02:08:21 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PULL] Smack: one more change for 5.2
In-Reply-To: <alpine.LRH.2.21.1905010207400.32268@namei.org>
Message-ID: <alpine.LRH.2.21.1905010208030.32268@namei.org>
References: <a0fd7fe4-d86f-798e-df66-c4390bc38567@schaufler-ca.com> <alpine.LRH.2.21.1905010207400.32268@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 1 May 2019, James Morris wrote:

> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

That should be next-smack.

-- 
James Morris
<jmorris@namei.org>

