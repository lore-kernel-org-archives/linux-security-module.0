Return-Path: <SRS0=x8UA=CF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D4C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4950F20737
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GU3t6tHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH0RBP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0RBN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Aug 2020 13:01:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1609C061264
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2020 10:01:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c8so5548726edn.8
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2020 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQwOilPKk1piCWiUYQqWKm3Q131dR9gCFRx5y6SMd7w=;
        b=GU3t6tHOHu2MtrVfx2sMpm5WdOuJxuu031alP5ivhrqq5P/pHwXExArOYO1KsWT1zq
         cknfojUCR6Td7kJzSIn9s0J9UNU9ulNJAEND9jG1v+PM4tggjg8yvlV75OPhB6poYwdK
         Tw++wzZ8I+mv/1wE3GebYJI9JPQCN4kZRRybwkHw+YvFkbI6PlDBeLJ/EMFKsRf5xcwE
         ZHjSHjEqZqJHgROwJw0gbYCNAQvpc1qZQ5gpgnXfw7rXC7vTsoQK9lQyrNcoNt4c8L9b
         Tdm/sGZlAGt0i45FRWvywm9vWtnyllycLoBpUyjmUXSbnlwbFYnJmFPomt9dRQ+sPkFR
         e2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQwOilPKk1piCWiUYQqWKm3Q131dR9gCFRx5y6SMd7w=;
        b=YfotUp+63mijR9Pi4I42DMA2Z7LxYCYw/PL6xhe5zQcrg8RO61JIabpnW3iw7d8WKe
         dA1p2fkmakjtXSarNDkyqbWTElemiV0Kzci7pSUNiQ+SC2t5sgjraSPCzu+YTwORdMMh
         pVUgRN5YvKLsz85bcASLDx5sywXCfkhgpy1mY/hdInX5wsF1Qddb79H+/+Ym/vI6uSRq
         zKH2PMw7LN66ZtcQAqdu93vjWQqKjd8RqRtzbR+2g1p/ylkttheg4K+lp+LE953dok33
         uWFIC6rcB54KleE/DgNNVhsSAbxlPwdaGiT/aB2jzkEt5mB6ds9+SIPteZfR1ToXEk05
         v6tA==
X-Gm-Message-State: AOAM5322USmkuYbw010PY6nsGCuiswic5o17eXF7UleCPJD2ZEttXQrX
        mx1YTLRiOcDi7JdXG+5oi4gxy4cPXwczBN9LG8lj
X-Google-Smtp-Source: ABdhPJxyYHZx4GJwDRAPIGE4a5yirISt0x+61wFkAezzM5ZYDXxdb9wD5WIZ/vnluTCqbhjdmfD3a/mC2JYpqD0za84=
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr18609335edt.128.1598547670264;
 Thu, 27 Aug 2020 10:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200827163712.106303-1-alex.dewar90@gmail.com>
In-Reply-To: <20200827163712.106303-1-alex.dewar90@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 13:00:58 -0400
Message-ID: <CAHC9VhRgi54TXae1Wi+SSzkuy9BL7HH=pZCHL1p215M9ZXKEOA@mail.gmail.com>
Subject: Re: [PATCH RFC] netlabel: remove unused param from audit_log_format()
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 27, 2020 at 12:39 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> Commit d3b990b7f327 ("netlabel: fix problems with mapping removal")
> added a check to return an error if ret_val != 0, before ret_val is
> later used in a log message. Now it will unconditionally print "...
> res=0". So don't print res anymore.
>
> Addresses-Coverity: ("Dead code")
> Fixes: d3b990b7f327 ("netlabel: fix problems with mapping removal")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>
> I wasn't sure whether it was intended that something other than ret_val
> be printed in the log, so that's why I'm sending this as an RFC.

It's intentional for a couple of reasons:

* The people who care about audit logs like to see success/fail (e.g.
"res=X") for audit events/records, so printing this out gives them the
warm fuzzies.

* For a lot of awful reasons that I won't bore you with, we really
don't want to add/remove fields in the middle of an audit record so we
pretty much need to keep the "res=0" there even if it seems a bit
redundant.

So NACK from me, but thanks for paying attention just the same :)

>  net/netlabel/netlabel_domainhash.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
> index f73a8382c275..526762b2f3a9 100644
> --- a/net/netlabel/netlabel_domainhash.c
> +++ b/net/netlabel/netlabel_domainhash.c
> @@ -612,9 +612,8 @@ int netlbl_domhsh_remove_entry(struct netlbl_dom_map *entry,
>         audit_buf = netlbl_audit_start_common(AUDIT_MAC_MAP_DEL, audit_info);
>         if (audit_buf != NULL) {
>                 audit_log_format(audit_buf,
> -                                " nlbl_domain=%s res=%u",
> -                                entry->domain ? entry->domain : "(default)",
> -                                ret_val == 0 ? 1 : 0);
> +                                " nlbl_domain=%s",
> +                                entry->domain ? entry->domain : "(default)");
>                 audit_log_end(audit_buf);
>         }
>

-- 
paul moore
www.paul-moore.com
