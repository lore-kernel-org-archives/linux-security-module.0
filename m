Return-Path: <SRS0=WgAi=AD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E46EC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1412320732
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 17:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgFVRi3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:38:29 -0400
Received: from namei.org ([65.99.196.166]:39828 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729864AbgFVRi3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 13:38:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05MHcE04020486;
        Mon, 22 Jun 2020 17:38:14 GMT
Date:   Tue, 23 Jun 2020 03:38:14 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Sami Tolvanen <samitolvanen@google.com>
cc:     David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: fix the key_permission LSM hook function
 type
In-Reply-To: <20200615181232.119491-1-samitolvanen@google.com>
Message-ID: <alpine.LRH.2.21.2006230337220.20337@namei.org>
References: <20200615181232.119491-1-samitolvanen@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 15 Jun 2020, Sami Tolvanen wrote:

> Commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than
> a mask") changed the type of the key_permission callback functions, but
> didn't change the type of the hook, which trips indirect call checking with
> Control-Flow Integrity (CFI). This change fixes the issue by changing the
> hook type to match the functions.
> 
> Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.8


NOTE: please cc: the LSM list with patches such as these.



-- 
James Morris
<jmorris@namei.org>

