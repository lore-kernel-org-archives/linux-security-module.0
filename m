Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56954C0015E
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Aug 2023 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjHOUFA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Aug 2023 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjHOUEg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Aug 2023 16:04:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9119A7
        for <linux-security-module@vger.kernel.org>; Tue, 15 Aug 2023 13:04:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7658430eb5dso512770085a.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Aug 2023 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692129874; x=1692734674;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxBcBZ5izURGaV85QiqkgIIt0uW9MKUgeI/7gZxjeAM=;
        b=Hs1LdeO1bMOezQQmtOJh4tQ8RppcJpDww1RyECA+NBNbh+o67S+EX0IhWuS6XFliIu
         ox+a7W+tiPavrDH0nDeSdzK76OZpoDVgGRBLPJlqL6Az4NNnijixjG5QWQmeg2vCic/1
         uU96PJV67hQT6O4vuQjJ4Y1GoLBaK9CfVI4UXx2140pVO8nkpoRd36r8q2icXyXObkdr
         Jljk+lfVg/mmxu1XwvccHXcWcY0ZOfQgJTHvBzGZRap7YW3CQ0WwrdMuVTfMFY6Q1cCd
         OPSn2MiTOWFtJK6eGbXQFQ22+ZyemAPucn01UIRjcX8QxIXUo8eWrineAmhLa4kRseEL
         2OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692129874; x=1692734674;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxBcBZ5izURGaV85QiqkgIIt0uW9MKUgeI/7gZxjeAM=;
        b=Tf2+NMgfX+3acqcr8VkQhtK58WiyJwAb3eWcqzOxGoE6vt09oq5lF0ddlUyE9/rAbb
         NXrWy9rAwLx1M/EkI3TqAPY5lcMG0U3LXOeTUQJBdHTafH5Xx+fX3QBIGeQN9c2lVf4E
         WfHB3P0RaMbm5yi3sgs4wdsD9fG1ErDoj0P5RwBPhi07iil2JZLMpH6mOivXBlBh4eiD
         wAS04xtODO2pEYuWadAQGllKsNR0mykuO1hYFBymmTorc57OIA/RkDL9D1XuajFQSNuz
         ETUMOFFgH7LWBuDL6uDImmlqtggIOMxwyCVQ1q7+IA+b4kjoSMS3ke/udwWf46Ns2yz4
         vqQQ==
X-Gm-Message-State: AOJu0YypWf+EWRRHq3mcEoVLVkoThV80GqKPMuyVVZdBa+Yit+82tkN8
        FmeO9jgH6KoG6ClrNhwn376L
X-Google-Smtp-Source: AGHT+IGXKkLXbf2kSy5nxFQoOTgiIrJcf4VQzgmwi7i6SkA7G7K2scNqrhMtLFn0vi6s58wg05XIxg==
X-Received: by 2002:a05:620a:240a:b0:765:a77c:7219 with SMTP id d10-20020a05620a240a00b00765a77c7219mr19235159qkn.0.1692129874156;
        Tue, 15 Aug 2023 13:04:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8468d000000b004033c3948f9sm4016624qto.42.2023.08.15.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:04:33 -0700 (PDT)
Date:   Tue, 15 Aug 2023 16:04:33 -0400
Message-ID: <80c3c2b488a603da62a0fd15201dec0b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH] lsm: constify the 'file' parameter in  security_binder_transfer_file()
References: <ZNelvBCFG7wZt24g@gmail.com>
In-Reply-To: <ZNelvBCFG7wZt24g@gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Aug 12, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> SELinux registers the implementation for the "binder_transfer_file"
> hook. Looking at the function implementation we observe that the
> parameter "file" is not changing.
> 
> Mark the "file" parameter of LSM hook security_binder_transfer_file() as
> "const" since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 8 ++++----
>  4 files changed, 8 insertions(+), 8 deletions(-)

Looks good to me, merged into lsm/next, thanks!

--
paul-moore.com
