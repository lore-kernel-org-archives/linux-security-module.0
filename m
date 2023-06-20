Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B50EB64D7
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jun 2023 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFTVxq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTVxp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jun 2023 17:53:45 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394891739
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 14:53:45 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a28de15c8aso5246008fac.2
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687298023; x=1689890023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RwIKNQ/sDPYsUp9NuDpJUiZEp0xcKok6NHODtE8I9c=;
        b=WWw71WkF/DPp6D0SjQ27oPl+LRAmj1zPIne/kjytgtbV4rzR5V/z1w7m96lm7hQjCe
         zBK4mcTGTbF+sVmhCSUScdV6bQPu5UFcT/FBYOG3Q3bSvNv7si+KmdRCsGQjb813V0A4
         8Pi97NKnfvJ+YVCfBYX3AQCFwbGa5MkqnoLIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298023; x=1689890023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RwIKNQ/sDPYsUp9NuDpJUiZEp0xcKok6NHODtE8I9c=;
        b=DaLac7c6mV5++H4yFbrQxWz9ycuEweVfQoT9YU7qKekQigjYJewEpqQ12xd702Yk76
         w2bVZpJd38kRapgcPof/lPB1wP0LUach2XkawpkpFKjc7GRjovv+T+Y2M0LbBEZJH1Oi
         S3jmC1egclVogyvsuXIQotuNxyKHUxwj/CJREGN1OS1YU7Imuk7GFzT6oEyL3RXM7OPo
         hg8fOpb81sf96jm6YX2vMNCERIvYF6+ISgnTs9CSGp468H/YUBnR20vxUxmVRBRpVGMr
         alqW2o4mInzS0E3p1XsftwuTiVE1YFjLDsSutlVuVIuI1+nxzUXtdnj2M3FxLsb6HXnY
         STOg==
X-Gm-Message-State: AC+VfDwHU6cFWZ9Rdq2dFmwEOxFSdBv8rasIoUBBXmUXW9YX3inOLZWC
        QwNV8mP2wP1/Y1/eoK0YbRGHjofLKHQJ6p9v5WQ=
X-Google-Smtp-Source: ACHHUZ4+K1t9bs+qIZsxYamDFjSpd6FoNM3t4NbbLejcLkWkDhPauqeB2BdJVQkRn97pIMlSeyDUNw==
X-Received: by 2002:a05:6870:5a8d:b0:1a0:bbee:c1d0 with SMTP id dt13-20020a0568705a8d00b001a0bbeec1d0mr10453257oab.42.1687298023735;
        Tue, 20 Jun 2023 14:53:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c49000000b0054fa8539681sm1822040pgm.34.2023.06.20.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:53:43 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:53:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Subject: Re: [PATCH v2 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202306201452.95107E750@keescook>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616000441.3677441-4-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 16, 2023 at 02:04:39AM +0200, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:

Overall, I find this a much cleaner patch compared to the v1 -- thanks
for cleaning up how the loops are replaced. I'm looking forward to v3
(with the build fixes and other comments addressed), as I think the
performance benefit this series provides is significant.

Thanks!

-Kees

-- 
Kees Cook
