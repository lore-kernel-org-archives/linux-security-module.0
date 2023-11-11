Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E650C4167B
	for <linux-security-module@archiver.kernel.org>; Sat, 11 Nov 2023 13:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjKKNYk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 11 Nov 2023 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNYj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 Nov 2023 08:24:39 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E07CE30C2;
        Sat, 11 Nov 2023 05:24:36 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3ABDOVvp003734;
        Sat, 11 Nov 2023 14:24:31 +0100
Date:   Sat, 11 Nov 2023 14:24:31 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] exitz syscall
Message-ID: <20231111132431.GA3717@1wt.eu>
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111125126.11665-1-yjnworkstation@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

On Sat, Nov 11, 2023 at 01:51:26PM +0100, York Jasper Niebuhr wrote:
> Adds a system call to flag a process' resources to be cleared on
> exit (or, in the case of memory, on free). Currently, only zeroing
> memory is implemented.
(...)

IMHO it does not make sense to add a syscall for this, please have a
look at prctl(2) instead, which is already used for similar settings.

Regards,
Willy
