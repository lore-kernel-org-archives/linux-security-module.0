Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4851C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Apr 2022 22:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiDRWQ5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDRWQ5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Apr 2022 18:16:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E827CCE
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 15:14:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg24so14136856pjb.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l9iX3O76iQ19mxLdkIRQWetqHCUUN6Yl8wyXvju+L58=;
        b=NKOJlVVw1gJhLASM4i9WIdrdYpP0RJ7udb9nNjDPBjFV9Hkyq8LHpDyLMYAcssOcbL
         0uHls7TNNgwFLz/gtqaQluedACtFDmwdZFSDa7JarDlE0tEwsKcx5QxGyX9rKCLiWxHb
         3KYOz6nsCtmjwv+CY46RN2KoQB0vIQOpmsfNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9iX3O76iQ19mxLdkIRQWetqHCUUN6Yl8wyXvju+L58=;
        b=Fsh0kjzGaMuE/9Y5d3fC3SH5+ar/eIlkzUwwg9MQ7+34v83qzsHJEjqrO39MMRVj/0
         TINsT2RrrC87Hojsxpv8lXSZUxnKLaXADzMIql8BzUKYVMHBW3alRXgEm202KpDUsD6A
         dIpEfIHaPccO0ykFmVZjwsMlqfYE/SIjBQetUZ2uc80FzFh0vFO2m0/Fr0nffJUb4evV
         8HdlZby+jQzxMpLQB8qx0P2fFNIUZtKIdbF6aAnjpi3J6joXuvj1uiCXEZQkRaEBFQIT
         n6WcqcUcyGr8raM5DkDThi5/9UunziijYe/XHK7nuUBKfyVwUuoNHDgRNoJviHlPg2gN
         /opA==
X-Gm-Message-State: AOAM530EmnYoa8eivsDcCf5pvciaCYiD1QISeuVqsIIjxsXcZ8UHCezb
        aQxnau9wIRhC4I5mEiSySf39lQ==
X-Google-Smtp-Source: ABdhPJxYWfaYuUfmsuYBP9tAVt7Q9FdYPOiskmz/BKG5SMVEEro5fUdapj1n24fWgg8kEKZu+KWh/g==
X-Received: by 2002:a17:90b:3a90:b0:1d1:7733:a6a2 with SMTP id om16-20020a17090b3a9000b001d17733a6a2mr17042453pjb.79.1650320055731;
        Mon, 18 Apr 2022 15:14:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b0050a4b5cf892sm10676304pfo.60.2022.04.18.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:14:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:14:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204181512.DA0C0C6EBD@keescook>
References: <20220418211559.3832724-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418211559.3832724-1-mka@chromium.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[oops, resending to actual CC list]

On Mon, Apr 18, 2022 at 02:15:56PM -0700, Matthias Kaehlcke wrote:
> This series extends LoadPin to allow loading of kernel files
> from trusted dm-verity devices. It adds the concept of
> trusted verity devices to LoadPin. Userspace can use the
> new systl file 'loadpin/trusted_verity_root_digests' to
> provide LoadPin with a list of root digests from dm-verity
> devices that LoadPin should consider as trusted. When a
> kernel file is read LoadPin first checks (as usual) whether
> the file is located on the pinned root, if so the file can
> be loaded. Otherwise, if the verity extension is enabled,
> LoadPin determines whether the file is located on a verity
> backed device and whether the root digest of that device
> is in the list of trusted digests. The file can be loaded
> if the verity device has a trusted root digest.
> 
> The list of trusted root digests can only be written once
> (typically at boot time), to limit the possiblity of
> attackers setting up rogue verity devices and marking them
> as trusted.

Hi,

Thanks for working all this out! Where does the list of trusted
roothashes come from? I assume some chain of trust exists. Is the list
maybe already stored on the rootfs?

It'd be nice if there was some way to pass the trust chain to LoadPin
more directly.

-Kees

-- 
Kees Cook
