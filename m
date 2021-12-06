Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E2C433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Dec 2021 02:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhLFCrJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhLFCrI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Dec 2021 21:47:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C702C061359
        for <linux-security-module@vger.kernel.org>; Sun,  5 Dec 2021 18:43:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t5so36865384edd.0
        for <linux-security-module@vger.kernel.org>; Sun, 05 Dec 2021 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymd6P5lILm8kCnpIAJpyY3MsDDsYTeqTIxl8Yef5YWE=;
        b=2kbZxWStBRfrT81SzE2HO3kF9ABLfHYL5BL3VYUs6WwWLjmIDonJdWwwSJ9a0FvgR7
         hHRmvcq5ouCeg94MAMPJaHwsVNINcmhY2+ZqsiMQpJZo5reyI+DDzmzM9MauDkiiYvtr
         v7M/5wqBN8XVpod5/DwNhhFA6zy8xjJL5b5QSgbzR/FKNyLtCKjRwhm9PAm+6rqUIrK4
         Y8STUO1xfj0nt+F9BpY0n1I6XFzf6itjiN53dg3KSj3chasVh48UWyjDBJ2HyutQ2vCe
         vT4UrdgFcjdr6YP+oL4Dugb3Uo18z5zmJHqTj6aL/LtYKoUL/DALbbHT1XQhpZ/LeNt+
         X6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymd6P5lILm8kCnpIAJpyY3MsDDsYTeqTIxl8Yef5YWE=;
        b=pM0Epfow1IAaigedIP12ESehh4+V+IoPyDeLZQjFYly2UbcPUawYLs995m8SfsASmx
         Kh8wUJnMflpmyQaSPqolSI8YacQwo5sq3e3//nwWE2ki4iBdETgafaK7fGEKrc+9rjVq
         PRO+P0+fPNlxjFZ3sNvxTmJmzAbDuVvWtubM5Y4NSyJYESZ0aWCaO6xlzGNngohrbEot
         cHgJ6ynPxyqytl7Do9awohi4Z7f1Mge/GuFj3wFDiCPRSmy2iO/o7ov8XKjWerqBlxi6
         VRttY8+ZiqX12GwTneeeD2SqYdhYx986qnsa8ByX4W6ylZXRFqCQNBdXxndmsy0PGmkb
         1OMQ==
X-Gm-Message-State: AOAM532rz7Hogi3le80gpUR7pFn18X/zXNxHr6eJOgU2P3hNEFX86aEm
        QiOZ+nBdoKeGookx7Eaw6hoU0Bf+fSx0p8C3+S5z0/XM6Q==
X-Google-Smtp-Source: ABdhPJx69ThSSJXqiAFgrgGcClluUyTxJgmFaPaaQ09XYzcsxYERZ20FcG40EB3q9kgHLNGQC2XObsEZv7oJQWgCako=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr41876657ejc.126.1638758618582;
 Sun, 05 Dec 2021 18:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-2-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-2-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:43:27 -0500
Message-ID: <CAHC9VhRSnxf2S=Re8etrDnBqEkRemFwA0F9THK9FNeV3edLXfg@mail.gmail.com>
Subject: Re: [PATCH v30 01/28] integrity: disassociate ima_filter_rule from security_audit_rule
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 23, 2021 at 8:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new fuctions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     | 26 ++++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 47 insertions(+), 26 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> # audit


--
paul moore
www.paul-moore.com
