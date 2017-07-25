From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 25 Jul 2017 16:47:20 -0400
Subject: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
In-Reply-To: <1501014695.3689.41.camel@HansenPartnership.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
	<1501008554.3689.30.camel@HansenPartnership.com>
	<20170725190406.GA1883@mail.hallyn.com>
	<1501009739.3689.33.camel@HansenPartnership.com>
	<1501012082.27413.17.camel@linux.vnet.ibm.com>
	<1501014695.3689.41.camel@HansenPartnership.com>
Message-ID: <1501015640.27413.40.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-07-25 at 13:31 -0700, James Bottomley wrote:
> On Tue, 2017-07-25 at 15:48 -0400, Mimi Zohar wrote:
> > On Tue, 2017-07-25 at 12:08 -0700, James Bottomley wrote:
> > > 
> > > On Tue, 2017-07-25 at 14:04 -0500, Serge E. Hallyn wrote:
> > > > 
> > > > On Tue, Jul 25, 2017 at 11:49:14AM -0700, James Bottomley wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 2017-07-25 at 12:53 -0500, Serge E. Hallyn wrote:
> [...]
> > > > > the latter, it does seem that this should be a property of
> > > > > either the mount or user ns rather than its own separate ns. ?I
> > > > > could see a use where even a container might want multiple ima
> > > > > keyrings within the container (say containerised apache service
> > > > > with multiple tenants), so instinct tells me that mount ns is
> > > > > the correct granularity for this.
> > > > 
> > > > I wonder whether we could use echo 1 >
> > > > /sys/kernel/security/ima/newns
> > > > as the trigger for requesting a new ima ns on the next
> > > > clone(CLONE_NEWNS).
> > > 
> > > I could go with that, but what about the trigger being installing
> > > or updating the keyring? ?That's the only operation that needs
> > > namespace separation, so on mount ns clone, you get a pointer to
> > > the old ima_ns until you do something that requires a new key,
> > > which then triggers the copy of the namespace and installing it?
> > 
> > It isn't just the keyrings that need to be namespaced, but the
> > measurement list and policy as well.
> 
> OK, so trigger to do a just in time copy would be new key or new
> policy.

The kernel has support for an initial builtin policy, which can be
later replaced. ?The builtin policies, if specified, begin measuring
files very early in the boot process. ?Similarly for namespace, we
would want to start measuring files as early as possible.

> The measurement list is basically just a has of a file taken
> at a policy point. ?Presumably it doesn't change if we install a new
> policy or key, so it sounds like it should be tied to the underlying
> mount point? ?I'm thinking if we set up a hundred mount ns each
> pointing to /var/container, we don't want /var/container/bin/something
> to have 100 separate measurements each with the same hash.
> 
> > IMA-measurement, IMA-appraisal and IMA-audit are all policy based.
> > 
> > As soon as the namespace starts, measurements should be added to the
> > namespace specific measurement list, not it's parent.
> 
> Would the measurement in a child namespace yield a different
> measurement in the parent? ?I'm thinking not, because a measurement is
> just a hash. ?Now if the signature of the hash in the xattr needs a
> different key, obviously this differs, but the expensive part
> (computing the hash) shouldn't change.

Depending on the measurement list template format (eg. ima-ng, ima-
sig, custom template format), the template data would contain the file
hash, but in addition it might contain the file signature. ?As keys
could be namespace specific, the file signatures could be different.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
