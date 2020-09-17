Return-Path: <SRS0=t07G=C2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFCC43463
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836B820872
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gZfnTVPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIQWFW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQWFV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 18:05:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DFEC06178A
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 15:05:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so2101462pfd.5
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RVejrFx8lqGVUKgRhIUmNAugSkLKO3AWaoC/1SxxcL0=;
        b=gZfnTVPqJkwyJQbCSxJtksOl0Wp3oPCryqhhzYqmD6nXS59iDI+KLW4Fe8f0f8zL3n
         /elUdPuoSqhgtEl2zfjQjTb/kbloI1vZr9vae5Jthw3imZMzfP9Eia8WaXmx3/Q3AM39
         b9Swp7NuoP77Vi0xXufmukO6fA00nsfebrOJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVejrFx8lqGVUKgRhIUmNAugSkLKO3AWaoC/1SxxcL0=;
        b=BDpD4uZlUqvL1XK4qRjJN+Cinqg0VbffT+HGYEYM0qz03EEHnlund+AE53gxvQbLnr
         NTbq4XnHJx1rZM0Y2VqbyYKEhsk8bKmVYnRsG0piefTkKqFtuyio0trphfJhEd5RP0VX
         lV6g1wW6jdwF0AmitaKj7xzhGDgG/R+AnTxqeDq54jNVP+x6UeYAYw6tM5xY52Rcdh1K
         llqRSmvymkiIy7F4wThKLRx3zKRot93HAHMXjH/Fwi4PaFfEsW0W3y6Cxc4JIoU9qMLL
         6lTk01C6PG9+yROOe7QBXznmUvu1bFZO6ahL9WIfuBJ/iyvins66I6sIi331uIpNLYZO
         /7XQ==
X-Gm-Message-State: AOAM533dXSb3YsQtPZ1eyEsevq6KUW0zrr85lvCvc53U9pheCKSvrkYr
        rdbch+z/qMXIXG/VYLt6LWs4ZA==
X-Google-Smtp-Source: ABdhPJxpTQhskINmsg7Ej2h7teJJR0+5sPJiS7FT04TblAYOWkDs4Jwx5Cao9/nMc6ypwIWmOhsmsw==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr6153286pge.346.1600380320847;
        Thu, 17 Sep 2020 15:05:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm611190pfq.53.2020.09.17.15.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:05:19 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:05:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, kernel-hardening@lists.openwall.com,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the
 fbfam feature
Message-ID: <202009171504.841FA53@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-2-keescook@chromium.org>
 <202009101615.8566BA3967@keescook>
 <20200917175146.GB3637@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917175146.GB3637@ubuntu>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 17, 2020 at 08:40:06PM +0200, John Wood wrote:
> Hi,
> 
> On Thu, Sep 10, 2020 at 04:18:08PM -0700, Kees Cook wrote:
> > On Thu, Sep 10, 2020 at 01:21:02PM -0700, Kees Cook wrote:
> > > From: John Wood <john.wood@gmx.com>
> > >
> > > Add a menu entry under "Security options" to enable the "Fork brute
> > > force attack mitigation" feature.
> > >
> > > Signed-off-by: John Wood <john.wood@gmx.com>
> > > ---
> > >  security/Kconfig       |  1 +
> > >  security/fbfam/Kconfig | 10 ++++++++++
> > >  2 files changed, 11 insertions(+)
> > >  create mode 100644 security/fbfam/Kconfig
> > >
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index 7561f6f99f1d..00a90e25b8d5 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -290,6 +290,7 @@ config LSM
> > >  	  If unsure, leave this as the default.
> > >
> > >  source "security/Kconfig.hardening"
> > > +source "security/fbfam/Kconfig"
> >
> > Given the layout you've chosen and the interface you've got, I think
> > this should just be treated like a regular LSM.
> 
> Yes, throughout the review it seems the most appropiate is treat
> this feature as a regular LSM. Thanks.
> 
> > >
> > >  endmenu
> > >
> > > diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
> > > new file mode 100644
> > > index 000000000000..bbe7f6aad369
> > > --- /dev/null
> > > +++ b/security/fbfam/Kconfig
> > > @@ -0,0 +1,10 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +config FBFAM
> >
> > To jump on the bikeshed: how about just calling this
> > FORK_BRUTE_FORCE_DETECTION or FORK_BRUTE, and the directory could be
> > "brute", etc. "fbfam" doesn't tell anyone anything.
> 
> Understood. But how about use the fbfam abbreviation in the code? Like as
> function name prefix, struct name prefix, ... It would be better to use a
> more descriptive name in this scenario? It is not clear to me.

I don't feel too strongly, but I think having the CONFIG roughly match
the directory name, roughly match the function prefixes should be best.
Maybe call the directory and function prefix "brute"?

-- 
Kees Cook
