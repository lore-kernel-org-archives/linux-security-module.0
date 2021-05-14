Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FCFC433ED
	for <linux-security-module@archiver.kernel.org>; Fri, 14 May 2021 19:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F526145B
	for <linux-security-module@archiver.kernel.org>; Fri, 14 May 2021 19:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhENT0C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 May 2021 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhENTZw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 May 2021 15:25:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4339C06138C
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:24:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 69so12004504plc.5
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zYWopn37Ev0Ztgo7qbckFoeWWV5RAzUDbw0Dfbjdlw=;
        b=CMZSonsnXKB5rfp654jW6UBkcZJpQvr4Hl3h/Sqp9c5xOeKlo+X+kqqWm3C/Otq38b
         Gby1KIQVxuvRvD6LivosEWOYnU+tAsjc0470WhZAINAdTPN3hksm4E8lMmzXHsMnhdIr
         dMg9q2OAFM5nEax3IUS56gN67MKdcrw2ETr6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zYWopn37Ev0Ztgo7qbckFoeWWV5RAzUDbw0Dfbjdlw=;
        b=gry88Y2FKJPMiBzItz/gW6cBCbTGP5F9vongFkpuQoS2wJIDsRkKeMypZSw6zJ5Y8k
         wDlzNVX2LgkK1D1Wp5+Lyf8r32Oh46qitK6nmW7iQ99vf+xS7osFroEITa9hzH9r181F
         ApCmU6VqvtBUghYMNw+v0jIO4ZDP0VZw3taKegjISumhlDnZSQ1/VlRBw1hv1tZoa269
         y4iEmB6lm5drBRzz10apXdejeolxQXZDi9nyMqQKs0eyXBc5dMmYq1k0zDB+mTUqN91e
         sDcr0kLuPla0qUaDi04T1MGdZn8ETdLmQRj5IavmNPZHyas1R8CwQF4JhF+KdaiYqee7
         Y7rg==
X-Gm-Message-State: AOAM532OmFgYx7njFkjuJ75a3ckPKVgX6DDhdYnRjEFE9IeJ2LX6EYR1
        Vs98nGGdM5gKKqMKeVHFtqgjag==
X-Google-Smtp-Source: ABdhPJxHMA/6v53f/nn/W7fZz/vDZdmjMu55VCA8wxeCxUw6+Ip7YnJ5TAlxokdAusW4aKY8IvIw/Q==
X-Received: by 2002:a17:90a:1c02:: with SMTP id s2mr20301156pjs.172.1621020280425;
        Fri, 14 May 2021 12:24:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm4983512pff.96.2021.05.14.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:24:39 -0700 (PDT)
Date:   Fri, 14 May 2021 12:24:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v26 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Message-ID: <202105141224.942DE93@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-18-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-18-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 01:07:59PM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seem good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
