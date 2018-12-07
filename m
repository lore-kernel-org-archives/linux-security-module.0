Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634BC07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 06:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7C20838
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 06:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC7C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGGjZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:39:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:58382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGGjZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 01:39:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 22:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="116762644"
Received: from makoli-mobl1.amr.corp.intel.com (HELO localhost) ([10.254.201.154])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2018 22:39:20 -0800
Date:   Thu, 6 Dec 2018 22:39:19 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Message-ID: <20181207063918.GB12969@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
 <1544148839.28511.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544148839.28511.28.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 06, 2018 at 06:14:03PM -0800, Huang, Kai wrote:
> On Mon, 2018-12-03 at 23:39 -0800, Alison Schofield wrote:
> > MKTME (Multi-Key Total Memory Encryption) key payloads may include
> > data encryption keys, tweak keys, and additional entropy bits. These
> > are used to program the MKTME encryption hardware. By default, the
> > kernel destroys this payload data once the hardware is programmed.
> > 
> > However, in order to fully support CPU Hotplug, saving the key data
> > becomes important. The MKTME Key Service cannot allow a new physical
> > package to come online unless it can program the new packages Key Table
> > to match the Key Tables of all existing physical packages.
> > 
> > With CPU generated keys (a.k.a. random keys or ephemeral keys) the
> > saving of user key data is not an issue. The kernel and MKTME hardware
> > can generate strong encryption keys without recalling any user supplied
> > data.
> > 
> > With USER directed keys (a.k.a. user type) saving the key programming
> > data (data and tweak key) becomes an issue. The data and tweak keys
> > are required to program those keys on a new physical package.
> > 
> > In preparation for adding CPU hotplug support:
> > 
> >    Add an 'mktme_vault' where key data is stored.
> > 
> >    Add 'mktme_savekeys' kernel command line parameter that directs
> >    what key data can be stored. If it is not set, kernel does not
> >    store users data key or tweak key.
> > 
> >    Add 'mktme_bitmap_user_type' to track when USER type keys are in
> >    use. If no USER type keys are currently in use, a physical package
> >    may be brought online, despite the absence of 'mktme_savekeys'.
> 
> Overall, I am not sure whether saving key is good idea, since it
> breaks coldboot attack IMHO. We need to tradeoff between supporting
> CPU hotplug and security. I am not sure whether supporting CPU hotplug
> is that important, since for some other features such as SGX, we don't
> support CPU hotplug anyway.

What is the application for saving the key anyway?

With my current knowledge, I'm not even sure what is the application
for user provided keys.

/Jarkko
