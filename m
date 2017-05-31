From: oiaohm@gmail.com (Peter Dolding)
Date: Wed, 31 May 2017 20:59:03 +1000
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <20170530205002.GA9841@srcf.ucam.org>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
Message-ID: <CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 31, 2017 at 6:50 AM, Matthew Garrett <mjg59@google.com> wrote:
> On Tue, May 30, 2017 at 08:11:57PM +0900, Masanobu Koike wrote:
>> An execution-whitelist, simply called whitelist, is a list
>> of executable components (e.g., applications, libraries)
>> that are approved to run on a host. The whitelist is used
>> to decide whether executable components are permitted to
>> execute or not. This mechanism can stop an execution of
>> unknown software, so it helps to stop the execution of
>> malicious code and other unauthorized software.
>> The whitelisting-type execution control works best in the
>> execution environments that are not changed for a long time,
>> for example, servers and control devices in industrial
>> control systems. This RFC provides a whitelisting-type
>> execution control implementation WhiteEgret.
>
> There's a few assumptions made here:
>
> 1) The system isn't subject to any form of offline attack. If it is, the
> attacker can simply replace either the whitelist agent or any of the
> executables.
> 2) The system contains no whitelisted executables that will execute
> arbitrary code. This means not shipping perl or python.
> 3) None of the whitelisted applications on the system will misbehave if
> fed invalid input.
> 4) It's impossible for a user to ptrace() any other process after it's
> been executed, and simply inject new code.
>
> (3) is especially awkward. If you're implementing this as an LSM then
> you're giving up on being able to use any of the other LSMs to protect
> you against this - a vulnerability in a single application bypasses your
> entire security model.
>
> The kernel already has support for application whitelisting in the form
> of IMA appraisal. All you need to do is sign the apps that you want
> whitelisted and then load a policy at runtime that enforces appraisal.
> Anything that's unsigned will then fail to execute. This deals with (1)
> (assuming that you load the policy from something that's validated
> earlier in the boot process), is no worse with respect to (2), and still
> allows you to use SELinux or Apparmor to mitigate (3) and (4). You also
> gain additional reliability by not having the system fail in the event
> of a bug in the whitelisting agent causing it to crash.
>
> I think it would be helpful to have more details of exactly what
> circumstances this is intended to be used in and then figure out whether
> there's any way to use existing kernel functionality to provide the same
> benefits.
>
Number 1 we need to split the idea of signed and whitelisted.   IMA is
signed should not be confused with white-listed.    You will find
policies stating whitelist and signed as two different things.

Like you see here in Australian government policy there is another
thing called whitelisted.
https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
Matthew Garrett you might want to call IMA whitelisting Australian
government for one does not agree.  IMA is signed.   The difference
between signed and white-listed is you might have signed a lot more
than what a particular system is white-listed to allowed used.

WhiteEgret has another fault that even if you locked the program
against ptrace there is another problem.   The idea of passing
application name and path than checking that is valid does not in fact
work a fd(File descriptor)need to be passed.

1) kernel sends request to open file1 has fd.
2) update updates file1
3) WEUA WhiteEgret opens and checks path and name resulting in reading
update file1 and approves it.
4) kernel runs non updated file1.

By passing a fd to the userspace you can be user that the kernel and
userspace are on the same page.

We do need a whitelisting solution in the kernel.   To allow for the
different government requirements a userspace application may be a
consideration.   Whitelisting agent crashing need to include the
option of kernel panic in that case.  Others many wish for the option
to reload the whitelisting agent and the possibility of the
white-listing agent sending here is a new agent run that then
terminate me.

The feature need to include in it name whitelisting or just like the
Australian Department of Defence other parties will mark Linux has not
having this feature.

Security policy enforcement is the title given to SELinux and
Apparmor.   As they do more than a simple list of what is approved to
run and what is not approved to run.     There are two forms of
whitelist we need to worry about per application/service and system
wide.   Preferable whitelist, Security Policy
enforcement(SELInux/Apparmor) and signed(IMA) all need to be able to
successfully run at the same time.

The big thing that has to stop is suggesting using Security Policy
enforcement or IMA as whitelisting that is not what major end
consumers of this are asking for.

Now I am only referring to how Australian government will title the
Linux kernel features and the requirement they are looking for.   I
would not be surprised if other governments are the same in their
titling of Linux features.

I see this idea of this patch kinda on the right path but
implementation is very lacking.    Maybe system wide whitelist
features should be linked to IMA as a user-space callable program of
course that program does not override signed or not signed approval
only checks against what ever the current whitelist is.

Whitelist is program name/path and checksum/s.   If the file any more
than that is now not a Whitelist but a Security Policy Enforcement or
signing.   Whitelist and blacklists are meant to be simple things.
This is also why IMA fails and is signed to too complete to be a basic
Whitelist.

Whitelists expected systemwide and per user/service.   So the ability
to connect a whitelist to a namespace could possibly be used to do the
per user/service.

Reason for the userspace is old Linux system and government policy
says some new checksum the old Linux kernel does not have.   Of course
this issue could possible be handled another way allowing the Linux
kernel to use assigned userspace programs for checksumming.   Remember
what we make to today will be old at some point in the future running
10+ year old system is nothing new to governments.

Yes inverted policy was not in this module being a blacklist due to
using a userspace application it would not be hard for the userspace
program to be set to approve everything bar what it had on a black
list..

So design need to include option to use both whitelist and blacklist
with these being simple filenames and path with checksums.   We need
something in Linux kernel documentation covering whitelist and
blacklist with them being simple.

Peter Dolding.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
