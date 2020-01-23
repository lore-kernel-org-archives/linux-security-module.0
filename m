Return-Path: <SRS0=QZUe=3M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C061BC2D0DB
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB44214AF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAWRiU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:38:20 -0500
Received: from mail.hallyn.com ([178.63.66.53]:36766 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWRiU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jan 2020 12:38:20 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 55A15F8F; Thu, 23 Jan 2020 11:38:18 -0600 (CST)
Date:   Thu, 23 Jan 2020 11:38:18 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: remove EARLY_LSM_COUNT which never used
Message-ID: <20200123173818.GA26551@mail.hallyn.com>
References: <1579596603-258380-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579596603-258380-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 21, 2020 at 04:50:03PM +0800, Alex Shi wrote:
> This macro is never used from it was introduced in commit e6b1db98cf4d5
> ("security: Support early LSMs"), better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Matthew Garrett <matthewgarrett@google.com>
> Cc: James Morris <jmorris@namei.org> 
> Cc: "Serge E. Hallyn" <serge@hallyn.com> 

Acked-by: Serge Hallyn <serge@hallyn.com>

Does indeed seem unused.

> Cc: linux-security-module@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  security/security.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index cd2d18d2d279..b9771de83cf7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -33,7 +33,6 @@
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> -#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> -- 
> 1.8.3.1
