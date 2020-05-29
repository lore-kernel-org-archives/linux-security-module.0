Return-Path: <SRS0=ngOM=7L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337BC433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9962071A
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M2zfIhsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgE2VGh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 May 2020 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgE2VGg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 May 2020 17:06:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C0C08C5CA
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2020 14:06:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f21so485550pgg.12
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2020 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p/Ov8sL4DrAiZu38/tMtDPHCSaLR76xmY23DLMflZaw=;
        b=M2zfIhsKul4HQv2VnAJO+u/iqfebyos6KWaRuwPJ56zlnFgHqQ29FsB3gZUCGMif/b
         Keic6ZWRzMUhkiTfftlD4aXXP6WYNcSt183Lo0Wc3aGOSjxFtY9gkQJiAa9abPA7dC5D
         i6Oi9BA/aAlbsvlXin3WuiduzcXkmaaq/8D8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/Ov8sL4DrAiZu38/tMtDPHCSaLR76xmY23DLMflZaw=;
        b=cb8vQFAgqO0AZQV9EVxDD9bMbD5gVe0i1PU1bRRQvah8ya0TO/KxCjDIFufo0O+CVy
         cff9lU1VPUF7JJAM6f5qRuYT+bRjuBZwZ9CpJLs4Ui6tfVepjvMPIf46aC8pPTGUcB4d
         kcI3hLW1OoLiYoS57wE/hUUFOrPrgTFabO0zDYVVgnWr6uROMIF6JDpZtWa2rXomgemi
         sPOTfh11mOhP3q/z7yQebisZlK1elrt/aWvYsDgXZnwdSp8ljlWfeVlIbTyiVKMc3pW3
         P3SayhnI7AWpZT/868eB0ckShb5U8qa9pRJGrHbWVmCwSEEm0tPtgr1triuljFapW5tE
         lukw==
X-Gm-Message-State: AOAM531E3VMNzIqQ9/5m8LHMy9cVx5RVfCh6YGYpJbUJAyKbygHBXI+P
        ZQouNEqDtec+4Hx6mcOcmDKefA==
X-Google-Smtp-Source: ABdhPJwGu0pY6JmkeZog/Tcw6O+49RsdbgBWT17tFEvI6bgf84KZEZVHvszc2DWwldNkFL/whW+jmw==
X-Received: by 2002:a62:8487:: with SMTP id k129mr7726912pfd.296.1590786396090;
        Fri, 29 May 2020 14:06:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm8067695pfg.22.2020.05.29.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:06:35 -0700 (PDT)
Date:   Fri, 29 May 2020 14:06:33 -0700
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
Subject: Re: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
Message-ID: <202005291403.BCDBFA7D1@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 29, 2020 at 11:46:40AM -0500, Eric W. Biederman wrote:
> 
> There is a small bug in the code that recomputes parts of bprm->cred
> for every bprm->file.  The code never recomputes the part of
> clear_dangerous_personality_flags it is responsible for.
> 
> Which means that in practice if someone creates a sgid script
> the interpreter will not be able to use any of:
> 	READ_IMPLIES_EXEC
> 	ADDR_NO_RANDOMIZE
> 	ADDR_COMPAT_LAYOUT
> 	MMAP_PAGE_ZERO.
> 
> This accentially clearing of personality flags probably does
> not matter in practice because no one has complained
> but it does make the code more difficult to understand.
> 
> Further remaining bug compatible prevents the recomputation from being
> removed and replaced by simply computing bprm->cred once from the
> final bprm->file.
> 
> Making this change removes the last behavior difference between
> computing bprm->creds from the final file and recomputing
> bprm->cred several times.  Which allows this behavior change
> to be justified for it's own reasons, and for any but hunts
> looking into why the behavior changed to wind up here instead
> of in the code that will follow that computes bprm->cred
> from the final bprm->file.
> 
> This small logic bug appears to have existed since the code
> started clearing dangerous personality bits.
> 
> History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yup, this looks good. Pointless nit because it's removed in the next
patch, but pf_per_clear is following the same behavioral pattern as
active_secureexec, it could be named active_per_clear, but since this
already been bikeshed in v1, it's fine! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

I wish we had more robust execve tests. :(

-- 
Kees Cook
