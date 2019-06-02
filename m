Return-Path: <SRS0=W1UI=UB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D491C28CC5
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C027825
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwdgG4KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFBC4h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:56:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38307 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFBC4g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 22:56:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so6236500pgl.5
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYBkyqo/yPlkXuPi+qAPWY5xhttsminToU3/+row8eo=;
        b=EwdgG4KWs0WFC0g2qGgDlx/QQfY8z8TRahYLL3PS2bjslsQ3YxJuNetJlygU0Y/rW2
         k7Yv+nzeS/fjPzpBajA6CHQjp1j4AZjImizUFdTznKz6VYnS6uGHDREju9E75zfJzmKt
         TBv/3YDHw8zVShT8PFpmjjeZ+upKwT5fZRg+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYBkyqo/yPlkXuPi+qAPWY5xhttsminToU3/+row8eo=;
        b=FI+WRjq9eOsE6rjOOR+oKRcVWE0WTxDzIPws3m1SZHYWI5hNZwZrxRGDfP3LsnRhdG
         h2bP51budca2bfR9YqqguSxge+Nawg8HsQ78l08BqucE0zC5A61BIdNKmcQI9Vh3mPv+
         VFC26JSsN6sShimWI5xwjWT3uXTw7EdOOONpxr2DxMOOlFOC52iZu5XVks28I+E3x5eI
         UCcUUQPeXh120sa0YqubyTsvEni6u7vBqT+fIsrMYd34MEDtd1F96KiFQzHFYYHLdD6P
         b5BY73a6iyDoN3vvxyHNpK7/loEOMm0SGXapzUSjgzGBJkG3tlgqD8hhPDNMuIuZ7/jx
         0n2A==
X-Gm-Message-State: APjAAAWXoOrxVFsEHUQGQrZIojW9JdF5lUprPstnBbU+GXQ2fyz6Vc/3
        x+UCc0odYSSU5qjuyotBwKCVAA==
X-Google-Smtp-Source: APXvYqwLYD7HaXO7AVb9B/ZrQ2U36ePix1eevfw6eGQxR4xL3hXDj7WGuJRc2xewYGlFTBsLDGm/Bg==
X-Received: by 2002:a65:4209:: with SMTP id c9mr11005489pgq.111.1559444196405;
        Sat, 01 Jun 2019 19:56:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6sm21303749pfm.163.2019.06.01.19.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:56:35 -0700 (PDT)
Date:   Sat, 1 Jun 2019 19:56:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
Message-ID: <201906011954.1153EF675@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:09:22PM -0700, Casey Schaufler wrote:
> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor

I will go read 51-58 from here :)

I'd really love to see summaries of the series broken down because I
think there are some separable parts:

First several patch: more blobs -- send this part again separately,
let's get some more review and land it. It's distinct from the other
changes.

rest until 35: secids work (is this actually separable from secctx?)

36-?: security context

-- 
Kees Cook
