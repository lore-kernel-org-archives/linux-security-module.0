From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Mar 2018 11:19:46 -0400
Subject: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <87d10513id.fsf@xmission.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
	<20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
	<87vadxfwqj.fsf@xmission.com>
	<c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
	<1521135192.5348.64.camel@HansenPartnership.com>
	<2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
	<1521139535.5348.89.camel@HansenPartnership.com>
	<0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
	<1521140467.5348.94.camel@HansenPartnership.com>
	<056e5b9e-b4d3-1862-baea-06dda4bd0713@linux.vnet.ibm.com>
	<87sh915eo0.fsf@xmission.com>
	<19ecc296-b584-4e1a-5369-30090fbc7880@linux.vnet.ibm.com>
	<87d10513id.fsf@xmission.com>
Message-ID: <1521645586.3848.136.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-15 at 15:35 -0500, Eric W. Biederman wrote:
> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
> > On 03/15/2018 03:20 PM, Eric W. Biederman wrote:

[..]

> >>  From previous conversations I remember that there is a legitimate
> >> bootstrap problem for IMA.  That needs to be looked at, and I am not
> >> seeing that mentioned.
> >
> > IMA's log should not have a gap. So ideally we shouldn't have to write something
> > into sysfs to spawn a new IMA namespace so that we don't miss whatever setup may
> > have happened to get there, including the writing into procfs. IMA should be
> > there right from the start. So a clone flag would be ideal for that.
> 
> Please make that securityfs not sysfs.  Sysfs should be about the
> hardware not these higher level software details.  I really don't want
> to have to namespace sysfs more than I already have.
> 
> As for the no gaps requirement.  That is a powerful lever for ruling out
> solutions that don't work as well.

IMA-measurement and IMA-audit need to be enabled from the very
beginning. ?The only reason we differentiate between IMA-measurement
and IMA-audit from IMA-appraisal is simply because the initramfs
doesn't include xattrs. ?Once support for CPIO xattrs is upstreamed,
IMA-appraisal could then also be enabled from the very beginning. ?For
now, we rely on the initramfs being measured (and appraised) and
enable IMA-appraisal before any files are accessed from real root.
?Systems with a custom /init today already can enable IMA-appraisal
from the very beginning. ?

In terms of IMA namespacing, we shouldn't need to differentiate
between IMA-measurement and IMA-audit from IMA-appraisal. ?All of them
should be initialized from the very beginning to capture all
measurements in the measurement list, audit the measurements and
appraise all files.

Requiring IMA namespacing to be joined to another namespace
complicates things, like the unnecessary creation of IMA namespaces.
?Just as there is an "owning" namespace for other namespaces, there
should be an "owning" IMA namespace, which is independent of either
the mount or user namespace.

(I hope I'm using the term "owning" properly here.)

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
