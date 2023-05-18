Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A9C77B7A
	for <linux-security-module@archiver.kernel.org>; Thu, 18 May 2023 18:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjERS75 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 May 2023 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjERS74 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 May 2023 14:59:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0716E52
        for <linux-security-module@vger.kernel.org>; Thu, 18 May 2023 11:59:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561e5014336so17344957b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 18 May 2023 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684436378; x=1687028378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtBOHOwmDp9SMINU5LAjPqVHhLD9SSVab8maKjIrOho=;
        b=A/v5w98UE3b9NLHqHa2kzJa6P+se5gh5td7rb7BYIYiUOUTG1Wv0AcVKxHsDW7H+K+
         6XKj5cAOfXxmbtOPX+F3Tjq3bDkj3diO56tw9wm0G6VUgd4BS20xaufxQ0a41b6rNl+d
         f/DW0DhUADqSgG8xwEpvLkUrwB8Dlvp13NXTmkTpCK9LInNztd396SEydzKZrdACYcYj
         IZYtm7fKaxr+7VNNZMM/ZHv3nH5MO/hEqkxvq6/oHBYzOb5sarsrnPP3h7WLkrlNGEmH
         bKDX+2VcVpxI7MGOKFmuUrTevhd4a+4Rw4jh869yTsMoIDXPvRMhQBi5efq+wBuaaLEY
         xJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684436378; x=1687028378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtBOHOwmDp9SMINU5LAjPqVHhLD9SSVab8maKjIrOho=;
        b=LYDazUrzKutWbnnq8OYRmst50ZkvrMpgS5EqgDNMe5qwsKtZRhoH3RIOY6dOzsdJnT
         cc+m+Khe+6rKE7Os0scBaH7YKy1nFnft5uOhgMaY1FndfkA3t3NA3Ydl3KpcRwLeSv8D
         S6mVhd8PkHyxg9CJcJTRY7f/hOgSL94qMeiMExZMsYMuOCLeL5CZmKZXzHXp+s1p4E9B
         NyjZHDxsj1pJM1DIac6aHyFDU/xVcpZYfDzvbihF/2iZP0PTQyF1ae3M3YfXg4jSWDUW
         0UjIGNrtxWwk1ett3ItiJ/yddKIO/T0S9LdgfpijdslkqzNHf1tdv/9YBAxPg5LxqqLK
         uvKA==
X-Gm-Message-State: AC+VfDxxTcexYNj34DRbG8odkQySygumjE0Z/SnwjhfIWBUjqCl5Un3r
        QQsaFhTHupHqn0Ng/1EgTk33rbQA4zMHESCt5++9
X-Google-Smtp-Source: ACHHUZ74/iXoSHc+ftLq8tme01H36+JfSuO86ZpjAPbOWNnDVIUmF3ovPG3r9WymgIzJJWKqXQmBbqEXhqCl/FofgPY=
X-Received: by 2002:a25:ac19:0:b0:b95:9b76:34a5 with SMTP id
 w25-20020a25ac19000000b00b959b7634a5mr1917345ybi.64.1684436378606; Thu, 18
 May 2023 11:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 May 2023 14:59:27 -0400
Message-ID: <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mortonm@chromium.org
Cc:     penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> pr_warn message clearly says that GID should be printed,
> but we have UID there. Let's fix that.
>
> Found accidentaly during the work on isolated user namespaces.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
> v2: __kuid_val -> __kgid_val
> ---
>  security/safesetid/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm assuming you're going to pick this up Micah?

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index e806739f7868..5be5894aa0ea 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct cr=
ed *cred,
>                  * set*gid() (e.g. setting up userns gid mappings).
>                  */
>                 pr_warn("Operation requires CAP_SETGID, which is not avai=
lable to GID %u for operations besides approved set*gid transitions\n",
> -                       __kuid_val(cred->uid));
> +                       __kgid_val(cred->gid));
>                 return -EPERM;
>         default:
>                 /* Error, the only capabilities were checking for is CAP_=
SETUID/GID */
> --
> 2.34.1

--=20
paul-moore.com
