Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498ECC433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 02:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FAC20663
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 02:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pd8yJsIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGOC20 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOC2Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 22:28:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FBC061794
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 19:28:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so459572edb.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzQjEy96mwvK5RqK1HselxgI2oA5I911Qdx2GNiQhg0=;
        b=pd8yJsIzUV+lmtpXyBfCDr7n3+H80zSFriHlcIPUQEshJKvvGy7eE8F14z2Me5kfma
         VchPpX69Esx3VqPLBaPtWBzKR87WMmuAAWVk6Zxbb59t8akiJqxXSK2gY6bFjn29yKdB
         u5gQKb2NXD0jidguQUC5MRpGj0zHsrpcgQuBsGynE5bZ8s9cVj6Q8jAbJceW4ZopqgQo
         IvkF1Gx536gA5Y4BkC0O7XTgAUc4PVIK4icnKvo1lQlDCDz3x4NjAf2shtmOTNMFbH8c
         +IGUMuuj3R2wNaCqM1RuDMeE1vo+SB1yNukyNP1BaeyfimEuy9EkvDvAtPydf4lgXJ5S
         7CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzQjEy96mwvK5RqK1HselxgI2oA5I911Qdx2GNiQhg0=;
        b=CqO4PU9gjAymY+xXuWnAH331usU1ee4N4Qo/amJfR6nd+8jlvc44kQzTyxZXDjqHGg
         5rbLtIB+M2BYgsrRoto2cmVqXXQApT0oDhGG+YiwjPzLcyNdEOEVnsGLJOCWfRBzgT7t
         q+coQdjHg2pb8KLLPb3aCJbmFlZAApvHy9yxuGpP0IFh5ywGA1Z7s49rH5dHv3r7ASxu
         4CMO8CxVD6Zd15O/Bd2dmtsJMD6axGCQQcb6sJB2Eb5b1ldi019Yw4ZH+UAbemK/XO83
         UoPJgrSQTqkb7duBmD2eGCPQS/Z0YXNuNstRMkHLdgyMqaDTq/WOTXU7nSjIZO6ddCqf
         Gx3A==
X-Gm-Message-State: AOAM533j6tSSExjC4YhA9kKqmZAditkiZrBw3kGweMHDCV1wxQyXKTG+
        +XsGMmb7Zls5f/VI9s+RH8xEhuP0I2reqn4teUCG
X-Google-Smtp-Source: ABdhPJwC+iS+MYu3jbSKussTXFfhjkiopLyiCmfWTihVgPblMmDRROS4S+1ydwyZ0bTIgA2yjuH02BgGUJUMI4Q0zDU=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr7142885edy.135.1594780103839;
 Tue, 14 Jul 2020 19:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200715021846.34096-1-yuehaibing@huawei.com>
In-Reply-To: <20200715021846.34096-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jul 2020 22:28:12 -0400
Message-ID: <CAHC9VhTPhtx-t7_WucUyKg=y1g_0OiFFs1RdvfuixOUoytWmvA@mail.gmail.com>
Subject: Re: [PATCH net-next] cipso: Remove unused inline functions
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 10:21 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> They are not used any more since commit b1edeb102397 ("netlabel: Replace
> protocol/NetLabel linking with refrerence counts")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/cipso_ipv4.h | 12 ------------
>  1 file changed, 12 deletions(-)

Looks good to me, thanks for the patch.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
