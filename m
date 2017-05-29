From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 29 May 2017 13:32:38 -0400
Subject: [RFC 04/11] ima: add support to namespace securityfs file
In-Reply-To: <CS1PR84MB0294089AC618EE12DB042263FFFF0@CS1PR84MB0294.NAMPRD84.PROD.OUTLOOK.COM>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
	<1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
	<1495656774.3841.72.camel@linux.vnet.ibm.com>
	<d8d55872-db78-3535-a540-85c0dbb2d6fd@canonical.com>
	<1495712762.3841.89.camel@linux.vnet.ibm.com>
	<CS1PR84MB0294089AC618EE12DB042263FFFF0@CS1PR84MB0294.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <1496079158.3841.350.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Guilherme,

(Wow, you should did Cc a lot of people.)

On Thu, 2017-05-25 at 19:04 +0000, Magalhaes, Guilherme (Brazil R&D-
CL) wrote:
> Mimi,
> With the securityfs symlink we would address the case of setting
> policy inside containers, but we still would need a way to set the
> IMA policy per namespace outside containers. So, the current
> proposed interface would address the latter case.
> As an alternative to symlinks, taking this patch set as base, and
> still considering setting policy inside containers (or inside
> namespaces in general), it is possible to bind mount the securityfs
> files into the containers, but it would be needed to prevent
> read/write access to the namespaced IMA policy files for processes
> not running on the same namespace.
> 
> These mechanisms would not require a change in the proposed design.
> Do you think these mechanisms are enough for the flexibility you
> asked?

I'm really sorry Guileherme, but as I previously explained, IMA has
many aspects to it - the original file measurements (IMA-measurement), 
file hash/signature appraisal (IMA-appraisal), and file audit messages
(IMA-audit) used for security analytics/forensics, not the file system
auditing.??To namespace IMA properly requires addressing some
underlying problems - securityfs, root privilege required for writing
security xattrs, per namespace IMA keyring - to name a few.

I understand wanting to namespace the appraisal aspect first, but when
you asked me if anyone else is working on namespacing IMA at the
moment, I suggested starting with the IMA-audit aspect for a
reason.??By beginning with the IMA-audit aspect, we could ignore, at
least for the time being, some of these underlying problems, but
define the basic namespacing architecture.??By jumping to namespacing
the appraisal aspect, you've simply avoided addressing the IMA
namespacing architecture issues, which need to be addressed.

Here are some, not by any means all, of the issues with namespacing
IMA.


- IMA-measurements:

The namespacing design will need to support different types of
environments. For example, depending on the environment, namespaces
can come and go frequently. In such an environment do we really want
all the namespace measurements to be included in the system
measurement list, or should each namespace have its own measurement
list???Should the namespace measurement policy be the same as the
system measurement policy???Should the namespace (container) owner be
allowed to modify their own policy???If a file matches a rule in both
the namespace and system policies, should the file measurement be in
both the namespace and the system measurement lists?


- IMA-appraisal

Assuming the IMA appraisal policy requires file signatures, signatures
are verified based on the keys on the IMA keyring.??When discussing
namespacing IMA-appraisal, we might want different sets of keys in
different namespaces. This requires separate keyrings for each
namespace. ?In some use cases, we might want to include the keys on
the system IMA keyring, while in other use cases we might not.

Even if real root initially installs the files with their file
signatures, stored as extended attributes, how will software be
updated, as writing file signatures requires root
privilege?Capabilities has recently added support to permit root in
the namespace to write security.capability.??Similarly when
namespacing IMA, root in the namespace needs the ability to write
security.ima.


- IMA-audit:

The IMA-audit messages can augment other file system security
information used in security analytics/forensics.??This information
should be on a per namespace basis, meaning that each time a new file
is accessed/executed, there needs to be a separate audit message, even
if a message already exists in another namespace.??Maintaining and
cleaning up this per namespace cache information, allows development
of the IMA namespace architecture independently of other issues.

My original suggestion stands. ?Start with namespacing IMA-
audit.??Afterwards resolve the securityfs issues needed for
namespacing IMA-measurement, and subsequently resolve the keyring and
xattr issues for namespacing IMA-appraisal. Although other subsystems
have already addressed some of the issues listed here, the advice to
start with IMA-audit is still valid.

Small incremental change does not imply without an overall design, but
an overall design which is broken up in such a way (to ease review)
that builds upon the previous change.

As both Apparmor and IMA use securityfs for policy, it would be nice
if their method for loading namespace policies would be similar too.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
