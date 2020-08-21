Return-Path: <SRS0=891B=B7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FFEC433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF38620791
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sJJ4ao6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHUUg2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHUUg1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 16:36:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D9C061574
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 13:36:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so3890472ejb.11
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebU6ZOPrEiT4sJ2Qift4Kje6ztl3WCJTClKg9hrAqUQ=;
        b=sJJ4ao6DisZKUH3MXLhKbGf3f83SemnBmSnc0GZe4BQVf99IvFWHXrBHpqkrQwShn7
         +bYszE3x5i2zzGpUWigeoglsgJZG38A2PkRWE45g+t0D2eLzT/AOq0gLKENYlXi4TshE
         J56DB12WAL2lMl49Fw1xhilezBWV73I457CHMUBCyFBlbtrk+98CEw+fB1Rp7QYyD8vG
         yOX6mVOCzDAznOB6DirK1zDl6I8Tk7+maUeZ5Z/mqvAaHmFfXZneBwgJ7NectQn6ZqK7
         naKp7Iiq5p8U7rxj3O4iUNiNR+/bbMYJ195On09y8rSChp9UtBOWc+GnEVFvXPMaDE1w
         8aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebU6ZOPrEiT4sJ2Qift4Kje6ztl3WCJTClKg9hrAqUQ=;
        b=rhMk6/v5lgYvmjJTCQs4zgQEYkaiY07hJNiqVnsqfxculHBaYSpxdWnNVYlhEwFtQ4
         urNAF5c7z/N3BZ4iFsuV+kok4b2pfNeW0FmqPmPNKqdcqBeZ58RsWNwNnDuXDu6UYbtd
         pUh8NO8ucyicmQq3KQTnnKLV7r2qsj1C7cvBRc4f/MFEYM/9b+sxATdBwKrDehR1m15s
         CpGGKFPegYPrcVmSsOZ3mZUTpmhdvATkP5uOnnKptJx5a4jgP3M+IqwIgickkEk41qL4
         BgSIJ39c2CDlkcaaDhq2MCBr3Okl861ebROnxhhI4xSHX+xanOe9TcCcp9W9R6QTj0b5
         cdbQ==
X-Gm-Message-State: AOAM5327yNodDr9woWaCJSVrafGW9b4yR3SZM/wID348b446b6RM64uO
        0vjXM5FyGhFPxkfyVVLl5aFOHd4EZqMkgO+BB/6U
X-Google-Smtp-Source: ABdhPJxDQil/PQ8kmBmFKvgLTSoD067CTWtz7P7sgZlRoEMyzAplC2icCm4EXb7/gBGF6eTw85Zm4lqErAh/T2no1x0=
X-Received: by 2002:a17:906:3390:: with SMTP id v16mr4569483eja.106.1598042184879;
 Fri, 21 Aug 2020 13:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <159797437409.20181.15427109610194880479.stgit@sifl> <20200821.113844.1413413632075759126.davem@davemloft.net>
In-Reply-To: <20200821.113844.1413413632075759126.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 16:36:13 -0400
Message-ID: <CAHC9VhQKRozweij6PndZbffq5uaVqkv-xnfhhNNqgLuQ6BDWeQ@mail.gmail.com>
Subject: Re: [net-next PATCH] netlabel: fix problems with mapping removal
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 21, 2020 at 2:38 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Thu, 20 Aug 2020 21:46:14 -0400
>
> > This patch fixes two main problems seen when removing NetLabel
> > mappings: memory leaks and potentially extra audit noise.
>
> These are bug fixes therefore this needs to target the 'net' tree
> and you must also provide appropriate "Fixes:" tags.
>
> Thank you.

Reposted as requested:

https://lore.kernel.org/selinux/159804209207.16190.14955035148979265114.stgit@sifl

-- 
paul moore
www.paul-moore.com
