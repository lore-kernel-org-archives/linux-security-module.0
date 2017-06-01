From: masanobu2.koike@toshiba.co.jp (masanobu2.koike at toshiba.co.jp)
Date: Thu, 1 Jun 2017 12:31:41 +0000
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <20170530205002.GA9841@srcf.ucam.org>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
Message-ID: <35b22a328e064096a8fd855bce0f9c3d@TGXML276.toshiba.local>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> -----Original Message-----
> 
> On Tue, May 30, 2017 at 08:11:57PM +0900, Masanobu Koike wrote:
> > An execution-whitelist, simply called whitelist, is a list
> > of executable components (e.g., applications, libraries)
> > that are approved to run on a host. The whitelist is used
> > to decide whether executable components are permitted to
> > execute or not. This mechanism can stop an execution of
> > unknown software, so it helps to stop the execution of
> > malicious code and other unauthorized software.
> > The whitelisting-type execution control works best in the
> > execution environments that are not changed for a long time,
> > for example, servers and control devices in industrial
> > control systems. This RFC provides a whitelisting-type
> > execution control implementation WhiteEgret.
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

Thank you for a lot of comments and suggestions.

We assume a system whose execution environment cannot be
changed for a long time. It includes industrial control
systems, and control devices are main target.
Owners of these systems do not want to change their execution
environments, including kernel update, for fear that the
systems might not run correctly.
As time goes on, new security vulnerabilities might be found
and new malwares might be allowed to access such devices.
We want to prohibit unknown executable objects from executing
on the devices.

Moreover, such devices, in general, continue to do the same
tasks for many years. Namely, executable objects for the tasks
are not changed for a long time.
So permitting only pre-determined executable objects to execute,
whitelisting execution control, is suitable for such devices.

I will reply later on technical aspects.

Thanks,

Masanobu Koike

> --
> Matthew Garrett | mjg59 at srcf.ucam.org



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
