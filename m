From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 25 Jul 2017 15:48:02 -0400
Subject: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
In-Reply-To: <1501009739.3689.33.camel@HansenPartnership.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
	<1501008554.3689.30.camel@HansenPartnership.com>
	<20170725190406.GA1883@mail.hallyn.com>
	<1501009739.3689.33.camel@HansenPartnership.com>
Message-ID: <1501012082.27413.17.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-07-25 at 12:08 -0700, James Bottomley wrote:
> On Tue, 2017-07-25 at 14:04 -0500, Serge E. Hallyn wrote:
> > On Tue, Jul 25, 2017 at 11:49:14AM -0700, James Bottomley wrote:
> > > 
> > > On Tue, 2017-07-25 at 12:53 -0500, Serge E. Hallyn wrote:
> > > > 
> > > > On Thu, Jul 20, 2017 at 06:50:29PM -0400, Mehmet Kayaalp wrote:
> > > > > 
> > > > > 
> > > > > From: Yuqiong Sun <suny@us.ibm.com>
> > > > > 
> > > > > Add new CONFIG_IMA_NS config option.??Let clone() create a new
> > > > > IMA namespace upon CLONE_NEWNS flag. Add ima_ns data structure
> > > > > in nsproxy. ima_ns is allocated and freed upon IMA namespace
> > > > > creation and exit. Currently, the ima_ns contains no useful IMA
> > > > > data but only a dummy interface. This patch creates the
> > > > > framework for namespacing the different aspects of IMA (eg.
> > > > > IMA-audit, IMA-measurement, IMA-appraisal).
> > > > > 
> > > > > Signed-off-by: Yuqiong Sun <suny@us.ibm.com>
> > > > > 
> > > > > Changelog:
> > > > > * Use CLONE_NEWNS instead of a new CLONE_NEWIMA flag
> > > > 
> > > > Hi,
> > > > 
> > > > So this means that every mount namespace clone will clone a new
> > > > IMA namespace.??Is that really ok?
> > > 
> > > Based on what: space concerns (struct ima_ns is reasonably small)?
> > > or whether tying it to the mount namespace is the correct thing to
> > > do. ?On
> > 
> > Mostly the latter.??The other would be not so much space concerns as
> > time concerns.??Many things use new mounts namespaces, and we
> > wouldn't want multiple IMA calls on all file accesses by all of
> > those.
> > 
> > > 
> > > the latter, it does seem that this should be a property of either
> > > the mount or user ns rather than its own separate ns. ?I could see
> > > a use where even a container might want multiple ima keyrings
> > > within the container (say containerised apache service with
> > > multiple tenants), so instinct tells me that mount ns is the
> > > correct granularity for this.
> > 
> > I wonder whether we could use echo 1 > /sys/kernel/security/ima/newns
> > as the trigger for requesting a new ima ns on the next
> > clone(CLONE_NEWNS).
> 
> I could go with that, but what about the trigger being installing or
> updating the keyring? ?That's the only operation that needs namespace
> separation, so on mount ns clone, you get a pointer to the old ima_ns
> until you do something that requires a new key, which then triggers the
> copy of the namespace and installing it?

It isn't just the keyrings that need to be namespaced, but the
measurement list and policy as well.

IMA-measurement, IMA-appraisal and IMA-audit are all policy based.

As soon as the namespace starts, measurements should be added to the
namespace specific measurement list, not it's parent.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
