Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C5EC10F0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 00:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7FB2075B
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDPAdq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:33:46 -0400
Received: from namei.org ([65.99.196.166]:33766 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfDPAdq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Apr 2019 20:33:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3G0XgGd008233;
        Tue, 16 Apr 2019 00:33:42 GMT
Date:   Tue, 16 Apr 2019 10:33:42 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list <linux-security-module@vger.kernel.org>
Subject: Re: [PULL] Smack: Changes for 5.2
In-Reply-To: <9a7f3da5-a80c-0fa6-c66d-70a1ef61af6f@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1904161033280.7992@namei.org>
References: <9a7f3da5-a80c-0fa6-c66d-70a1ef61af6f@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 15 Apr 2019, Casey Schaufler wrote:

> James, please take these updates for 5.2. There's one bug fix for
> IPv6 handling and two memory use improvements.
> 
> The following changes since commit 9d7b7bfbafba5e6cad609f1188243a7f0cd0d293:
> 
>   Merge tag 'v5.1-rc2' into next-general (2019-03-26 16:28:01 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/cschaufler/next-smack smack-for-5.2
> 
> for you to fetch changes up to f7450bc6e76860564f3842a41892f9b74313cc23:
> 
>   Smack: Fix IPv6 handling of 0 secmark (2019-04-03 14:28:38 -0700)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack


-- 
James Morris
<jmorris@namei.org>

