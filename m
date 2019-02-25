Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7CDC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 23:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8715C20C01
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfBYXRU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:17:20 -0500
Received: from namei.org ([65.99.196.166]:54188 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbfBYXRU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1PNH3pu019472;
        Mon, 25 Feb 2019 23:17:03 GMT
Date:   Tue, 26 Feb 2019 10:17:03 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     serge@hallyn.com, keescook@chromium.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: Update function documentation for cap_capable
In-Reply-To: <20190225221710.226552-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1902261016560.19242@namei.org>
References: <20190225221710.226552-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 25 Feb 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> This should have gone in with commit
> c1a85a00ea66cb6f0bd0f14e47c28c2b0999799f.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Thanks!

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

> ---
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 188eaf59f82f..f1d117c3d8ae 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -57,7 +57,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>   * @cred: The credentials to use
>   * @ns:  The user namespace in which we need the capability
>   * @cap: The capability to check for
> - * @audit: Whether to write an audit message or not
> + * @opts: Bitmask of options defined in include/linux/security.h
>   *
>   * Determine whether the nominated task has the specified capability amongst
>   * its effective set, returning 0 if it does, -ve if it does not.
> 

-- 
James Morris
<jmorris@namei.org>

