Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C2C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE8B2082D
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE8B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbeLDJqy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:46:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:33153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJqy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:46:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 01:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="280782949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2018 01:46:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 95A8D22D; Tue,  4 Dec 2018 11:46:47 +0200 (EET)
Date:   Tue, 4 Dec 2018 12:46:47 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alison Schofield <alison.schofield@intel.com>, dhowells@redhat.com,
        tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204092550.GT11614@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 09:25:50AM +0000, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:47PM -0800, Alison Schofield wrote:
> > (Multi-Key Total Memory Encryption)
> 
> I think that MKTME is a horrible name, and doesn't appear to accurately
> describe what it does either. Specifically the 'total' seems out of
> place, it doesn't require all memory to be encrypted.

MKTME implies TME. TME is enabled by BIOS and it encrypts all memory with
CPU-generated key. MKTME allows to use other keys or disable encryption
for a page.

But, yes, name is not good.

-- 
 Kirill A. Shutemov
