Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD3C43334
	for <linux-security-module@archiver.kernel.org>; Sun, 10 Jul 2022 14:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGJOPb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 10 Jul 2022 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJOPa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 10 Jul 2022 10:15:30 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDBB841
        for <linux-security-module@vger.kernel.org>; Sun, 10 Jul 2022 07:15:28 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id BC1369CB; Sun, 10 Jul 2022 09:15:26 -0500 (CDT)
Date:   Sun, 10 Jul 2022 09:15:26 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
Message-ID: <20220710141526.GA10287@mail.hallyn.com>
References: <165731248606.335227.15503387932450699761.stgit@olly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165731248606.335227.15503387932450699761.stgit@olly>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 08, 2022 at 04:34:46PM -0400, Paul Moore wrote:
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

Acked-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Paul Moore <paul@paul-moore.com>
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
