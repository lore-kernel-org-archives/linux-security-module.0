Return-Path: <SRS0=t07G=C2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F09CC43464
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C4420838
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 23:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0ZFhCZ1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIQXQZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 19:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQXQZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 19:16:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D58C06174A
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 16:16:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so5511888ejb.12
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJGw9Ip9s8kfLfRW8uaiYRslvSC0oKoTfTsXs1hgUOg=;
        b=0ZFhCZ1f7A8KQAHT47UYHLerak4RLebvoKeI/USWgkNzfwtUiN5MxsFKw2rf+Sa1rJ
         YMxTW+0K6npYVuXbe2tNYhfbexb/E0FWWJWmLtUVvOgKHqpJ0BT/AY9NxTaWrUGI3Cxn
         8qnes04L+ALbwKr68rD3fT81wCeb3kWu3XE/nPqZYvG9I7Y6ch5nHKjMbzZOFsBjq8VP
         EWszMimXMMYAU0bcjGDUOHOPOY6euwJNrWWOEtzCOPuNzemoDxQ5tn5sBugpxL2X0hWp
         RAvcDu3zcPhCgh2h8Yp3dG8VXYk//XsQ2D+9igHLjMQhwc5A/mFWBDraKx19pNOo9NZ5
         tXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJGw9Ip9s8kfLfRW8uaiYRslvSC0oKoTfTsXs1hgUOg=;
        b=NLM29uZESi/cjmri9dlP8Lk1OtMMO5oJCGhx8wEEI8WR4zXsIdmR9/m/bD2vjHS5UI
         GsGub9C5N22y/0zCTHEWoRCJXZKHLHbGc+uJGC7jNUPk2nPY2inNgaV6ZSWIBNtbmn5B
         QrP8xzjC+WwyWgTveRiDlADOC5tUn2/0W9uu48rd/pESfuBZubJjTJ7wGvEKGrWw+z7E
         zCris5StM1zzmu9nUDFcFZtCSb+ILTevuNr9PyTHCCokzAFRxIiTyTGqzW2eHC80M3wU
         BP3PYJndcb68xyLJzQS//AdW2MyFTTz+mx/NFg9hnNiiJA+oVmpM6cPA6Hoosg2VENR9
         BEJw==
X-Gm-Message-State: AOAM530UnYFQMYDLl5dn2Z8+x16miZT4fnLzt3+hGQjkg6egPEhVzxEV
        qpYpW7yKUcBJV7+R4MGpdn+fV6mJA7pOtyON0aYt
X-Google-Smtp-Source: ABdhPJxaLm/9H1fV+azAHf7j1P5F3UCgxuYNs3M6qzzFfqkOIvAc6tC+Bxlb37TUxvOXGvJ8OV5DfT+LQlmpAE5Irdw=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr16036046eja.488.1600384583416;
 Thu, 17 Sep 2020 16:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200917173143.57241-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200917173143.57241-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Sep 2020 19:16:12 -0400
Message-ID: <CAHC9VhQchXj6yHSTHgB_4wrk+dadz=KCg05pxYhX21_y1n82QA@mail.gmail.com>
Subject: Re: [PATCH] ip.7: Document IP_PASSSEC for UDP sockets
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        smcv@collabora.com, James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 17, 2020 at 1:31 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Document the IP_PASSSEC socket option and SCM_SECURITY
> ancillary/control message type for UDP sockets.
>
> IP_PASSSEC for UDP sockets was introduced in Linux 2.6.17 [1].
>
> Example NetLabel and IPSEC configurations and usage of this option
> can be found in the SELinux Notebook [2] and SELinux testsuite [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2c7946a7bf45ae86736ab3b43d0085e43947945c
>
> [2] https://github.com/SELinuxProject/selinux-notebook
>
> [3] https://github.com/SELinuxProject/selinux-testsuite
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  man7/ip.7 | 48 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)

Thanks for including the note about the SCM_SECURITY/IP_HDRINCL
conflict.  I figure it's probably not the best for another SELinux
person to ACK this, but I will mark it as "reviewed".

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
