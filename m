Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2DC433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jul 2022 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiGHVTL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiGHVTK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jul 2022 17:19:10 -0400
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE505C9D0
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jul 2022 14:19:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 6B1AF197;
        Fri,  8 Jul 2022 21:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 6B1AF197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1657314026; bh=suzpY7Zig2TvjbgCxOSj0C8bJ24M8lH+Ouzqa9qMIHc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=N2xt+Lyj6mButhrhxRBUDSUbUVSNWI38N8tUWfbQPwaxyJUACk9m9+uQt49ij+XZp
         4AiK7TbMmSzvtG13R/x1cLNa4OdG1TO8QVHo2u45q0oM5X101WOqXMtCWEvqGxv0Y0
         6/gtz9UvhteEP3023ExDMC5PdONk1h6IVb92rOJ8=
Date:   Sat, 9 Jul 2022 07:00:26 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
In-Reply-To: <165731248606.335227.15503387932450699761.stgit@olly>
Message-ID: <4c33604f-25ee-c1e7-4a4c-afe95b3dba15@namei.org>
References: <165731248606.335227.15503387932450699761.stgit@olly>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 8 Jul 2022, Paul Moore wrote:

> After many years of shepherding the LSM layer, and Linux kernel
> access control in general, James has decided to take a small step
> away from his technical role and has asked me to assume the
> day-to-day maintenance tasks for the LSM.  This patch makes the
> necessary updates to the MAINTAINERS file.
> 
> Thanks for all you patience and stewardship over the years James,
> I promise to do my best not to screw it all up :)
> 
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..5c7c5d04b99d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17909,12 +17909,13 @@ S:	Supported
>  F:	Documentation/admin-guide/security-bugs.rst
>  
>  SECURITY SUBSYSTEM
> +M:	Paul Moore <paul@paul-moore.com>
>  M:	James Morris <jmorris@namei.org>
>  M:	"Serge E. Hallyn" <serge@hallyn.com>
>  L:	linux-security-module@vger.kernel.org (suggested Cc:)
>  S:	Supported
>  W:	http://kernsec.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	security/
>  X:	security/selinux/
>  
> 

-- 
James Morris
<jmorris@namei.org>

