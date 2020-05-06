Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D3C28CBC
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 22:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C206F2076D
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 22:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="apgnO1tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgEFWtz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgEFWtz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 18:49:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA4C061A0F
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 15:49:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1734847pje.5
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2FUrzCimCoQvPDI8jhXkMBxIsQZ8fqLNRuB8pW8C9I=;
        b=apgnO1tx03gYzmTiztou0ozl4DqE9Ke1CUls8XDLxiqo5GiuaT0cgajPeNIc1Nvgrh
         QSR/aDtXJFrDbcw3pE4mo7iM3uXupATiB4zjUWXDBhAWz29oyPbkwjLQEjzRYt4t1HSV
         HCgAaF82vmv4XqWI3sJU/yOu1FGAMo8m0rBsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2FUrzCimCoQvPDI8jhXkMBxIsQZ8fqLNRuB8pW8C9I=;
        b=KT7bjvnVGPEB3H/Y/KxZALr7UMHqQSWnN/1JE3r2g0avSC+8PvuARAdac5VRmgeM3F
         YduyVbFaeoOX0jdyCP1QJGfP3R3bapDf+ZePh+ojYzuDjeoBLk+c3q25a0M/ey8x9JIr
         o9DT/3zchQtv1kbyKDnJXnhJizt3vVexcnVGHJCuJj7Dyt/l9GVGdxRv2UCcLs8bsynA
         RaWdPz/QXIMmMiDIAMkhbybEV6EqWPZhOP+8CTfBUBdKSftWtoXxmSqMxB7Pq2CLsenZ
         MitQCfBOxxxd6eeCdDEKkTtHDGjzQpuWEd7VWkE/xv1w03xvx6LirzM5UkfK4C+nWIh0
         01Lw==
X-Gm-Message-State: AGi0Pub/AFVreyHMSKYSwvn+LQt8ESqbOf6ctfg/Gf4x5qYWDPtBbdYs
        XDN7x118IPBONVH5zby/GnWtQg==
X-Google-Smtp-Source: APiQypKzOSl6t5TXplgO53uZ+njke5Lpns5FHbM+l01D4h+BwwkOyeefVKk0O7oypj6oZi1uWRWTzA==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr10891853pls.214.1588805394525;
        Wed, 06 May 2020 15:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a30sm2294097pgm.44.2020.05.06.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:49:53 -0700 (PDT)
Date:   Wed, 6 May 2020 15:49:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <202005061543.97CC065531@keescook>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
 <202005052024.2D7626C742@keescook>
 <20200506040252.GC23230@ZenIV.linux.org.uk>
 <202005060831.C05759E@keescook>
 <20200506184920.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506184920.GD23230@ZenIV.linux.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 06, 2020 at 07:49:20PM +0100, Al Viro wrote:
> On Wed, May 06, 2020 at 08:34:29AM -0700, Kees Cook wrote:
> 
> > Just posted the whole series:
> > https://lore.kernel.org/lkml/20200506152114.50375-1-keescook@chromium.org/
> > 
> > But the specific question was driven by this patch:
> > https://lore.kernel.org/lkml/20200506152114.50375-11-keescook@chromium.org/
> 
> Yecchh...  First of all, you are leaving a dangling pointer in your
> struct pstore_private ->dentry.  What's more, in your case d_delete()

Yeah, good idea: I can wipe out the pstore_private->dentry at this point
just for robustness. From what I could tell the evict got immediately
called after the dput().

> is definitely wrong - either there are other references to dentry
> (in which case d_delete() is the same as d_drop()), or dput() right
> after it will drive ->d_count to zero and since you end up using
> simple_dentry_operations, dentry will be freed immediately after
> that.

Do you mean the d_drop() isn't needed? What happens if someone has
the file open during this routine? The goal here is to make these files
disappear so they'll go through evict.

> I have not looked at the locking in that series yet, so no comments

Yeah, I would not be surprised by some more locking issues, but I think
it's an improvement over what was there. Most of the code seems to have
been designed to be non-modular. :P

> on the races, but in any case - that d_delete() is a misspelled d_drop().

I'll change it; thanks!

-- 
Kees Cook
