From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 11 May 2018 01:00:26 -0400
Subject: [PATCH 3/6] firmware: differentiate between signed
	regulatory.db and other firmware
In-Reply-To: <20180510232639.GF27853@wotan.suse.de>
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
	<20180510232639.GF27853@wotan.suse.de>
Message-ID: <1526014826.3414.46.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-05-10 at 23:26 +0000, Luis R. Rodriguez wrote:
> On Wed, May 09, 2018 at 10:00:58PM -0400, Mimi Zohar wrote:
> > On Wed, 2018-05-09 at 23:48 +0000, Luis R. Rodriguez wrote:
> > > On Wed, May 09, 2018 at 06:06:57PM -0400, Mimi Zohar wrote:
> > 
> > > > > > Yes, writing regdb as a micro/mini LSM sounds reasonable. ?The LSM
> > > > > > would differentiate between other firmware and the regulatory.db based
> > > > > > on the firmware's pathname.
> > > > > 
> > > > > If that is the only way then it would be silly to do the mini LSM as all
> > > > > calls would have to have the check. A special LSM hook for just the
> > > > > regulatory db also doesn't make much sense.
> > > > 
> > > > All calls to request_firmware() are already going through this LSM
> > > > hook. ?I should have said, it would be based on both READING_FIRMWARE
> > > > and the firmware's pathname.
> > > 
> > > Yes, but it would still be a strcmp() computation added for all
> > > READING_FIRMWARE. In that sense, the current arrangement is only open coding the
> > > signature verification for the regulatory.db file.  One way to avoid this would
> > > be to add an LSM specific to the regulatory db
> > 
> > Casey already commented on this suggestion.
> 
> Sorry but I must have missed this, can you send me the email or URL where he did that?
> I never got a copy of that email I think.

My mistake. ?I've posted similar patches for kexec_load and for the
firmware sysfs fallback, both call security_kernel_read_file().
Casey's comment was in regards to kexec_load[1], not for the sysfs
fallback mode. ?Here's the link to the most recent version of the
kexec_load patches.[2]

[1]?http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006690.html
[2] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006854.html

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
