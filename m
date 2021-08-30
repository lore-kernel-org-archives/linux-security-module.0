Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1417AC432BE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85A360F23
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhH3OV2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhH3OV2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 10:21:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E430C061764
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 07:20:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bt14so31549259ejb.3
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AhXC7FsliCDbgMBllCtVSrepgVuX0YpwGQp9z/ekM1Y=;
        b=aizIAHzAv3IZCt4XAp2HBi2nBu99U5vp1261GVSeUsVCmxPQ9XcjIJUXm+PnBPp1p2
         On1W34iNSDUP3GuA5Sk3YMWsBc8udP1Sq1YRFH+b19ypOZOfudgnwfu5gUzZrHfELV4D
         oidZKe5e9SyEJkDw2IlyR62BYFOWuY37PetkpS4Be0IGVvVpB0yQ9ADVWhhXS0wssujW
         MfhUKI0hpYkDC6aegg89z3B+sZ/dDeRE9DD+7HmnLr9MoMrvgNVWRytKOYughnseaiZm
         1E2gfW21Y+O2tOlLu2G4+4KQo/E3IzsUD5zJhbpAkMuxM8t0R4MTEXKT1yYElZcKH6lS
         QPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AhXC7FsliCDbgMBllCtVSrepgVuX0YpwGQp9z/ekM1Y=;
        b=WT5E8xckWLLcDrDTgIdxZ+rKwk4WRknZOSd6b7+1inruZFF5dOKwYMn9FOdZsSvvo1
         tQ/lXQ+IsOlM/xtfsWH3/37IQlRxILMAyR2CV96oMc4J8jYYhEg5gyT11c85ep5qInn+
         BYsKY9zyqcpF4FlRyNsSh458WKlW7w4AgznnhVlY66orKzt1tnf7vggdgUR9qG2izpjM
         nYbHY6omiy0O1gZ/3lBtSk73OhvUbxaczgQlDhmLSo12bfh2XddtIotQERdzU+TJM1p9
         ud/JjLPPN5UhKHjHZwWUqxeinFAjckpNd7YbIpQ4nXakx6ErzbTjX4lw8zwqn8k3dd+6
         A8NQ==
X-Gm-Message-State: AOAM532Lk5bltbrD3J70cpByyJRVvEdDIT7ELjngsSvFWZ3ySqTP6NQP
        g2lXmDW/2CmGcphIFT3swbJpQ4HGlmIc20yzZjSF
X-Google-Smtp-Source: ABdhPJzofMywvHG9GYplqHaT8BalSiL9uoUxDKQw/jVvGW+oC9BvtDJV521UIbWSBHNfDlNS5rfeQLoPnlOP789groQ=
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr24982312ejd.488.1630333232912;
 Mon, 30 Aug 2021 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830115942.1017300-1-sashal@kernel.org> <20210830115942.1017300-13-sashal@kernel.org>
 <CAD-N9QUXXjEMtdDniuqcNSAtaOhKtHE=hLMchtCJgbvxQXdABQ@mail.gmail.com>
In-Reply-To: <CAD-N9QUXXjEMtdDniuqcNSAtaOhKtHE=hLMchtCJgbvxQXdABQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 10:20:22 -0400
Message-ID: <CAHC9VhTjFMw111-fyZsFaCSnN3b-TuQjqXcc1zVu2QTTekTohw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 13/14] net: fix NULL pointer reference in cipso_v4_doi_free
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Abaci <abaci@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 30, 2021 at 8:42 AM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Mon, Aug 30, 2021 at 8:01 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com>
> >
> > [ Upstream commit 733c99ee8be9a1410287cdbb943887365e83b2d6 ]
> >
>
> Hi Sasha,
>
> Michael Wang has sent a v2 patch [1] for this bug and it is merged
> into netdev/net-next.git. However, the v1 patch is already in the
> upstream tree.
>
> How do you guys handle such a issue?
>
> [1] https://lkml.org/lkml/2021/8/30/229

Ugh.  Michael can you please work with netdev to fix this in the
upstream, and hopefully -stable, kernels?  My guess is you will need
to rebase your v2 patch on top of the v1 patch (basically what exists
in upstream) and send that back out.

--=20
paul moore
www.paul-moore.com
