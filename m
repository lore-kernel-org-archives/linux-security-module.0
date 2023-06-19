Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE44EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 20:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjFSUCe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFSUCd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 16:02:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E3E6F
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55e40fac2faso1126186eaf.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=MxTzKEpPsN8E1NeSqfonHti4awTgTuvYy/mjO/bv/gu0ZMswT+k+ao1q6z9qPCW3cM
         WJpRDOV7jEzMIa0r4uhzpy/DMPB1zGlduIulz1ULfbZHPRsgpcGJntCIh68zl1788SGC
         qiAIo2P7Ur3swlE7KWCdMSObPW8t8yt3WzFzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=QXo9uwWEV6DSeYYsGL7r2d7pHdkAE4F3Ig2pYAABQDBFZZySUXd/2MBD9+xY2gaTZZ
         C9QVjphw0wNwkj4sPoysRSo/fLVGRmG1SZgAOnIfJYTXnboCVu71o6aALVa7lkjFeR4p
         8xXnr9gJRV4j1ISoYa8NryEr8zUfK7wVVgIVsX+fKgsYt06unCG2SNWQS735+nWo8vE9
         bsbcc3C3G0s06q7D3VYIrX37Rbr13JAMDdURg5wVTtLr4P4JgFlJLoDonx/H5taglitb
         17p5K+hgZ4a9XtdcfUrCU7qf576tgvPASP/r+m0EKpB6ltezOoN61VSExLDa+PUBKQ1S
         yfcA==
X-Gm-Message-State: AC+VfDynO1+G9qmJV6GUmGJru3APJ/yXyKl5xD285QDJlzfSH2yW6xkZ
        fz1MdZc+eh/xS7mBy53nffROzw==
X-Google-Smtp-Source: ACHHUZ4ZoxYuE6uFoU/9PanoiRvxpOUmQpxKPvt3v0x/+zQ3f49YW8hcYed3sSmYg5qTbN8rRKCtIg==
X-Received: by 2002:aca:220d:0:b0:39a:afc3:bdf1 with SMTP id b13-20020aca220d000000b0039aafc3bdf1mr11532542oic.48.1687204950862;
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a63e342000000b0053fb37fb626sm88386pgj.43.2023.06.19.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:02:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <202306191302.94F212CD@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-8-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 16, 2023 at 09:50:51AM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
