Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591BDC433DB
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C764FF1
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhCDVqR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbhCDVqJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 16:46:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD6C061574
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 13:45:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id dx17so24782647ejb.2
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/jIt2s7Q0eFHgHDjIsWzLDkXQSa4GDJusn0w6/VBWs=;
        b=swnDs4vCPHoHZHuQLS0U2qI0CZQTG1t3aWZiS+iWzbdE2jTP6zVgdfli7+qdEryy59
         IM7pfwi0RsKGYYNeecreyiWzw7I87qj2GNu+MtvFblLOFrBTVr00hsBoKiqpD6HyotoN
         Nidpc+WE/oxBPAXjOi9OfhrEMIXIeH5ZLhYxFpb/7p3J7yoPN0w9bGXW6TFTPrXIHsAD
         HVZrUMjap/6MHl43Ixe84rrPKQpiUVtvJ7tKaqdV7fbRSnfbwy65a+0yghpuZOIN3G3W
         EnAwohwsOCH3/xpuPHL59SC59LgD36IHxnwjYyClScyl5gzhXlbYAn230pFRMPjFYvIt
         lriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/jIt2s7Q0eFHgHDjIsWzLDkXQSa4GDJusn0w6/VBWs=;
        b=nRmIPIgd8ITdp3U7f4KI3HnDlhydhbv34jNhN/Ljc0gmRvzc/bDaun51+fJnrFWHOO
         7tFnES8OHLPnp2oGyc1mMezIMK4HxetHPeH5QqIyaOds50NL/QDDVNaZlNQnfqEoBLA6
         4t+D1nQ07Jm0oA98cjbxmFTfmfMBZY9UjEYiftDeXeDtMbLNc5sFSUp73bN1SyUlbc5g
         YNdJmf4jwgDqT/dn+9QAt1tU1ESahxTDrEeXWEe5oP292zmHGizGe2F8O29etCPa98Kv
         sPwOFJCkVRHxd7Tir7BIZYT0wGCmEwjkzIrr8kgCV35VI28UuO9PjKrpYpVdyjkhVPLP
         +oag==
X-Gm-Message-State: AOAM530uLxRfDk7wzwbpZPX00EwAxdYRYoeqApmmH4ZVupN3uNQdpLSq
        xlQ8GoRwRCLMkWyoPjVKzriZ7YJ0w44iLZQQts8frbuhZEkdvhw=
X-Google-Smtp-Source: ABdhPJwNCi+6ZEkX7Lzsf81G0Z8WRmGKJmmTen5edPYi1Q2f4I8B0ODZHl5deTZWgsoFeaTCq9rRP43YAPLUJLUyTu0=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr6616321ejd.106.1614894328178;
 Thu, 04 Mar 2021 13:45:28 -0800 (PST)
MIME-Version: 1.0
References: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru> <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 16:45:17 -0500
Message-ID: <CAHC9VhSRKwiDB0Ekffs3DWWC6hzZy=2Nazzfg_UdE9vhffbv=g@mail.gmail.com>
Subject: Re: [PATCH] CIPSO: Fix unaligned memory access in cipso_v4_gentag_hdr
To:     Seergey Nazarov <s-nazarov@yandex.ru>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 4, 2021 at 4:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Mar 4, 2021 at 10:09 PM Seergey Nazarov <s-nazarov@yandex.ru> wrote:
> > We need to use put_unaligned when writing 32-bit DOI value
> > in cipso_v4_gentag_hdr to avoid unaligned memory access.
> >
> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > ---
> >  net/ipv4/cipso_ipv4.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > index 471d33a..28dfe40 100644
> > --- a/net/ipv4/cipso_ipv4.c
> > +++ b/net/ipv4/cipso_ipv4.c
> > @@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const struct
> > cipso_v4_doi *doi_def,
> >  {
> >         buf[0] = IPOPT_CIPSO;
> >         buf[1] = CIPSO_V4_HDR_LEN + len;
> > -       *(__be32 *)&buf[2] = htonl(doi_def->doi);
> > +       put_unaligned_be32(doi_def->doi, (__be32 *)&buf[2]);
>
> I think you can now also drop the cast, since put_unaligned_be32()
> expects a void *.

Yes, it shouldn't be necessary.

You should also send this to netdev as NetLabel code lives under net/
and goes to Linus via the netdev tree.

Also, looking at the code, there are a few similar spots you should
probably fix while you are revising this patch:

* the short/__be16 assignment in cipso_v4_map_cat_enum_hton()
* the short/__be16 assignments in cipso_v4_map_cat_rng_hton()
* the long/__be32 assignment in calipso_genopt()

-- 
paul moore
www.paul-moore.com
