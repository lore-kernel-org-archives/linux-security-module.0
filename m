Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D0C04A94
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjHAQm4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHAQmz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 12:42:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E22113
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 09:42:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5861116fd74so25504517b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 01 Aug 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690908167; x=1691512967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJYAPQwhBH1tNOvk5+y2uVRsR1UJGpdCrK2Bal18A0=;
        b=fo9mfeegk2LZX5Y9ejYMeXp/LJ8/FRNtPKHEZgMtxPeVzBgwXm8WzfWk88smxlKVYi
         Hd42QGXOSea0phSxPKSSLyqx7B4JovEA//JrDPfPXsGIMo50We4ORJz8VmGxy8MLp+ec
         zT6HHGsQ4wkdsBzj3/bmD260rYeJ86Y9kroB25RdLxWCX+LgbJUTSVily+9aa5O3lnzl
         uuwenZqAod31RmF7zJp0d7ZmOC47nHPJcLCyF8zK6EnKn0AcrOhnMDNc0TTxoqUaM8PN
         TQO0QsJrmq+wshK8SzU+VjPK5F6VC7S1FHx+dRADt56zmbeJufekWYhTtK61Qi5q0yCi
         YLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690908167; x=1691512967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjJYAPQwhBH1tNOvk5+y2uVRsR1UJGpdCrK2Bal18A0=;
        b=i1TEWQ9OlWMVepXRNBpj74L+K9sZ42SPuSh9fwfoNfejqNoh9sxck5erDVTdU/ysJ7
         gIYgHmYQCDAGx68k2DZIrvwttKQpDHdvw4EjcWsHb5g2bjn+gD8FcEAqP+DZf1me6cVu
         k1oR3BQPb4UeW8ypTn8VnxdaB+fsXpXVl/ik+hlKZkXX8sGdPbnVm2kUpaUa4P3aVH3x
         03ZyZEKu9pHkk9VHFwk2hORipIuDdoWf2UUl4Uh2m0fNdojeZvZkKQfGQ+Gw7AacsqcO
         ebAG/cTBgkZ2wvaJJEEWd1WTuXnYRHduJ0qGY2rzpI3/TcgSCp+EHlz7DVzDkbb6E0kd
         wzLA==
X-Gm-Message-State: ABy/qLYAoK10uNWt73C4BIKelFDqtXLe/X3M3bbTYZ3olKL5qTJb+2tS
        krYNZWDBNWMKvLtzqH4UperhPj/A576hVambX58p
X-Google-Smtp-Source: APBJJlGBqmDaOnxMqThBvheaXOpM8pw+v+T95Y+Q4Tx2EZUrSCxjIN7ezDKQKzRWz7GBOqeid5FjuLfmkwi/J6uWolQ=
X-Received: by 2002:a0d:ea01:0:b0:57a:8de6:86b1 with SMTP id
 t1-20020a0dea01000000b0057a8de686b1mr11087937ywe.31.1690908167207; Tue, 01
 Aug 2023 09:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230801143453.24452-1-yuehaibing@huawei.com>
In-Reply-To: <20230801143453.24452-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Aug 2023 12:42:36 -0400
Message-ID: <CAHC9VhSqvzogdH2=PuGnD5W4FAquWEL5Se2qVvzyAMP6CQ1G0g@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Remove unused declaration netlbl_cipsov4_doi_free()
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 1, 2023 at 10:35=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Since commit b1edeb102397 ("netlabel: Replace protocol/NetLabel linking w=
ith refrerence counts")
> this declaration is unused and can be removed.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/netlabel/netlabel_cipso_v4.h | 3 ---
>  1 file changed, 3 deletions(-)

Thanks for catching this.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
