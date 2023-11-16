Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE9C197A0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Nov 2023 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKPVt7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Nov 2023 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKPVt6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Nov 2023 16:49:58 -0500
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D43EA
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 13:49:55 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SWYbj4rPwzMqSyh;
        Thu, 16 Nov 2023 21:49:53 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SWYbh15PHzMpp9q;
        Thu, 16 Nov 2023 22:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1700171393;
        bh=6etZtjUaZeHyPqf+c2+urdnoLpIdFf1o3uycUQJsczg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnG3214UvbhjjX4IpRv++w5rpiZKdInkIgOTAOCvpnXQsJroChUI6hCf4j7F4ycmw
         NeoRT9O7EFysDJ7uRnRkrzoHwe9ue/0DlYetCSitRsGstEuejXveTb8b5y+UbWBIoU
         wTR0WyoDlsZfcMoFZKk+D915Ns/70eh4a/rAK9yg=
Date:   Thu, 16 Nov 2023 16:49:46 -0500
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] landlock: Optimize the number of calls to
 get_access_mask slightly
Message-ID: <20231116.iho7Faitawah@digikod.net>
References: <20231103155717.78042-1-gnoack@google.com>
 <20231103155717.78042-2-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103155717.78042-2-gnoack@google.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 03, 2023 at 04:57:11PM +0100, Günther Noack wrote:
> This call is now going through a function pointer,
> and it is not as obvious any more that it will be inlined.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  security/landlock/ruleset.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ffedc99f2b68..fd348633281c 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -724,10 +724,11 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>  	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
>  		const unsigned long access_req = access_request;
>  		unsigned long access_bit;
> +		access_mask_t access_mask =

You can make it const and move it below the other const.

> +			get_access_mask(domain, layer_level);
>  
>  		for_each_set_bit(access_bit, &access_req, num_access) {
> -			if (BIT_ULL(access_bit) &
> -			    get_access_mask(domain, layer_level)) {
> +			if (BIT_ULL(access_bit) & access_mask) {
>  				(*layer_masks)[access_bit] |=
>  					BIT_ULL(layer_level);
>  				handled_accesses |= BIT_ULL(access_bit);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
