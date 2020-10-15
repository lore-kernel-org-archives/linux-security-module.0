Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F5C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8BC22255
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 15:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgJOPjQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 11:39:16 -0400
Received: from mail.hallyn.com ([178.63.66.53]:48058 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389749AbgJOPjP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 11:39:15 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 11:39:14 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 505261105; Thu, 15 Oct 2020 10:30:09 -0500 (CDT)
Date:   Thu, 15 Oct 2020 10:30:09 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Aleksandr Nogikh <a.nogikh@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com,
        andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [RFC PATCH 1/1] security: add fault injection capability
Message-ID: <20201015153009.GA26517@mail.hallyn.com>
References: <20201015104649.2104432-1-a.nogikh@gmail.com>
 <20201015104649.2104432-2-a.nogikh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015104649.2104432-2-a.nogikh@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 15, 2020 at 10:46:49AM +0000, Aleksandr Nogikh wrote:
> From: Aleksandr Nogikh <nogikh@google.com>
> 
> Add a fault injection capability to call_int_hook macro. This will
> facilitate testing of fault tolerance of the code that invokes
> security hooks as well as the fault tolerance of the LSM
> implementations themselves.
> 
> Add a KConfig option (CONFIG_FAIL_LSM_HOOKS) that controls whether the
> capability is enabled. In order to enable configuration from the user
> space, add the standard debugfs entries for fault injection (if
> CONFIG_FAULT_INJECTION_DEBUG_FS is enabled).
> 
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
>  lib/Kconfig.debug   |  6 +++++
>  security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 08c82666cf3e..0c9913ebe1c1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1803,6 +1803,12 @@ config FAIL_MAKE_REQUEST
>  	help
>  	  Provide fault-injection capability for disk IO.
>  
> +config FAIL_LSM_HOOKS
> +	bool "Fault-injection capability for LSM hooks"
> +	depends on FAULT_INJECTION
> +	help
> +	  Provide fault-injection capability for LSM hooks.
> +
>  config FAIL_IO_TIMEOUT
>  	bool "Fault-injection capability for faking disk interrupts"
>  	depends on FAULT_INJECTION && BLOCK
> diff --git a/security/security.c b/security/security.c
> index 69ff6e2e2cd4..bd4dbe720098 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/fault-inject.h>
>  #include <net/flow.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
> @@ -669,6 +670,51 @@ static void __init lsm_early_task(struct task_struct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
>  
> +
> +#ifdef CONFIG_FAIL_LSM_HOOKS
> +
> +static struct {
> +	struct fault_attr attr;
> +	int retval;
> +} fail_lsm_hooks = {
> +	.attr = FAULT_ATTR_INITIALIZER,
> +	.retval = -EACCES
> +};
> +
> +static int __init setup_fail_lsm_hooks(char *str)
> +{
> +	return setup_fault_attr(&fail_lsm_hooks.attr, str);
> +}
> +__setup("fail_lsm_hooks=", setup_fail_lsm_hooks);
> +
> +static int should_fail_lsm_hook(void)
> +{
> +	return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retval : 0;
> +}
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int __init fail_lsm_hooks_debugfs(void)
> +{
> +	umode_t mode = S_IFREG | 0600;
> +	struct dentry *dir;
> +
> +	dir = fault_create_debugfs_attr("fail_lsm_hooks", NULL,
> +					&fail_lsm_hooks.attr);
> +	debugfs_create_u32("retval", mode, dir, &fail_lsm_hooks.retval);
> +	return 0;
> +}
> +
> +late_initcall(fail_lsm_hooks_debugfs);
> +
> +#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
> +
> +#else
> +
> +static inline int should_fail_lsm_hook(void) { return 0; }
> +
> +#endif /* CONFIG_FAIL_LSM_HOOKS */
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -707,16 +753,17 @@ static void __init lsm_early_task(struct task_struct *task)
>  	} while (0)
>  
>  #define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> -	do {							\
> +	int RC = should_fail_lsm_hook();			\

seeing 'should_fail' here, kind of out of context, would be confusing to
thousands of ppl reading the code and wondering why it should fail.  maybe
"inject_fail_lsm_hook()" ?

> +	if (RC == 0) {								\
>  		struct security_hook_list *P;			\
> +		RC = IRC;								\
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>  			RC = P->hook.FUNC(__VA_ARGS__);		\
>  			if (RC != 0)				\
>  				break;				\
>  		}						\
> -	} while (0);						\
> +	}							\
>  	RC;							\
>  })
>  
> -- 
> 2.28.0.1011.ga647a8990f-goog
