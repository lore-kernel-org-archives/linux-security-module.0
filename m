Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC093C433DB
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Jan 2021 21:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9F2076D
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Jan 2021 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhABVho (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Jan 2021 16:37:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:36487 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbhABVho (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Jan 2021 16:37:44 -0500
IronPort-SDR: 7v49CNtAqioH5xNayiqBSzlAqA7g6k2K1FbEP0rWx5zUbmPI7opNVrJQVoKtzt9/qYrfxtdKoG
 WH3QtlAnUWoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9852"; a="173329717"
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="173329717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 13:35:58 -0800
IronPort-SDR: wV1gawkYGc9NR2N+p/Kyn/hkqFOTGHX3rcj9LnrirqPGlSSwsg4vhshZZnnBQcGW2ZMNsllmxD
 j1K6l6VEJBdA==
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="349323384"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 13:35:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kvoa3-001Fri-Oc; Sat, 02 Jan 2021 23:36:59 +0200
Date:   Sat, 2 Jan 2021 23:36:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Message-ID: <20210102213659.GP4077@smile.fi.intel.com>
References: <20201015115028.81857-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015115028.81857-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 15, 2020 at 02:50:28PM +0300, Andy Shevchenko wrote:
> When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> its internal members.

Any comment on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  security/integrity/platform_certs/efi_parser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/platform_certs/efi_parser.c b/security/integrity/platform_certs/efi_parser.c
> index 18f01f36fe6a..d98260f8402a 100644
> --- a/security/integrity/platform_certs/efi_parser.c
> +++ b/security/integrity/platform_certs/efi_parser.c
> @@ -55,7 +55,7 @@ int __init parse_efi_signature_list(
>  		memcpy(&list, data, sizeof(list));
>  		pr_devel("LIST[%04x] guid=%pUl ls=%x hs=%x ss=%x\n",
>  			 offs,
> -			 list.signature_type.b, list.signature_list_size,
> +			 &list.signature_type, list.signature_list_size,
>  			 list.signature_header_size, list.signature_size);
>  
>  		lsize = list.signature_list_size;
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


