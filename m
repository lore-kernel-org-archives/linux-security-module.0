Return-Path: <SRS0=m40R=BG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D2C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693C62075A
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 18:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgG0So3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:44:29 -0400
Received: from namei.org ([65.99.196.166]:55654 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgG0So2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 14:44:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06RIiID6022465;
        Mon, 27 Jul 2020 18:44:18 GMT
Date:   Tue, 28 Jul 2020 04:44:18 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module@vger.kernel.org, keescook@chromium.org,
        casey@schaufler-ca.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, serge@hallyn.com,
        Thomas Cedeno <thomascedeno@google.com>
Subject: Re: [PATCH 1/2] LSM: Signal to SafeSetID when in set*gid syscall
In-Reply-To: <20200720181156.1461461-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.2007280444060.18670@namei.org>
References: <20200720181156.1461461-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 20 Jul 2020, Micah Morton wrote:

> From: Thomas Cedeno <thomascedeno@google.com>
> 
> For SafeSetID to properly gate set*gid() calls, it needs to know whether
> ns_capable() is being called from within a sys_set*gid() function or is
> being called from elsewhere in the kernel. This allows SafeSetID to deny
> CAP_SETGID to restricted groups when they are attempting to use the
> capability for code paths other than updating GIDs (e.g. setting up
> userns GID mappings). This is the identical approach to what is
> currently done for CAP_SETUID.
> 
> Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

