Return-Path: <SRS0=p3Qd=62=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F1C54E4B
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 06:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1C120733
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 06:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgELGoF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 May 2020 02:44:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:36714 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGoF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 02:44:05 -0400
IronPort-SDR: wFOhgeAH8h4OSLqYLn39dbUs4GFc65S1NAE052uJmg0XEoF+syBIw4YrKAofBXJMrzwckqdY15
 df/RCuK4xBag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 23:44:04 -0700
IronPort-SDR: Xl0uZ7EF12TbnJ0IwesxKzMMp6T45wVEjSdzvJIxVhtqPWqZ+R/3uMA/M0KTOQ6jewdxlYxgyx
 pkOF3oXHQkAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,382,1583222400"; 
   d="scan'208";a="371468564"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 23:44:02 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 May 2020 09:44:01 +0300
Date:   Tue, 12 May 2020 09:44:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Message-ID: <20200512064401.GF487496@lahna.fi.intel.com>
References: <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com>
 <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
 <20200511104504.GK487496@lahna.fi.intel.com>
 <CAD2FfiHn0PNaC3aFXE-hn9Mmtt5JW_D8BK0hOScYXR9EJLNbcw@mail.gmail.com>
 <20200511162811.GA487496@lahna.fi.intel.com>
 <CAD2FfiHo1EzRupjgKhtLX0Zguq-bVeW5+u_PNQGAzV0x+AtfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiHo1EzRupjgKhtLX0Zguq-bVeW5+u_PNQGAzV0x+AtfVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 11, 2020 at 09:08:31PM +0100, Richard Hughes wrote:
> > For the security stuff you are adding, do you need to look at the PCI
> > device registers as well?
> 
> No, just the config space. I guess at some point I might want to put
> some of the chipsec vulnerability checks into the module, although I'm
> not happy adding anything remotely dangerous.

I mean for the SPI-NOR controller PCI device registers (not the LPC PCI
device, sorry about not being clear), like config space. Typically it is
PCI device 1f.5 and in that case you can't use the LPC driver because it
should not touch other devices than what it is bound to (OK, there are
exceptions but still).

If that's the case then I guess this should go to intel-spi-pci/platform
drivers after all. I think one option is that we add Kconfig option that
makes the driver load but only provide the security bits without
actually calling intel_spi_probe().
