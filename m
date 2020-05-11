Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E05C47255
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6219207DD
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEKKlR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 06:41:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:33003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKlR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 06:41:17 -0400
IronPort-SDR: 2UMKUjRWNfb8JKnWCPRPsYlPKZgLbI/JbeiyQsZ3bA2GbbaXFj0LeOdLT4iNJk1fleO6goOf2I
 yq4yiWGpz8LA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:41:16 -0700
IronPort-SDR: xFEZE12xISkmwQY8B7HEN57E2P3BZfQe77usOg03sOuMSgJNonsFa9TagqIDy/oxFpoIOyck2j
 Uloyi0kyLuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371183021"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:41:13 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 11 May 2020 13:41:13 +0300
Date:   Mon, 11 May 2020 13:41:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     hughsient@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Message-ID: <20200511104113.GJ487496@lahna.fi.intel.com>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com>
 <34e4985da20747a780971b8ce7cd83ab@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e4985da20747a780971b8ce7cd83ab@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 08, 2020 at 05:27:12PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> > owner@vger.kernel.org> On Behalf Of Mika Westerberg
> > Sent: Friday, May 8, 2020 3:20 AM
> > To: Limonciello, Mario
> > Cc: hughsient@gmail.com; platform-driver-x86@vger.kernel.org; linux-
> > security-module@vger.kernel.org
> > Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system
> > SPI chip
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thu, May 07, 2020 at 08:03:21PM +0000, Mario.Limonciello@dell.com
> > wrote:
> > > > -----Original Message-----
> > > > From: Richard Hughes <hughsient@gmail.com>
> > > > Sent: Thursday, May 7, 2020 2:49 PM
> > > > To: Limonciello, Mario
> > > > Cc: Platform Driver; linux-security-module;
> > mika.westerberg@linux.intel.com
> > > > Subject: Re: [PATCH] platform/x86: Export LPC attributes for the
> > system SPI
> > > > chip
> > > >
> > > >
> > > > [EXTERNAL EMAIL]
> > > >
> > > > On Thu, 7 May 2020 at 20:22, <Mario.Limonciello@dell.com> wrote:
> > > > > By default the driver exposes SPI serial flash contents as read-
> > only but it
> > > > can
> > > > > be changed from kernel command line, passing “intel-
> > spi.writeable=1”.
> > > >
> > > > Ahh, that was the bit I didn't know; having the SPI as readonly by
> > > > default is certainly a good idea, and probably sane enough to enable
> > > > for Fedora/RHEL as you still need to "do" something manual to enable
> > > > SPI writing. I guess I can add my securityfs additions to
> > > > intel-spi-pci.c with Mikas approval.
> > > >
> > > > Richard
> > >
> > > Mika,
> > >
> > > Since you're being joined into the thread late, here is the context:
> > > https://www.spinics.net/lists/platform-driver-x86/msg21646.html
> > 
> > Thanks for the information. I actually prefer that this would be in a
> > separate driver because I do not want distros to enable intel-spi just
> > for this. It is really only meant for special setups where firmware
> > upgrade/access flow has been thoroughly tested.
> 
> Mika,
> 
> Thanks for those comments and context on that driver.  Considering this,
> what do you think about as part of this new driver, moving the list of
> supported IDs in there to something that can be sourced by both drivers?
> I think it should help avoid having to keep the two lists fully in sync
> as new silicon comes out.

Hi,

Since this is binding to the LPC/eSPI device I think you may be adding
this functionality to drivers/mfd/lpc_ich.c. It is also filling the data
for intel-spi so it is natural place to re-use the code. I actually
think it already has some of these PCI IDs.
