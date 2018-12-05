Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E4C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043192081C
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043192081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeLEFlT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:41:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:14725 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeLEFlT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 00:41:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 21:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="123049832"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2018 21:41:18 -0800
Date:   Tue, 4 Dec 2018 21:43:53 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a
 system wide basis
Message-ID: <20181205054353.GE18596@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204092145.GR11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 10:21:45AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> 
> > +static int mktme_build_leadcpus_mask(void)
> > +{
> > +	int online_cpu, mktme_cpu;
> > +	int online_pkgid, mktme_pkgid = -1;
> > +
> > +	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	for_each_online_cpu(online_cpu) {
> > +		online_pkgid = topology_physical_package_id(online_cpu);
> > +
> > +		for_each_cpu(mktme_cpu, mktme_leadcpus) {
> > +			mktme_pkgid = topology_physical_package_id(mktme_cpu);
> > +			if (mktme_pkgid == online_pkgid)
> > +				break;
> > +		}
> > +		if (mktme_pkgid != online_pkgid)
> > +			cpumask_set_cpu(online_cpu, mktme_leadcpus);
> 
> Do you really need LOCK prefixed bit set here?
No. Changed to __cpumask_set_cpu(). Will check for other instances
where I can skip LOCK prefix.

> How is that serialized and kept relevant in the face of hotplug?
mktme_leadcpus is updated on hotplug startup and teardowns.

> Also, do you really need O(n^2) to find the first occurence of a value
> in an array?
How about this O(n)?
	
	unsigned long *pkg_map;
	int cpu, pkgid;

	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
		return -ENOMEM;

	pkg_map = bitmap_zalloc(topology_max_packages(), GFP_KERNEL);
	if (!pkg_map) {
		free_cpumask_var(mktme_leadcpus);
		return -ENOMEM;
	}
	for_each_online_cpu(cpu) {
		pkgid = topology_physical_package_id(cpu);
		if (!test_and_set_bit(pkgid, pkg_map))
			__cpumask_set_cpu(cpu, mktme_leadcpus);
	}







