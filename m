Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EEEC43334
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jun 2022 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiFJVG3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbiFJVG0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jun 2022 17:06:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03F9255B9
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 14:06:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so515102pjq.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVhfbIukOKEVFvNF87H3xskC9Oa1vruUMas0TKGSYm0=;
        b=nUaBKVT5J8mwmiDpTKFhYMr5X6B97KvxMCWwwWjCo69v2K9ZvUkTEC5pE8DyMQG1mU
         JNFVAkbelc/drapO000q+0h0xtP5KanI5Z1wF+j0iYcWFcmL66vgbkyZsfMb0xV14Wrz
         n9YCGn9EmO0MoppPxe9cAtWTqQpvKEf9rTAcXycm8s/y2L5sMuXmXX9WI7n5pMD2V9DL
         pOw5uJ6CSSBSiiZKbwLOvzafe3tnkgR9ohmxQ/04zaTeiGXbFUxahNfU9xiBU7tQHqhv
         eR6ZN6RiS0RuxU8DIaPHvmJE/3xCM9nDZN4SQuRvqmMCezf/4MOxVabPuhq4m477txoq
         h3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVhfbIukOKEVFvNF87H3xskC9Oa1vruUMas0TKGSYm0=;
        b=BVnng2rZfxSwK8EPN0EYq+6BY1hpKhb24SaPM2/s0rmMCGPudm0k3WW4v+9CTpXTvV
         ACdkOblt0MC/KYnIITLgvsi2eh0AvGQxOrTpIlcM5WhG2a6vBEOhAnUhoaPGfQ97yBxU
         24KVf8aR1lz2QHUMA/13gEpunTMR4ThdUeEkseKHwi5Mcn7gje6LWLecc0In2DskVF9E
         n1vKpWlSvw/gTLfDYGOXJqEqE9KFq8W143bCdMMVmHKC5WyJVk3XnhebHgFL9sKNt4I2
         BZ3i1wrc4GhRhWmFd+gSizGPdLWlVjxA+S3mYhLVF77kqsepT17jDX7hdlZyAKBy4j/d
         AlSA==
X-Gm-Message-State: AOAM5320H1oGolfzm2AWWmyeagjXFFquTiTyBJDyHV0kL3sqSJR3zLTR
        Q8j64MKLb2J9/Z+Wu2ED5Ax0ZyzDY7cD48xF5a4A
X-Google-Smtp-Source: ABdhPJzIMHgsZ4tZhpk9aRuapm/Sl7e4TCz9bkJJUYRDpM0VclwMSgMCBCsHtkFgTHE9/eqfYCAPhNwufAxTaQy/2io=
X-Received: by 2002:a17:902:f54b:b0:163:e2fd:10a5 with SMTP id
 h11-20020a170902f54b00b00163e2fd10a5mr47483065plf.28.1654895184250; Fri, 10
 Jun 2022 14:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-28-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-28-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:06:13 -0400
Message-ID: <CAHC9VhR4xUpe4fQrUqvUfH_zaBSzfCS2yZ62XHN2+ugKg=Kd4g@mail.gmail.com>
Subject: Re: [PATCH v36 27/33] Audit: Add record for multiple task security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 9, 2022 at 7:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1420) record is:
>
>     type=MAC_TASK_CONTEXTS[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
>
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 42 +++++++++++++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
