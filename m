Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0586DC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 03:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiKJDSH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 22:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKJDSF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 22:18:05 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906842D1F3
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 19:18:04 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id r10-20020a4aa2ca000000b0049dd7ad4128so93366ool.13
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 19:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui4nz+rk4+cy7iX09mK3SZJkU54S/hpyEMWrZ+RjI2M=;
        b=eC+RoKfhId/DMoP2yqdKWn4KQDV/bHSjRCDt/kWA5xOVi5nb2pPkI4mlgslo1JNknx
         Tbc3SQ7t4elqvdUA3nUUCKvQbTL7ks+AB1IJ5XhKa2/de9c1Udet2zrq/4jLZG7GTcyo
         qTJd5hnqSuyrRaevhIkhNKvsdvsYMK4tChfEz0tiplUuDiC5uC04CxKrOxSGi0hN2o+4
         CO0OjAnj9tnmtB5qAC9vFShPdrrfEgCzNnfwl/zNEBCkbuZ9vTypUAhuhzEGgjMN41/b
         UI8hKSlDuk0oJLzFvXx2H4VG88DRFWuETaRueen5S0NSNB5HmirGKvFdgsSm1yQjpbQW
         TSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui4nz+rk4+cy7iX09mK3SZJkU54S/hpyEMWrZ+RjI2M=;
        b=ctD16RRNxUbhkwY74LT5qv6VYXiVrZGuC5P40EewnW+blehI4VwditChxoabdqPC7L
         UyVTOrrDn/kyu2YkP2u/JvOCmoeM5RNuaYd5UZYerlpesnekJMEzGsY1bmPbKJXHIYtY
         L0WxR7Yv1caqB1sx403OdhYn/Ss90UhyUIIpH+jFIKhfBkJGgsS5OoKiN4PA/R2iWJYe
         fs3ka3/XnKOFtJw8WUWg0G03P8n62j2fTq3WCSGpIyN/AQpneJmOt2DpIXxK94LwKKID
         pcaY9JueSRpav/iYDfIsxVy5ZDFFYz1qS7Q4yJK+RmaGtbr0rBBoozLVOTurjraapYQP
         jpHw==
X-Gm-Message-State: ANoB5pmXOv+LUHE9EqDJ8rsd0vCLFHRwuCAK+GSJieg7JI77Ro6x9grG
        6htn2d65waWNBI/ARLP2C3Cagzh6Ke+mS8l5HXuP
X-Google-Smtp-Source: AA0mqf4jNyWHNPdiVFcHIrPF0+v2AoEgmnjHvVUr776+Z6yoxo2tMWAfX7sFLgPjynd2YPyaEA2X+YXWw2y/wJe591Q=
X-Received: by 2002:a4a:ca8f:0:b0:49e:f01a:feaf with SMTP id
 x15-20020a4aca8f000000b0049ef01afeafmr7560680ooq.81.1668050283850; Wed, 09
 Nov 2022 19:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-8-casey@schaufler-ca.com> <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
 <ea927e49-0099-df0a-d263-400782486b35@schaufler-ca.com>
In-Reply-To: <ea927e49-0099-df0a-d263-400782486b35@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 22:17:52 -0500
Message-ID: <CAHC9VhQMfAix=KqpWGNg_2cryBJHyiFTzURQ1YuD_0SY92ZHsA@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:35 PM, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call to report the list of Linux Security Modules
> >> that are active on the system. The list is provided as an array
> >> of LSM ID numbers.
> >>
> >> The calling application can use this list determine what LSM
> >> specific actions it might take. That might include chosing an
> >> output format, determining required privilege or bypassing
> >> security module specific behavior.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/syscalls.h |  1 +
> >>  kernel/sys_ni.c          |  1 +
> >>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 40 insertions(+)
> > ..
> >
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> index da0fab7065e2..cd5db370b974 100644
> >> --- a/security/lsm_syscalls.c
> >> +++ b/security/lsm_syscalls.c
> >> @@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
> >>         kfree(final);
> >>         return rc;
> >>  }
> >> +
> >> +/**
> >> + * lsm_module_list - Return a list of the active security modules
> >> + * @ids: the LSM module ids
> >> + * @size: size of @ids, updated on return
> >> + * @flags: reserved for future use, must be zero
> >> + *
> >> + * Returns a list of the active LSM ids. On success this function
> >> + * returns the number of @ids array elements. This value may be zero
> >> + * if there are no LSMs active. If @size is insufficient to contain
> >> + * the return data -E2BIG is returned and @size is set to the minimum
> >> + * required size. In all other cases a negative value indicating the
> >> + * error is returned.
> >> + */
> > Let's make a promise that for this syscall we will order the LSM IDs
> > in the array in the same order as which they are configured/executed.
>
> Sure. Order registered, which can vary, as opposed to LSM ID order,
> which cannot. That could be important to ensure that applications
> that enforce the same policy as the kernel will hit the checks in
> the same order as the kernel. That's how it is coded. It needs to
> be documented.

Yep.  One of the big reasons for documenting it this way is to ensure
that we define the order as part of the API.

-- 
paul-moore.com
