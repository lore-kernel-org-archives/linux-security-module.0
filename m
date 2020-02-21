Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98701C35646
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCBA208C4
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBUQvn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:51:43 -0500
Received: from namei.org ([65.99.196.166]:47390 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBUQvn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 11:51:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LGpOnL014504;
        Fri, 21 Feb 2020 16:51:24 GMT
Date:   Sat, 22 Feb 2020 03:51:24 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jeremy Cline <jcline@redhat.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH] lockdown: Allow unprivileged users to see lockdown
 status
In-Reply-To: <20200220151738.1492852-1-jcline@redhat.com>
Message-ID: <alpine.LRH.2.21.2002220351010.18183@namei.org>
References: <20200220151738.1492852-1-jcline@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 20 Feb 2020, Jeremy Cline wrote:

> A number of userspace tools, such as systemtap, need a way to see the
> current lockdown state so they can gracefully deal with the kernel being
> locked down. The state is already exposed in
> /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> permissions so unprivileged users can read the state.
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Cc: Frank Ch. Eigler <fche@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Looks fine to me, any objection from Matthew or others?

> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5a952617a0eb..87cbdc64d272 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
>  {
>  	struct dentry *dentry;
>  
> -	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> +	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
>  					&lockdown_ops);
>  	return PTR_ERR_OR_ZERO(dentry);
>  }
> 

-- 
James Morris
<jmorris@namei.org>

