Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E9C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6833D61039
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhJYIBS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhJYIBR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 04:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeUaEKBazBPDsRvPc85+E5svUhK5D7xGXblBBx8ImfA=;
        b=Clz6J//BFpQNDAx8pe7PPCKQ3fq/tjYeR2MZ0V5YrgwEYgtASBHVLBjp+srtwg2QWi2oCc
        EWc/e5JVdzEO/rvtOHAOheVUki3B845xstbfoXCUuVDVhAVO/6SejohZGBnyVucw9wmePy
        ZWYBufKYBkH/Gp4OCJk47638/46MJ8Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-tLScq13FOU6HSo2hAh3d3g-1; Mon, 25 Oct 2021 03:58:54 -0400
X-MC-Unique: tLScq13FOU6HSo2hAh3d3g-1
Received: by mail-yb1-f198.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so16042484ybk.16
        for <linux-security-module@vger.kernel.org>; Mon, 25 Oct 2021 00:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeUaEKBazBPDsRvPc85+E5svUhK5D7xGXblBBx8ImfA=;
        b=AHD2I6Q7r2omhRXKUytef7WKuEpvYHc0otji9KIrUsgDj1avCpH+1HtJX255g/MLdh
         tBqIai7atL8CGKpos/TrnWr3rTjS/sOHNTQv3saMb6k+HUyuWOGxqb35cRgJgmljWWko
         hqtPJsxIOFupR6db5KQj3XO6PRNNsa4BPfTFUBeo6/HMWaoHf8Nxa7p0HUaKbmDBeb1t
         CrT2XHF9kh/zdjKk21mnCbOxbK77TzcE+3Z0IKFH1QInKcXEi0fs8e+ODC0cXtssEp4D
         ov4wyj7sF6ZqU2JU0IhE0v29+Qlst7zEhs8JeIsPXNPDkVb4PlnXTUuRgOda9lhUAmfv
         Y6ug==
X-Gm-Message-State: AOAM530iWpdhFDy7SqgQBu3G7uDpswnl0GJDh0qloBych7oW55+25B7W
        bQbUbpca5IUaqL5VwdPEqNUhNu1Mpf0l+2QiZyY1iQamkri7gB+bMf60Zpc6eo8jPxuKCsz225P
        S4NbM3uG8xFeDZwsAQm6VabKD0e0yadEYxlPC90roPo4kXq3X4Rz+
X-Received: by 2002:a25:2404:: with SMTP id k4mr8045842ybk.363.1635148732562;
        Mon, 25 Oct 2021 00:58:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFNRYuuJ/BOE2vEMOVIaGGoP0dBQjAZh465kVSD8VgMFTjfh0Re3l1GkwsYF53olzBAw7VCKE61BE74/gEFDc=
X-Received: by 2002:a25:2404:: with SMTP id k4mr8045800ybk.363.1635148731889;
 Mon, 25 Oct 2021 00:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <ba8724d10da0f7545e5b91d1540a984c2b398a6a.1634884487.git.lucien.xin@gmail.com>
In-Reply-To: <ba8724d10da0f7545e5b91d1540a984c2b398a6a.1634884487.git.lucien.xin@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 09:58:40 +0200
Message-ID: <CAFqZXNu5PxBh8XFs=AFwJW0jpxKxPNQyXiyYekz_whHWGGXs5A@mail.gmail.com>
Subject: Re: [PATCH net 2/4] security: call security_sctp_assoc_request in sctp_sf_do_5_1D_ce
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 22, 2021 at 8:36 AM Xin Long <lucien.xin@gmail.com> wrote:
> The asoc created when receives the INIT chunk is a temporary one, it
> will be delete after INIT_ACK chunk is replied. So for the real asoc

Nit: s/delete/deleted/

> created in sctp_sf_do_5_1D_ce() when receives the COOKIE_ECHO chunk,

Nit: s/receives the COOKIE_ECHO chunk/the COOKIE_ECHO chunk is received/

> security_sctp_assoc_request() should also be called.
>
> Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  Documentation/security/SCTP.rst | 15 +++++++++------
>  net/sctp/sm_statefuns.c         |  5 +++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
> index 415b548d9ce0..9a38067762e5 100644
> --- a/Documentation/security/SCTP.rst
> +++ b/Documentation/security/SCTP.rst
> @@ -151,9 +151,9 @@ establishing an association.
>           INIT --------------------------------------------->
>                                                     sctp_sf_do_5_1B_init()
>                                                   Respond to an INIT chunk.
> -                                             SCTP peer endpoint "A" is
> -                                             asking for an association. Call
> -                                             security_sctp_assoc_request()
> +                                             SCTP peer endpoint "A" is asking
> +                                             for an temporary association.

Nit: s/an/a/

> +                                             Call security_sctp_assoc_request()
>                                               to set the peer label if first
>                                               association.
>                                               If not first association, check
> @@ -163,9 +163,12 @@ establishing an association.
>            |                                       discard the packet.
>            |
>      COOKIE ECHO ------------------------------------------>
> -                                                          |
> -                                                          |
> -                                                          |
> +                                                  sctp_sf_do_5_1D_ce()
> +                                             Respond to an COOKIE ECHO chunk.
> +                                             Confirm the cookie and create an

Nit: s/an/a/

> +                                             permanent association.
> +                                             Call security_sctp_assoc_request() to
> +                                             do the same as for INIT chunk Response.
>            <------------------------------------------- COOKIE ACK
>            |                                               |
>      sctp_sf_do_5_1E_ca                                    |
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 3206374209bc..b818532c3fc2 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -781,6 +781,11 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
>                 }
>         }
>
> +       if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
> +               sctp_association_free(new_asoc);
> +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
> +       }
> +
>         /* Delay state machine commands until later.
>          *
>          * Re-build the bind address for the association is done in
> --
> 2.27.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

