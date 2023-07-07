Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA96EB64DA
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 13:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGGN4m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGGN4l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 09:56:41 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A421BEE
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 06:56:39 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9585A3F32A
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688738197;
        bh=HhoEDvLUHji0H4nkgmBsSeZ1ppMwCe3pxCokQT59sj8=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=qkLHxKo53O/ne2jR2HO6CeOu67ad/TSc0EV3xUCxLdYo2LlfTgOH+5UNU+nMGhctI
         ujkYmvhU/yxhj9rVDsdwXMP/p5GNpAK5MVymBryyDHF+jC7fjK+mW3NuaE6atZwaD1
         a81j+0u7iYUxeY5BCRZfVndVCefj8fuR5IFTMr8/RemLGVIVhegrFtQ3rE0rrqxBGI
         WOh5wDNIzFyNEH/SdwraEDaUUohdffeNRH3W7fxLU2x6p6hyIX4lrvpewnIPtD6y6V
         VS3BEO+V3wggI38HI9JLMchSjldkdTbcZqs6g/BRMb579FZcEn4tOre3pig1ttA9AR
         r1/wJZE6BtufQ==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b886e8c29cso1926814a34.3
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jul 2023 06:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738196; x=1691330196;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhoEDvLUHji0H4nkgmBsSeZ1ppMwCe3pxCokQT59sj8=;
        b=EGbfcheIIWyIX6HqHWDiraUiE0JQ2pKcL5vGlo76W3E81KC9hSE3uyUefZyl5npskH
         NX1Bv3vwBtEoDFVVkfhSrDfG9vt7lGffABOQLmHCmvH4yad/Ie2YHm1c3Q1W1882LnwV
         rvNQiGLJdRQRJBY5R+pue8irXUVv1u2RypTc2XLG37E4t6zRW+kw3WW1fV26zTmZV50e
         hr9LU0Wj/wai8LCRM5o7VOZqvqiHtt7r4AodwSUU1NG/juxH/pQ/3929eMHvGEY6UJlI
         WOpcyx+olpGkRXjwGVcL2Nil5RwkHhHkfc8Qt/bUPwI9uQ7rtCIYDmdRVNwDlxkngk21
         dHrg==
X-Gm-Message-State: ABy/qLbqNxRqYPeWq95G9TalkL2rtf4XTmaoUrSAfsf7jBr1px7pRnEb
        VkQuD95dr+Uw0KUgnPSvSQM7h8xqibxeLQZcVDAD0KKxainIgT/v8Sh02m2DFPMNFIw43yqLKg5
        jIj0yWec2WwF5Jf2uPEnzvaS+cPTWReFLedFrNS2Da0f/3WwTNi2zMaPmqkM/1aKg
X-Received: by 2002:a9d:5e19:0:b0:6b7:54b1:6524 with SMTP id d25-20020a9d5e19000000b006b754b16524mr4557649oti.36.1688738196328;
        Fri, 07 Jul 2023 06:56:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFT7uVWhdX8H+KII3j64afpzIpjFPfqSi1VhYQ7wQdJmKWCkIZ4/DldFwQnKVCcDHzQ2XJQlg==
X-Received: by 2002:a9d:5e19:0:b0:6b7:54b1:6524 with SMTP id d25-20020a9d5e19000000b006b754b16524mr4557641oti.36.1688738196114;
        Fri, 07 Jul 2023 06:56:36 -0700 (PDT)
Received: from ?IPv6:2001:1284:f02e:6c12:3fa7:9073:5b23:9e41? ([2001:1284:f02e:6c12:3fa7:9073:5b23:9e41])
        by smtp.gmail.com with ESMTPSA id m14-20020a056830328e00b006b71deb7809sm1684336ott.14.2023.07.07.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:56:35 -0700 (PDT)
Message-ID: <9f12342f083bca94e3b7392c8e3bfbdca4d3e2b4.camel@canonical.com>
Subject: Re: [PATCH -next 10/11] apparmor: Fix kernel-doc warnings in
 apparmor/policy_compat.c
From:   Georgia Garcia <georgia.garcia@canonical.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Date:   Fri, 07 Jul 2023 10:56:31 -0300
In-Reply-To: <20230625011349.1457810-11-cuigaosheng1@huawei.com>
References: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
         <20230625011349.1457810-11-cuigaosheng1@huawei.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi, Gaosheng Cui

On Sun, 2023-06-25 at 09:13 +0800, Gaosheng Cui wrote:
> Fix kernel-doc warnings:
>=20
> security/apparmor/policy_compat.c:151: warning: Function parameter
> or member 'size' not described in 'compute_fperms'
>=20
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/apparmor/policy_compat.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/security/apparmor/policy_compat.c b/security/apparmor/policy=
_compat.c
> index 0cb02da8a319..18e4ddccf623 100644
> --- a/security/apparmor/policy_compat.c
> +++ b/security/apparmor/policy_compat.c
> @@ -143,6 +143,7 @@ static struct aa_perms compute_fperms_other(struct aa=
_dfa *dfa,
>   * compute_fperms - convert dfa compressed perms to internal perms and s=
tore
>   *		    them so they can be retrieved later.
>   * @dfa: a dfa using fperms to remap to internal permissions
> + * @size: the permission table size

I believe the size is returned, right?

>   *
>   * Returns: remapped perm table
>   */

Thanks,
Georgia
