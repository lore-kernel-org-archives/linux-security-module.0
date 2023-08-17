Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F637C64EB4
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Aug 2023 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349142AbjHQVTb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355323AbjHQVTX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 17:19:23 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 14:19:22 PDT
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE11C1
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:19:22 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id WcM8qfrD7yYOwWkMcqtiag; Thu, 17 Aug 2023 21:17:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WkMbq0mJjoeMqWkMbqmI3K; Thu, 17 Aug 2023 21:17:05 +0000
X-Authority-Analysis: v=2.4 cv=F9xEy4tN c=1 sm=1 tr=0 ts=64de8e51
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=edGIuiaXAAAA:8 a=xVhDTqbCAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=4kyDAASA-Eebq_PzFVE6:22 a=GrmWmAYt4dzCMttCBZOh:22 a=yV38gEssg_2GhkhKF82i:22
 a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XPrmBnGis32Q4Plsd5hHko1y81xn30PHQUauq/WHvYE=; b=j1YUKDz7wraUXWHGPd7VTuEae/
        Byk8pUT8yXEhDXuwemji864YtuYgeSgS1NcZzfKN4eMUZpiDU83w/kzCUY6sz20kx2UXpnj6WGE8B
        HMue5dVwt6HvqXAAwVHOWEAfiLzGLaE/G5rNbcgYlx603vNA4JDTDKXPzer3vx96Qns869F2nunBU
        52XoOlRv8x92H4zTANHgQtrni72bme3zfbjLfpnA9cxVMlzTsUxmqIRd9bkX62lKRnpe6SGyFnN18
        ye41BDVA7BnW/DmfGzyx2XuAVURRveQoMk3BWLhGK8n9sQZCfCMgZ46IkWWoGkNfNHEEhuYjyTYam
        G2XvhWBw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56616 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWkMa-001gal-1N;
        Thu, 17 Aug 2023 16:17:04 -0500
Message-ID: <713066f1-1c03-94c4-c9d6-7b145a9ac00b@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:18:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] landlock: Annotate struct landlock_rule with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817210257.never.920-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817210257.never.920-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWkMa-001gal-1N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56616
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBbpnNaehSS8OEGalDm7W/qszE0eh2DTXdMAcHlsjtd/AIucVeyTc1Pmy+9xLWyf9ApraXDndnvkKoP0zImnL8fzzuAHjzffXs4YrOeYbu89Qw3Id9Q0
 7z//9hGTsooFoyARRKYmSoNybvLmEIFQpAE2MfZsiR5Hnf6No6Znugq8XzXbPhdnHBDOZAxfUnVfTpoPcrx5DqzUkpoc2mb4e1V3ESbMzqs7771vo/COXvZZ
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/17/23 15:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct landlock_rule.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   security/landlock/ruleset.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index d43231b783e4..55b1df8f66a8 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -67,7 +67,7 @@ struct landlock_rule {
>   	 * @layers: Stack of layers, from the latest to the newest, implemented
>   	 * as a flexible array member (FAM).
>   	 */
> -	struct landlock_layer layers[];
> +	struct landlock_layer layers[] __counted_by(num_layers);
>   };
>   
>   /**
