Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5926C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F0B2075F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J2dvXZG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgESTOn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESTOm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 15:14:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A06C08C5C0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 12:14:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so277674pgn.4
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hzUIWpf2COJGu10K9zNA4alrQYEQDf2ZxnZ+vLrtLOs=;
        b=J2dvXZG++NKRPJGTT7H8hZxKOiRbCEO0NPkYH8e/WSip7ia/fghW2ryML++SjOJivD
         3w4qWG541m3+I4jObP3wmuFMPB6X5nmJME2bH+SHtK8tKuI0yUnXdUfBJUsLrs/srBs5
         1T83uq+SrW/TDwqo2A0Q+jIRCayxBiQhfcJ0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzUIWpf2COJGu10K9zNA4alrQYEQDf2ZxnZ+vLrtLOs=;
        b=lgFP+3Ba1D4PT6JddZCbPaCxE4F1gWVG2X7jcMWq2zQCN6o3DItqTalel0mTAuPDsa
         2tX+FfuQWuyrXELfR1F5u1j3aUJ6wcpevBT/f9/l4PTU1N9/LKPinZt5oW7VcCmnqdT+
         0SlsnxGjysUDzR7Wt8dAI3SMHDNlhfeHUX0gF4zq1Guw2r250XSWtCJqCoMGZRx7PEzQ
         E4bdF7CIO0yahoa5y92HlLQBufcy9Pam0i+JDXLpoDxiVbevvH9nIedpGA0MoBEDiO6M
         ZqJ55hOQLqsw9f1O7NWcS0sbPvEZOuI0Vioy+iiH4sVlDCIJbP4L6OEVifVlS3bVhbK2
         Mg2Q==
X-Gm-Message-State: AOAM530kBC7W4IsAWFs3qG5cOpBLvHROG/+/Dr4lXcmvbchXeQlBX6sL
        moqjtgdWCNRw68Hl9iQkllpuIw==
X-Google-Smtp-Source: ABdhPJwti/qBt30q0tzc1ytgag0FAtjpL1Zx0HGmxi2XXuFmfXwbUXXIhiOcrt59HkCR+E7SMGiUSA==
X-Received: by 2002:a63:546:: with SMTP id 67mr704972pgf.364.1589915682040;
        Tue, 19 May 2020 12:14:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm261612pjs.17.2020.05.19.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:14:41 -0700 (PDT)
Date:   Tue, 19 May 2020 12:14:40 -0700
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
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into
 security_bprm_repopulate_creds
Message-ID: <202005191211.97BCF9DA@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
 <202005191111.9B389D33@keescook>
 <875zcrpx1g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zcrpx1g.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 19, 2020 at 02:03:23PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
> >> [...]
> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> >> index d1217fcdedea..8605ab4a0f89 100644
> >> --- a/include/linux/binfmts.h
> >> +++ b/include/linux/binfmts.h
> >> @@ -27,10 +27,10 @@ struct linux_binprm {
> >>  	unsigned long argmin; /* rlimit marker for copy_strings() */
> >>  	unsigned int
> >>  		/*
> >> -		 * True if most recent call to cap_bprm_set_creds
> >> +		 * True if most recent call to security_bprm_set_creds
> >>  		 * resulted in elevated privileges.
> >>  		 */
> >> -		cap_elevated:1,
> >> +		active_secureexec:1,
> >
> > Also, I'd like it if this comment could be made more verbose as well, for
> > anyone trying to understand the binfmt execution flow for the first time.
> > Perhaps:
> >
> > 		/*
> > 		 * Must be set True during the any call to
> > 		 * bprm_set_creds hook where the execution would
> > 		 * reuslt in elevated privileges. (The hook can be
> > 		 * called multiple times during nested interpreter
> > 		 * resolution across binfmt_script, binfmt_misc, etc).
> > 		 */
> Well it is not during but after the call that it becomes true.
> I think most recent covers the case of multiple calls.

I'm thinking of an LSM writing reading these comments to decide what
they need to do to the flags, so it's a direction to them to set it to
true if they have determined that privilege was gained. (Though in
theory, this is all moot since only the commoncap hook cares.)

> I think having the loop explicitly in the code a few patches
> later makes it clear that there is a loop dealing with interpreters.
> 
> Conciseness has a virtue in that it is easy to absorb.  Seeing
> active says most recent and secureexec does not is enough to ask
> questions and look at the code.

I still think a hint about the nature of nested exec resolution would be
nice in here somewhere, especially given that this value is zeroed
before each call to the hook.

-- 
Kees Cook
