Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C57EB64DA
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 20:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGJUBB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGJUBA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 16:01:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C513E;
        Mon, 10 Jul 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=NARVxAHU8hdSWaaKOBo8T6Vk6x7Y5zqJLlil7BmYBVI=; b=cqIo0WmUCiJcN5pvSBP2FkMxKH
        k2ZnLOmwNaJJPJkw4PW+4V3p2f4rePzcvXzUNSG9s+9OInLdffZVlrx4tymeLgq9+VbRSOhSDl6XV
        4gtgUmlPmRQG54ZE3p97WtRvFk/wCSzluiK4GvAwWodn6Amlah7IDZlamtPctaEDuMOEi3MDQ62hy
        2YpdSsn6d3WpLq9OkhK4ACN/DAvHvtIMgQgXllsRX8VX658Y5w/AEMGXljrHpWRgFPQ5hYAm2uKID
        lCk+W3XQOdHKr9dRwzvFmdojjV2R6D87JreCthNUssxalzqdYYxQv1yDjNSd2VvteMN1Zkqp43zkS
        AdjdKvfQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIx47-00CcDE-1R;
        Mon, 10 Jul 2023 20:00:59 +0000
Message-ID: <fa1d9a4c-16fe-955d-071b-d39f1a0d9b58@infradead.org>
Date:   Mon, 10 Jul 2023 13:00:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/13] Update MAINTAINERS file.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-2-greg@enjellic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710102319.19716-2-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 7/10/23 03:23, Dr. Greg wrote:
> Add an entry to the MAINTAINERS file to document the maintainer's
> address and files relevant to the Trusted Security Event Modeling
> system (TSEM).
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35e19594640d..4660c972d5e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19026,6 +19026,14 @@ F:	include/uapi/linux/selinux_netlink.h
>  F:	scripts/selinux/
>  F:	security/selinux/
>  
> +TSEM SECURITY MODULE
> +M:	Greg Wettstein <greg@enjellic.com>
> +S:	Maintained
> +L:	linux-security-module@vger.kernel.org
> +F:	Documentation/admin-guide/LSM/tsem.rst
> +F:	Documentation/ABI/testing/tsemfs
> +F:	security/tsem/
> +

Please insert entries in the MAINTAINERS file in alphabetical order
(as stated in that file).

Thanks.

>  SENSABLE PHANTOM
>  M:	Jiri Slaby <jirislaby@kernel.org>
>  S:	Maintained

-- 
~Randy
