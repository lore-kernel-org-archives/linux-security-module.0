Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D441DC678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCBW4i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCBW4g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 17:56:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31210559D8
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 14:56:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so4402656pjh.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=cPNPEoDiS/HfsiIItPLGT3E2KS7Pa2nDCzgKjzoBCNTmF5ovdMVml+ppsm005Cz2gc
         pMD41ueS/rsqWBDjk0Ang+swrwWISO9NpTVI+XcAlfsXxlunEfDcOqSyRkjHfJ2N7W3M
         nXhJv2G01aF56hxwfL9a8N8s/N1YUs1FWh6Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=iR0k6rIkfNOXca/sCFZUpoGp/a+63c4eVKUkWlOzJbuHTjPwtK/knhsxEAcPmkcV7K
         PcK67SN2gCTJHGkiNcLqVcPPLkJUgP2BQ2X7fjcPYsukFHHo5kRL7THtCvH0pPb3wnQO
         oBsStV7KiucaFm/JOKeOYOevQ6APTBs8R+A/j1rszryBJ9LiBr2CZjq3n0FYDQHUYdd0
         yzc+5y7Ib9sXVhLqQPUWdaVGv80a7nhBB15bEkQP5dsL5GnSIkmb/SgEcWCCK9iHNR1A
         8KwWtNboiW0b3QpYsr3d4Eq+G+v/xnDpz+rfk/oKkJFmlIlGSTRzVfCnKT3eIuMuUqye
         gtTw==
X-Gm-Message-State: AO0yUKUtsglEueXb8pJo9WZXv2YxNUMMnlfLglxrDzoczNgQ0KcBJILA
        JQu+13DH5uVfHnEuYmUnTDE5Fg==
X-Google-Smtp-Source: AK7set+MdZhHyeith+B94HrQd6WpkfpBD5XCV21gXOzsSKhUw+dB78RFefTe7N6XbvDbdrdQDA//KA==
X-Received: by 2002:a17:902:ec88:b0:19a:e762:a1af with SMTP id x8-20020a170902ec8800b0019ae762a1afmr3404427plg.33.1677797788585;
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b00198d7b52eefsm168326plh.257.2023.03.02.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Message-ID: <6401299c.170a0220.3a2e.0b8a@mx.google.com>
X-Google-Original-Message-ID: <202303021456.@keescook>
Date:   Thu, 2 Mar 2023 14:56:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org,
        j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] seccomp: simplify sysctls with
 register_sysctl_init()
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-8-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 02, 2023 at 12:28:22PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is only needed if you have childs (directories)
> with entries. Just use register_sysctl_init() as it also does the
> kmemleak check for you.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
