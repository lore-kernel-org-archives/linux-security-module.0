Return-Path: <SRS0=7rH2=O2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88DFC43444
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Dec 2018 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B9217D9
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Dec 2018 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeLQT25 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:28:57 -0500
Received: from namei.org ([65.99.196.166]:52190 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeLQT25 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Dec 2018 14:28:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBHJSt2U029421;
        Mon, 17 Dec 2018 19:28:55 GMT
Date:   Tue, 18 Dec 2018 06:28:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] linux-integrity patches for Linux 4.21
In-Reply-To: <1544795552.3879.7.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812180627470.29218@namei.org>
References: <1544795552.3879.7.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 14 Dec 2018, Mimi Zohar wrote:

> The following changes since commit 26b76320a8a550472bbb8f42257df83fcb8d8df6:
> 
>   Merge tag 'v4.20-rc2' into next-general (2018-11-12 09:07:41 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> 

Pulled to next-integrity and next-testing.

Also, please ask me to sync to an updated -rc version if you need a patch 
in there, rather than including it yourself.


-- 
James Morris
<jmorris@namei.org>

