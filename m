Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDE3C07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 06:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465620882
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 06:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B465620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLGGso (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:48:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:42812 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbeLGGso (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 01:48:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 22:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="108021363"
Received: from makoli-mobl1.amr.corp.intel.com (HELO localhost) ([10.254.201.154])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2018 22:48:38 -0800
Date:   Thu, 6 Dec 2018 22:48:38 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181207064837.GD12969@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
 <1544148344.28511.21.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544148344.28511.21.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 06, 2018 at 06:05:50PM -0800, Huang, Kai wrote:
> On Wed, 2018-12-05 at 22:19 +0000, Sakkinen, Jarkko wrote:
> > On Tue, 2018-12-04 at 11:19 -0800, Andy Lutomirski wrote:
> > > I'm not Thomas, but I think it's the wrong direction.  As it stands,
> > > encrypt_mprotect() is an incomplete version of mprotect() (since it's
> > > missing the protection key support), and it's also functionally just
> > > MADV_DONTNEED.  In other words, the sole user-visible effect appears
> > > to be that the existing pages are blown away.  The fact that it
> > > changes the key in use doesn't seem terribly useful, since it's
> > > anonymous memory, and the most secure choice is to use CPU-managed
> > > keying, which appears to be the default anyway on TME systems.  It
> > > also has totally unclear semantics WRT swap, and, off the top of my
> > > head, it looks like it may have serious cache-coherency issues and
> > > like swapping the pages might corrupt them, both because there are no
> > > flushes and because the direct-map alias looks like it will use the
> > > default key and therefore appear to contain the wrong data.
> > > 
> > > I would propose a very different direction: don't try to support MKTME
> > > at all for anonymous memory, and instead figure out the important use
> > > cases and support them directly.  The use cases that I can think of
> > > off the top of my head are:
> > > 
> > > 1. pmem.  This should probably use a very different API.
> > > 
> > > 2. Some kind of VM hardening, where a VM's memory can be protected a
> > > little tiny bit from the main kernel.  But I don't see why this is any
> > > better than XPO (eXclusive Page-frame Ownership), which brings to
> > > mind:
> > 
> > What is the threat model anyway for AMD and Intel technologies?
> > 
> > For me it looks like that you can read, write and even replay 
> > encrypted pages both in SME and TME. 
> 
> Right. Neither of them (including MKTME) prevents replay attack. But
> in my understanding SEV doesn't prevent replay attack either since it
> doesn't have integrity protection.

Yep, it doesn't :-) That's why I've been wondering after seeing
presentations concerning SME and SVE what they are good for.

Cold boot attacks are definitely at least something where these
techs can help...

/Jarkko
