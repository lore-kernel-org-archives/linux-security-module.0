Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB1DC38A2A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42451208D6
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 08:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHIUc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 04:20:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:39910 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHIUc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 04:20:32 -0400
IronPort-SDR: UXG57jDr92DaMwZShoJKPxHvEjccCq6sIxV+7w+FYvEVi5JuBPAbOKKtvG8YrnPbf6AAUmnLOv
 YpnFUggHJshw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 01:20:31 -0700
IronPort-SDR: 9aXlZSI1bfKt+fDdEciy7ghyycxKD/Qj/NyoBHxv4dgiWR0JY/Pspy4wKv7QcwKhEh+Jqe6pP+
 9qXej/XqGcTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370377902"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 08 May 2020 01:20:29 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 08 May 2020 11:20:28 +0300
Date:   Fri, 8 May 2020 11:20:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     hughsient@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Message-ID: <20200508082028.GP487496@lahna.fi.intel.com>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 07, 2020 at 08:03:21PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Richard Hughes <hughsient@gmail.com>
> > Sent: Thursday, May 7, 2020 2:49 PM
> > To: Limonciello, Mario
> > Cc: Platform Driver; linux-security-module; mika.westerberg@linux.intel.com
> > Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
> > chip
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thu, 7 May 2020 at 20:22, <Mario.Limonciello@dell.com> wrote:
> > > By default the driver exposes SPI serial flash contents as read-only but it
> > can
> > > be changed from kernel command line, passing “intel-spi.writeable=1”.
> > 
> > Ahh, that was the bit I didn't know; having the SPI as readonly by
> > default is certainly a good idea, and probably sane enough to enable
> > for Fedora/RHEL as you still need to "do" something manual to enable
> > SPI writing. I guess I can add my securityfs additions to
> > intel-spi-pci.c with Mikas approval.
> > 
> > Richard
> 
> Mika,
> 
> Since you're being joined into the thread late, here is the context:
> https://www.spinics.net/lists/platform-driver-x86/msg21646.html

Thanks for the information. I actually prefer that this would be in a
separate driver because I do not want distros to enable intel-spi just
for this. It is really only meant for special setups where firmware
upgrade/access flow has been thoroughly tested.
