Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A4C54E8D
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 22:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BA1206F5
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 22:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXruX/xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEKWJO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKWJN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 18:09:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F4C061A0C
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 15:09:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so8520294pjb.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aomPkVehe7TL/kKU0Me66UERAR5lg9DL9drhmGOnVxE=;
        b=eXruX/xCbQJfFsbqHN2CJokshetL/6PLgXB+QVz+bKAQHCpfXEbAjzkghODaZYT7ca
         m5uHGvS9M34uv2UOLK5nR38ppj2wJP1ipPrT7Jmh7OPNkwyvQ6/GBDca4TK8s9gZrDyE
         0WW0D6lDwjdQ29RO6Hfqi8ztL4q7UGcHG3W/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aomPkVehe7TL/kKU0Me66UERAR5lg9DL9drhmGOnVxE=;
        b=UjeVCrbsuPykWU/w8/Ed7FvQ9sF8hatR6QuT5GDXgljrfroIoHjd4plvJCdY4I4R4w
         io3OSvJBa67eGESKhUP/r9bpqJZW/Eg+R2a0i4apVlu9aLOZFbfDmdCHqTR2D2c4xxSX
         iRGrJjz0UictVBCkmeyejpA4zXjv8X6MLVEV4rzwHrhhnlkVb6UG3LhdHzSY8uVkLfgR
         sCanD8RvVrOo8wrVFRy0gZOwaw05pxcXNAFsZbkMuojDmAKKVbCu7W6nb5inAUzZH4Am
         i7NIkaUZ5/AvioZoOwGReKJwQo86mTJvWva7PnLs5bKJKTLjq9j5ZIuHDl2S8LXbVUGk
         /Fow==
X-Gm-Message-State: AGi0PuaxJ+P20SSiBWpXDkW3MKP9nkqJYMalYEJfjavChd32bqPEfhIY
        xCAasK/sCGX8rzg89hCElgGmQw==
X-Google-Smtp-Source: APiQypKi68we7ermoAWRfQW2qEytOl35kvRZgSR1OMlPxo26w8nY5kkYJw6WqdApCEIF0R4HUGYN7A==
X-Received: by 2002:a17:90b:614:: with SMTP id gb20mr21080900pjb.211.1589234951533;
        Mon, 11 May 2020 15:09:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s101sm10918738pjb.57.2020.05.11.15.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:09:10 -0700 (PDT)
Date:   Mon, 11 May 2020 15:09:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 4/5] exec: Allow load_misc_binary to call prepare_binfmt
 unconditionally
Message-ID: <202005111457.8CC3A4A7@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <878si0zyhs.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878si0zyhs.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 09, 2020 at 02:42:23PM -0500, Eric W. Biederman wrote:
> 
> Add a flag preserve_creds that binfmt_misc can set to prevent
> credentials from being updated.  This allows binfmrt_misc to always
> call prepare_binfmt.  Allowing the credential computation logic to be
> consolidated.
> 
> Ref: c407c033de84 ("[PATCH] binfmt_misc: improve calculation of interpreter's credentials")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/binfmt_misc.c        | 15 +++------------
>  fs/exec.c               | 14 +++++++++-----
>  include/linux/binfmts.h |  2 ++
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 127fae9c21ab..16bfafd2671d 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -218,19 +218,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  		goto error;
>  
>  	bprm->file = interp_file;
> -	if (fmt->flags & MISC_FMT_CREDENTIALS) {
> -		loff_t pos = 0;
> -
> -		/*
> -		 * No need to call prepare_binprm(), it's already been
> -		 * done.  bprm->buf is stale, update from interp_file.
> -		 */
> -		memset(bprm->buf, 0, BINPRM_BUF_SIZE);
> -		retval = kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE,
> -				&pos);
> -	} else
> -		retval = prepare_binprm(bprm);
> +	if (fmt->flags & MISC_FMT_CREDENTIALS)
> +		bprm->preserve_creds = 1;
>  
> +	retval = prepare_binprm(bprm);
>  	if (retval < 0)
>  		goto error;
>  
> diff --git a/fs/exec.c b/fs/exec.c
> index 8bbf5fa785a6..01dbeb025c46 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1630,14 +1630,18 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
>   */
>  int prepare_binprm(struct linux_binprm *bprm)
>  {
> -	int retval;
>  	loff_t pos = 0;
>  
> -	bprm_fill_uid(bprm);
> +	if (!bprm->preserve_creds) {

nit: hint this to the common execution path:

	if (likely(!bprm->preserve_creds) {

> +		int retval;
>  
> -	retval = cap_bprm_set_creds(bprm);
> -	if (retval)
> -		return retval;
> +		bprm_fill_uid(bprm);
> +
> +		retval = cap_bprm_set_creds(bprm);
> +		if (retval)
> +			return retval;
> +	}
> +	bprm->preserve_creds = 0;
>  
>  	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
>  	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 89f1135dcb75..cb016f001e7a 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -26,6 +26,8 @@ struct linux_binprm {
>  	unsigned long p; /* current top of mem */
>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>  	unsigned int
> +		/* Don't update the creds for an interpreter (see binfmt_misc) */

I'd like a much more verbose comment here. How about this:

		/*
		 * Skip setting new privileges for an interpreter (see
		 * binfmt_misc) on the next call to prepare_binprm().
		 */

> +		preserve_creds:1,

Nit pick: we've seen there is a logical difference here between "creds"
(which mean "the creds struct itself") and "privileges" (which are
stored in the cred struct). I think we should reinforce this distinction
here and name this:

		preserve_privileges:1,

>  		/*
>  		 * True if most recent call to the commoncaps bprm_set_creds
>  		 * hook (due to multiple prepare_binprm() calls from the
> -- 
> 2.25.0
> 

Otherwise, yeah, this seems okay to me.

-- 
Kees Cook
