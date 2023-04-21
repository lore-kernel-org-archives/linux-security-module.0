Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D010C7618E
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Apr 2023 19:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjDUTio (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjDUTin (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Apr 2023 15:38:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B52719
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b603bb360so2499734a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682105921; x=1684697921;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PxXQ+D8Pkaph99A6al2RDXs7bG5gkRFhfZgwGF4wYvE=;
        b=GiMmLe1sjlCmCoc1pgVNOWYWw8FvBNlPV622rv+M0T5Tlf34uZLwu3sJYsAve8IU+i
         k8QzRcpkjwzHtVBIqqmR5egwBT+Z4DeCzoPxOX3M9mn2rsKiRbxVXV2e5jpyEWwb7E/J
         Iu6liw05mPoh1QoaPJE5E1co2ET6dCkracvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105921; x=1684697921;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxXQ+D8Pkaph99A6al2RDXs7bG5gkRFhfZgwGF4wYvE=;
        b=N0i3sEx7L5PxC5mmVH0UiNShsYmgDFovP5RezAmJgPI7P31/A1LTYJWn875rbNMvqk
         S3En/RaOf/aXlgwPUTjfVH435cbA8yWFgKeGQSHX6Q5r5fKMc3nn07mOkFNkcIEX3jup
         lpGRGpuT9gftl+zui+tZDm4OLBbv34t2ZFb7E7YdS2VxpWNtOMXJ4rSq9fV4N/gFnYLk
         JapkegY0DM8zsVDgKU04RM4s7w0GdbEl7PiYdwlzrLHVAYAPvrQLDiUKeLAF03UMh4oD
         gLOvYBWytxy54IluGyXYtE7e8wESssFALzQFnNyu18VtCG0vh/O7rqgXv/CSnZj1KMpl
         cqPg==
X-Gm-Message-State: AAQBX9f/luhOQnVqjX5cb2P1AyoDG34iroWTEAFHikDugJobWDL5KNVP
        dMQwrMgEox4m1lj/ec1tSevjBA==
X-Google-Smtp-Source: AKy350bT27YPbLT0jehhGpZQfIuRO27PeJRL1FZAIZKkOtlY3DgAtQDG+XFh640pJIVkRMqwCU7AcA==
X-Received: by 2002:a17:903:120d:b0:1a6:9289:6b with SMTP id l13-20020a170903120d00b001a69289006bmr6979869plh.30.1682105921399;
        Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709027b8d00b0019edc1b421asm3061222pll.163.2023.04.21.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Message-ID: <6442e641.170a0220.1153c.6bb5@mx.google.com>
X-Google-Original-Message-ID: <202304211238.@keescook>
Date:   Fri, 21 Apr 2023 12:38:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 06/11] LSM: wireup Linux Security Module syscalls
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-7-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 21, 2023 at 10:42:54AM -0700, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
> system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
