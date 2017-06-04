From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Sun, 4 Jun 2017 14:51:54 -0400
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <CANA3KFX1Q4gfV+uAW=e8dZ_3YUm9g=Ewu=Jys=nimpFTgd_4Sw@mail.gmail.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<88D2080F-FEFA-4535-ACF1-01A584F469D9@linux.vnet.ibm.com>
	<CANA3KFX1Q4gfV+uAW=e8dZ_3YUm9g=Ewu=Jys=nimpFTgd_4Sw@mail.gmail.com>
Message-ID: <8A71A84B-8629-4155-BFD1-55E254EF414C@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Jun 3, 2017, at 10:21 PM, Peter Dolding <oiaohm@gmail.com> wrote:
> 
> On Thu, Jun 1, 2017 at 1:36 AM, Mehmet Kayaalp
> <mkayaalp@linux.vnet.ibm.com> wrote:
>> 
>>> On May 31, 2017, at 6:59 AM, Peter Dolding <oiaohm@gmail.com> wrote:
>>> 
>>> Number 1 we need to split the idea of signed and whitelisted.   IMA is
>>> signed should not be confused with white-listed.    You will find
>>> policies stating whitelist and signed as two different things.
>> 
>> IMA-appraisal can do both. If the securtiy.ima extended attribute
>> of the file is a hash and not a signature, then it is whitelisting.
> 
> This this point you straight up fail.   This is no long classes a
> whitelist.  Its now an extended attribute checksum.

I think you have a limited view of what constitutes a whitelist. The xattr
approach has the (subjective) benefit of not having a centralized list.
You are describing NetBSD veriexec [1].  

> IMA with proper whitelist support were whitelist is a file allows IMA
> to have hashs and so on stored in that file so removing the need for
> the filesystem where IMA being used to have extended attributes.

I agree with this point. Perhaps IMA could benefit from a fallback
mechanism for filesystems without xattr support. But since other LSMs
make heavy use of xattr as well, we should also pursue adding xattr
support.

> Second for this is being able to open up 1 file and see what is approved.

This is also a nice feature of a central list. But what people don't like about
this might be the mount point, symlink, chroot etc.

>>> Like you see here in Australian government policy there is another
>>> thing called whitelisted.
>>> https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
>>> Matthew Garrett you might want to call IMA whitelisting Australian
>>> government for one does not agree.  IMA is signed.   The difference
>>> between signed and white-listed is you might have signed a lot more
>>> than what a particular system is white-listed to allowed used.
>> 
>> I doubt the Australian government is an authority on Linux features.
>> IMA-appraisal can be set to "fix" mode with a boot parameter. If the
>> policy covers what you want to whitelist (e.g. files opened by user x),
>> and then when those files are accessed, the kernel writes out the hash.
>> Then, you can switch to "enforce" mode to allow only files with hashes.
> 
> Question does this feature support booting the system in different
> modes giving different accessible files.

Different policies and keys are possible, but probably not as easy to manage
as having several whitelist files. 

> The feature says whitelist but is fact to tick the box is lists.   So
> booted into standard mode has one lot of applications and booted into
> repair mode has another lot of applications and so on with this being
> achieved by choosing different whitelist files at boot.

Our goal is not exactly ticking boxes for compliance etc. This, again,
could be achieved by perhaps having different keys. 

>> Also, you can achieve the same thing by signing all whitelisted
>> files and add the certificate to .ima keyring and throwing away the
>> signing key.
> 
> This here is signed nothing to-do with whitelist.    This is using
> signing to hack round not having a proper whitelist feature so this
> can never ticks the box.

I wouldn't call it a hack. If you are using a key for the sole purpose of
signing everything in a whitelist, then the verification of a signature
becomes: "is this in my whitelist?". It is an indirection. One can treat
each key as a different whitelist. Again, not ticking boxes. Considering
attacks and how to protect the integrity of the system.

>>> The feature need to include in it name whitelisting or just like the
>>> Australian Department of Defence other parties will mark Linux has not
>>> having this feature.
>> 
>> I guess we need to advertise IMA-appraisal better.
> 
> They have looked that and it fails.   Because IMA currently is lacking
> the feature.
> 
> I do see that whitelist and blacklist file support added to IMA so IMA
> does not need extended attribute file systems and for those who want
> all the setting in one file would be a good thing.
> 
> UUID of the file system could be included in path to file in whitelist.

I'm not sure who looked at what and what was the lacking feature. But
what is the threat model, why wouldn't IMA-appraisal work in terms of 
security? If there is a compelling reason for having a whitelist file, 
maybe we should think of an IMA policy mechanism for this. IMA policy 
can specify files by owner/user, filesystem type/UUID, LSM labels etc. 
If we could also say "files listed in this file", I guess it would provide the
usability "benefit" of a single file.  

>>> Whitelist is program name/path and checksum/s.   If the file any more
>>> than that is now not a Whitelist but a Security Policy Enforcement or
>>> signing.   Whitelist and blacklists are meant to be simple things.
>>> This is also why IMA fails and is signed to too complete to be a basic
>>> Whitelist.
>> 
>> When you work out all the little details, you arrive at IMA-appraisal.
>> You have to consider how the scheme is bootstrapped and how it
>> is protected against the root. IMA-appraisal either relies on a boot
>> parameter and write-once policy, or the trusted keyrings.
>> 
> Here you have gone wrong.
> 
> You are presume whitelist has to be protected against root.   A signed
> whitelist does have to be protected against root.   Unsigned whitelist
> in fact being alterable by those with privilege is expected..
> 
> You don't have firewall rules always protected against root right.
> Unsigned whitelists are in the same camp.

Yes, I assumed the protection should not be easy to turn off. But that
is a valid assumption for many situations.

> Also other mistakes is when they are looking for whitelist feature
> they are also looking for blacklist feature.

If there is a single whitelist and the enforcement prevents access to
any other file, do you still need a blacklist? You could just remove it
from the whitelist maybe? 

> IMA features need to apply just as much to containers as they do to
> the complete system.   This is where things get tricky.   Putting
> entries in filesystem xattr for every service you have risks running
> you out of file system xattr space.

I agree with the first two sentences, but you lost me at the third. 
What do you mean by every service? Are they different containers,
using the same file? Because, if they are different files, then it is not
a problem of xattr space.

> From my point view the missing system wide whitelist and blacklist
> file support is a defect of IMA that is not design at this stage to be
> able to function without filesystem xattr as soon as remove the means
> to use xattr design IMA you are forced to implement whitelist file at
> least..

Yes, xattr is a design choice of IMA. It has the "benefit" of having a
distributed whitelist. 

> Also I see it as a weakness in IMA that it cannot be done on a per
> container base and this is also mostly likely due to over file system
> dependence.

Containers make everything more difficult. The absolute path approach 
has the mount point dependence.  

> I am not saying that IMA xattr usage has to be removed but it should
> not be the only option IMA has.

Agreed.

[1] https://wiki.netbsd.org/guide/veriexec/

Mehmet

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
