Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8AAC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Mar 2022 01:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358298AbiCQB2Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358307AbiCQB1u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Mar 2022 21:27:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59A1E3F2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:26:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a8so7712220ejc.8
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg72bDDMXKgIFi4/3pJ510z+c/iucl3unZbSLqSuVPE=;
        b=D1BJhdsQ8C0/EXJsr5prdMYV5Iy4RSwkDYjHmUKFnj2CZKCBGkzkAXu4Rs7DIr/+Z4
         ZfSM/kuOa35PMdjptMxhHqP2t3+VNoupShB1xXjFBk2DzX2cUzoIjI7XT6JJODM/tYIf
         8lA6KtoFMhwT3j+PcPePSF9MOQeW3WwSzzks8E+NX55uvktEGS5MWcESDp9pUYBUVPsq
         6pa2CviNGYWuBVueLigdwYK4kL52uaysCvcWIbWphWhVeFY8OjFosN0Iy/flCQqmQP8U
         IrSh3kH82dc44rF5DEX70LabAkVZhbxhKhFez87gath/Ru7xG+g8/aKc+mC+hshrjnPh
         iZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg72bDDMXKgIFi4/3pJ510z+c/iucl3unZbSLqSuVPE=;
        b=AgOx4c1mfmk+FSrKXXJ1JKYc5ECHY8KpKOc9YJs97eqH7QH1xcAYebm8UpKTnTirCM
         Z0iv+oIYQEx5ZV34xHdoFjSLwf4ULDNTtWlzyL0CsZQ7f4bqxCmwP+yG5VR8KIlzf3Q2
         pC6d+RUa/Rw3yPKJQ6BM6JKx2589uJKp0EaQ9e9okvYVs1cIFV5fgXI72+1snhLkaRdt
         qK2PSDfYcztF7doXlPogD7XpwKMCi5NLedodmstddI/brkCcGgAR/m2LSsh/rOAKEpGL
         eJcBcgbbrADAJ60PPP94Yu5TsJyB1SqinG7dZNuCMogN+OiAbkz7mqjNvHQI4M0bZCPc
         fYog==
X-Gm-Message-State: AOAM530FSGSFYCryIk+ZZCSzqr4hsrDboGMr0bZEht5EAO3q6oF+KlVz
        vj2NptsgaahafYuHEEOS3BulbyewOmzDj+6e4NLJ/UIZOQ==
X-Google-Smtp-Source: ABdhPJzpu6lp6njiy52N0zdfBqZGt9nd46eib4HOnCsGmHdwyVJiXgdilrP0Ia8kUmKFsYygmbE/G+cWMPcsCXk/jHw=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr2251417ejp.12.1647480393427; Wed, 16 Mar
 2022 18:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-4-mic@digikod.net>
In-Reply-To: <20220221212522.320243-4-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:22 -0400
Message-ID: <CAHC9VhTF4j+z-kp5apB2MYK0zk9q4RNu2ou9yWm7jBNk7BG1=Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] landlock: Create find_rule() from unmask_layers()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> This refactoring will be useful in a following commit.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-4-mic@digikod.net
> ---
>  security/landlock/fs.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
