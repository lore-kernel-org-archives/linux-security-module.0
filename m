Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C2EB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 22:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGEWfg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjGEWfg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 18:35:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2721730
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 15:35:35 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so5218813276.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688596534; x=1691188534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGcxF4BR9idnjfupGfZyCZ3tDVPU/xSvJaiVs/YzQCI=;
        b=AhF64Ii2K3KiAB2gOnjbOyZ2KDgXL21Paphcf+V6zGa/QuHpJea1/xzEJLgRT9f7Tz
         ycFWBUn5vsbvhng7jDBvf2TYWTgw444okXaPCq1iV+JoosRrWCXS599JtHWwSOndp6Tc
         BaZ6pr5CZDXozxVYXszGuwh2tGdGIzQHWRDHYTiXs4aul+5PVvNagQO+Z5EgLsIHLHhS
         kOUeZ1+lACxN9vS1dmF1Spc/Qridb+y+YW1hf8pXncsf29xA3THa5GUWVxFUFAKYOPUt
         zZRX04zIQwUEEGzo0bt08MTS7yiLEmZd02vhwyW6rAlvf3hxvU6uJy5HLM3wJd62Rhug
         lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596534; x=1691188534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGcxF4BR9idnjfupGfZyCZ3tDVPU/xSvJaiVs/YzQCI=;
        b=io1eWYP/Owetwfg7RQZUkzK6WHIjWYiFb1xRG6Sp25+8bVF2Bl3Va1Qocxyvx35waf
         QJj72unAL5WeGwXjYdOREnPeY/4XbYrFr83HZgkVPuHTxjP0Q5hg1fjWYm/Bw1ROorj/
         f18uTY629r/OEY5qA4tyCDvbHQhE6polq6Qstw0AIfGbHgLvctkoj4Qq1k8ahOpW/LRi
         r8eVG5ZTf9fD8E/p6L2JKfVvvWHzWKpX/GQNum91FBlVvLyE0Cg8Oh1L/AFO8aTYmbXp
         lmrTwWS+3oo/z2u1auBlrMAqWqO6TKcb1WeoZ/ppgU8lJBn6EBlMIVZFNIsA3b2QZ3NJ
         eDEw==
X-Gm-Message-State: ABy/qLYjRNDf+vP9w//bV5RZZcsa3A4BIK6IOT0v5LR57tSGlLJr38YZ
        tzpiNI6SkgGzjXCmQEKoT8/pfYitnzxjjH1t8DIyn3PWQWUSXAY=
X-Google-Smtp-Source: APBJJlFUIN4oesag3UOXr7IMZjuy9McghVh2XL5utXpAKB8uwjlvAhYonStnTo3EudkZalVMNi0oXRA+5N+I0AAJsss=
X-Received: by 2002:a0d:da41:0:b0:568:be91:c2b1 with SMTP id
 c62-20020a0dda41000000b00568be91c2b1mr336115ywe.9.1688596534388; Wed, 05 Jul
 2023 15:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230702170857.15603-1-pairmanxlr@gmail.com>
In-Reply-To: <20230702170857.15603-1-pairmanxlr@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 18:35:23 -0400
Message-ID: <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
Subject: Re: [PATCH] LSM: Fix typo in a comment
To:     Pairman Guo <pairmanxlr@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jul 2, 2023 at 1:09=E2=80=AFPM Pairman Guo <pairmanxlr@gmail.com> w=
rote:
>
> Hi maintainers,
>
> In the description of function definition security_file_lock(),
> the line "@cmd: fnctl command" has a typo where "fnctl" should be
> "fcntl". This patch fixes the typo.
>
> Please merge if it is the case. Thanks in advance.
>
> Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks good to me, I'll plan to merge this once the merge window
closes.  Thanks.

> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..adaa7043c172 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2717,7 +2717,7 @@ int security_file_lock(struct file *file, unsigned =
int cmd)
>  /**
>   * security_file_fcntl() - Check if fcntl() op is allowed
>   * @file: file
> - * @cmd: fnctl command
> + * @cmd: fcntl command
>   * @arg: command argument
>   *
>   * Check permission before allowing the file operation specified by @cmd=
 from
> --
> 2.41.0

--=20
paul-moore.com
