Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F79C2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944322467B
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0U6W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:58:22 -0500
Received: from namei.org ([65.99.196.166]:60026 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgA0U6W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 15:58:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 00RKwHEm025870;
        Mon, 27 Jan 2020 20:58:17 GMT
Date:   Tue, 28 Jan 2020 07:58:17 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Alexander Ivanov <amivanov@fastmail.com>
cc:     linux-security-module@vger.kernel.org
Subject: Re: Denying access from sb_umount issue
In-Reply-To: <9e7ccbf8-e640-49b1-8e9c-ffa330b0feef@www.fastmail.com>
Message-ID: <alpine.LRH.2.21.2001280754180.22715@namei.org>
References: <9e7ccbf8-e640-49b1-8e9c-ffa330b0feef@www.fastmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 27 Jan 2020, Alexander Ivanov wrote:

> The lsm module implementes sb_umount() hook to disable lazy umounts. When access is denied, all consecutive umounts fail. It looks like mount reference count is messed up when sb_umount() return -EPERM. Is it possible that umount syscall assumes do_umount() touches those references and it calls 
> 
>  dput(path.dentry);
>  mntput_no_expire(mnt);
> 
> regardless of what do_mount() returns?

You mean do_umount()?

There are several other do_umount() error cases which would have the same 
behavior, right after security_sb_umount().

What error codes are you seeing for the consecutive failures?

-- 
James Morris
<jmorris@namei.org>

