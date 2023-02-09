Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A275C05027
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBIWmO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBIWlf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 17:41:35 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8546D8F6
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 14:40:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n3so2546869pgr.9
        for <linux-security-module@vger.kernel.org>; Thu, 09 Feb 2023 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8WD2Tk2aMsAKkpoh/02h7dwq14Lo/nQ5ijqmG2ognM=;
        b=JqhDpOWUO0e7lVagrg2jSszeXP/Yl46O0L093WS7t++4Uh9q5RQLBsLQzDK5rpaEmT
         mMOUX2bZ8pjCBXSfGJN/rniC9VgcRkk5ZMqu1+tuQ3Dqm+jvsr66YeL4i/AOVDvCISk2
         7FJ+BsJfELPDOgy6kTr+4P4qWrZfgkPrbF1V0auhmgAKhZkTKxN3WWqU58ccuVrMzt/E
         sw9C/DcFgoKHyiRwm16dInV3wPSm0i2CBn7XUUgvLAWDdBAtexadYayXxw1EPGhrghpu
         Qxr4vsHUm0cKKKu2EueqUo7rWcRzjfkXmPmr3AVVPC5Zelyb/iJRK4wKn6Fk3gLq9PiY
         04nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8WD2Tk2aMsAKkpoh/02h7dwq14Lo/nQ5ijqmG2ognM=;
        b=Ki7BUbxW3XS5Sad5KxFL12onqFjaMIvyaIkrduutU1wT0kfzTIUl7BTcD5Cqz8sXeO
         XBSQqbe1OCjDfSjH1xrYKkYtZw6cq6lhHGs5Xnf3sBgNyoPWVcOmmHfDplcfLPqbgdsv
         q7mIJe6fCOuP8yDG+HyzX16VgNalDDACC5pN59puloYHtV2eYPnf71id5/zlmsMmGWU6
         cEARUAFD5VdtN6Or90EU/p4WteucGE/64ofbEofSHkcpP4RZ8tszL6kQcQBv/61bBIcH
         Lbv9NXJfS599amzYRHebG53ACHxMq3mvVCt6lalKUhunVCc2uW0JpzNC8hU/REfYxau7
         6i4Q==
X-Gm-Message-State: AO0yUKUOq67zA57va3pqgd63NyzDin1KVQrg+GKwjAQWtHmu369qpcNu
        oumpDVksVyMK65wz4FglOnf5z8p6DHcZHsgbbX9O
X-Google-Smtp-Source: AK7set+aAm3AleeHjYOu78iZj7lQ/qZLZif3YC6WdLurY09xDxthywTU6LWeeI31+6RAF3co5hNQ5qyRgr0yk7M1wzY=
X-Received: by 2002:a62:6456:0:b0:5a8:4d9f:d51f with SMTP id
 y83-20020a626456000000b005a84d9fd51fmr1169389pfb.22.1675982448164; Thu, 09
 Feb 2023 14:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20230209223814.308370-1-mic@digikod.net>
In-Reply-To: <20230209223814.308370-1-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 17:40:37 -0500
Message-ID: <CAHC9VhSYAWMJ+d9k7m75X+eDmEA82anJZEu228XweCkA0rPTQw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Landlock repository
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 9, 2023 at 5:38 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> I only use the kernel.org repository for Landlock.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20230209223814.308370-1-mic@digikod.net
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like a proper git repo to me :)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a36df9ed283d..70f13280921a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11686,7 +11686,7 @@ M:      Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
>
>  L:     linux-security-module@vger.kernel.org
>  S:     Supported
>  W:     https://landlock.io
> -T:     git https://github.com/landlock-lsm/linux.git
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
>  F:     Documentation/security/landlock.rst
>  F:     Documentation/userspace-api/landlock.rst
>  F:     include/uapi/linux/landlock.h
> --
> 2.39.1

--=20
paul-moore.com
