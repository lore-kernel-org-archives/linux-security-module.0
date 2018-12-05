Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E8C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 09:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D282082B
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioGjgiKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D282082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeLEJKk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:10:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeLEJKk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nhnI5mMj5gSRoamC7Hn8KhYimZ2XdCkARmodfPUD580=; b=ioGjgiKZha0wmIDi86JB0dx45
        4n2ki49ga0fnKGT8MD1cN0MdTNLjjL/Yj67BUWQF3524HL4OY0k3xZK1JyRy1Lxkw8uV6mLDNOm/I
        ZgiCOs9rasYJt2WjAB7C5zhbY27OSOZq08v5mEV5cFZNbZOkgXnbTIKgRW0+EBjV6H60CI11Ub0Ck
        FcW0hs/zjtcejY2bP/FVLbT627v/zXo2f8yWwm26JS1iBXGqyw1dJU+/vUfHWj7ciy4aQZb5hNntk
        QRpfX+UGBw6aFwYN+Iv5A1CIu65c5i7XIE/haMn0gmAQlWkhjxypZ7cU1kIMyF+zVcjWtxqnX80PQ
        Xf5fA2WiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUTCV-0000FO-KE; Wed, 05 Dec 2018 09:10:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26F192029FD58; Wed,  5 Dec 2018 10:10:29 +0100 (CET)
Date:   Wed, 5 Dec 2018 10:10:29 +0100
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
Message-ID: <20181205091029.GB4234@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
 <20181205054353.GE18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205054353.GE18596@alison-desk.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 09:43:53PM -0800, Alison Schofield wrote:
> On Tue, Dec 04, 2018 at 10:21:45AM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> > 
> > > +static int mktme_build_leadcpus_mask(void)
> > > +{
> > > +	int online_cpu, mktme_cpu;
> > > +	int online_pkgid, mktme_pkgid = -1;
> > > +
> > > +	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> > > +		return -ENOMEM;
> > > +
> > > +	for_each_online_cpu(online_cpu) {
> > > +		online_pkgid = topology_physical_package_id(online_cpu);
> > > +
> > > +		for_each_cpu(mktme_cpu, mktme_leadcpus) {
> > > +			mktme_pkgid = topology_physical_package_id(mktme_cpu);
> > > +			if (mktme_pkgid == online_pkgid)
> > > +				break;
> > > +		}
> > > +		if (mktme_pkgid != online_pkgid)
> > > +			cpumask_set_cpu(online_cpu, mktme_leadcpus);
> > 
> > Do you really need LOCK prefixed bit set here?
> No. Changed to __cpumask_set_cpu(). Will check for other instances
> where I can skip LOCK prefix.
> 
> > How is that serialized and kept relevant in the face of hotplug?
> mktme_leadcpus is updated on hotplug startup and teardowns.

Not in this patch it is not. That is added in a subsequent patch, which
means that during bisection hotplug is utterly wrecked if you happen to
land between these patches, that is bad.

> > Also, do you really need O(n^2) to find the first occurence of a value
> > in an array?

> How about this O(n)?
> 	
> 	unsigned long *pkg_map;
> 	int cpu, pkgid;
> 
> 	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> 		return -ENOMEM;
> 
> 	pkg_map = bitmap_zalloc(topology_max_packages(), GFP_KERNEL);
> 	if (!pkg_map) {
> 		free_cpumask_var(mktme_leadcpus);
> 		return -ENOMEM;
> 	}
> 	for_each_online_cpu(cpu) {
> 		pkgid = topology_physical_package_id(cpu);
> 		if (!test_and_set_bit(pkgid, pkg_map))

You again don't need that LOCK prefix here.

	__test_and_set_bit() :-)

> 			__cpumask_set_cpu(cpu, mktme_leadcpus);
> 	}

Right.
