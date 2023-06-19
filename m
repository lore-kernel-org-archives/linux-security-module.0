Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E80EB64DA
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 16:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjFSQG6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFSQG5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 12:06:57 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C161AE
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 09:06:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570002c9b38so42201847b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687190814; x=1689782814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Gz+pnHILNa9vWsNogxJJDOmyqbXg0zg3q5EITIlyc=;
        b=cBZoYDbHUrKhlJCdSIqjbSOIiuXD8YwnymLZ9S75FsrsLTa4U/5c289R7l8No3uhUo
         /V8c/HXr9O8bUYXlY+C0kyTeIPWtdxflMTa7eGHyqRd203pDb0pkmv6rTaQyg8JIEwQh
         E7IobhpfiNG8CkR/P/kzC6DkDsPTp93jUcawIzWVc8gNYPgThtGA0hXHgHLclnn1QNnh
         5r2kceqYplEfKZE8TtCcXzjLcZMeamsZZwFgjv8GktBBo5CshHurrT+dLk8m740EYRAD
         fQ2JbmcLZxJbrAVH2rOHKM/vHktRkG3sAhLKPMkMiGVUC9G49tlAxFWx8xsqn6aRAHso
         3tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687190814; x=1689782814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Gz+pnHILNa9vWsNogxJJDOmyqbXg0zg3q5EITIlyc=;
        b=HZ/9HPWSx1IpBzi9RGeYqlGiBYMXs706zdi6+Ugj4sD1H9VVIhVCnvP9G1dbueourl
         Jf4/Bs6O9i5EDZtJCK462D0vkCiSZvN71lP4EnxkJ3U/v/3NQiE516GYCSSccb/tqtJE
         mVDth4NYPLNjQ+gpiRGo0QkDZ+l8Uw0frsaOuhD96QTVGtet0BikZFffOu5zCfWMir2Q
         qWuzhvxlj8LhCyfOuvPGYbACjDgp7u+TCBrj+xIiBtcpVDRhkGNAbX/JBotPK1hVoTrE
         1cd2t9n4AYtlU7eR3WZfGuUZRU6jA5fqdw4CcxC1Kt9N42DNoKmsXUk5WOW+J6XtrxCN
         l1VQ==
X-Gm-Message-State: AC+VfDwV5lbIEY6DLJJNG/UTWpRyauzmHYjz2Od2Fi8pWPrXVhCNo17d
        msJyBVlS/99aUVMwyXAhSpaFU+OPcBVMHcZv88qz
X-Google-Smtp-Source: ACHHUZ6Pm/zBPHr7GxLINf+kQ3ucnOJrHhsX5RZRZ7fWZLZ3aeqR5bT2dsKcT1WNl0Mxf4joP/ftAF6WpPnMN8Kw06I=
X-Received: by 2002:a0d:e892:0:b0:573:527b:747b with SMTP id
 r140-20020a0de892000000b00573527b747bmr2700111ywe.36.1687190813964; Mon, 19
 Jun 2023 09:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 12:06:43 -0400
Message-ID: <CAHC9VhTu4dEbi0Sj1F9R+OR=5BfOzQNq5fBF9MWag2QxxMtfwg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Reorder fields in 'struct netlbl_domaddr6_map'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 18, 2023 at 6:16=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Group some variables based on their sizes to reduce hole and avoid paddin=
g.
> On x86_64, this shrinks the size of 'struct netlbl_domaddr6_map'
> from 72 to 64 bytes.
>
> It saves a few bytes of memory and is more cache-line friendly.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Using pahole
>
> Before:
> =3D=3D=3D=3D=3D=3D
> struct netlbl_dom_map {
>         char *                     domain;               /*     0     8 *=
/
>         u16                        family;               /*     8     2 *=
/
>
>         /* XXX 6 bytes hole, try to pack */
>
>         struct netlbl_dommap_def   def;                  /*    16    16 *=
/
>         u32                        valid;                /*    32     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct list_head           list;                 /*    40    16 *=
/
>         struct callback_head       rcu __attribute__((__aligned__(8))); /=
*    56    16 */
>
>         /* size: 72, cachelines: 2, members: 6 */
>         /* sum members: 62, holes: 2, sum holes: 10 */
>         /* forced alignments: 1 */
>         /* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));
>
>
> After:
> =3D=3D=3D=3D=3D
> struct netlbl_dom_map {
>         char *                     domain;               /*     0     8 *=
/
>         struct netlbl_dommap_def   def;                  /*     8    16 *=
/
>         u16                        family;               /*    24     2 *=
/
>
>         /* XXX 2 bytes hole, try to pack */
>
>         u32                        valid;                /*    28     4 *=
/
>         struct list_head           list;                 /*    32    16 *=
/
>         struct callback_head       rcu __attribute__((__aligned__(8))); /=
*    48    16 */
>
>         /* size: 64, cachelines: 1, members: 6 */
>         /* sum members: 62, holes: 1, sum holes: 2 */
>         /* forced alignments: 1 */
> } __attribute__((__aligned__(8)));
> ---
>  net/netlabel/netlabel_domainhash.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
