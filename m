Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A48C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06786206B7
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06786206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeLEFtb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:49:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:47387 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeLEFtb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 00:49:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 21:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="98750411"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2018 21:49:30 -0800
Date:   Tue, 4 Dec 2018 21:52:05 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory
 encryption keys
Message-ID: <20181205055205.GB18844@alison-desk.jf.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
 <7896A3D4-22B3-4124-BA0A-ED763128C5D6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7896A3D4-22B3-4124-BA0A-ED763128C5D6@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 07:35:50AM -0800, Andy Lutomirski wrote:
> 
> 
> > On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.com> wrote:
> > 
> > Define a global mapping structure to manage the mapping of userspace
> > Keys to hardware KeyIDs in MKTME (Multi-Key Total Memory Encryption).
> > Implement helper functions that access this mapping structure.
> > 
> 
> Why is a key “void *”?  Who owns the memory?  Can a real type be used?
>
It's of type "struct key" of the kernel key service.
Replacing void w 'struct key'.
