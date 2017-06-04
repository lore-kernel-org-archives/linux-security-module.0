From: oiaohm@gmail.com (Peter Dolding)
Date: Sun, 4 Jun 2017 12:21:45 +1000
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <88D2080F-FEFA-4535-ACF1-01A584F469D9@linux.vnet.ibm.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<88D2080F-FEFA-4535-ACF1-01A584F469D9@linux.vnet.ibm.com>
Message-ID: <CANA3KFX1Q4gfV+uAW=e8dZ_3YUm9g=Ewu=Jys=nimpFTgd_4Sw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 1, 2017 at 1:36 AM, Mehmet Kayaalp
<mkayaalp@linux.vnet.ibm.com> wrote:
>
>> On May 31, 2017, at 6:59 AM, Peter Dolding <oiaohm@gmail.com> wrote:
>>
>> Number 1 we need to split the idea of signed and whitelisted.   IMA is
>> signed should not be confused with white-listed.    You will find
>> policies stating whitelist and signed as two different things.
>
> IMA-appraisal can do both. If the securtiy.ima extended attribute
> of the file is a hash and not a signature, then it is whitelisting.

This this point you straight up fail.   This is no long classes a
whitelist.  Its now an extended attribute checksum.

IMA with proper whitelist support were whitelist is a file allows IMA
to have hashs and so on stored in that file so removing the need for
the filesystem where IMA being used to have extended attributes.

Second for this is being able to open up 1 file and see what is approved.


>
>> Like you see here in Australian government policy there is another
>> thing called whitelisted.
>> https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
>> Matthew Garrett you might want to call IMA whitelisting Australian
>> government for one does not agree.  IMA is signed.   The difference
>> between signed and white-listed is you might have signed a lot more
>> than what a particular system is white-listed to allowed used.
>
> I doubt the Australian government is an authority on Linux features.
> IMA-appraisal can be set to "fix" mode with a boot parameter. If the
> policy covers what you want to whitelist (e.g. files opened by user x),
> and then when those files are accessed, the kernel writes out the hash.
> Then, you can switch to "enforce" mode to allow only files with hashes.

Question does this feature support booting the system in different
modes giving different accessible files.

The feature says whitelist but is fact to tick the box is lists.   So
booted into standard mode has one lot of applications and booted into
repair mode has another lot of applications and so on with this being
achieved by choosing different whitelist files at boot.
>
> Also, you can achieve the same thing by signing all whitelisted
> files and add the certificate to .ima keyring and throwing away the
> signing key.

This here is signed nothing to-do with whitelist.    This is using
signing to hack round not having a proper whitelist feature so this
can never ticks the box.
>
>> The feature need to include in it name whitelisting or just like the
>> Australian Department of Defence other parties will mark Linux has not
>> having this feature.
>
> I guess we need to advertise IMA-appraisal better.

They have looked that and it fails.   Because IMA currently is lacking
the feature.

I do see that whitelist and blacklist file support added to IMA so IMA
does not need extended attribute file systems and for those who want
all the setting in one file would be a good thing.

UUID of the file system could be included in path to file in whitelist.
>
>> Whitelist is program name/path and checksum/s.   If the file any more
>> than that is now not a Whitelist but a Security Policy Enforcement or
>> signing.   Whitelist and blacklists are meant to be simple things.
>> This is also why IMA fails and is signed to too complete to be a basic
>> Whitelist.
>
> When you work out all the little details, you arrive at IMA-appraisal.
> You have to consider how the scheme is bootstrapped and how it
> is protected against the root. IMA-appraisal either relies on a boot
> parameter and write-once policy, or the trusted keyrings.
>
Here you have gone wrong.

You are presume whitelist has to be protected against root.   A signed
whitelist does have to be protected against root.   Unsigned whitelist
in fact being alterable by those with privilege is expected..

You don't have firewall rules always protected against root right.
Unsigned whitelists are in the same camp.

Also other mistakes is when they are looking for whitelist feature
they are also looking for blacklist feature.

IMA features need to apply just as much to containers as they do to
the complete system.   This is where things get tricky.   Putting
entries in filesystem xattr for every service you have risks running
you out of file system xattr space.

>From my point view the missing system wide whitelist and blacklist
file support is a defect of IMA that is not design at this stage to be
able to function without filesystem xattr as soon as remove the means
to use xattr design IMA you are forced to implement whitelist file at
least..

Also I see it as a weakness in IMA that it cannot be done on a per
container base and this is also mostly likely due to over file system
dependence.

I am not saying that IMA xattr usage has to be removed but it should
not be the only option IMA has.

Peter Dolding
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
