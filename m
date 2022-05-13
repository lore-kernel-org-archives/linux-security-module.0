Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031EC433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 12:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380495AbiEMM6O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380492AbiEMM6N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 08:58:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F129B19B
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 05:58:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p189so4760387wmp.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=thaX8F5YMEB8rBSpYIHSf7KiewyBMS4c1TXezvvYXWo=;
        b=auGUYIiH8r7oJP67oOuHmzM/NOGPcdCLkLQF91WtkEgHQTmkJLUMnLAuJDyzjYn4e2
         2t8AnU/iUvEat3vHWqybIizYNTPVY0ZILJEv2VtWYhJv4l6so1W1LFOoNYlSuXPbDREi
         CaWD/8FR0FE/ZE//HYKE5FX42YiD7R6zQrQdllq9MeLOMcL/PmTY9bEtbPaGwG1GUk8I
         YXfqv/Clz9P/mcGMzzMu65NpEzl6n5AizJbkoffXPxU2NidzoyAY9tD0kyqBJW+cV6Yo
         L2XUKHbPY5DKUYM1pS6eoC+6qn9GDVlPBM5mHQ4SaO+Ed5OW841882ELq1gSprMqGPzV
         8sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=thaX8F5YMEB8rBSpYIHSf7KiewyBMS4c1TXezvvYXWo=;
        b=7Xzuo4eP2ODcQzpoKSH3WdH83BNK5iNy72npurpys2Uu6NU+nuzbG7noVB3J6jl6jg
         R4kzlWC/Sqn0yH5nIoHgbghffnrvzyhRZthx9N3A1zO9qdEWdbgldjrJ+SEF09LnP467
         9TWMTj+72VoSrGp9GesrK+Ak1tpTnf/VbWxMOGs7JnH2nxzuhZAJ+S3uiwoTA9MDNp/I
         HikGSu44c8tnUFi1pRSACwaik/EJzMmh7OOFxL6T6pllqyWmi/9i1SQz58DM2xTye+5Y
         5vIuQM7GuLzfsl9XxsDRJETNqpYOk2Y2uKDE4NIyYNmw6tjyAnZUUs5dgAIH032beAPe
         1Myw==
X-Gm-Message-State: AOAM533hHJO1cbxaQME8c6lVMe/p/TKSoT8zYEFVFYpem1KmUuLh2FWW
        7PuQ6mzFjw17MnQi0/HX2Hxi/XfinOH3HmnO3bfP
X-Google-Smtp-Source: ABdhPJyuPrauqU//BMVcgTUuAktKz5n/8NYQebKBmgF7eFtX+zbGS3ouW2oyFE/TlzAylCXCC9SYX/nSdl005MFElIs=
X-Received: by 2002:a05:600c:4fd0:b0:394:7999:98ab with SMTP id
 o16-20020a05600c4fd000b00394799998abmr4378959wmq.179.1652446690471; Fri, 13
 May 2022 05:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220513112743.156414-1-mic@digikod.net>
In-Reply-To: <20220513112743.156414-1-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 May 2022 08:57:59 -0400
Message-ID: <CAHC9VhQS1mNAzC2Qo2+rxUs5BERA6Y9FyzapdRQ65g5FY1Mwtw@mail.gmail.com>
Subject: Re: [PATCH v2] landlock: Explain how to support Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 13, 2022 at 7:27 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Let's help users by documenting how to enable and check for Landlock in
> the kernel and the running system.  The userspace-api section may not be
> the best place for this but it still makes sense to put all the user
> documentation at the same place.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220513112743.156414-1-mic@digikod.net
> ---
>
> Changes since v1:
> * Move the checking subsection at the beginning (suggested by Paul
>   Moore) and merge the two configuration subsections.
> * Use both dmesg and journalctl to handle cases where journald is not
>   installed or when the kernel log buffer is full.
> * Add reference to the syscall check (ABI section).
> * Improve explanations.
> * Update copyright date.
> ---
>  Documentation/userspace-api/landlock.rst | 29 +++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Looks good to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
