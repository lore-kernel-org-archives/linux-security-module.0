Return-Path: <SRS0=R80q=QB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FFC282C0
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C64218CD
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p+9RrB0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAYQqB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:46:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33273 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfAYQqB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Jan 2019 11:46:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so7423799lfc.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Jan 2019 08:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUBTBhsoEod0r+sPpZj9kpX0Q0Wrx8sRS3fdt8CKxGc=;
        b=p+9RrB0oR52i0OvEXY0QyExAG2XuSqMRCUQn0rrKiHD0PgL5CQUxzQeOzGBFEPqmQz
         82mE4gdKo4r5rgZ6FTfDwa/9o7vVm1PKfKTBOGaZHPL4cCpyGkYQCnjiednC2NmhE/5J
         7t/kKLHbMLtxh3RJW3OLZYnbshFYUFqtRpZW/qtbmoYTHaQpLX1DWLNhJeBZhqKqfzKO
         WtHZZJP0sbvFQsjOM3CmpCpHCBewbxek0lDWgwgoNNJonaPMvvtfG6DW9RzWXbyyauqM
         9LSiNjQXaMmO/IpiWlFgTaUhrZyOA0SKUu8ZUmEozEncw0PXwN2EBEXZwd5xtXVtrhop
         7I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUBTBhsoEod0r+sPpZj9kpX0Q0Wrx8sRS3fdt8CKxGc=;
        b=N+mQB9Gat6v4a0ZvN9OpGiLRtflFn+t0mANNi4Qk++o8r5/ROeYuzkK5brXQZnqKMy
         RnNAr1fmx7WBQgQ0pNhsBoHU5xYhsNWByYOrvNkln0Wca7NTuheZENuhioSGdc/yvjsA
         i1a4+bKt+wEJDd3BSJlVOv2WeWdyzGRFMopaGeVtqpGqmAiZXVrMqvYeojwtkqD/JOgW
         PIa7+su8gvgY8AP55XNR61lpDRzgX4nf5QJpgtBsdG7//NsKcL2xPgtx0iCCVKQWx/id
         kIUK3Tho6SXFhXQ69M+mH7uUIWccNyfbUwvVZ4INhRZw/xxRrrfbrGjNj9nOEyQXqW9D
         AM1g==
X-Gm-Message-State: AJcUuke+bCKR0vlq06no1JCdwbq4LWfckzeITeXnMvB+r5Fyy1xZOB+y
        VcRlwkfgN8VrrpWFJ//CJP+nacKMmF4+84GNsuWW
X-Google-Smtp-Source: ALg8bN4+Y+aYnJRDyelJmS00jvlxMtDpkz6K2smhwQKLYoaVxlnHEaIJXnd/Xm6FwgezbiPCD/gswdxduAYWTcxlemU=
X-Received: by 2002:a19:4287:: with SMTP id p129mr9428851lfa.135.1548434758604;
 Fri, 25 Jan 2019 08:45:58 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
 <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net>
In-Reply-To: <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 11:45:47 -0500
Message-ID: <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 24, 2019 at 9:46 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 22.01.2019, 20:48, "Paul Moore" <paul@paul-moore.com>:
> >
> > Yes, exactly. If you don't pass the skb it shouldn't attempt to call
> > icmp_send() in case of error.
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> You are right, sorry. We can do that without ip_options_compile modification.
> Simplified patch 2:
> ---
>  net/ipv4/cipso_ipv4.c |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 777fa3b..a4ed0a4 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1735,13 +1735,27 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
>   */
>  void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
> +       unsigned char optbuf[sizeof(struct ip_options) + 40];
> +       struct ip_options *opt = (struct ip_options *)optbuf;
> +
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
>
> +       /*
> +        * We might be called above the IP layer,
> +        * so we can not use icmp_send and IPCB here.
> +        */
> +
> +       memset(opt, 0, sizeof(struct ip_options));
> +       opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);

Hmm, I think the above calculation should take into account the actual
length of the IP options, and not just the max size (calculate it
based on iphdr->ihl).

Beyond that fix, I think it's time to put together a proper patchset
and post it to the lists for formal review/merging.

Thanks for your work on this.

> +       memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
> +       if (ip_options_compile(dev_net(skb->dev), opt, NULL))
> +               return;
> +
>         if (gateway)
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
>         else
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
>  }

-- 
paul moore
www.paul-moore.com
