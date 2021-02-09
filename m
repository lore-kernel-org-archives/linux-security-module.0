Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38FC433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Feb 2021 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9278664E9D
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Feb 2021 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhBIQx3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233097AbhBIQwj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Feb 2021 11:52:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E0D864EAC
        for <linux-security-module@vger.kernel.org>; Tue,  9 Feb 2021 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612889518;
        bh=o5DqyL4zi91LkW1Fu/xBEB9kzU++yZy0aSmEmaug1v0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1oNE48NfnVuCK0DPSfvfIB8Z5XS6Q7FNNG1uts1ZRg8HtBWkUNOAGEePCX3Dg2xP
         GWsyY0beeSvQlhubScfPtgw+kZcAQirMeCnz3mdNrmOxTU2Daip9syDGKdzfgTRPTu
         SbNNVmu7xEmVBqvsFgX3FOBv/MYfBWQjzCOnc6tIfZCPJoP8K+YZWv54DdmLMoa7ip
         17nEeS58hQHqr6rmv0IMQzVR/vVHV2N5seqnkLqMSZ1YN/+izfDRmEVJ6UPA7VpXom
         G28Tc7aoqd5rU0In/XoC75LlDRR/ntqs9C9R6nRQnMsVtX10yiw/AXtrKRNq7mGiyd
         QTx1o1RGhebQQ==
Received: by mail-oi1-f179.google.com with SMTP id h6so20128314oie.5
        for <linux-security-module@vger.kernel.org>; Tue, 09 Feb 2021 08:51:58 -0800 (PST)
X-Gm-Message-State: AOAM533hGJW4fGA+9Wkehe02VqRlOQg1LDUMBOAK30WhYeNfRDmAHrh/
        KGh10U5TNBaxRdrAzG3XEYPrUT4xafUu2zhNt3c=
X-Google-Smtp-Source: ABdhPJwFPtcyIScUSyy2e18cwYLXLD3uky3nbf2OZSK/EWz7qQeAlNDHfD/kGX0e4O2ZoGPqPrdkQa8nobndqWnXT+0=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr3130630oif.47.1612889517390;
 Tue, 09 Feb 2021 08:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Feb 2021 17:51:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
Message-ID: <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> its internal members.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  security/integrity/platform_certs/efi_parser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/platform_certs/efi_parser.c b/security/integrity/platform_certs/efi_parser.c
> index 18f01f36fe6a..d98260f8402a 100644
> --- a/security/integrity/platform_certs/efi_parser.c
> +++ b/security/integrity/platform_certs/efi_parser.c
> @@ -55,7 +55,7 @@ int __init parse_efi_signature_list(
>                 memcpy(&list, data, sizeof(list));
>                 pr_devel("LIST[%04x] guid=%pUl ls=%x hs=%x ss=%x\n",
>                          offs,
> -                        list.signature_type.b, list.signature_list_size,
> +                        &list.signature_type, list.signature_list_size,
>                          list.signature_header_size, list.signature_size);
>
>                 lsize = list.signature_list_size;
> --
> 2.30.0
>
