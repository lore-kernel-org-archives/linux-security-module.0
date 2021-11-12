Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FDC433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Nov 2021 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B849061284
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Nov 2021 01:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKLB2j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Nov 2021 20:28:39 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47028
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhKLB2j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Nov 2021 20:28:39 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3988B3F213;
        Fri, 12 Nov 2021 01:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636680345;
        bh=PCSur0ZtY7MRvBGP7BdvoVh93lbY+NBrxaqer9dSa1I=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Et1gZsbXueowidj9n3U9eKC5djQ12lsbR++yrEEEBIm/UiFwNQFhX5oiRdhvrMCQa
         TdRuqWoM7m5y8ERvdSaCgEXSHwrWauVa2z0cXmSqCz7IaiRX4RGinfT70UkCWwy/mW
         88xt5GRTbxBkNwpmmehbBnKSrh2Qy1A1HUTnizoQmAmguYQaBNHcinuREQ8vhcfmlU
         2VLR0j2mfz9audJ8I+TmdGCbwWVasKy7tLW7ndiVmR45yYlsSFhf17VezQ7dCe0Dcn
         JSWA4/bJwcPz7O/W/EngoApcLbDb2MIEVhoughXfwokvGbfohuolZajk228FLAONxS
         Yz7PU5Os6rQmA==
Subject: Re: [PATCH] apparmor: remove duplicated 'Returns:' comments
To:     Austin Kim <austindh.kim@gmail.com>, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211103092531.GA25721@raspberrypi>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <f4447f61-59f2-cfc2-1157-df00175c6a10@canonical.com>
Date:   Thu, 11 Nov 2021 17:25:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103092531.GA25721@raspberrypi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/3/21 2:25 AM, Austin Kim wrote:
> It might look better if duplicated 'Returns:' comment is removed.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

sorry, it looks like I forgot to reply to this. I pulled this into the
apparmor tree and it has been merged for 5.16

> ---
>  security/apparmor/procattr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index c929bf4a3df1..fde332e0ea7d 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -21,8 +21,6 @@
>   * @profile: the profile to print profile info about  (NOT NULL)
>   * @string: Returns - string containing the profile info (NOT NULL)
>   *
> - * Returns: length of @string on success else error on failure
> - *
>   * Requires: profile != NULL
>   *
>   * Creates a string containing the namespace_name://profile_name for
> 

