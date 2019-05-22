Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639DC282CE
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2120821
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEVRmr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 13:42:47 -0400
Received: from namei.org ([65.99.196.166]:33816 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVRmr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 13:42:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4MHgjUY019238;
        Wed, 22 May 2019 17:42:45 GMT
Date:   Thu, 23 May 2019 03:42:45 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: Update MAINTAINERS file for SafeSetID LSM.
In-Reply-To: <20190522172241.192669-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1905230341520.18826@namei.org>
References: <20190522172241.192669-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 22 May 2019, Micah Morton wrote:

> This is in preparation for SafeSetID to be maintained in its own tree,
> rather than going via the security tree.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..0fcd34e64fa7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13561,6 +13561,12 @@ F:	drivers/media/common/saa7146/
>  F:	drivers/media/pci/saa7146/
>  F:	include/media/drv-intf/saa7146*
>  
> +SAFESETID SECURITY MODULE
> +M:	Micah Morton <mortonm@chromium.org>
> +S:	Supported
> +F:	security/safesetid/
> +F:	Documentation/admin-guide/LSM/SafeSetID.rst
> +
>  SAMSUNG AUDIO (ASoC) DRIVERS
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
>  M:	Sangbeom Kim <sbkim73@samsung.com>
> 

-- 
James Morris
<jmorris@namei.org>

