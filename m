Return-Path: <SRS0=WgAi=AD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92507C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 12:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D29620716
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 12:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgFVMc0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:32:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgFVMc0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 08:32:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 657271F1;
        Mon, 22 Jun 2020 05:32:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF82F3F71E;
        Mon, 22 Jun 2020 05:32:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:32:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pranith Kumar <bobby.prani@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] security: Add a config option to disable security
 mitigations
Message-ID: <20200622123220.5qdykbd3rtjfsjkq@e107158-lin.cambridge.arm.com>
References: <20200618010755.4179-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618010755.4179-1-bobby.prani@gmail.com>
User-Agent: NeoMutt/20171215
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 06/17/20 18:07, Pranith Kumar wrote:
> Instead of having to pass 'mitigations=off' on the kernel command line,
> add a config option that has a similar effect.
> 
> Adding this makes it easier to disable mitigations in scenarios where
> you cannot modify the command line or are unable to pass a command line
> while booting.

Better wait to hear from others too, but I think if you want a config, then it
better support all possible variations of the option too, not just the 'off'
one.

> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  kernel/cpu.c     | 2 +-
>  security/Kconfig | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..584eb39585d6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2542,7 +2542,7 @@ early_param("mitigations", mitigations_parse_cmdline);
>  /* mitigations=off */
>  bool cpu_mitigations_off(void)
>  {
> -	return cpu_mitigations == CPU_MITIGATIONS_OFF;
> +	return cpu_mitigations == CPU_MITIGATIONS_OFF || IS_ENABLED(CONFIG_DISABLE_MITIGATIONS);
>  }

So if cmdline asked for this to be auto, but the config is compiled with off
then the config always wins according to this.

This conflict makes me think this is probably going to be a bad idea because
2 points of control would create a confusion of which one should be honored.

You can set the cmdline in the config too, have you tried this?

On arm64, I can add additional cmdline paramter in the config

	Boot options --> Default kernel command string

On x86 I found this too

	Processor type and features --> Built-in kernel command line

Beside that, you can always use kexec to boot a new kernel with extra cmdline
option

The command I used in the past (from memory, so worth double checking)

	kexec --command-line "$(cat /proc/cmdline) migrations=off" -f Image

>  EXPORT_SYMBOL_GPL(cpu_mitigations_off);
>  
> diff --git a/security/Kconfig b/security/Kconfig
> index cd3cc7da3a55..90b8e9c89a6d 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -65,6 +65,14 @@ config PAGE_TABLE_ISOLATION
>  
>  	  See Documentation/x86/pti.rst for more details.
>  
> +config DISABLE_MITIGATIONS
> +	bool "Disable kernel security mitigations"
> +	default n

No need for default n in general as it is the default anyway :)

HTH.

Thanks

--
Qais Yousef
