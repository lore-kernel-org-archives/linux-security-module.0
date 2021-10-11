Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BACC433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CA3606A5
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhJKOnI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244249AbhJKOmV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Oct 2021 10:42:21 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E60C06178C
        for <linux-security-module@vger.kernel.org>; Mon, 11 Oct 2021 07:38:06 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HShH02CrVzMqPZx;
        Mon, 11 Oct 2021 16:38:04 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HShGz6PxXzlhP4w;
        Mon, 11 Oct 2021 16:38:03 +0200 (CEST)
Subject: Re: [PATCH] security/landlock: use square brackets around
 "landlock-ruleset"
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-security-module@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20211011133704.1704369-1-brauner@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
Date:   Mon, 11 Oct 2021 16:38:55 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20211011133704.1704369-1-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 11/10/2021 15:37, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Make the name of the anon inode fd "[landlock-ruleset]" instead of
> "landlock-ruleset". This is minor but most anon inode fds already
> carry square brackets around their name:
> 
>     [eventfd]
>     [eventpoll]
>     [fanotify]
>     [fscontext]
>     [io_uring]
>     [pidfd]
>     [signalfd]
>     [timerfd]
>     [userfaultfd]
> 
> For the sake of consistency lets do the same for the landlock-ruleset anon
> inode fd that comes with landlock. We did the same in
> 1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext" [ver #2]")
> for the new mount api.

Before creating "landlock-ruleset" FD, I looked at other anonymous FD
and saw this kind of inconsistency. I don't get why we need to add extra
characters to names, those brackets seem useless. If it should be part
of the interface, why is it not enforced by anon_inode_getfd()?

There is a lot of other names that come without brackets (e.g. inotify,
bpf-*, btf, kvm-*, iio*). Do you plan to send patches for those too?
Changing such FD names could break user space because they may already
be exposed and used (e.g. through SELinux).
