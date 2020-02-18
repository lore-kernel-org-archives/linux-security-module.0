Return-Path: <SRS0=lArx=4G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64383C34031
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3517922B48
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="D6s6qOgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRWu1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:50:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36656 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRWu1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 17:50:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so26750110edp.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Feb 2020 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41cGzlU4cjOdIvYsB+FQ4XEqSVKoQUwQYSLczOx+4g8=;
        b=D6s6qOgHjccdc5oGSjGRqwxlUW6kIZZPog/sURVbWHbS3Cb2XZFtNtalcUDhRwfi6c
         KMZWzKfrC9mjM8IfBy+t8tO2xdGQO+8QNww/Q4b2NHygytY/qtPrMxTkYbL31pcagluO
         5zNenTvZ3/qZYgulcelTOG5nWniaGs4zafcOmLeLMRy2p4ka8WukVSjL2QbDzZoR7r2o
         G4BZaqyM+UQLcIWT4GWLsdbZuUM0A0rLKMIi8L4q3+EFdxfNpMA7fI42E44VacWDurBQ
         ym1Xbj1x8Si0Qj39ehvo8PwoG3gAd3+PghuaUB5/p8U6zX+Gq6Uq67SUYkmfbAPYZszj
         0S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41cGzlU4cjOdIvYsB+FQ4XEqSVKoQUwQYSLczOx+4g8=;
        b=jJ2pKeYDKiaPBkUABgLtYNPl4r8T2AXTqbOmIooDA5H/a25nBfw0OUMqNlMK+cNeHd
         IMdEsVEJ7RGTPEHolS3rbpTsz0Y6FGGGCBfVwiOnUn9saXfT+VNwAddtW6Iz51VJp38i
         CrXvuCD//Ct+HYshANO5dLzBd3erdaQJZnI6dL2/+63AnYbUmFyX+OVWmu3PqKxN8T1F
         UerFhKTKyrAp+5QBHB0/eoHWCsWURXsyBkH4mCC3j7nmzEvE6FkEB73EWp904d95Iu1f
         /gXIgN0Rs4rrRa2kOBJeEz2mIOOMybndwmnI16vJQmQyEWrnx5L4fINyH41EKFoGcv2t
         eSFw==
X-Gm-Message-State: APjAAAW4Dy5czdr/EOHBY/5dn2aDIZ2F3XBTYGRj9TbpIfNJ8ifsalTk
        45d+IguuxCZCrIw5eBzJctioc2y+EGIyYryakwzO
X-Google-Smtp-Source: APXvYqyhhYGjJi44BuMzGcIPQERfVr3yRw9OSPDNrlzTgybuGmGK43HZ9IiGu1tLojzYp++JzNqAIROsoipZq7DV9xU=
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr21930378ejd.271.1582066224967;
 Tue, 18 Feb 2020 14:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20200218184132.20363-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200218184132.20363-1-madhuparnabhowmik10@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Feb 2020 17:50:14 -0500
Message-ID: <CAHC9VhShJnD-YnGNN7eYK3k5B3uJd7KVmG4oATboqWGXvFuv5w@mail.gmail.com>
Subject: Re: [PATCH] netlabel_domainhash.c: Use built-in RCU list checking
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

On Tue, Feb 18, 2020 at 1:42 PM <madhuparnabhowmik10@gmail.com> wrote:
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
>  net/netlabel/netlabel_domainhash.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Same as with the other patch.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
> index f5d34da0646e..a1f2320ecc16 100644
> --- a/net/netlabel/netlabel_domainhash.c
> +++ b/net/netlabel/netlabel_domainhash.c
> @@ -143,7 +143,8 @@ static struct netlbl_dom_map *netlbl_domhsh_search(const char *domain,
>         if (domain != NULL) {
>                 bkt = netlbl_domhsh_hash(domain);
>                 bkt_list = &netlbl_domhsh_rcu_deref(netlbl_domhsh)->tbl[bkt];
> -               list_for_each_entry_rcu(iter, bkt_list, list)
> +               list_for_each_entry_rcu(iter, bkt_list, list,
> +                                       lockdep_is_held(&netlbl_domhsh_lock))
>                         if (iter->valid &&
>                             netlbl_family_match(iter->family, family) &&
>                             strcmp(iter->domain, domain) == 0)
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
