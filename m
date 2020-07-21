Return-Path: <SRS0=/BYZ=BA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBFC433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC642072E
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 02:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGUCLt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:11:49 -0400
Received: from mail.hallyn.com ([178.63.66.53]:58014 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGUCLt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 22:11:49 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id B260AA10; Mon, 20 Jul 2020 21:11:47 -0500 (CDT)
Date:   Mon, 20 Jul 2020 21:11:47 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org, keescook@chromium.org,
        casey@schaufler-ca.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, serge@hallyn.com,
        jmorris@namei.org, Thomas Cedeno <thomascedeno@google.com>
Subject: Re: [PATCH 1/2] LSM: Signal to SafeSetID when in set*gid syscall
Message-ID: <20200721021147.GA28125@mail.hallyn.com>
References: <20200720181156.1461461-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720181156.1461461-1-mortonm@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 20, 2020 at 11:11:56AM -0700, Micah Morton wrote:
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

I see that only safesetid is using that now anyway.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  kernel/sys.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 00a96746e28a..55e0c86772ab 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -373,7 +373,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>  	if (rgid != (gid_t) -1) {
>  		if (gid_eq(old->gid, krgid) ||
>  		    gid_eq(old->egid, krgid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>  			new->gid = krgid;
>  		else
>  			goto error;
> @@ -382,7 +382,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>  		if (gid_eq(old->gid, kegid) ||
>  		    gid_eq(old->egid, kegid) ||
>  		    gid_eq(old->sgid, kegid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>  			new->egid = kegid;
>  		else
>  			goto error;
> @@ -432,7 +432,7 @@ long __sys_setgid(gid_t gid)
>  	old = current_cred();
>  
>  	retval = -EPERM;
> -	if (ns_capable(old->user_ns, CAP_SETGID))
> +	if (ns_capable_setid(old->user_ns, CAP_SETGID))
>  		new->gid = new->egid = new->sgid = new->fsgid = kgid;
>  	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
>  		new->egid = new->fsgid = kgid;
> @@ -744,7 +744,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>  	old = current_cred();
>  
>  	retval = -EPERM;
> -	if (!ns_capable(old->user_ns, CAP_SETGID)) {
> +	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
>  		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
>  		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
>  			goto error;
> @@ -871,7 +871,7 @@ long __sys_setfsgid(gid_t gid)
>  
>  	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
>  	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> -	    ns_capable(old->user_ns, CAP_SETGID)) {
> +	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
>  		if (!gid_eq(kgid, old->fsgid)) {
>  			new->fsgid = kgid;
>  			if (security_task_fix_setgid(new,old,LSM_SETID_FS) == 0)
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
