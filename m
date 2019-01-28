Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0EC282CD
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416121738
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfA1WMx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:12:53 -0500
Received: from namei.org ([65.99.196.166]:48802 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfA1WMw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 17:12:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0SMCggq022003;
        Mon, 28 Jan 2019 22:12:42 GMT
Date:   Tue, 29 Jan 2019 09:12:42 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, keescook@chromium.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: Add 'name' field for SafeSetID in DEFINE_LSM
In-Reply-To: <20190128203056.102178-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901290912340.21032@namei.org>
References: <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com> <20190128203056.102178-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 28 Jan 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> Without this, system boot was crashing with:
> 
> [0.174285] LSM: Security Framework initializing
> [0.175277] BUG: unable to handle kernel NULL pointer dereference
> ...
> [0.176272] Call Trace:
> [0.176272]  ordered_lsm_parse+0x112/0x20b
> [0.176272]  security_init+0x9b/0x3ab
> [0.176272]  start_kernel+0x413/0x479
> [0.176272]  secondary_startup_64+0xa4/0xb0
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

