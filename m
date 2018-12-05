Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF49C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BEB2084C
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BEB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeLEFZ3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:25:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:48587 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEFZ3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 00:25:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 21:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="301122280"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2018 21:25:28 -0800
Date:   Tue, 4 Dec 2018 21:28:03 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 07/13] x86/mm: Add helpers for reference counting
 encrypted VMAs
Message-ID: <20181205052802.GA18596@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
 <20181204085835.GO11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204085835.GO11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 09:58:35AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:54PM -0800, Alison Schofield wrote:
> 
> > +void vma_put_encrypt_ref(struct vm_area_struct *vma)
> > +{
> > +	if (vma_keyid(vma))
> > +		if (refcount_dec_and_test(&encrypt_count[vma_keyid(vma)])) {
> > +			mktme_map_lock();
> > +			mktme_map_free_keyid(vma_keyid(vma));
> > +			mktme_map_unlock();
> > +		}
> 
> This violates CodingStyle

Got it!
Will fix this and the other instances where you noticed poorly nested
if statements. 

> > +	if (refcount_dec_and_test(&encrypt_count[keyid])) {
> > +		mktme_map_lock();
> 
> That smells like it wants to use refcount_dec_and_lock() instead.
> 
> Also, if you write that like:
> 
> 	if (!refcount_dec_and_lock(&encrypt_count[keyid], &lock))
> 		return;
> 
> you loose an indent level.
Looks good! I need to make sure it's OK to switch to a spinlock to use
the *_lock functions.
