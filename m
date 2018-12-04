Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD83C04EBF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D620851
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="js+/e48N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995D620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLDJb0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:31:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJbZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eA3+dars/15Ftvml6Jp+hxCmqWOHLtsxS34EGOx66r8=; b=js+/e48NVSWfKoHPjW6rlMHsw
        wzJh2SrJzcAckljHSF5uorSELTk+c7r2Pcz65bIw6ioiuYLOQtux5tLniAGkZ+Nw7L42dtyY6Ha29
        32G8Rqnaq2PJWbzgvaGdv6MrxoKgALelrQf/9dxfZ26T2ILN/FctpaAqxJZOKuuyPs8gL2IoGLnL3
        ACP+TuJCaHQHqZgSFYLS4XG5tlXYXKnh6+L+LCwkKH1AFfvzYUHwOYKYZCmuv066dpyaXeZ/uAmrI
        PlrEsXaGCo2w0Zq/1/vwotQI43BZb8TWyvZU9i5rFGC9ggqb/BssPWWFQJN8hj/f9ml5U/IVcNh5M
        6DfrcU19g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU730-00005d-6f; Tue, 04 Dec 2018 09:31:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49AE2029FD58; Tue,  4 Dec 2018 10:31:16 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:31:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Message-ID: <20181204093116.GV11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:40:00PM -0800, Alison Schofield wrote:
>  static int mktme_program_system(struct mktme_key_program *key_program,
> -				cpumask_var_t mktme_cpumask)
> +				cpumask_var_t mktme_cpumask, int hotplug)
>  {
>  	struct mktme_hw_program_info info = {
>  		.key_program = key_program,
>  		.status = MKTME_PROG_SUCCESS,
>  	};
> -	get_online_cpus();
> -	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
> -	put_online_cpus();
> +
> +	if (!hotplug) {
> +		get_online_cpus();
> +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> +				 &info, 1);
> +		put_online_cpus();
> +	} else {
> +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> +				 &info, 1);
> +	}
>  
>  	return info.status;
>  }

That is pretty horrible; and I think easily avoided.
