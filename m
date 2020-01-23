Return-Path: <SRS0=QZUe=3M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F6C35240
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91D2087E
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAWXoj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:44:39 -0500
Received: from namei.org ([65.99.196.166]:59502 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgAWXoj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jan 2020 18:44:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 00NNiJVP013876;
        Thu, 23 Jan 2020 23:44:19 GMT
Date:   Fri, 24 Jan 2020 10:44:19 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Matthew Garrett <matthewgarrett@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: remove EARLY_LSM_COUNT which never used
In-Reply-To: <1579596603-258380-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LRH.2.21.2001241043540.12618@namei.org>
References: <1579596603-258380-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 21 Jan 2020, Alex Shi wrote:

> This macro is never used from it was introduced in commit e6b1db98cf4d5
> ("security: Support early LSMs"), better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Thanks, applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

