Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE1BC432BE
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Aug 2021 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3569A60F21
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Aug 2021 15:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhHZPJf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:09:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:58981 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhHZPJf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Aug 2021 11:09:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="278775324"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="278775324"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="516738612"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:08:46 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mJGzg-00E0jd-EM; Thu, 26 Aug 2021 18:08:40 +0300
Date:   Thu, 26 Aug 2021 18:08:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Message-ID: <YSeueHLVPsfCO0ah@smile.fi.intel.com>
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
 <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
 <YL5TN6oTtgggIFvv@smile.fi.intel.com>
 <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 10, 2021 at 05:05:55PM +0200, Ard Biesheuvel wrote:
> On Mon, 7 Jun 2021 at 19:11, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 09, 2021 at 05:51:45PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> > > > its internal members.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Thanks!
> >
> > Can we get this applied, please?
> 
> Apologies, this one slipped behind the desk.

Do I need to resend it?

-- 
With Best Regards,
Andy Shevchenko


