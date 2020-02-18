Return-Path: <SRS0=lArx=4G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00793C34031
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61E822B48
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ih8OVG9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBRWtK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:49:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40083 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBRWtK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 17:49:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so26739571edx.7
        for <linux-security-module@vger.kernel.org>; Tue, 18 Feb 2020 14:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6bGLfW+S3PbTSNe7BlkqXOXTsrm4VZ4lQdamKUPW64=;
        b=Ih8OVG9omwJ6Rxw+SlKjwczxNf0k2Ng94CvXCZbV3YDaX3UQbLCeVFJCDBgE+/TbWa
         949c1MNdpMLpcyDXtROzVlkZqcqThZvj3dhD1ALAKRu2iuAubkhK1t55o+Mi/JGULJQA
         Do0mKi+fIwpeSajmK6ZtYgsGWtcp2ixmaSSIN7Z+3VM59asG03lUut8OZYU+OftobKN/
         FARxahH/c9osR5/SjqCdrfiIcl3zufcnKdJwz8aagy+PHbiKJZq82UM0DiByhRA429++
         amw4egh1MaKmoNsfmmEllJZPFRXMrhRAJ3PBPBSRTfXKHz76UknYvpsHjXKYCfr9H+iG
         sLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6bGLfW+S3PbTSNe7BlkqXOXTsrm4VZ4lQdamKUPW64=;
        b=rkBjYWtIgxmdmDikaq+TA+0qHcXC+g5rnBJrLlpfmO3U2aZ4l5M9rx8hkPJ3vmKEsw
         P7bFKM0W2F4dWstS4OYIZEVKGlCQoDLG7xjpJwdkqz5Kf9fj9xtP3+8SWoke7BFZrX7V
         5tCJ2dUkDnHNWVkJtOlPumfIxf2aJGf4yaPaZFwTJof16BAlq6i53byLYViiPZfgyNnC
         DUp7CsmfedqFHrjrKeN7J+XC4InwBnjVIxRmsTFKPTGwYelqTFg7+0lKqOx7GANi3z1i
         pSgvOFcYhvzhN9r1tIi/CaumWQbFkCTzzDvFNxd2AkcOr8pNqgSEtxeiOEngZPZQ5Pe+
         jkug==
X-Gm-Message-State: APjAAAVUhaj5nY0vwlcR4ThTptUdCZ7z2Kn20vWrVcdIo79M9obrIOH4
        vv/oHXEWteOhcekh+pKz8h1FzRlVdG5b8PF+7NYG
X-Google-Smtp-Source: APXvYqyL9+hoGiE8tChYcCVk+t7iqdIxiz2N27oHXffytLSJrvsGhrrkoMyf4wu5HG59PmlYeN3uSH1WjtWg9WFGERg=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr21225090ejb.308.1582066147205;
 Tue, 18 Feb 2020 14:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20200218181718.7258-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200218181718.7258-1-madhuparnabhowmik10@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Feb 2020 17:48:56 -0500
Message-ID: <CAHC9VhSzqccDgt2EAPqVmTFCcETrKrkUDRoL-2YzzSFGfYJGQg@mail.gmail.com>
Subject: Re: [PATCH] net: netlabel: Use built-in RCU list checking
To:     madhuparnabhowmik10@gmail.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 18, 2020 at 1:17 PM <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> list_for_each_entry_rcu() has built-in RCU and lock checking.
>
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
> by default.
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Not that this has much bearing since it's already been merged, but for
what it's worth ...

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..77bb1bb22c3b 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -207,7 +207,8 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>
>         bkt = netlbl_unlhsh_hash(ifindex);
>         bkt_list = &netlbl_unlhsh_rcu_deref(netlbl_unlhsh)->tbl[bkt];
> -       list_for_each_entry_rcu(iter, bkt_list, list)
> +       list_for_each_entry_rcu(iter, bkt_list, list,
> +                               lockdep_is_held(&netlbl_unlhsh_lock))
>                 if (iter->valid && iter->ifindex == ifindex)
>                         return iter;
>
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
