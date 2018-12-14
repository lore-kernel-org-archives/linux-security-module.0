Return-Path: <SRS0=mair=OX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F702C67839
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Dec 2018 03:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341B2075B
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Dec 2018 03:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9341B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLNDdG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:33:06 -0500
Received: from namei.org ([65.99.196.166]:51790 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeLNDdG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 22:33:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBE3WvGi013468;
        Fri, 14 Dec 2018 03:32:57 GMT
Date:   Fri, 14 Dec 2018 14:32:57 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     LSM <linux-security-module@vger.kernel.org>,
        =?ISO-8859-15?Q?Jos=E9_Bollo?= <jobol@nonadev.net>,
        Zoran Markovic <zmarkovic@sierrawireless.com>
Subject: Re: [PULL] Smack: Changes for 4.21
In-Reply-To: <8f3fc078-e6ba-afc5-be96-444117ac9d7f@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1812141432370.13348@namei.org>
References: <8f3fc078-e6ba-afc5-be96-444117ac9d7f@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 13 Dec 2018, Casey Schaufler wrote:

> James, I have two Smack patches for 4.21. One Jose's patch adds
> missing documentation and Zoran's fleshes out the access checks
> on keyrings.
> 
> The following changes since commit 26b76320a8a550472bbb8f42257df83fcb8d8df6:
> 
>   Merge tag 'v4.20-rc2' into next-general (2018-11-12 09:07:41 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/cschaufler/next-smack smack-for-4.21-a

Pulled to next-smack and next-testing.


-- 
James Morris
<jmorris@namei.org>

