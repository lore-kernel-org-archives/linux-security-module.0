Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE3C43461
	for <linux-security-module@archiver.kernel.org>; Fri, 14 May 2021 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46F361451
	for <linux-security-module@archiver.kernel.org>; Fri, 14 May 2021 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhENTGR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 May 2021 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhENTGR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 May 2021 15:06:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02AC06174A
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:05:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so1789445pjo.0
        for <linux-security-module@vger.kernel.org>; Fri, 14 May 2021 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2oyWB47DVh2Z1QlH8RDV8bFzaQjwvqlwdoVeOlHpTjY=;
        b=N7xVGKEZAXnH63GpXE5YnML5NzFhi5pHSpODhdP/+SHXypBf+ks4urojkWF+Ax4bXJ
         H9elgm+fGXV0S5oqzNOAJNQmqcxAsHqbr2rN+1FBkvyF2WznF6gFOSPjTXX5SglQyi2y
         LXNsTtw2ir4m0hJtlXyLOuM593MKZvmymmOBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oyWB47DVh2Z1QlH8RDV8bFzaQjwvqlwdoVeOlHpTjY=;
        b=OAwc6fQYYV+346tc6ZMuO2GvJnueM0oIUkIkE1mKuvkhW02sXgfQapoKObXDCiK0JA
         mkv4QWPd4PNWcowMYmn2A5SbZJHveIFHSpayGDobKfMW8cwujXcV209AmiK7GqdaIRHe
         ibrofyKlViqcO4DltbqKRnc/Vhg7fMq6rbDbP+vkjXVpOPIIVsitFFV7PgRs4WE1/0Bl
         fkQpocZg0BL2LTrKu9A1w/LdDAelrhgACvxqOi3bwEEpnP1yiOmrqRu+ZrwWgdhRT3gL
         WkaWk6Eomqv/ncYy71pfsrOK1pgfNNWeA3j4Sjpibqm7LSh99SXGjEZ6JCz7SJHCMVwm
         yKlA==
X-Gm-Message-State: AOAM531GTP6cJtMAEo19dxjGo/N7In/Hds7QmJAX8OtYSDA/EWSyV10l
        hCZR5dHr5M9B+5edaX0Irk6I6g==
X-Google-Smtp-Source: ABdhPJyUObluMNbfEqWcZJnBSUzUGr8HvBPdxmzJ89o/blQ7U0kb+Fxmtnzn6tpGLVDTKLmFXMSQzQ==
X-Received: by 2002:a17:902:860b:b029:ef:46b8:886e with SMTP id f11-20020a170902860bb02900ef46b8886emr24070539plo.18.1621019103903;
        Fri, 14 May 2021 12:05:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v67sm4506950pfb.205.2021.05.14.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:05:03 -0700 (PDT)
Date:   Fri, 14 May 2021 12:05:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v26 08/25] LSM: Use lsmblob in security_secid_to_secctx
Message-ID: <202105141204.B7691DAD26@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-9-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 01:07:50PM -0700, Casey Schaufler wrote:
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

This looks sensible.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
