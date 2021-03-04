Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695ABC433DB
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3830664FF9
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhCDVTL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239427AbhCDVS4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 16:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614892650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEHCVfDeqdqA0zHDaZmd5D5sQXOzeEofr2j0KxvLlo4=;
        b=iRicODzS1gxo0LplXlBKZe33ZaEuyMIwz2BQ+eqwqUwGuIbfBeCJD//zu5PGU2agLvo1Va
        6aDiWeiIlhsA8FCZbn6PCJMWQsa4XMkknm+Ebp38Maogu5uFWqaYfCC4sjIAWbwLOPmFSx
        0erEkKijDIOTr4hHvPH/b1hqK6DA9WM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-qKvvXZUhP2KRlaGlqAcOzw-1; Thu, 04 Mar 2021 16:17:23 -0500
X-MC-Unique: qKvvXZUhP2KRlaGlqAcOzw-1
Received: by mail-yb1-f200.google.com with SMTP id 131so5750ybp.16
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 13:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEHCVfDeqdqA0zHDaZmd5D5sQXOzeEofr2j0KxvLlo4=;
        b=op9CqfY3xZZ4rwVPAhw0/8/W/IeQ9+uzZiLZJOFl4N5GIfxrSwoqIHHpKFnlvChWA8
         uqk91xruWEgBwmFWceHAvloEStZMlJGHA5LTq8AUHF7m9W1gLBy2/7aK5Vfk4dlFhV6O
         aiexUCZS9o3pYws86MX4FcTrjTrDm9596wQN702oGVOmA9/Hchw7uQlGykKUeEoBPn7e
         5lWxGrRRzVh+hf861W2V3qD1UiZz4s5cxXrqkBV8ZfkyVPxSovSftT8MtDTf1wlSxVGr
         ljsOZYbJa2dgoJLFM35jW97b3lfFGCJ4gvnikItudcMvwIMqUMlNEyG07Y0gfQh3LlP9
         yv4Q==
X-Gm-Message-State: AOAM533JrhXtj1IF/uS0BUfi/Fg5LY0wzFJGlOZQqEQ7CTz7jnCwpY8Z
        aejvypQLS2+9TgiCcyXRX0CMsgASYIHWEIsVeANw0pHN+6yhpRnAdK3nZ+KDqHGp3q2uPjzPzVt
        2nJwRWoPFD4u5y4klI+cyPwiOXaGYk18/M72ZZPbhbVEmFaTDybEP
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr9547832ybf.26.1614892643159;
        Thu, 04 Mar 2021 13:17:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzqaO4ZafNLOCdeeC+5+ug6tNXE2iBQJAXwtdFrw3QifmaBk4NpmHQ+2voaIGv6/NToczYTUfRYZWahQKuxEI=
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr9547817ybf.26.1614892642994;
 Thu, 04 Mar 2021 13:17:22 -0800 (PST)
MIME-Version: 1.0
References: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru>
In-Reply-To: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Mar 2021 22:17:11 +0100
Message-ID: <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
Subject: Re: [PATCH] CIPSO: Fix unaligned memory access in cipso_v4_gentag_hdr
To:     Seergey Nazarov <s-nazarov@yandex.ru>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 4, 2021 at 10:09 PM Seergey Nazarov <s-nazarov@yandex.ru> wrote:
> We need to use put_unaligned when writing 32-bit DOI value
> in cipso_v4_gentag_hdr to avoid unaligned memory access.
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  net/ipv4/cipso_ipv4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 471d33a..28dfe40 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const struct
> cipso_v4_doi *doi_def,
>  {
>         buf[0] = IPOPT_CIPSO;
>         buf[1] = CIPSO_V4_HDR_LEN + len;
> -       *(__be32 *)&buf[2] = htonl(doi_def->doi);
> +       put_unaligned_be32(doi_def->doi, (__be32 *)&buf[2]);

I think you can now also drop the cast, since put_unaligned_be32()
expects a void *.

>  }
>
>  /**
> --
> 1.8.3.1
>
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

