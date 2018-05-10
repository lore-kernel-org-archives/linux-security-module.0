From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 10 May 2018 23:26:39 +0000
Subject: [PATCH 3/6] firmware: differentiate between signed regulatory.db
	and other firmware
In-Reply-To: <1525917658.3551.322.camel@linux.vnet.ibm.com>
References: <20180504000743.GR27853@wotan.suse.de>
	<1525393466.3539.133.camel@linux.vnet.ibm.com>
	<20180508173404.GG27853@wotan.suse.de>
	<1525865428.3551.175.camel@linux.vnet.ibm.com>
	<20180509191508.GR27853@wotan.suse.de>
	<1525895838.3551.247.camel@linux.vnet.ibm.com>
	<20180509212212.GX27853@wotan.suse.de>
	<1525903617.3551.281.camel@linux.vnet.ibm.com>
	<20180509234814.GY27853@wotan.suse.de>
	<1525917658.3551.322.camel@linux.vnet.ibm.com>
Message-ID: <20180510232639.GF27853@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 09, 2018 at 10:00:58PM -0400, Mimi Zohar wrote:
> On Wed, 2018-05-09 at 23:48 +0000, Luis R. Rodriguez wrote:
> > On Wed, May 09, 2018 at 06:06:57PM -0400, Mimi Zohar wrote:
> 
> > > > > Yes, writing regdb as a micro/mini LSM sounds reasonable. ?The LSM
> > > > > would differentiate between other firmware and the regulatory.db based
> > > > > on the firmware's pathname.
> > > > 
> > > > If that is the only way then it would be silly to do the mini LSM as all
> > > > calls would have to have the check. A special LSM hook for just the
> > > > regulatory db also doesn't make much sense.
> > > 
> > > All calls to request_firmware() are already going through this LSM
> > > hook. ?I should have said, it would be based on both READING_FIRMWARE
> > > and the firmware's pathname.
> > 
> > Yes, but it would still be a strcmp() computation added for all
> > READING_FIRMWARE. In that sense, the current arrangement is only open coding the
> > signature verification for the regulatory.db file.  One way to avoid this would
> > be to add an LSM specific to the regulatory db
> 
> Casey already commented on this suggestion.

Sorry but I must have missed this, can you send me the email or URL where he did that?
I never got a copy of that email I think.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
