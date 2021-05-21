Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291DC04FF3
	for <linux-security-module@archiver.kernel.org>; Fri, 21 May 2021 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66548613E1
	for <linux-security-module@archiver.kernel.org>; Fri, 21 May 2021 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhEUUVZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 May 2021 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhEUUVM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 May 2021 16:21:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3293AC0613ED
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so32215961ejy.7
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=aG3bBjgVeg6slH6NXO/4ixHXPGXGELFb98HmduPBE+sk25y//o2bRRKcaARiDg1p7r
         Ozu6MToPEGXm2IsakqX3NYJXJMtB2pgtfkj0HRlt/O3XV6FPK+ZmafBVMw397fb3siBV
         Ym6c6OhgQ/BbBPgcaUrSg/ObB813tXqU6lqYivpVGYTSEyEAHMHc+9ExoYvMQSqhYrcp
         qObmfIZLSwbX29/TiIs9l7krP5U/BWdae6GVoJKcyPw1I+PrcjPYoDRf4JWY0JWBa5z2
         ArQYV3pvf/0S/Vh55fioWORYr/OIioK3LtSKT9AZIiY9Sd3ggrtQ9uqaKsfmhj95+znj
         hpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=gTSeZ6d7gSjvBcqlStdrU/YKEjTTwlqDsRmIqow0RbqI9sb+QFSRUiYm80Lgt6uuAe
         jUnnCjtPBtlC2iTwoFJDWewt3nnY6LVa7MmivkTZYTByAjr3oj1EtZBMSIbq/SknKpK8
         5DnhP/xh4uE4rp0/3se3J5kzgmU3PkKc16S2u3MpuKXYsL1rvD+0QKqx/UZNixHr0iCT
         as/nMqP+U7fNha+bQLyt+hLoF+6O29s3FEsh06lt4UzLe96qFEN4dsfeYtdoJNNr+MKt
         aHt10fVu+wVxa1w2sId1JbsWcQHG+Qmf1XChHVcLPJL3kqmlGImvdvE2tftrWsjmAOEq
         hyzw==
X-Gm-Message-State: AOAM530G5bxBvRCM6jSYEQc28sEJZzH6p+boki7C4tyWh+g06v1a4lKu
        9AwfX8MFvqQvCPlTkN0q9L3MouhMQ/h+Y8A2SHxY
X-Google-Smtp-Source: ABdhPJz6RI+DFTaAZKp1yYFkI36BapBPZgGOSGg8oZyqUJOh8WRI4wf9Oyp08Zz6Th80x+gDaI37+ox3yh/PXrCSCRM=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr12367624ejc.178.1621628377771;
 Fri, 21 May 2021 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-22-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-22-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:19:26 -0400
Message-ID: <CAHC9VhSmAUg-mVrHpmgr3bF_+MeFd3p6W9N3b_kptzEY5YrsiA@mail.gmail.com>
Subject: Re: [PATCH v26 21/25] audit: add support for non-syscall auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 4:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> To: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)

At some point I suspect we will need to add filtering for these
"local" records, but that is a problem for another day.

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
