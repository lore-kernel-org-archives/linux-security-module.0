Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E756EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGJSCV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGJSCT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:19 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE2F9
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:02:18 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a1fa977667so4395966fac.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689012137; x=1691604137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsHm4asAiCOk33uCZVwENCOzoNNk6JHzs23yJyW+awA=;
        b=JYE/vTETaRRYvBFabD7fu9Ksz5ZUxoF1Gb9voreULcOStmUu17vWFHYOmrSjK1ko9r
         YxNuCrAGy0yUUe081sbHCdyoXKhG3IX/gFvkLrBXBiqqgOpGDGVV8UEpz7+iXmduPRxP
         ggaxziEBxmFwAb/od9McZO2odqNfK7Ix63+KYuuxUzpkEAqX4SUODJiGJTt87ydMkCuW
         OpzGJQRVSx3IeEXJngQAZjAjvaBPSXeQlRQDN2fxu5Zig4t7M3NUz4ASWRHam2U1PUBr
         QBIOMOrBVmecjnU9SgsThsEpkz+nAW/1RtM+kDj9F2y0zi2avgt7EtkKmkn1UvHe7t1h
         5BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012137; x=1691604137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsHm4asAiCOk33uCZVwENCOzoNNk6JHzs23yJyW+awA=;
        b=mGaNC0TcECiZ9t94M3KG99EiTf/16v/XgRnr9/U7SrlqUbS+e/Lz5BDU4DnLywaLeP
         YuwLoRPBW1ye4d8YtVC1jF5Q37b3ma1hRvIQFizv6BuA77Po6XevJXQ/0UlN9IpnZtqJ
         WUe9beeqhd8T0hzcGI+l2gYXVra3+Hz77SbwKsGDT/UenmSnnKrMjVI4e8PLQfOwW0aF
         RH7a8QAxEUPBZo5FSg5LzqYDdZh7eVjY2mXfjyJgTrOPLyvDR2BB07tZYKZK+RdxEHss
         fet+SeQXeLZP2VtFxff7hsFx75II/+1M1LfVDhKGm8R04UIewrcKiFnzJxOP4PERG6JT
         38pA==
X-Gm-Message-State: ABy/qLZ1ojGOqA8DOKi/7+54IAyVTEnBl/05pO5yag5eOvNvd+DZ5vGv
        o1eN1apf6Bh3lO+DZZOrat49P3/llcEFmCmdQ5trdAlOn40U90g=
X-Google-Smtp-Source: APBJJlGL5bp3qdIiL0+HM4FKThICi3Lcz8FRmqtymyT4mNrm5kCmNADx7L4kmNfJ9c3slmET4J1NBIRi8J6DJjCpH5Q=
X-Received: by 2002:a05:6870:e40d:b0:1b3:904a:51da with SMTP id
 n13-20020a056870e40d00b001b3904a51damr14455342oag.35.1689012137450; Mon, 10
 Jul 2023 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230702170857.15603-1-pairmanxlr@gmail.com> <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
In-Reply-To: <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:02:06 -0400
Message-ID: <CAHC9VhRpO4oGvgAA1AMXD8HYuJvqM+OuZ0AKHzWX4Bk=FBJUmw@mail.gmail.com>
Subject: Re: [PATCH] LSM: Fix typo in a comment
To:     Pairman Guo <pairmanxlr@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 5, 2023 at 6:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Sun, Jul 2, 2023 at 1:09=E2=80=AFPM Pairman Guo <pairmanxlr@gmail.com>=
 wrote:
> >
> > Hi maintainers,
> >
> > In the description of function definition security_file_lock(),
> > the line "@cmd: fnctl command" has a typo where "fnctl" should be
> > "fcntl". This patch fixes the typo.
> >
> > Please merge if it is the case. Thanks in advance.
> >
> > Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This looks good to me, I'll plan to merge this once the merge window
> closes.  Thanks.

I'm merging this into lsm/next now, thanks!

--=20
paul-moore.com
