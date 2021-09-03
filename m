Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D780C433F5
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 14:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1289B610CE
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 14:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhICOJP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhICOJO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Sep 2021 10:09:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C8C061757
        for <linux-security-module@vger.kernel.org>; Fri,  3 Sep 2021 07:08:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e21so12318555ejz.12
        for <linux-security-module@vger.kernel.org>; Fri, 03 Sep 2021 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cdPH0RUrZjKAXah7cowHX5Y+IopONEnkhgKNCSY3VPw=;
        b=Vf1l0IL5pe3MFxiQdNRXIyLZxAIBZiZdFrcYZ+LpU2j6vhQiUbAlXd4yfIpm9/1SZV
         VY1GK9B71BNVjo49ax2WMFtEeTRLW8B8oo7rgRpy3VGigfjw3xO3lXqP0YJjrwOILgDD
         TTrxgbeKlQGdbXYvykcCoNHtka7KLU+8jYrpz/98gHHt6gw3WSvrC8vA0B6pF98ixq6o
         WuKf+ulUvi+z1mYpANjUZ/pK8/Nzdgoupppl11Vfug12v7Y3c3x3/HDYZrmK6uTqrZwr
         1z/3orDN8UUCrN4wQY3fGV9CLl+hArzm6XKOrCAcExRm5aFg0kTGaQaLRQGUwcbo0GYO
         bdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdPH0RUrZjKAXah7cowHX5Y+IopONEnkhgKNCSY3VPw=;
        b=tmDMi2f7fJU1y3eeTreZsUdxAiliTUule3fzBfnu6nlViWsW95sSvUizodfAAQxytJ
         tEdCU6XrrOl64eni64g0cmpt3E4oojkn9lxJo+jLUneh4JHz7OvpgLC7FiOrWjus/yLP
         wyL+z8/rgwalop8ThuG6y+kcjGpDZ041HoxP2iA1qaGa835lBfT+Lu5w9JRkhKTYb/uY
         TB0TT/9VEo3uB1mWZg9xK/OXmTyGvSWGywNDQjkmwuppi81FWDdKDXNVrcNPqEn+WBTG
         DupSszYPAvSIgYpjqF4hjVjHrz2FrmKWgK1eTR9EMQom0NF2irTVvoaaD2HnKB/w8yc7
         gRGQ==
X-Gm-Message-State: AOAM530g+o8Dls7KZOrXj/rXAR0jSwGLtXtY+qAWNy8hjxQ/vHGfYlhH
        Vjs4asulbPjQPa4jwl+/MxVyGH4UK+r1mszUj9bN
X-Google-Smtp-Source: ABdhPJwbSl4jRpGYOLS5AmybLrWXMIoT85h9FP8yaT+M2JBwaP3KkPlqliaddTmXQhWSJzuTbtqTa3Yxk7ZFssRzTlc=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr4325477ejj.157.1630678092913;
 Fri, 03 Sep 2021 07:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com> <53f6b3fe-dde3-c35a-5ee1-ff480936b356@linux.alibaba.com>
In-Reply-To: <53f6b3fe-dde3-c35a-5ee1-ff480936b356@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Sep 2021 10:08:01 -0400
Message-ID: <CAHC9VhSR8ETPaNVv6506z-wji9KCbRkrgzw0bC9uNtK7nSgzbQ@mail.gmail.com>
Subject: Re: [PATCH] net: remove the unnecessary check in cipso_v4_doi_free
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 2, 2021 at 10:27 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.=
com> wrote:
>
> The commit 733c99ee8be9 ("net: fix NULL pointer reference in
> cipso_v4_doi_free") was merged by a mistake, this patch try
> to cleanup the mess.
>
> And we already have the commit e842cb60e8ac ("net: fix NULL
> pointer reference in cipso_v4_doi_free") which fixed the root
> cause of the issue mentioned in it's description.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  net/ipv4/cipso_ipv4.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Verified that the v2 patch is in net/master so removing the v1 patch
as this does is the right thing to do.  Thanks for sending this out.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 7fbd0b5..099259f 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -465,16 +465,14 @@ void cipso_v4_doi_free(struct cipso_v4_doi *doi_def=
)
>         if (!doi_def)
>                 return;
>
> -       if (doi_def->map.std) {
> -               switch (doi_def->type) {
> -               case CIPSO_V4_MAP_TRANS:
> -                       kfree(doi_def->map.std->lvl.cipso);
> -                       kfree(doi_def->map.std->lvl.local);
> -                       kfree(doi_def->map.std->cat.cipso);
> -                       kfree(doi_def->map.std->cat.local);
> -                       kfree(doi_def->map.std);
> -                       break;
> -               }
> +       switch (doi_def->type) {
> +       case CIPSO_V4_MAP_TRANS:
> +               kfree(doi_def->map.std->lvl.cipso);
> +               kfree(doi_def->map.std->lvl.local);
> +               kfree(doi_def->map.std->cat.cipso);
> +               kfree(doi_def->map.std->cat.local);
> +               kfree(doi_def->map.std);
> +               break;
>         }
>         kfree(doi_def);
>  }
> --
> 1.8.3.1
>


--=20
paul moore
www.paul-moore.com
