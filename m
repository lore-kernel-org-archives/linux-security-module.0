From: greg@enjellic.com (Dr. Greg Wettstein)
Date: Wed, 31 May 2017 04:49:58 -0500
Subject: [RFC 04/11] ima: add support to namespace securityfs file
In-Reply-To: <1496079158.3841.350.camel@linux.vnet.ibm.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
	<1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
	<1495656774.3841.72.camel@linux.vnet.ibm.com>
	<d8d55872-db78-3535-a540-85c0dbb2d6fd@canonical.com>
	<1495712762.3841.89.camel@linux.vnet.ibm.com>
	<CS1PR84MB0294089AC618EE12DB042263FFFF0@CS1PR84MB0294.NAMPRD84.PROD.OUTLOOK.COM>
	<1496079158.3841.350.camel@linux.vnet.ibm.com>
Message-ID: <20170531094958.GA3799@wind.enjellic.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 29, 2017 at 01:32:38PM -0400, Mimi Zohar wrote:

> Hi Guilherme,
> 
> (Wow, you should did Cc a lot of people.)

Indeed.

We have namespaced a significant amount of the IMA code so we will
continue the broadcast, under the assumption that this is of general
interest to the community.

Comments below.

> On Thu, 2017-05-25 at 19:04 +0000, Magalhaes, Guilherme (Brazil R&D-
> CL) wrote:
> > Mimi,
> > With the securityfs symlink we would address the case of setting
> > policy inside containers, but we still would need a way to set the
> > IMA policy per namespace outside containers. So, the current
> > proposed interface would address the latter case.
> > As an alternative to symlinks, taking this patch set as base, and
> > still considering setting policy inside containers (or inside
> > namespaces in general), it is possible to bind mount the securityfs
> > files into the containers, but it would be needed to prevent
> > read/write access to the namespaced IMA policy files for processes
> > not running on the same namespace.
> > 
> > These mechanisms would not require a change in the proposed design.
> > Do you think these mechanisms are enough for the flexibility you
> > asked?
> 
> I'm really sorry Guileherme, but as I previously explained, IMA has
> many aspects to it - the original file measurements (IMA-measurement), 
> file hash/signature appraisal (IMA-appraisal), and file audit messages
> (IMA-audit) used for security analytics/forensics, not the file system
> auditing.????To namespace IMA properly requires addressing some
> underlying problems - securityfs, root privilege required for writing
> security xattrs, per namespace IMA keyring - to name a few.
> 
> I understand wanting to namespace the appraisal aspect first, but when
> you asked me if anyone else is working on namespacing IMA at the
> moment, I suggested starting with the IMA-audit aspect for a
> reason.????By beginning with the IMA-audit aspect, we could ignore, at
> least for the time being, some of these underlying problems, but
> define the basic namespacing architecture.????By jumping to namespacing
> the appraisal aspect, you've simply avoided addressing the IMA
> namespacing architecture issues, which need to be addressed.
> 
> Here are some, not by any means all, of the issues with namespacing
> IMA.
>
> 
> - IMA-measurements:
> 
> The namespacing design will need to support different types of
> environments. For example, depending on the environment, namespaces
> can come and go frequently. In such an environment do we really want
> all the namespace measurements to be included in the system
> measurement list, or should each namespace have its own measurement
> list?????Should the namespace measurement policy be the same as the
> system measurement policy?????Should the namespace (container) owner be
> allowed to modify their own policy?????If a file matches a rule in both
> the namespace and system policies, should the file measurement be in
> both the namespace and the system measurement lists?
> 
> 
> - IMA-appraisal
> 
> Assuming the IMA appraisal policy requires file signatures, signatures
> are verified based on the keys on the IMA keyring.????When discussing
> namespacing IMA-appraisal, we might want different sets of keys in
> different namespaces. This requires separate keyrings for each
> namespace. ??In some use cases, we might want to include the keys on
> the system IMA keyring, while in other use cases we might not.
> 
> Even if real root initially installs the files with their file
> signatures, stored as extended attributes, how will software be
> updated, as writing file signatures requires root
> privilege?Capabilities has recently added support to permit root in
> the namespace to write security.capability.????Similarly when
> namespacing IMA, root in the namespace needs the ability to write
> security.ima.
> 
> 
> - IMA-audit:
> 
> The IMA-audit messages can augment other file system security
> information used in security analytics/forensics.????This information
> should be on a per namespace basis, meaning that each time a new file
> is accessed/executed, there needs to be a separate audit message, even
> if a message already exists in another namespace.????Maintaining and
> cleaning up this per namespace cache information, allows development
> of the IMA namespace architecture independently of other issues.
> 
> My original suggestion stands. ??Start with namespacing IMA-
> audit.????Afterwards resolve the securityfs issues needed for
> namespacing IMA-measurement, and subsequently resolve the keyring and
> xattr issues for namespacing IMA-appraisal. Although other subsystems
> have already addressed some of the issues listed here, the advice to
> start with IMA-audit is still valid.
> 
> Small incremental change does not imply without an overall design, but
> an overall design which is broken up in such a way (to ease review)
> that builds upon the previous change.
> 
> As both Apparmor and IMA use securityfs for policy, it would be nice
> if their method for loading namespace policies would be similar too.

Our deterministic platform modeling code is built on top of the IMA
infrastructure.  Our modeling implementation has namespace support so
we ended up OS virtualizing a significant amount of the IMA
infrastructure to implement container specific behavior modeling.  So
the following is under the moniker of been there, done that to some
extent.

As an aside, we refer to containers running in a modeled environment
as 'canisters' since they are containers with a label.

Based on our experiences, the community will want each namespace
implementation to be as independent as possible.  A primary benefit of
namespaced implementations of integrity/behavior modeling is to enable
more tractable deployments since the system can be run from a very
small TCB whose behavior is rooted to a hardware integrity guarantee.
System upgrades are way more tractable in this type of architecture.

Each canister in our model has its own behavioral trajectory path
which is the equivalent of a superset of the IMA measurement list.
After the canister behavior is sealed, each canister reports forensics
violations as new entries on the trajectory path.  So forensic
evaluations are enabled at the canister level, which is extremely
valuable.

Implementing all of this was fairly straight forward on top of the
current IMA infrastructure.  Mimi's recommendation to start with the
audit layer is well taken, that is a solid pathway for determining how
to generically address the relevant infrastructure issues.

>From an implementation perspective we don't use bind mounts or the
like.  The securityfs pseudo-files all sense which namespace they are
operating in which resulted in a much cleaner implementation, at least
in our experience.

We implemented a model where the behavioral eigenvectors (events) are
surfaced through a new pseudo-file created for each canister.  This
pseudo-file is rooted in the /sys/fs/iso-identity pseudo-directory and
named by the namespace inode number which was allocated for the
canister namespace when the behavioral domain (namespace) is created.

This could have been done as well in the securityfs filesystem but we
were too {cramped for time,lazy} to implement polling and sysfs files
gives you that for free.

This seems to be a pretty flexible model for orchestration.  We
propagate the behavioral eigenvectors into individual SGX enclaves
which monitor the behavior of each canister.  The model would support
propagating events into a vTPM as well.

>From an orchestration perspective we plumbed all of this, including
SGX support, into the most recent release of runc and it has all
worked surprisingly well with respect to running existing containers.
All you need to do is specify in the container config.json that the
container is to run in an independent behavioral namespace.  We do
lament that runc was written in GO rather then C... :-)

There are some rough edges which need polishing though.  A more
expressive and namespace specific policy engine needs to be addressed.
In addition to the namespace implementation we implemented superblock
independent content digests which closes what we believe is a rather
significant measurement gap.  Addressing network inode measurement is
an entirely new and different can of worms as well.

We have also spent a fair amount of time reflecting on Viro's rants
with respect to IMA and all of its inherent ugliness... :-)

Our major concern is what does the community want to do with respect
to defining the CLONE_* flag which is used to signal that the
integrity/behavior namespace should be unshared.  We currently build
on top of 4.4 LTS and we stole the last bit which was available.  What
are the thoughts with respect to expanding this resource as it won't
be the last OS virtualization which is undertaken?

> Mimi

Hopefully the above reflections and experiences are useful datapoints.

Have a good week.

Greg

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-1686
FAX: 701-281-3949           EMAIL: greg at enjellic.com
------------------------------------------------------------------------------
"We can't solve today's problems by using the same thinking we used in
 creating them."
                                -- Einstein
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
