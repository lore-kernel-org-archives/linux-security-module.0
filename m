Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B0C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B9B2084C
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B9B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLEF1q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:27:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:39456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeLEF1q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 00:27:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 21:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="98155857"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2018 21:27:45 -0800
Date:   Tue, 4 Dec 2018 21:30:20 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 09/13] mm: Restrict memory encryption to anonymous VMA's
Message-ID: <20181205053020.GB18596@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
 <20181204091044.GP11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204091044.GP11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 10:10:44AM +0100, Peter Zijlstra wrote:
> > + * Encrypted mprotect is only supported on anonymous mappings.
> > + * All VMA's in the requested range must be anonymous. If this
> > + * test fails on any single VMA, the entire mprotect request fails.
> > + */
> > +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
> 
> That's a 'weird' interface and cannot do what the comment says it should
> do.

More please? With MKTME, only anonymous memory supports encryption.
Is it the naming that's weird, or you don't see it doing what it says?

> > +	struct vm_area_struct *test_vma = vma;
> 
> That variable is utterly pointless.
Got it. Will fix.

Thanks
