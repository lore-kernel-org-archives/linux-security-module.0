Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0FC6FA99
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Mar 2023 23:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCJXiE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Mar 2023 18:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCJXiC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Mar 2023 18:38:02 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD7B74A
        for <linux-security-module@vger.kernel.org>; Fri, 10 Mar 2023 15:37:59 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5416698e889so6562717b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Mar 2023 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678491478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAsl0x71H/TTZvG/oR3VnRExXsP3bWi1hx0WaLiiJtE=;
        b=JRXQCPq5zg4qTSmdgtUN7OP9NuAGsnrIjn54cqLJRcwrqbHTRa18hfGhrk/xDG+ZXr
         EVxMsV2iDJDu2udOakivT+l6gvHAkZuGLkaXpFsa7orCJki3sp8dk00C7WIUAp1I1Tl6
         eYGsqZ/lew99fWvKU9ppRH7LM+kJoQbS9q2mW4mvk6Rp61nklzhL/Fbw5YMfdkexBJkq
         fSCpscmBOOej+qEb2mL2mBfgHgJtTKFIZT0oFbWGQ6ab9vOfOj6+viJwmDEBl31kjUVO
         yxNKRwXF2NjkunG1GCdwbUmwZ4YKcNDU/e9PEAfHA9Mi/Ir2gGOpdzMNxshxh9dVnKcB
         I4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAsl0x71H/TTZvG/oR3VnRExXsP3bWi1hx0WaLiiJtE=;
        b=K/omL3E9H9vi6Iisn3woo9FYktT34fyDBhapXEd/Yf9M93F9YzOCjORIP7arsKppdc
         tTtcAcy8qfmvQ3HVdgje7VxuK0xgtCjWRuVNWze3Z5gbePdiWg4tSCr91YH99N6QegCt
         c1ss1pixNm/0Pl/NZlNaP5ObQppkUdoFFWiBEzj20XFVvK3Y02YtaOyYH2p7DaLrVtFp
         T/1BcrPR2BYSOOZh5TrgpKy7SRAiXxkqEbAti8H1ZFthanR3ApJDpR014+YSR884QzhB
         PHYZzgyxwJHeke3/gjOVaAnEYgi4d/AG2I5wKZvfTRCxf01xK/9QC7db0LxtZAeSwTeV
         dHHw==
X-Gm-Message-State: AO0yUKXoeBBLn8QHIxozeOwHDOCBdR+DR2fSgcssm1MuJS6mbdEAaZQ4
        1r7+pf6nz8gSrey8X/Gz8rVE/P6DTy5MTm5jSPfZ
X-Google-Smtp-Source: AK7set/UM/hEEMUK6bVRDLfraDarPiY+xljrjjvUO83Jh4wDTGJ/dbydMv2X6EqZ1OFoJoykot/hNCtL+11T2bdzWew=
X-Received: by 2002:a0d:dbca:0:b0:533:9d13:a067 with SMTP id
 d193-20020a0ddbca000000b005339d13a067mr2648739ywe.3.1678491478514; Fri, 10
 Mar 2023 15:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 18:37:47 -0500
Message-ID: <CAHC9VhR=Kv7U2ERqVadFx4Gu5zR2VJeEb1m4UAD-im-ef4_aVQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] security: Always enable integrity LSM
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 10, 2023 at 3:54=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Since the integrity (including IMA and EVM) functions are currently alway=
s
> called by the LSM infrastructure, and always after all LSMs, formalize
> these requirements by introducing a new LSM ordering called LSM_ORDER_LAS=
T,
> and set it for the 'integrity' LSM (patch 1).
>
> Consequently, revert commit 92063f3ca73a ("integrity: double check
> iint_cache was initialized"), as the double check becomes always verified
> (patch 2), and remove 'integrity' from the list of LSMs in
> security/Kconfig (patch 3).
>
> Changelog
>
> v3:
> - Remove Signed-off-by tag by Mimi (suggested by Paul)
> - Clarify that an LSM with order LSM_ORDER_FIRST or LSM_ORDER_LAST is
>   always enabled if it is selected in the kernel configuration (suggested
>   by Paul)
>
> v2:
> - Fix commit message in patch 1 (suggested by Mimi)
> - Bump version of patch 2 (v1 -> v3) to make one patch set
> - Add patch 3 (suggested by Mimi)
>
> v1:
> - Add comment for LSM_ORDER_LAST definition (suggested by Mimi)
> - Add Fixes tag (suggested by Mimi)
> - Do minor corrections in the commit messages (suggested by Mimi and
>   Stefan)
>
> Roberto Sassu (3):
>   security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
>   Revert "integrity: double check iint_cache was initialized"
>   security: Remove integrity from the LSM list in Kconfig
>
>  include/linux/lsm_hooks.h |  1 +
>  security/Kconfig          | 16 +++++++++-------
>  security/integrity/iint.c |  9 +--------
>  security/security.c       | 12 +++++++++---
>  4 files changed, 20 insertions(+), 18 deletions(-)

I just merged the full patchset into the lsm/next branch, thanks everyone!

--=20
paul-moore.com
