Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6BC678D5
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCHShU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHShT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 13:37:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938EAD013
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 10:37:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so2560102pja.5
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678300635;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hyr62x/EaZ/lxo+IARR2QFhrj8oMdl3USOusTJCMDfE=;
        b=Y9Dw/jCbPdUGOKfUBy8+1wgw9q+pSvlEFGJUBxtRwyqh2mqthkvJnOnJUiATlM7eVg
         t+s8g8aisvwJUkYJVVyK+40het71SDkkhSN1ds8+ea7TJ9zXPbOs2hl2+1LLXvW8Tz5y
         SZ6iwUHUMVWkrfB1dhW2aSqyzh/tkDK7dPbNG2nmfi+25PaU2zVmFrp6bZvobn0Act0Y
         ISEDY5o0xkI3Mzpw2qkxkhzoHjtvWW54kbZW/3YKA5rje0xYUfG1qKQKEPpReiMs9GUG
         WIXz8d9pzj2G+gn7+ax7SgFCDEZRGsH/ptsUCiyPyAPB3OKuQ9192kE2wnefwFX8XKDI
         CsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300635;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hyr62x/EaZ/lxo+IARR2QFhrj8oMdl3USOusTJCMDfE=;
        b=8RYbNXCiTxd2lBBE5B9zgt9dN90Vibp9kZ+9Nz41+E2QPz1tjQD4klG3E0aCYqbLQp
         cV/TikQZOlXpjcFkgHt7mZ1LWkmUdt9S89TX/GK0sbzRoH1P+sTpDG8czu5PNfOkyZsJ
         dy0iDswT49qPs4Ls+PcvcL9UQpHT1SiVo96KxroF5qbctbEPtHO3nVJmVBemMuTAfLga
         ww9075afumLQXd90v7GGYt34LZh2LNGzWtfr2ZXUfKMdjUp75s0bfkG6u+9EWyMcGmQe
         kEfi7A+xKU6MHH6decFqs3k1r0QSJaCgZ6LR9PkG6pD6U1lqY1/uADqEkm9nRUMKbBN2
         YzVQ==
X-Gm-Message-State: AO0yUKUWGrdaBtzasGGDYIKGKpHlL9vLlPk9q9d8gvZTnqPz/p8MceQl
        V9cGnFGPMYWpF8SyykVGOHVbJaUWsFyMHKbBIvUmecgDNSuLll8=
X-Google-Smtp-Source: AK7set/TZdsYXyRrZ0634lZJUdezNgCn5z/J/4fCgi3EimhQzl693rdmUldMRqx7Q1c96I976IIxsL6cEbzceve5h4M=
X-Received: by 2002:a17:90b:902:b0:23a:1461:abc with SMTP id
 bo2-20020a17090b090200b0023a14610abcmr7164982pjb.8.1678300635335; Wed, 08 Mar
 2023 10:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20230308182802.195662-1-paul@paul-moore.com>
In-Reply-To: <20230308182802.195662-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 13:37:03 -0500
Message-ID: <CAHC9VhROVX16gkanx6=DsA=nrEWibGtcuu6REZLk3kEs3mp4Fg@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix doc warnings in the LSM hook comments
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 8, 2023 at 1:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Due to the trivial nature of this patch I've gone ahead and merged
this into lsm/next just now.

--=20
paul-moore.com
