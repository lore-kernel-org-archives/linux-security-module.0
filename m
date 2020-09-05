Return-Path: <SRS0=FBAC=CO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB8C43461
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Sep 2020 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A508A2072D
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Sep 2020 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kzz4iRAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgIENSs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIENSr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Sep 2020 09:18:47 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215FC061244
        for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2020 06:18:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l63so8546027edl.9
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2020 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WK7p3KEx2Y1obY9ifz2GCoN6MGqbfG7ZjSbn/axOcCo=;
        b=kzz4iRATCdwJ4eMCNcVVCyV1HeAuyVkxgdnyd2WFO6p7cLQtJ9Si7c1zlwT81Qtdqp
         WwTtTFVaaHkc7wyCOfh3bQt7OX+1xLmfCwHHJelHvhrZozYPnVo0ab1e1LDAURZgIzgz
         1bpjq333tCHqqG+gZkhd5g/kf9E6n8c7vn8cFqK3ADWT/Q3Yaq7Aw1cqdSuWDMOu4wml
         VyTEQNyL/jAIkIt1+rhrRkhltrPKYcIBe+eF2S3UyTmY7TnPBuhN+K0+w0r9gq/sL9Wk
         a9Ne6y6sLF81BYwOt8tVXUNlmGYLMuTU9F6TIqEe8PqXwofl6SDsM/EbW+ax/MePhfMK
         Rdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WK7p3KEx2Y1obY9ifz2GCoN6MGqbfG7ZjSbn/axOcCo=;
        b=gua30THUbTqiVdpuBOyNKPTSE3ymSkvC2CxJsnrxg4CWvHSHKc9rZgvTNX5mmoxDBV
         RCEM+8bfdYA1JaidPDMIVGHnNYJK6cUJHvEXcPsd0HyGhecIUgUr2pbU+TsvIAuMN8IQ
         KGI1A1h0XQ/JBKN5ejjYR5dSSJiw76TiKGr5S9Iv1YYMoZIz1JQwchD0d3IVP/9g/Mt9
         rZCbYzlUQ23pMXkws1fVjkmf4GAspHMoXB7TxUXRwYP/1192WlTeXaai6I3/tw/p4raT
         Y+jp4TgO33VTWqKlPxBI+KQYLOoVkFAqCQkx0K1n18vBfcmRx/mp4v9fiyfoF6JHwWlk
         boDA==
X-Gm-Message-State: AOAM530KOq025cusVcXAhgrJ3H+677R1fTzDPmUzlzkcFYQR/Z1hSp8h
        3nr1B4aax0fq4RhkWxfpt4+0FFTVPSrRjoVB9Thw
X-Google-Smtp-Source: ABdhPJxuCv/2FKUD/4jcrASP1SzCOIc0XcI66J4vGjkUKFwbMiBFGzI4zC9CaPzZEeto9qDHSvepG0dMKziKlEiXQKI=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr13327162edw.31.1599311925396;
 Sat, 05 Sep 2020 06:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-10-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-10-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:18:34 -0400
Message-ID: <CAHC9VhSsz+O28xAuVykhYq6L2XBC2gV+G-3A2AqiFzDY1_8Q6A@mail.gmail.com>
Subject: Re: [PATCH v20 09/23] LSM: Use lsmblob in security_task_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_task_getsecid() interface to fill in
> a lsmblob structure instead of a u32 secid in support of
> LSM stacking. Audit interfaces will need to collect all
> possible secids for possible reporting.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> ---
>  drivers/android/binder.c              | 12 +------
>  include/linux/security.h              |  7 ++--
>  kernel/audit.c                        | 16 ++++-----
>  kernel/auditfilter.c                  |  4 +--
>  kernel/auditsc.c                      | 25 +++++++-------
>  net/netlabel/netlabel_unlabeled.c     |  5 ++-
>  net/netlabel/netlabel_user.h          |  6 +++-
>  security/integrity/ima/ima_appraise.c | 10 +++---
>  security/integrity/ima/ima_main.c     | 49 +++++++++++++++------------
>  security/security.c                   | 12 +++++--
>  10 files changed, 76 insertions(+), 70 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
