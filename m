Return-Path: <SRS0=sdO6=QG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD2C282D7
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526CB218AC
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 20:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfA3UbF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:31:05 -0500
Received: from namei.org ([65.99.196.166]:49278 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfA3UbF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 15:31:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0UKUwCg015458;
        Wed, 30 Jan 2019 20:30:58 GMT
Date:   Thu, 31 Jan 2019 07:30:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     kbuild-all@01.org, linux-security-module@vger.kernel.org,
        james.morris@microsoft.com
Subject: Re: [PATCH] LSM: SafeSetID: remove unused include
In-Reply-To: <20190130155643.167055-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901310730520.10106@namei.org>
References: <201901300828.TveZbnBP%fengguang.wu@intel.com> <20190130155643.167055-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 30 Jan 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> The include for asm/syscall.h was needed in a prior version of lsm.c
> that checked return values of syscall_get_nr, but since we did away with
> that part of the code this include is no longer necessary. Take out this
> include since it breaks builds for certain architectures. We no longer
> have any arch-specific code in SafeSetID.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


> ---
>  security/safesetid/lsm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 282a242beb86..cecd38e2ac80 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -14,7 +14,6 @@
>  
>  #define pr_fmt(fmt) "SafeSetID: " fmt
>  
> -#include <asm/syscall.h>
>  #include <linux/hashtable.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/module.h>
> 

-- 
James Morris
<jmorris@namei.org>

