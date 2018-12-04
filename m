Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462AC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440A62082B
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440A62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLDJuP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:50:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:18632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJuP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:50:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 01:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="115483840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2018 01:50:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BAD8122D; Tue,  4 Dec 2018 11:50:09 +0200 (EET)
Date:   Tue, 4 Dec 2018 12:50:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alison Schofield <alison.schofield@intel.com>, dhowells@redhat.com,
        tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a
 system wide basis
Message-ID: <20181204095009.ehgyxvv4lcd7ztd7@black.fi.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204092145.GR11614@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 09:21:45AM +0000, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> 
> > +struct mktme_hw_program_info {
> > +	struct mktme_key_program *key_program;
> > +	unsigned long status;
> > +};
> > +
> > +/* Program a KeyID on a single package. */
> > +static void mktme_program_package(void *hw_program_info)
> > +{
> > +	struct mktme_hw_program_info *info = hw_program_info;
> > +	int ret;
> > +
> > +	ret = mktme_key_program(info->key_program);
> > +	if (ret != MKTME_PROG_SUCCESS)
> > +		WRITE_ONCE(info->status, ret);
> 
> What's the purpose of that WRITE_ONCE()?

[I suggested the code to Alison.]

Yes, you're right. Simple assignment will do.

-- 
 Kirill A. Shutemov
