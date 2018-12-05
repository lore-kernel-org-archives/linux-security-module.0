Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFEC04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8BD20878
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8BD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeLERYE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:24:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:7041 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbeLERYE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 12:24:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="281190323"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2018 09:24:03 -0800
Date:   Wed, 5 Dec 2018 09:26:37 -0800
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
Message-ID: <20181205172637.GA443@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
 <20181205054353.GE18596@alison-desk.jf.intel.com>
 <20181205091029.GB4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205091029.GB4234@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 05, 2018 at 10:10:29AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 04, 2018 at 09:43:53PM -0800, Alison Schofield wrote:
> > On Tue, Dec 04, 2018 at 10:21:45AM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> > 
> > > How is that serialized and kept relevant in the face of hotplug?
> > mktme_leadcpus is updated on hotplug startup and teardowns.
> 
> Not in this patch it is not. That is added in a subsequent patch, which
> means that during bisection hotplug is utterly wrecked if you happen to
> land between these patches, that is bad.
>
The Key Service support is split between 4 main patches (10-13), but
the dependencies go further back in the patchset.

If the bisect need outweighs any benefit from reviewing in pieces,
then these patches can be squashed to a single patch:

keys/mktme: Add the MKTME Key Service type for memory encryption
keys/mktme: Program memory encryption keys on a system wide basis
keys/mktme: Save MKTME data if kernel cmdline parameter allows
keys/mktme: Support CPU Hotplug for MKTME keys

Am I interpreting your point correctly?
Thanks,
Alison
