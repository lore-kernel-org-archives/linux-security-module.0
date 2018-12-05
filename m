Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A207C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98032084C
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98032084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeLEFdm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:33:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:30487 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeLEFdl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 00:33:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 21:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="107389653"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2018 21:33:40 -0800
Date:   Tue, 4 Dec 2018 21:36:15 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Message-ID: <20181205053615.GD18596@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
 <20181204093116.GV11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204093116.GV11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 10:31:16AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:40:00PM -0800, Alison Schofield wrote:
> >  static int mktme_program_system(struct mktme_key_program *key_program,
> > -				cpumask_var_t mktme_cpumask)
> > +				cpumask_var_t mktme_cpumask, int hotplug)
> >  {
> >  	struct mktme_hw_program_info info = {
> >  		.key_program = key_program,
> >  		.status = MKTME_PROG_SUCCESS,
> >  	};
> > -	get_online_cpus();
> > -	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
> > -	put_online_cpus();
> > +
> > +	if (!hotplug) {
> > +		get_online_cpus();
> > +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> > +				 &info, 1);
> > +		put_online_cpus();
> > +	} else {
> > +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> > +				 &info, 1);
> > +	}
> >  
> >  	return info.status;
> >  }
> 
> That is pretty horrible; and I think easily avoided.
Agree it's ugly. Not sure we share the same reasoning. I realize that
the hotplug case is on the current cpu and so that whole
one_each_cpu_mask() call is not needed. mktme_program_package() can just
be called on the current cpu.

The ugliness that haunts me is that I wanted to reuse this code path,
and so I passed that 'hotplug' parameter along as a differentiator
between hotplug & 'typical' key programming. 
I'll rework this.
