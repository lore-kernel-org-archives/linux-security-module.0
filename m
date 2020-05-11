Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0DC47255
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810C020801
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 10:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgEKKpI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 06:45:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:7369 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKpH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 06:45:07 -0400
IronPort-SDR: KVIJIlNWkevURttMhvNlJOFjYT29m9XA8z/56pjPCGC1dqZQDJAWJLH8jwgl1HAYXL3WZUdCQ3
 innvSGWfmjHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:45:07 -0700
IronPort-SDR: Ua4bAD1ceo59o+HlpUjYW70GLXtLGm/3joX0Yni0MTQueVkiRQo6fGMlxpULpC/paAOdXJhkPk
 8RthcAlSDrcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371183649"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:45:05 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 11 May 2020 13:45:04 +0300
Date:   Mon, 11 May 2020 13:45:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Message-ID: <20200511104504.GK487496@lahna.fi.intel.com>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com>
 <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 08, 2020 at 05:15:07PM +0100, Richard Hughes wrote:
> On Fri, 8 May 2020 at 09:20, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Thanks for the information. I actually prefer that this would be in a
> > separate driver because I do not want distros to enable intel-spi just
> > for this. It is really only meant for special setups where firmware
> > upgrade/access flow has been thoroughly tested.
> 
> Do you think the driver should be part of mtd (e.g. something like
> drivers/mtd/spi-nor/controllers/intel-spi-pci-lpc.c) or be something
> like I proposed in drivers/platform/x86? Ideas very welcome, thanks.

I think you may want to look at drivers/mfd/lpc_ich.c and see if some of
this can be placed there. It is the "LPC" driver that binds to the
LPC/eSPI PCI device so it already has at least some of these PCI IDs.
