Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C08C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4C620578
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5wm3j0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgESS12 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESS11 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 14:27:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7DC08C5C0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:27:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so296448pfu.5
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X+EjBfM39k69WBHN4/ekIWimO/d9vuhDt/Vo5vtGtAE=;
        b=k5wm3j0ZFUD/z29kzyzWM3Ts6RzjmHfYKcvUqUD9IACZssyAf8JKWmEbFUkn1OrPKf
         pmVYFVlyr+dS+hfCae3pARec9ZCRZUODOa9jm2cfESVBmVjP7xV6lP6DmtlCnPUWY0PB
         JgYQESHA/aXh2EEkWDGlvcKEmdovXGAJygOBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+EjBfM39k69WBHN4/ekIWimO/d9vuhDt/Vo5vtGtAE=;
        b=cMKx9fbaxChGJ9eLMpSBM50ka+jxFd5gHb9Q/xIxMh+10ous6KruZ8KqFdg/TkrO86
         Buot3G8Ip/nO74ynoRAHIjOoDRYQAgxlD3GnWOOyzv9k6IKUwYds/bcOCdx7bcAaNlA8
         kiliWHOhLxze5ja5hQnCiCNPnCvsKJftBkXzVPHS/eaxN46MSxFfgDGNqJ3oO4q209s7
         V2NAOAzo1GPxMGgaGGZ/V0/AMTFLq4wvaN9cwAlLCqbkQkWoao5X7RNkjklZLRas+IpL
         Adx0eEpwP5nXu42LKPv+OMC9r8E9v4g9kVesfOqR2bfjLak92cPlbXq9GiVMF39y7p11
         WkYQ==
X-Gm-Message-State: AOAM531xFD4SMtvCE2W3DxqyAVYGa5ixkvO9Cdwg10TWdfM/zCJ0wBtr
        h8GIDFAJ661go5JAWf66ubChdg==
X-Google-Smtp-Source: ABdhPJxLV+9+iUF7RnugjFhTaU3WzPCcGgGLXrt1uU4iwA1cLBlFFTFDMUPFBE84tI2+OdJIcTyc+w==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr401180pfc.116.1589912847368;
        Tue, 19 May 2020 11:27:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm217492pju.38.2020.05.19.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:27:26 -0700 (PDT)
Date:   Tue, 19 May 2020 11:27:25 -0700
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
Subject: Re: [PATCH v2 4/8] exec: Allow load_misc_binary to call
 prepare_binfmt unconditionally
Message-ID: <202005191122.0A1FD07@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 18, 2020 at 07:31:51PM -0500, Eric W. Biederman wrote:
> 
> Add a flag preserve_creds that binfmt_misc can set to prevent
> credentials from being updated.  This allows binfmt_misc to always
> call prepare_binfmt.  Allowing the credential computation logic to be

typo: prepare_binprm()

> consolidated.
> 
> Not replacing the credentials with the interpreters credentials is
> safe because because an open file descriptor to the executable is
> passed to the interpreter.   As the interpreter does not need to
> reopen the executable it is guaranteed to see the same file that
> exec sees.

Yup, looks good. Note below on comment.

Reviewed-by: Kees Cook <keescook@chromium.org>

> [...]
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 8605ab4a0f89..dbb5614d62a2 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -26,6 +26,8 @@ struct linux_binprm {
>  	unsigned long p; /* current top of mem */
>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>  	unsigned int
> +		/* It is safe to use the creds of a script (see binfmt_misc) */
> +		preserve_creds:1,

How about:

		/*
		 * A binfmt handler will set this to True before calling
		 * prepare_binprm() if it is safe to reuse the previous
		 * credentials, based on bprm->file (see binfmt_misc).
		 */

-- 
Kees Cook
