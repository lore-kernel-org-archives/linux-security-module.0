From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 21 Nov 2017 09:05:48 -0500
Subject: IMA appraisal master plan?
In-Reply-To: <fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
References: <20171107151742.25122-1-mjg59@google.com>
	<1510766803.5979.17.camel@intel.com>
	<CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
	<1510770065.5979.21.camel@intel.com>
	<alpine.LFD.2.20.1711161101360.27132@localhost>
	<CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
	<1510798382.3711.389.camel@linux.vnet.ibm.com>
	<8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
	<1510837595.3711.420.camel@linux.vnet.ibm.com>
	<a88aff89-1e75-9019-4394-640f5fb318da@huawei.com>
	<alpine.LFD.2.20.1711200746120.25470@localhost>
	<1511173252.5979.45.camel@intel.com>
	<fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
Message-ID: <1511273148.4729.206.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-11-21 at 10:33 +0100, Roberto Sassu wrote:
> On 11/20/2017 11:20 AM, Patrick Ohly wrote:
> > On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
> >> On Fri, 17 Nov 2017, Roberto Sassu wrote:
> >>
> >>> LSMs are responsible to enforce a security policy at run-time,
> >>> while IMA/EVM protect data and metadata against offline attacks.
> >>
> >> In my view, IMA can also protect against making an online attack
> >> persistent across boots, and that would be the most compelling use of
> >> it?for many general purpose applications.
> 
> It would be possible, if IMA knows when the system is in the expected
> state. For example, if the system is in the expected state after digest
> lists have been loaded, IMA could erase the EVM key, sealed to that
> state, when a file with unknown digest is measured. The system won't be
> able to produce valid HMACs, and files modified after the attack can be
> identified at the next boot, due to the invalid HMAC. Also accessing
> files with invalid HMAC will cause the EVM key to be zeroed.

Roberto, allowing the system to boot with an EVM HMAC key, but then
transition to a point when it can't be used, is a good idea. ?The
transitioning, however, shouldn't be tied to white lists. ?Please keep
these concepts independent of each other.

Preventing a device from booting is major. ?Is there a less drastic
solution that would allow detection, without resealing the EVM HMAC
key so it can't be used?

Years ago Dave and I had a prototype of "locking" mutable files, after
a certain point in the boot process, working. ?It allowed the ~20
mutable files to be created/updated, as necessary. ?The limitation was
that any package updates or new packages installations needed to be
done during this window, before the transition, as well.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
