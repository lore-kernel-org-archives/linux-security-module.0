Return-Path: <SRS0=EupR=RE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D57C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 22:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F7E20684
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 22:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfCAW2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:28:55 -0500
Received: from mail.hallyn.com ([178.63.66.53]:49868 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfCAW2z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Mar 2019 17:28:55 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D689AB38; Fri,  1 Mar 2019 16:28:53 -0600 (CST)
Date:   Fri, 1 Mar 2019 16:28:53 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
Message-ID: <20190301222853.GA17210@mail.hallyn.com>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 01, 2019 at 11:30:26AM +0000, Ben Dooks wrote:
> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/keys/keyctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 7bbe03593e58..3e4053a217c3 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1752,7 +1752,7 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		return keyctl_pkey_query((key_serial_t)arg2,
>  					 (const char __user *)arg4,
> -					 (struct keyctl_pkey_query *)arg5);
> +					 (struct keyctl_pkey_query __user *)arg5);
>  
>  	case KEYCTL_PKEY_ENCRYPT:
>  	case KEYCTL_PKEY_DECRYPT:
> -- 
> 2.20.1
