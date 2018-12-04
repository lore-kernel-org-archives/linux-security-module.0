Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC45C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8575B20851
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5Ek/gBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8575B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLDJVy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:21:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48262 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLDJVy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=80tFOJKSd/eCmjmBoQCoQ3uscddXojCWCEWO7LdIU1I=; b=P5Ek/gBR0LX6wectKI9lmiGph
        7MRFtxLWFhvBIKL4R3HlAX2f4ulrfOrkge4ZEIK8vgRdfXVsKmy45SZ580bQEJDQY4W1aMzFvzpYj
        Yxp4TKI0iCly0EVmAGJQO0ipA2nDW/34akhjZn9mhYBxxOux/m7fquiV4784AXEvpuKnIaBiaQPF7
        iMf3gk5Ea6G7cQoRTA5OXxashSCowhc/Wzj5Q0/3OTHsYpwxDj2NAOy7KgQff2DPUHO5og6BayEnf
        DcB7wQB4O5D9OGjjEaujzPpNC+bStCTYNQ5tFxP8M3dpWBAl/o25MOdpS88niCmsM5bwlCLsyh3P4
        25KOLjHhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6tm-0008PD-W8; Tue, 04 Dec 2018 09:21:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C5C92029FD58; Tue,  4 Dec 2018 10:21:45 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:21:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a
 system wide basis
Message-ID: <20181204092145.GR11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:

> +struct mktme_hw_program_info {
> +	struct mktme_key_program *key_program;
> +	unsigned long status;
> +};
> +
> +/* Program a KeyID on a single package. */
> +static void mktme_program_package(void *hw_program_info)
> +{
> +	struct mktme_hw_program_info *info = hw_program_info;
> +	int ret;
> +
> +	ret = mktme_key_program(info->key_program);
> +	if (ret != MKTME_PROG_SUCCESS)
> +		WRITE_ONCE(info->status, ret);

What's the purpose of that WRITE_ONCE()?

> +}
> +
> +/* Program a KeyID across the entire system. */
> +static int mktme_program_system(struct mktme_key_program *key_program,
> +				cpumask_var_t mktme_cpumask)
> +{
> +	struct mktme_hw_program_info info = {
> +		.key_program = key_program,
> +		.status = MKTME_PROG_SUCCESS,
> +	};
> +	get_online_cpus();
> +	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
> +	put_online_cpus();
> +
> +	return info.status;
> +}
> +
>  /* Copy the payload to the HW programming structure and program this KeyID */
>  static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
>  {
> @@ -84,7 +116,7 @@ static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
>  			kprog->key_field_2[i] ^= kern_entropy[i];
>  		}
>  	}
> -	ret = mktme_key_program(kprog);
> +	ret = mktme_program_system(kprog, mktme_leadcpus);
>  	kmem_cache_free(mktme_prog_cache, kprog);
>  	return ret;
>  }
> @@ -299,6 +331,28 @@ struct key_type key_type_mktme = {
>  	.destroy	= mktme_destroy_key,
>  };
>  
> +static int mktme_build_leadcpus_mask(void)
> +{
> +	int online_cpu, mktme_cpu;
> +	int online_pkgid, mktme_pkgid = -1;
> +
> +	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	for_each_online_cpu(online_cpu) {
> +		online_pkgid = topology_physical_package_id(online_cpu);
> +
> +		for_each_cpu(mktme_cpu, mktme_leadcpus) {
> +			mktme_pkgid = topology_physical_package_id(mktme_cpu);
> +			if (mktme_pkgid == online_pkgid)
> +				break;
> +		}
> +		if (mktme_pkgid != online_pkgid)
> +			cpumask_set_cpu(online_cpu, mktme_leadcpus);

Do you really need LOCK prefixed bit set here?

> +	}
> +	return 0;
> +}

How is that serialized and kept relevant in the face of hotplug?

Also, do you really need O(n^2) to find the first occurence of a value
in an array?
