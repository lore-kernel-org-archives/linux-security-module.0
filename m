Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D8DC35658
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FAD24650
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgBUQ4f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:56:35 -0500
Received: from namei.org ([65.99.196.166]:47406 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQ4f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 11:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LGu5Us014747;
        Fri, 21 Feb 2020 16:56:05 GMT
Date:   Sat, 22 Feb 2020 03:56:05 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] security: remove duplicated include from
 security.h
In-Reply-To: <20200221074342.16788-1-yuehaibing@huawei.com>
Message-ID: <alpine.LRH.2.21.2002220355530.18183@namei.org>
References: <20200221074342.16788-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 21 Feb 2020, YueHaibing wrote:

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/security.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 910a1ef..fe2c566 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> -#include <linux/fs.h>
>  
>  struct linux_binprm;
>  struct cred;
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

