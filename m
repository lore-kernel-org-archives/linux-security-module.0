Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95416C10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 22:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D71821473
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 22:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SOYAjZQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDHWQA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:16:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHWQA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 18:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UPjKN9jGEkZAbLp7R7MMobTpErLdQSydL4CFy9La1lY=; b=SOYAjZQzskXBUghIfRNtdGhPuA
        WlWMNZytkLbdGVWk/hSsvVzikhGVVWZPtS16O6Lff2C3KM9WduytoSZuLMhvhE3MHaMH0/OH4nf1R
        sSgezZVg+lPULbetu7TQSBAUgs5TT37bnOvUrnTloOkDoQjD+mpZGfeEt+jLKmL14byPg3RPhcMT6
        3/CMG2TAuth03EWhPbZBHueYJrYv4QomhlTDsAtU8FqbUbrRUCJTYV24ia0AfkUFxk0w14Adx+iN2
        HfdlyXXWlxM/uoo+CElEiBkJOLVxRAE0k6xLeuquvRC1kl2SlEVbsiDgXmooMUh9Oa6DHMjWjsm2W
        Zdnqi83g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDcYJ-0001xM-C1; Mon, 08 Apr 2019 22:15:43 +0000
Subject: Re: [PATCH v3 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and
 CONFIG_INIT_ALL_STACK
To:     Alexander Potapenko <glider@google.com>,
        yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, kernel-hardening@lists.openwall.com
References: <20190408170418.148554-1-glider@google.com>
 <20190408170418.148554-2-glider@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <adb23353-2e02-ecd2-7506-50f4db814b25@infradead.org>
Date:   Mon, 8 Apr 2019 15:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408170418.148554-2-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/8/19 10:04 AM, Alexander Potapenko wrote:
> diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> new file mode 100644
> index 000000000000..5e49a55382ad
> --- /dev/null
> +++ b/security/Kconfig.initmem
> @@ -0,0 +1,29 @@
> +menu "Initialize all memory"
> +
> +config CC_HAS_AUTO_VAR_INIT
> +	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
> +
> +config INIT_ALL_MEMORY
> +	bool "Initialize all memory"
> +	default n
> +	help
> +	  Enforce memory initialization to mitigate infoleaks and make
> +	  the control-flow bugs depending on uninitialized values more
> +	  deterministic.
> +
> +if INIT_ALL_MEMORY
> +
> +config INIT_ALL_STACK
> +	bool "Initialize all stack"
> +	depends on INIT_ALL_MEMORY

This "depends on" is redundant with the "if INIT_ALL_MEMORY" above it.

Similar comment for patch 2/2 and INIT_ALL_HEAP.

> +	depends on CC_HAS_AUTO_VAR_INIT || (HAVE_GCC_PLUGINS && PLUGIN_HOSTCC != "")
> +	select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> +	select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> +	select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> +	default y
> +	help
> +	  Initialize uninitialized stack data with a fixed pattern
> +	  (0x00 in GCC, 0xAA in Clang).
> +
> +endif # INIT_ALL_MEMORY
> +endmenu


-- 
~Randy
