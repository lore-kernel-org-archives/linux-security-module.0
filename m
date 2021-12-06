Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AFEC433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Dec 2021 18:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbhLFSwe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLFSw3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Dec 2021 13:52:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80126C0613F8
        for <linux-security-module@vger.kernel.org>; Mon,  6 Dec 2021 10:49:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o20so46987507eds.10
        for <linux-security-module@vger.kernel.org>; Mon, 06 Dec 2021 10:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFNd9y7zjP1MZt+ih91bQ58I7tOdLaR33IaqrsbckfE=;
        b=zYi/8H3h0HaydowF6DdzwRAt0sz/3H5Pq+cHBdGWCuTMKu7JSTORqS0A6zV3mPtJ2E
         vRqUkbTs8Cg8eI677C2XlsG0/5FiKn+7Lb2/ihT6gY9EGRDaKjTBrIIh2N2y0TbfJ7o/
         MJNtHdUyuYjRXPqOYV4ZvcteHTujspI17XREkjh5dlY7yaMfzHptTsYmkDw5MaEFGNd3
         9J1ho+R+etgUcwdQNnEHvfMpLB9E2o4203w2/Q2uynX4RHURBgAjPXF96VYmK0ggVz+1
         KRPIzB8cLSeysPfNlHWrNBlUqUyOiHMklYV2OP+ise3AeE+pt//Y7WxRBz81q9Jlf8N1
         bWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFNd9y7zjP1MZt+ih91bQ58I7tOdLaR33IaqrsbckfE=;
        b=u5yikqyTmHHuoFk1ANk2C4yLzfShHiwKl0+03A85AR1ERnfuIfjknBQDfL1dWQZ6m9
         rKZImMwR6kcNGr6vEyho2WCRFefyfo2ShGrA8V2q7EZdkglkadi+Qwrq8AT8JWhl4TeU
         A//r6+jXa0Bldl6kH9nt4tsSXGRMjm9/9iNHKoDoDK02qICK9xuFf861hSAnlxDoXc5B
         0I7TqII4pJHODN5kHMyI/HEZRzcWbl7HK7BabjBHW9QcCNG0wMxx636LayIw2J18Brso
         Rrz1WCko9x6pwyEuBXybNl1n3e89EzOuxiUFCW8Ky/jEPphCgHGdKS0kGYRXlG1pBazG
         HpIg==
X-Gm-Message-State: AOAM531JLNM0aU8W8m8+Vp4qlhMbnClqOb0k3l9D+7YSyjYTe5qVyPpI
        9Lvk6J7MRTrh2ht6pyt8DFuODPB1x3QLi0Qu7ebnQ4h6lQ==
X-Google-Smtp-Source: ABdhPJwliFX2CTvdqeiZsfHMs1CAYWPPZBKN2puXETpr9zGqcYUg+dPnOsqRPmLnQmc1k0vjyaRfj8WX054yJd0iuXg=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr1275316edx.244.1638816538988;
 Mon, 06 Dec 2021 10:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20211206132406.235872-1-omosnace@redhat.com>
In-Reply-To: <20211206132406.235872-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Dec 2021 13:48:48 -0500
Message-ID: <CAHC9VhQABwr1y09i6=KB8UjhvW0C8UwYMJpdatznTYDxFVhZLw@mail.gmail.com>
Subject: Re: [PATCH] security,selinux: remove security_add_mnt_opt()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 6, 2021 at 8:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Its last user has been removed in commit f2aedb713c28 ("NFS: Add
> fs_context support.").
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 --
>  include/linux/lsm_hooks.h     |  2 --
>  include/linux/security.h      |  8 -------
>  security/security.c           |  8 -------
>  security/selinux/hooks.c      | 39 -----------------------------------
>  5 files changed, 59 deletions(-)

Good catch.  As this really only affects SELinux, I've merged this
into the selinux/next tree.

-- 
paul moore
www.paul-moore.com
