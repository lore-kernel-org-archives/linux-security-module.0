Return-Path: <SRS0=mt4R=CN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A19DC433E2
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3653206B7
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Rn0xA98t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIDSx5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIDSx4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Sep 2020 14:53:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A071C061245
        for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2020 11:53:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g6so3462804pjl.0
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2020 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0EdNA6QqIRV7z2Jdp5B7kGzED4Dd6lXmJioCdLGMho=;
        b=Rn0xA98tLfMfoCKeJ2h/KHMOI6v+CnTBiEwiE/btIxIlOhpAarSGm6Srx0HJklSxao
         wrgrD6QaSLH/kKBEHiLyrZBWXOt7AY1q+q5LrSg8stGLRdaA8vdVXWBjijuDFX0p7Ivr
         uLrAwLY7JCnhHoXEH8EfLPiznYk4/iLaoJbXt0k8mTx/x9etmIAym9hwWW5pA8F0rsNk
         lK/xRQtDse4QUHyqoAizt7jnnPGUuBbGW7W4XSN40mI5o/C17qGhbF0W2VnM1Fad0XdR
         MvIc5EaA7zxe0h0e1d+g1djZY78b7V5u3aNesKt0ecccJmIxQTcTgx05uVwOd95ODSy3
         ASKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0EdNA6QqIRV7z2Jdp5B7kGzED4Dd6lXmJioCdLGMho=;
        b=Dhn2lwqmmD/9C8eeCFYv7K26dyG1sG0qPXRmIoCWmrThZnfl6EsVqHEJKUmgV5SaAj
         mVjXBNpnmzTMeHeMAXKSrcaWOJxJO6XaOPI75ikQMkpouJIxUOiT122eluu4HEhcXBDh
         CtBujhlaBJLDgRhi6tyhaduK7DarbQtVSk1uO+5D0sjeW4/M+7K8lqLdqulc0epDbrF3
         Fac/RT1+3RgbT7p1jDyfxlsWigbnVvs/AhBjN+NJ0c0lfq2Ypt39ANCNWk5zvpHzG1vA
         9mg8iL/tfMDDwQZRbQl8/q9RmuLdlSIXJMzVhVQ/1Gmmt8TjBLmXQgurffF/VcK3zfqj
         fheA==
X-Gm-Message-State: AOAM530vXJnlSS25zXYfyF4DSoLoMfKuKBaMCptiRHab+zHONAP6aM8D
        qWmTNLUCngums5IztyAq58WNm18bT/FXNCrns3IZ
X-Google-Smtp-Source: ABdhPJyM9O0la6AoFSfY0FtgHcG7DxhFxvh9tdrS0BKPzORvKYAQm06i1OFQLZrxVd5kaPq97I37Cbphesx4sQLi/2M=
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr3393806plr.24.1599245634561;
 Fri, 04 Sep 2020 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-4-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 14:53:43 -0400
Message-ID: <CAHC9VhSe18hJMcjma4kDLPzo2MmiWYk2FY5+EfYiDUX5FmTyrg@mail.gmail.com>
Subject: Re: [PATCH v20 03/23] LSM: Use lsmblob in security_audit_rule_match
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:04 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
>
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. The scaffolding function lsmblob_init()
> fills the blob with the value of the old secid, ensuring that
> it is available to the appropriate module hook. The sources of
> the secid, security_task_getsecid() and security_inode_getsecid(),
> will be converted to use the blob structure later in the series.
> At the point the use of lsmblob_init() is dropped.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditfilter.c                |  6 ++++--
>  kernel/auditsc.c                    | 14 ++++++++++----
>  security/integrity/ima/ima.h        |  4 ++--
>  security/integrity/ima/ima_policy.c |  7 +++++--
>  security/security.c                 | 10 ++++++++--
>  6 files changed, 33 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
