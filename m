Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721AFCDB474
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Oct 2023 19:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjJQTsT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Oct 2023 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJQTsS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Oct 2023 15:48:18 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8022C4
        for <linux-security-module@vger.kernel.org>; Tue, 17 Oct 2023 12:48:15 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S94K822LTzMpvVK;
        Tue, 17 Oct 2023 19:48:12 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S94K71h0rzMppKN;
        Tue, 17 Oct 2023 21:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1697572092;
        bh=KYTSWCOsGz/+WO0VVte/iQLr7+7gseBuosrKHouMfog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/UGxxriqrUKFRtOh5a3ThG8rx7skFYg/EMX3ZPdaKEzAPVifpm30WUcUuNMDFgdG
         6WZViG32DRb3ewln32KRnjk2xWTHvrLf8KvX3NriaCYQzHA/FEHU96VpkxZK2Y6jDu
         KpB9HZEQDglnN3TisBCc4aw5438H5xFYKrexpgdQ=
Date:   Tue, 17 Oct 2023 21:48:10 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: fix typo in landlock_append_net_rule() stub
 function
Message-ID: <20231017.ia3Aiv5Am5ee@digikod.net>
References: <20231017143341.2875980-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017143341.2875980-1-arnd@kernel.org>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks Arnd, I fixed the issue and squashed it in -next.

There will be a next patch series including other fixes.

On Tue, Oct 17, 2023 at 04:33:35PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is an extraneous semicolon in the empty stub helper for
> this function tha causes randconfig builds to break:
> 
> In file included from security/landlock/setup.c:17:
> security/landlock/net.h:28:1: error: expected identifier or '(' before '{' token
> security/landlock/net.h:26:1: error: 'landlock_append_net_rule' declared 'static' but never defined [-Werror=unused-function]
> 
> Fixes: 614d46b333ab9 ("landlock: Add network rules and TCP hooks support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/landlock/net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/net.h b/security/landlock/net.h
> index 588a49fd69076..09960c237a13e 100644
> --- a/security/landlock/net.h
> +++ b/security/landlock/net.h
> @@ -24,7 +24,7 @@ static inline void landlock_add_net_hooks(void)
>  
>  static inline int
>  landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
> -			 access_mask_t access_rights);
> +			 access_mask_t access_rights)
>  {
>  	return -EAFNOSUPPORT;
>  }
> -- 
> 2.39.2
> 
