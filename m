Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F1C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 23:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AB72072C
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 23:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8TpZMqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETXnc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 19:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgETXnb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 19:43:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E82C061A0F
        for <linux-security-module@vger.kernel.org>; Wed, 20 May 2020 16:43:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so2017179plz.13
        for <linux-security-module@vger.kernel.org>; Wed, 20 May 2020 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzigqvCYVoWhJQjGnZdN10eq4UVPeXb2NdIvrtIBgdk=;
        b=S8TpZMqqF+vCdU5tBHdSe/IPfbqyqb2zQD2+XXASut4eAydcA2VnRgFtcX25M/0feS
         G3Eq8oEgHI5fKit7gG8wXj2RA1JJUI3tqo3ysm1Ori/jhahRsENZ2LKpLJbAtqm3rRuO
         HGmsY3G7a7tmtLva5XdGTPe8sPmoXHkmOypU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzigqvCYVoWhJQjGnZdN10eq4UVPeXb2NdIvrtIBgdk=;
        b=jfMa0ZuPFDNNm4rGDNBXXxcjct6BKJoyKLoqHbqVpUghI7x963fnCJGXMJA2HMJHtq
         4HbjL7rxsEciRQefxdz463imrp4UDTE3vfQsapoXedPm2ijB7sMI66e10+F/+VeCD9WF
         opmF/0LFXctwGhTh13Ap6RkmmG++KxvwWQdN7BdSLh7k2YuBj2jdyhSyk/yuREqna4wP
         FqrgXTc6DHq0Vm5Dv2HkNifvb64qpx/Wg6pLc9JmVSryQ//L/cXl+81au5XJBbptTes1
         qbDaYdIRoaJn/Nb1nb/Vtt/YGer4rLN1zmjdHr3nNjhazu50lYZaemHHXGZ9Du+sFtt2
         I3Dw==
X-Gm-Message-State: AOAM531JtPGUM6Y+ORr8vGA4ttECwPYU/jW808ud87W3S8RnGWvbeQ0f
        kOwX4krr3jZB1iinsKAQjGCOhw==
X-Google-Smtp-Source: ABdhPJzAmXhGgMQ9bm3JEcA9zNoKFZ1bL5DiGR8yLS6nj0HxejjmJnyhib07lt61xKLuMTlbQKDt7w==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr6893114pla.157.1590018210903;
        Wed, 20 May 2020 16:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s123sm3007557pfs.170.2020.05.20.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:43:29 -0700 (PDT)
Date:   Wed, 20 May 2020 16:43:28 -0700
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
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
Message-ID: <202005201642.E1C6B4A457@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87d06ygssl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d06ygssl.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 20, 2020 at 05:12:10PM -0500, Eric W. Biederman wrote:
> 
> I have pushed this out to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next
> 
> I have collected up the acks and reviewed-by's, and fixed a couple of
> typos but that is it.

Awesome!

> If we need comment fixes or additional cleanups we can apply that on top
> of this series.   This way the code can sit in linux-next until the
> merge window opens.
> 
> Before I pushed this out I also tested this with Kees new test of
> binfmt_misc and did not find any problems.

Did this mean to say binfmt_script? It'd be nice to get a binfmt_misc
test too, though.

Thanks!

-Kees

-- 
Kees Cook
