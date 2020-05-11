Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245DFC54E4A
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 22:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0427F20736
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 22:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pe7YR+b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEKWYP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 18:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgEKWYO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 18:24:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D52C061A0C
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 15:24:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so4515681plr.4
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QvaxpqAOG9RnWvaCfYYP2fpuftRhg/t8uSRu7E32TuQ=;
        b=Pe7YR+b338sDJoO+XPIuxNX60nLt75l2VTRDebHqRLmJt9h1yK4Rapmdcyoyh8FrXi
         3FEeVdBp1hFpjkSej5hGNFz5+cCHNg6DeNgMNrCLAOApXzVtZuQi6lIz5zxiKPdwGJ3V
         Syh/TrNkjs76R08MkAtq8MqryvycOESpiNiyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvaxpqAOG9RnWvaCfYYP2fpuftRhg/t8uSRu7E32TuQ=;
        b=qDH2hMSwfJuKLPVuyC0rg/ipxerbkC0V8krejSTD6Zg9ZKo0QmYIXyEXluGWFKy6Ni
         jPcLhsz5EC+D6qJxthUw/aav3N2DosEaalOBxNJWOfGOb8Kxd0nK4ilh3v6YcwwhqFyr
         2aatn/rv0ArO5OEo4MrbXr+uNP+FwPWtMAL6Xo1lYaX11rDr2mA2ol4BJUI8yO19/+15
         Y168qae+XVaHKrDea0yhuw2L1UwH66YxtirgMVYo4C/uzQcP+6Qhuxa9loFYbW9USo7J
         /AkxNovbSnpaAex4cLtMgOv+T0z49BtqtK2/Cpzu+aR/1og9igPEvKBMg9/1KE6oPmTm
         H0yg==
X-Gm-Message-State: AGi0Pua9hkmk5OjjEqZ+G6ANOE27ylfH1WCU83fiBRVlFa6DVwt3ITdy
        ebXoc+wzu4HrQBbqvpUPRjFaBA==
X-Google-Smtp-Source: APiQypIqupBdX5IGlXP5mdijDfuVXimMgcwG1qOCb2qRhVNHBZolu5RIdeWlFv/6jCEG2LR8QocOxQ==
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr26301393pjb.172.1589235852612;
        Mon, 11 May 2020 15:24:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s123sm10145294pfs.170.2020.05.11.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:24:11 -0700 (PDT)
Date:   Mon, 11 May 2020 15:24:10 -0700
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
Subject: Re: [PATCH 5/5] exec: Move the call of prepare_binprm into
 search_binary_handler
Message-ID: <202005111517.27E34BB6@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <873688zygz.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873688zygz.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 09, 2020 at 02:42:52PM -0500, Eric W. Biederman wrote:
> 
> The code in prepare_binary_handler needs to be run every time
> search_binary_handler is called so move the call into search_binary_handler
> itself to make the code simpler and easier to understand.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yes, nice. :) I don't see any ordering dependencies here. The only thing
I see is a potential for more "work done by kernel before bailing" in
the sense that the arg copying will be performed before we check the
kernel_read() result. I struggle to see how that might be a problem,
and this get us to fewer exec.c exports. Yay!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
