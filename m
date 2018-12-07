Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C8C07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 03:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4916E2083D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 03:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLGDjt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:39:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:2236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGDjt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 22:39:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 19:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="98765078"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2018 19:39:48 -0800
Date:   Thu, 6 Dec 2018 19:42:17 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "luto@kernel.org" <luto@kernel.org>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Message-ID: <20181207034217.GA13388@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
 <1544148839.28511.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544148839.28511.28.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 06, 2018 at 06:14:03PM -0800, Huang, Kai wrote:
> On Mon, 2018-12-03 at 23:39 -0800, Alison Schofield wrote:

8< ------------

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
> Overall, I am not sure whether saving key is good idea, since it breaks coldboot attack IMHO. We
> need to tradeoff between supporting CPU hotplug and security. I am not sure whether supporting CPU
> hotplug is that important, since for some other features such as SGX, we don't support CPU hotplug
> anyway.

Yes, saving the key data exposes it in a cold boot attack.

Here we have 2 conflicting requirements. Do not save the data and
support CPU hotplug. I don't think CPU hotplug support is budging!
If the risk of offering the mktme_savekeys option is too dangerous,
then we can't have user type keys.
Is mktme_savekeys options too risky to offer?
(That's not just a question for you Kai ;). I'll pursue too.)
> 
> Alternatively, we can choose to use per-socket keyID, but not to program keyID globally across all
> sockets, so you don't have to save key while still supporting CPU hotplug.

An alternative, with a lot of impact to the core linux support for
MKTME.  I don't think we need to go there. I'll leave this thought for
a Kirill or Dave to perhaps elaborate on. 

Alison 
> 
> Thanks,
> -Kai
