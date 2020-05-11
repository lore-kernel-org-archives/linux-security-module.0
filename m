Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82DFC47255
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4071206DB
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 16:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgEKQ2P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 12:28:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:6889 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgEKQ2P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 12:28:15 -0400
IronPort-SDR: ZeE+8LLUCMyZvY18bc+uSNSqDiM3q2jWTiWXWYLEofpGi4RBtxNo96c/imBZVIR9t4ntRKA2g6
 KR08i758CtPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:28:14 -0700
IronPort-SDR: tPxYopzJGX1WjR5PKzi59Zu55kRojt6kgE1DEfCLx+VLCugzI/fgVSNf8HZQZEji2DVDyPsAJZ
 7YYE5xeyI8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="371273305"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 09:28:12 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 11 May 2020 19:28:11 +0300
Date:   Mon, 11 May 2020 19:28:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Message-ID: <20200511162811.GA487496@lahna.fi.intel.com>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com>
 <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
 <20200511104504.GK487496@lahna.fi.intel.com>
 <CAD2FfiHn0PNaC3aFXE-hn9Mmtt5JW_D8BK0hOScYXR9EJLNbcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiHn0PNaC3aFXE-hn9Mmtt5JW_D8BK0hOScYXR9EJLNbcw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 11, 2020 at 04:40:36PM +0100, Richard Hughes wrote:
> On Mon, 11 May 2020 at 11:45, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > I think you may want to look at drivers/mfd/lpc_ich.c and see if some of
> > this can be placed there. It is the "LPC" driver that binds to the
> > LPC/eSPI PCI device so it already has at least some of these PCI IDs.
> 
> Ahh, that's useful, thanks. I've attached something based on lpc_ich
> that works, although there are a few things needing discussion:
> 
> * Some of the reported eSPI IDs are missing, and I can't easily find
> references to them in the official Intel specifications. Do you need
> me to hunt them down, or can I add DIDs without referencing a document
> number? I can certainly split out the new DIDs and the securityfs
> stuff when this patchset looks half-acceptable.

I don't think you need to hunt them down. It should be fine to add PCI
IDs to the driver without reference document. Of course I'm not the
maintainer of this driver but I suspect nobody cares.

> * Do you want the CONFIG_SECURITY functionality put in a different
> file, perhaps with a different Kconfig entry? e.g. LPC_SCH_SECURITYFS
> -- if so, how do you want the hooks implemented? Declare a dummy
> lpc_ich_init_securityfs() if there is no support for securityfs like
> iommu does? Put the securityfs dentries static in this new file rather
> than in the lpc_ich_priv struct? Any advice welcome.

If it depends on that functionality then you may simply add something
like this in lpc_ich.c:

#if IS_ENABLED(CONFIG_SECURITY)
static int lpc_ich_init_securityfs(struct pci_dev *dev)
{
	...
}
#else
static inline int lpc_ich_init_securityfs(struct pci_dev *dev) { return 0; }
#endif

I mean empty stubs when the feature is not enabled so the callers can
always call them. This avoids most ugly #ifdefs.

> * My hardware seems to not set RCBA and so res->start never gets
> defined.I don't think it's a problem from my naive point of view, but
> the -ENODEV is presumably there for a reason.

Yes, so for these recent CPUs the SPI-NOR is actually a PCI device
itself so it is not exposed through LPC/eSPI. In many cases the device
is disabled by the BIOS so you can't see it if you run lspci. For
example my SPT based laptop the device is not visible.

For the security stuff you are adding, do you need to look at the PCI
device registers as well? Then some of these bits (at least WPD) is part
of the config space of that device. In that case lpc_ich may not be the
right place for this after all.

> If you want the patch inline, that's fine too, please just ask and I
> can resend. Thanks for your help so far, and sorry for all the silly
> mistakes -- I'm new to all this kernel stuff.

No problem :)

Typically inline is good. I suggest you to run

  $ scripts/get_maintainers.pl path/to/the/patch

and see who actually maintains this thing. Then, based on the above, if
you still add it this driver you can send the patch again (I suggest to
use git send-email) and Cc the maintainer(s). Actually there is this
entry in MAINTAINERS:

ICH LPC AND GPIO DRIVER
M:      Peter Tyser <ptyser@xes-inc.com>
S:      Maintained
F:      drivers/gpio/gpio-ich.c
F:      drivers/mfd/lpc_ich.c

So you should Cc Peter as well. And also the MFD maintainer (Lee Jones)
but get_maintainers.pl should list him.
