Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF5C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Sep 2021 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC196154B
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Sep 2021 19:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhI2TVP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbhI2TVO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Sep 2021 15:21:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E3C06161C
        for <linux-security-module@vger.kernel.org>; Wed, 29 Sep 2021 12:19:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b26so12868406edt.0
        for <linux-security-module@vger.kernel.org>; Wed, 29 Sep 2021 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JMtOTrplDvFfeNYGyrJ/J6i2JTh/PixwMka1xBwXDXk=;
        b=g+mVIFzhjhtRHCRqkW9mWTlicacgsZPX0dE0hBUVwGbAqbtDGhrMCzDxPB5YlDAq2J
         gEpi/ET6eOOeSuhpVZULYgHCo6OpktnB5yCY321LD5n2SlidUzLRRWPr3+DvpKVGJBRO
         N6c6PLOp8+AYkC3dh8Z/U5bzhc9KO78TU/1/J0DMEIpnbXHASE1zVlZiwQASNClUX2/7
         fUqFxCccvSrZ0VBHGVqNDdSe+PsAI50a5vjssbHu/aqMP7Ju6H6zGkzMerja5cBn7Iq4
         IF+0vpDY8VZo4zvnYxHUdqp3jRguXyjfIBtextcBcskrAr3nAgNtSbM0gjL4ibexg6Hw
         1ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JMtOTrplDvFfeNYGyrJ/J6i2JTh/PixwMka1xBwXDXk=;
        b=1KgFXNh5s1m86LJoiF49cUp22bx7dlEkoD7H9gk5UBXpZpqcYKYiDRFu+F5wOWsXLA
         v1emI5tyYHFMLNvKPhJX33xTZVxpWt+P5nqaDRf9eNGIVwkG//hWi6jkTrsEPyxuWt4w
         E55ctc4OneDc+KbZO3fPBEfAt/xdkYRYuNpcVEheedgE6vuMywh21kP3hTFhdYX8YDwc
         XZ34Snvxf/aG9mAzhwXbE1dZSdVGzuxMLh7HKyRJVTlnl4gRoXeSsJDc3i2vDjs7QDH/
         zaQJWDDLcOkRfJaDE16lopomSkdoj/7k7PDaPHXI2kCcw11Kgm8xwhlrBCD3EIJzK8Vf
         WV8g==
X-Gm-Message-State: AOAM532x8w0LGxCoU6URLFhoKpd96dOkA+yZiLB18aXuiv5qStY01w1j
        qG0nQR0qWHth+KyB7eczcLPxo7na+6/+qk3nzfAFPd7bEA==
X-Google-Smtp-Source: ABdhPJx3cpmGhALXBTZIpW26/jyXlQ1paVrzbkRsVfmfNguooKFe00gnVDUhCPlU7yRwHlsqjbEVMF634hH7HjphquE=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr1750058ejc.69.1632943171484;
 Wed, 29 Sep 2021 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly>
In-Reply-To: <163294304032.208242.9097581875096098591.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Sep 2021 15:19:20 -0400
Message-ID: <CAHC9VhSbBCtb72b+kCDJsC9vF=m+zjQ-pfqqe+2jE==4boQqaw@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The security_task_getsecid_subj() LSM hook invites misuse by allowing
> callers to specify a task even though the hook is only safe when the
> current task is referenced.  Fix this by removing the task_struct
> argument to the hook, requiring LSM implementations to use the
> current task.  While we are changing the hook declaration we also
> rename the function to security_current_getsecid_subj() in an effort
> to reinforce that the hook captures the subjective credentials of the
> current task and not an arbitrary task on the system.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h         |    3 +--
>  include/linux/lsm_hooks.h             |    8 +++-----
>  include/linux/security.h              |    4 ++--
>  kernel/audit.c                        |    4 ++--
>  kernel/auditfilter.c                  |    3 +--
>  kernel/auditsc.c                      |   10 +++++++++-
>  net/netlabel/netlabel_unlabeled.c     |    2 +-
>  net/netlabel/netlabel_user.h          |    2 +-
>  security/apparmor/lsm.c               |   13 ++++++++++---
>  security/integrity/ima/ima_appraise.c |    2 +-
>  security/integrity/ima/ima_main.c     |   14 +++++++-------
>  security/security.c                   |    6 +++---
>  security/selinux/hooks.c              |   19 +++----------------
>  security/smack/smack.h                |   16 ----------------
>  security/smack/smack_lsm.c            |    9 ++++-----
>  15 files changed, 48 insertions(+), 67 deletions(-)

FYI, this patch is based on v5.15-rc3 as it needs the LSM subj/obj
credential fix present in the v5.15-rcX releases.  Applying it on top
of previous releases will result in compilation errors.

-- 
paul moore
www.paul-moore.com
