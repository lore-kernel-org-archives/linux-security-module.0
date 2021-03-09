Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346FAC433E6
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014BF65268
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 10:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCIKIZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhCIKIP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 05:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615284494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=fP1WhAXasJkHPQZSrv01h0/EdXVa+L2W5wb7zMiEje0tc512FPz/vTxw1uaTMhI++adC+D
        5K/PpvHSFmbquW8PHoqAFc0NJPxp/brMr++QJaBic/85jj0IuoMhO1aZHUS1a1CBhXASF/
        mdXZsudsU39/T2wHfaygJ/r34b9bWQw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Sg4xSvcfMuam2ZK-WTQ-Sw-1; Tue, 09 Mar 2021 05:08:13 -0500
X-MC-Unique: Sg4xSvcfMuam2ZK-WTQ-Sw-1
Received: by mail-yb1-f197.google.com with SMTP id g17so16550821ybh.4
        for <linux-security-module@vger.kernel.org>; Tue, 09 Mar 2021 02:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=p3Vspm2CYDOErdLRdIdrpZXwuHxlrrvo5ZVSNofeh6TeaSpjkup1i3eKlVxbKZVsR6
         Zvdehv/I/l5uaomSLf3067j/dYjgw6Y9ehU7IWAyf5L2bIoTXDumxHOzlYo2NDvgAUiR
         p2i7gIjFoGrLS5DW/GMc5+b/dl2u+sSivMohd0k+yVG//+F4NeTnF6WS2h5jXuk74bsv
         bh0a+Z7VCgh2jJjcK0Qo0J1czrClFPszuMzQLL7rqII5cOdfe9kCCUaeEceqlDKd+T6+
         mfM6Uz4GbavznjpnZLORTIbxv1HWwxC7rIisLcbjNaggc9nboFRgmj6F6uKBIOt3wcQd
         ap9g==
X-Gm-Message-State: AOAM531i7N45JwMblEU0AfeAB8jCOrBBo42tWuohloho9iliJSvTPNqS
        wTTVjUJZ3I1YmCGAuz9YiYBGhOJZ8PTeXKSHy8nAFbGqqnLZqXB9szPAOShCksz+z0NzwluFjV/
        AiV7nyh9Q+hKvf7J9T0EMqz3dRIpzSXmpPP4+QJ/8g5NVV/qHVjPh
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282822ybe.172.1615284492512;
        Tue, 09 Mar 2021 02:08:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOdXiOr+CcTEln+8TZ0CZvuB0W0M+aAg2Wavc5dcrB2nfJuV742vWVQiWOrCjwyEKAIQngbWmatIoZcEM8YyI=
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282799ybe.172.1615284492300;
 Tue, 09 Mar 2021 02:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com>
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 9 Mar 2021 11:08:01 +0100
Message-ID: <CAFqZXNtssgDmhMS+p6+F2zC=ka3=bM22GpNQLO2NbSLWQroYFg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        David Quigley <dpquigl@davequigley.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 15, 2021 at 6:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> An xattr 'get' handler is expected to return the length of the value on
> success, yet _nfs4_get_security_label() (and consequently also
> nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
> just 0 on success.
>
> Fix this by returning label.len instead, which contains the length of
> the result.
>
> Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 2f4679a62712a..28465d8aada64 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>                 return ret;
>         if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
>                 return -ENOENT;
> -       return 0;
> +       return label.len;
>  }
>
>  static int nfs4_get_security_label(struct inode *inode, void *buf,
> --
> 2.29.2
>

Ping. It's been almost 2 months now, and I can't see the patch applied
anywhere, nor has it received any feedback from the NFS maintainers...
Trond? Anna?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

