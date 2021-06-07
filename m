Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE47BC47094
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC9A60FF2
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFGRNP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:13:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:41309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhFGRNP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 13:13:15 -0400
IronPort-SDR: q7Daxz0rRwOcAA0sPlR9u8SpauxDst/tpQnVYGTuFETS1fTVsJgoQ5vTXeLY1hUQxzQ1AaapeW
 dO2kxWuQTf3w==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201644239"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="201644239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:11:23 -0700
IronPort-SDR: HIpv589rUj3eCUwXDFAcboahUkoDihfgfT1TMDf7nwruUA0Tygk+hMl7IShxFB8PyjM3zK1iZx
 qf2mhma6AoAw==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551960282"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:11:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqImV-000JOQ-Nz; Mon, 07 Jun 2021 20:11:19 +0300
Date:   Mon, 7 Jun 2021 20:11:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Message-ID: <YL5TN6oTtgggIFvv@smile.fi.intel.com>
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
 <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 09, 2021 at 05:51:45PM +0100, Ard Biesheuvel wrote:
> On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> > its internal members.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

Can we get this applied, please?


-- 
With Best Regards,
Andy Shevchenko


