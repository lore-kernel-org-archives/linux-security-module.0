Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FDAC35669
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6DD24650
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 21:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V3JYFzrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBUVSO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:18:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34858 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBUVSO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 16:18:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id c7so4067029edu.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBP7f40J0J3eKoNEz0Cylkg5NVkiiGfoOV/snLtt/Cg=;
        b=V3JYFzrWyZ1va3zBN9uGeCbiQztnLKwOF1eem4dxHD4E4fot+n7WJsHWtcaCF5mZn5
         GIZt3wgK4VtWVg0UKmVAzUTJhzHuWKUSWJB4EpHdvsVmnchFkDM6H36v5c/5RSzz/Sd5
         PxEf2QU9vkDMJrJFEyhbXoLZ+OWsgEtL+Z/lwsjghBdw5KaUbFBlxut5id6DcNJOhZ0C
         yoMm3b7BMVvCkLYMLLPIbqzYLUuBtEnTa2AUk4SlDvPL2E6nrtC6/LLZeSZt2jXVDyUx
         o+FN+rbBgwei1Ihrpm/D/c+448FiMwuyTZBqETW69gfS3wavIWzMvO6H9sTjfJYhAwl6
         SVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBP7f40J0J3eKoNEz0Cylkg5NVkiiGfoOV/snLtt/Cg=;
        b=N7Q2NDHday2x6nIQI/t46HhYTGBziT0V56QEpn6jiZS2urziSuWg+0QR+S3KpFbGV3
         lb3Y8eLDvDq/fQlq04fxbg+rg+oxumNUgOrOjDN4NQQxIPc44W2/jwi/rflvBiKvLnAh
         +VZdcUWKOnRsfCP0QGkRkl0m7ZNqoeC6Egnku1yz/tgwbdfMDVFAu7qVUvfMV/aHG/OW
         8340TTujxzCINUMaKY2EFCQrx1xZJsMD7cTW9gRbB3iHPphhLIznh8e5XJJDD7ut15XL
         GmQP/hxeNeYUxSq1KlrV7O7no7MDWJsA5Tur+kEiqJ+qGAqcywy9GU3TWFxKd66wpF2I
         HUEQ==
X-Gm-Message-State: APjAAAVZs2egkUXOmbow91ZYx3lialxeT424NXBgGLHGRVQAltK369Xs
        tfSRnhkjFSk5PoyoCmASELgnYXCBpV8TnUmrtRBO
X-Google-Smtp-Source: APXvYqwCnuHPxngKHrdwK9m0w5wDcMtUvOAkK2zHaDns4aBOr8SsmmUQVeLaPWo5verGntkAvMm/xRvqhpkxegxUeog=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr34496938edr.164.1582319891719;
 Fri, 21 Feb 2020 13:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20200221112838.11324-1-mcroce@redhat.com>
In-Reply-To: <20200221112838.11324-1-mcroce@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Feb 2020 16:18:00 -0500
Message-ID: <CAHC9VhQdN571U3-xGpMc44uwkwTayQ5n-yqvouF7q=VurtcS9g@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ensure rcu_read_lock() in cipso_v4_error()
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 21, 2020 at 6:28 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Similarly to commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in
> ipv4_link_failure()"), __ip_options_compile() must be called under rcu
> protection.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This seems consistent with the ipv4_link_failure() fix, even though
ipv4_link_failure() has changed a bit since the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 376882215919..0bd10a1f477f 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1724,6 +1724,7 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
>         unsigned char optbuf[sizeof(struct ip_options) + 40];
>         struct ip_options *opt = (struct ip_options *)optbuf;
> +       int res;
>
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
> @@ -1735,7 +1736,11 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>
>         memset(opt, 0, sizeof(struct ip_options));
>         opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
> -       if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
> +       rcu_read_lock();
> +       res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
> +       rcu_read_unlock();
> +
> +       if (res)
>                 return;
>
>         if (gateway)
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
