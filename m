Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62BECAAD3
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Aug 2022 18:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiHaSus (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiHaSur (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 14:50:47 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCCAB07A;
        Wed, 31 Aug 2022 11:50:44 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id BBD80EB4; Wed, 31 Aug 2022 13:50:39 -0500 (CDT)
Date:   Wed, 31 Aug 2022 13:50:39 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, jbenc@redhat.com,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2] bpf: use bpf_capable() instead of CAP_SYS_ADMIN
 for blinding decision
Message-ID: <20220831185039.GA20800@mail.hallyn.com>
References: <20220831090655.156434-1-ykaliuta@redhat.com>
 <20220831152414.171484-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831152414.171484-1-ykaliuta@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 31, 2022 at 06:24:14PM +0300, Yauheni Kaliuta wrote:
> The capability check can cause SELinux denial.
> 
> For example, in ptp4l, setsockopt() with the SO_ATTACH_FILTER option
> raises sk_attach_filter() to run a bpf program. SELinux hooks into
> capable() calls and performs an additional check if the task's
> SELinux domain has permission to "use" the given capability. ptp4l_t
> already has CAP_BPF granted by SELinux, so if the function used
> bpf_capable() as most BPF code does, there would be no change needed
> in selinux-policy.

The selinux mentions probably aren't really necessary.  The more
concise way to say it is that bpf_jit_blinding_enabled() should
be permitted with CAP_BPF, that full CAP_SYS_ADMIN is not needed.
(Assuming that that is the case)

> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> ---
> 
> v2: put the reasoning in the commit message
> 
> ---
>  include/linux/filter.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a5f21dc3c432..3de96b1a736b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1100,7 +1100,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
>  		return false;
>  	if (!bpf_jit_harden)
>  		return false;
> -	if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
> +	if (bpf_jit_harden == 1 && bpf_capable())
>  		return false;
>  
>  	return true;
> -- 
> 2.34.1
