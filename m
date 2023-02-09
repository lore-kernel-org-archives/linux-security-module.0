Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AC5C05027
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBIXsA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 18:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIXr7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 18:47:59 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B24E23317
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 15:47:57 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 319NleVV023306;
        Thu, 9 Feb 2023 17:47:40 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 319NleI6023305;
        Thu, 9 Feb 2023 17:47:40 -0600
Date:   Thu, 9 Feb 2023 17:47:40 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
Message-ID: <20230209234740.GA23164@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com> <Y+TdSivplpimof7o@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+TdSivplpimof7o@kroah.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 09 Feb 2023 17:47:41 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 09, 2023 at 12:47:22PM +0100, Greg KH wrote:
> On Fri, Feb 03, 2023 at 11:09:42PM -0600, Dr. Greg wrote:
> > An entry was added to the ABI testing documentation to document
> > the files in the TSEM management filesystem.
> > 
> > The file documenting the kernel command-line parameters was
> > updated to document the tsem_mode command-line parameter.
> > 
> > The primary TSEM documentation file was added to the LSM
> > administration guide and the file was linked to the index of LSM
> > documentation.
> > 
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  Documentation/ABI/testing/tsemfs              |  576 ++++++++

> Ah, here's the documentation, thanks.

Very good, hopefully it was found to be complete.

I will respond to the control plane filesystem concerns in your
comments in response to the patch that introduces the filesytem.

> > diff --git a/Documentation/ABI/testing/tsemfs b/Documentation/ABI/testing/tsemfs
> > new file mode 100644
> > index 000000000000..3d326934624c
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/tsemfs
> > @@ -0,0 +1,576 @@
> > +What:		/sys/fs/tsem
> > +Date:		November 2022

> It's not November 2022 anymore :(

I know, we will fix all of the 2022 dates in the second spin of the
patchset.

> thanks,
> 
> greg k-h

Have a good evening.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
