Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F1C433DB
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBEA64ED6
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 10:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBUKOX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Feb 2021 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUKOW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 05:14:22 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D61C061574;
        Sun, 21 Feb 2021 02:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hcq3wt5qS99lFcdtQEki70DkgteFRHHdLhomfjlqf0A=; b=d9BmVzeMt89rCXwVLeKlwPtHG
        2BNk+iWh/L0CsP42TqedSeGrmfDsxu4ckY9qOc6ml4YSXe7ocS2VmYqTdpsflYZ5KXY61rBG+Rd3C
        ak55BBcZmcE3iw7hxjb6nDM/coJQH9po0P6r+Vq70oEVXerNc+lLm2VWZ4J6ijxQddMUw7x2oycoW
        ushzuWhMycc9J5pOfsJXQSIBZHmkGfB70a2jKKEZSQaDdtUJlvxCPR+pQ6t8neNP+u62ehJLQW2qa
        dPt5YWVNsfvbKX0YaqpEI7RhM+jpVkWItrx1qgHUKOzxrfQuCkUBUXwO8GMmoFhCGDUwtK8FMk8wZ
        Av6+zio3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46232)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lDljt-0005aH-Cr; Sun, 21 Feb 2021 10:13:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lDljp-00012f-NP; Sun, 21 Feb 2021 10:13:17 +0000
Date:   Sun, 21 Feb 2021 10:13:17 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jian Cai <jiancai@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        James Morris <jmorris@namei.org>, manojgupta@google.com,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        clang-built-linux@googlegroups.com, llozano@google.com,
        David Brazdil <dbrazdil@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        David Laight <David.Laight@aculab.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
Message-ID: <20210221101317.GN1463@shell.armlinux.org.uk>
References: <20210219201852.3213914-1-jiancai@google.com>
 <20210219230841.875875-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219230841.875875-1-jiancai@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 03:08:13PM -0800, Jian Cai wrote:
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 269967c4fc1b..146b75a79d9e 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -121,6 +121,16 @@ choice
>  
>  endchoice
>  
> +config HARDEN_SLS_ALL
> +	bool "enable SLS vulnerability hardening"
> +	default n

Please get rid of this useless "default n"

> +	depends on $(cc-option,-mharden-sls=all)
> +	help
> +	  Enables straight-line speculation vulnerability hardening on ARM and ARM64
> +	  architectures. It inserts speculation barrier sequences (SB or DSB+ISB
> +	  depending on the target architecture) after RET and BR, and replacing
> +	  BLR with BL+BR sequence.

Given that this is in an architecture independent Kconfig file, and it
detects support in CC for this feature, why should this help text be
written to be specific to a couple of architectures? Will this feature
only ever be available on these two architectures? What if someone adds
support for another architecture?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
