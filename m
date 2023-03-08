Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D3C64EC4
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 22:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCHWH1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCHWHZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 17:07:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5EA5C5
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 14:07:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso309078pju.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678313244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQb53TQ7jWjrEo8sZG9DhLdkMLNjitlbjL6y90s2PWY=;
        b=WNYUrIdGov1iosyvhxsB05hEOX1arj5iNydmRhSR05hYSii/ViznbO+kJ+b21SXEcZ
         nGPIXZ43YPKacoug3TO8/A1TBv51suiAGU9zZkGJiy24nAson5EfbbJHsSrG0Y4H9176
         hQyrLAicG27qJ2ZkYvl6unImMvE14J24MOR4UmxNlK6bclU4dbs2FQ6ObngCi6yXsbXu
         zZDAjX5cp0MtuHB5dGEzrZUyEVBUZxIATdVmRs8XFoGo/dQYwReRo06xYlbKQCc3Q/yi
         xhyaB4Nl3zf6HngiZgGeCRTTww+ATRf0yCOLTQjX+YnvL8WoTbC/+c+Nh2nEuiHkVWCV
         KxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQb53TQ7jWjrEo8sZG9DhLdkMLNjitlbjL6y90s2PWY=;
        b=ysQ8REBA0qefgZG8AoTJeG/aaMmUF9zFeGHI2Dg91IixowUWVyDQVfYPDMc7YfsNMX
         ey5Zo2LVpmh2dl8hhFBIZnPlIOx7uiZOLjw95i/aUIq2Q+DvyDmGkvL3Pb7RMzSiXUit
         Q/3vJ8aK6tIttaRKTHkmgnpQZsvdvQZW3aFMpjToTy2dAEgduTSE6T0NgupA7BnwTEbL
         ZZAimqssmkPuxhvzs9Wa1k5v+Mu1iPcECprsgx4SQm/HapVmVVI30/zlMGDMNGBuqutm
         MBp2ptNYcFA4ebj2KBcVhffl3z/QL9p6/3ofMvg2eqtpaXp6/PQYYfHcH2k28FooYm9Y
         QCGQ==
X-Gm-Message-State: AO0yUKUW91TcO7yM6sGPO/FnezaBftWgHHChMTYa73IBu0hjEhszD2nL
        psLOW9VxtDFVlUgGvre9jveMwpyzF7iDGmLiLGfk
X-Google-Smtp-Source: AK7set/uRNoQjUWqSPoMNt4AAqS3kc6Wxz67c+jaYkuinhju+8pfMGgIn7RSzk0NA4o02KGBfzlRWxZ3MCnbIQ14WmM=
X-Received: by 2002:a17:903:4285:b0:19c:da35:6699 with SMTP id
 ju5-20020a170903428500b0019cda356699mr7579863plb.7.1678313243799; Wed, 08 Mar
 2023 14:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20230304072923.286534-1-kamalesh.babulal@oracle.com>
In-Reply-To: <20230304072923.286534-1-kamalesh.babulal@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 17:07:12 -0500
Message-ID: <CAHC9VhS_uvWRK+AuvoDLrAJrbjWNmnnC2MLaBnMpDEFv_y-zkQ@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Fix typo in devcgroup_css_alloc description
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Mar 4, 2023 at 2:30=E2=80=AFAM Kamalesh Babulal
<kamalesh.babulal@oracle.com> wrote:
>
> Fix the stale cgroup.c path in the devcgroup_css_alloc() description.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
>  security/device_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/next, thanks.

> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index bef2b9285fb3..7507d14eacc7 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -216,7 +216,7 @@ static void devcgroup_offline(struct cgroup_subsys_st=
ate *css)
>  }
>
>  /*
> - * called from kernel/cgroup.c with cgroup_lock() held.
> + * called from kernel/cgroup/cgroup.c with cgroup_lock() held.
>   */
>  static struct cgroup_subsys_state *
>  devcgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> --
> 2.34.3

--=20
paul-moore.com
