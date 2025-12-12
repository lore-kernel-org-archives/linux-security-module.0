Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76A9463
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564355; cv=none; b=NRXC7/f6kAcub1BcMMcbYEQadnuAXjMObKyYYaQf9ZeKD3debuGt5epb9JzCnnBqgZbIV0eHIlWtUeRWHediOjvFGlN8gVXrm+n/JBJ152v0OVno+xscf06hQpcSdDA2KqMaj8EviHS1cbT5EEe0bhTH2JmGLdvkGKxUG2Bq68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564355; c=relaxed/simple;
	bh=1lZycL5nWdOLtYz8LWRL5R/f9lno9WU2iLupdLAunsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuhqwVAto4KtF5H1dS6g/0OPq8EmIAj9HUTOMoKjkskg0o+jkZZPUA4aGLuwS7T6Uam1y2PIDtSNrwc/uEHh6kfJhqcf4h7RChT1OMHgn4KW5khuQhjDW8KEq8+qeKFlDTdeMqfJZD1oIaZ1ZA6MwaB08HoY4h57+05T7wRIOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5BCIB3c3027757;
	Fri, 12 Dec 2025 12:11:03 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5BCIAwHG027756;
	Fri, 12 Dec 2025 12:10:58 -0600
Date: Fri, 12 Dec 2025 12:10:58 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: An opinion about Linux security
Message-ID: <20251212181058.GA27467@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com> <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 12 Dec 2025 12:11:03 -0600 (CST)

On Fri, Dec 12, 2025 at 05:47:24PM +0300, Timur Chernykh wrote:

Good morning again to everyone.

> > eBPF has been accepted because of these restrictions. Without them
> > an eBPF program could very easily reek havoc on the system's behavior.
> 
> Unfortunately, these restrictions also make it impossible to use eBPF
> effectively for security. We can certainly discuss the limitations
> themselves if needed, but that???s not the main point I???m trying to make
> here.
> 
> > Yes. That's true for many kernel features.
> 
> Right, and that's a well-known issue that has no clean solution other
> than backporting. I completely agree with that.
> 
> > To the best of my understanding, and I have been working with LSMs
> > and the infrastructure for quite some time, there has never been an
> > out-of-tree LSM API.
> 
> I was under the impression that there was something of that sort.
> For example: https://elixir.bootlin.com/linux/v3.10/source/include/linux/security.h#L1688
> It may not have been 'officially' exported, but people who needed it
> simply resolved the symbol through `kallsyms` or a kprobe and used it.
> I'm not claiming that this is good practice, but it did work.
> 
> > You will need to provide more detail about why you believe that the
> > integrity of an AV/EDR product cannot be protected.
> 
> Consider the case where an attacker already has root access. The first
> thing they typically do is disable or tamper with security tools.
> After that, they establish persistence. Access-control models alone
> are not enough here sometimes they need to be adjusted dynamically,
> based on complex real-time analysis.
> 
> > What APIs do you want? It's possible that some exist that you haven't
> > discovered.

> I'm confident I've studied all the mechanisms available for
> real-time system protection. I've even given talks and published
> material on approaches to securing Linux.  I may not have covered
> every LSM module in depth, but in practice they simply don't provide
> the capabilities required for modern security workloads.
>
> And I don't want to sound overly categorical, but the current path of
> security development feels like a dead end to me, for several reasons.
> Modern security relies on analyzing hundreds of thousands of events
> per second. eBPF isn't particularly fast to begin with, and on top of
> that it imposes strict technological limitations that prevent
> meaningful in-kernel analysis. Every EDR vendor ends up doing the same
> thing: collecting raw data (which is already difficult) and pushing it
> into userspace for processing. That adds transport overhead on top of
> everything else.
> 
> Or, of course, writes a dirty and unsafe kernel module. For me in the
> perfect world seems to it's better to provide an API for userspace.
> It's safe enough and doesn't contain a restriction that eBPF has.

You may be cooking a response to my previous e-mail so a quick comment
to perhaps constructively shape forward conversations.

We looked at the ESF implementation and if we understand the Mac/Apple
approach an API is supplied to register for security events of
interest.

With TSEM we came at the problem from a framework of supporting the
mathematical modeling of security behavior, a 'y = mx + b' type of
approach.  With an objective of providing complete flexibility with
respect to how the functional definition for security is generated.

The most universal method of doing this, at least in our view, was to
supply the stream of LSM events and their parameters and let a
modeling engine, either in the kernel or userspace, decide how to
filter for and process the events in order to create the functional
definition.

A userspace orchestrator receives a JSON encoded record for each LSM
event to do with as it pleases.  If you feed that into something like
an Elastic or Open Search instance you have a complete compliance
record as to every event that the kernel deemed to have security
implications.

Obviously a lot of events can be generated.  We currently support
policy specific screening of events with standard kernel modules and
doing this with eBPF is our next step.  From an eBPF perspective this
is much more of a lightweight approach than attempting to code for
specific security analytics or behavior analysis.

For example, we implemented the rough equivalent of userspace IMA by
in kernel filtering for security_file_open events invoked with
administrative privileges.

The LSM API isn't considered stable but the reality of security
telemetry in this day and age is that security vendors have to code
for specific LTS kernel releases.  Even with a 'stable' release there
are issues with telemetry acquisition, CrowdStike ended up blue
screening RHEL not too long ago on one of their kernel point releases.

We would be interested as to what you see to be the challenges, from
an EDR vendor perspective, with this approach.

FWIW.  If you namespace the security event stream you end up with the
ability to much more precisely model whether or not a workload is
exhibiting aberrant behavior, while decreasing the event flux rate.

> > Please propose the interfaces you want. An API definition would be
> > good, and patches even better.
> 
> I'm lucky enough to have already built a working prototype, which I
> once offered for review:
> 
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/security/esf
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/include/uapi/linux/esf
> 
> Less lucky was the reaction I received. Paul Moore was strongly
> opposed, as far as I remember. Dr. Greg once said that heat death of
> the universe is more likely than this approach being accepted into the
> kernel.

> I don't want to 'poke old wounds', but the design I proposed was
> largely inspired by Apple's Endpoint Security Framework
> (originally 'mac policies'):
> https://developer.apple.com/documentation/endpointsecurity

> In my view, it is an exemplary model. The kernel provides a
> consistent stream of events to userspace, hides the complexity of
> data collection and transport, and ensures fault-tolerance if
> userspace fails to process events quickly enough.  Audit, for
> comparison, simply hangs the system if its buffer overflows. ESF
> does not have that problem and even lets userspace control the event
> stream.

> > There are numerous cases where LSMs have mitigated attacks. One case:
> 
> And there are thousands of cases where LSMs did not. Most companies
> never disclose successful breaches because of NDAs and fear of
> investor backlash. The few disclosures we see typically appear only
> when it???s safe for the company, or when they specifically want to
> appear transparent.
> 
> > Your assertion that LSMs don't provide "real" value is not substantiated
> > in the literature.
> 
> Which literature do you mean?
> As I mentioned above, public reports about successful attacks are rare.
> 
> Maybe I poorly delivered my point. I'll try again.
> 
> The strongest protection on Linux today is provided by proprietary
> security vendors. Unfortunately, they often achieve this using
> kernel-module ???hacks??? rather than LSMs. It???s not because they prefer
> hacks ??? it???s because Linux doesn???t offer proper APIs to implement the
> required functionality.
> 
> > Each of the existing LSMs addresses one or more real world issues. I would
> > hardly call any of the Linux security mechanisms, from mode bits and setuid
> > through SELinux, landlock and EVM, "theoretical".
> 
> In practice, most LSM modules are either disabled or misconfigured on
> real servers, and the responsibility falls on AV/EDR vendors. As
> someone who has been building such systems professionally for years, I
> can say with confidence: there is no clean, reliable mechanism
> available today.
> As much as I love Linux, its security and its friendliness toward
> security vendors are its weak side.
> 
> In the real world, deploying a modern security product means dealing
> with endless pain: missing kernel headers (sometimes there isn???t even
> Internet access to download them), unstable kernel APIs, lack of BTF,
> constant fights with the eBPF verifier, and all the other limitations
> of eBPF.
> 
> To be honest, many developers ??? and I???m taking the liberty to speak
> broadly here ??? would simply like to see something similar to Apple???s
> ESF available on Linux.
> 
> Best regards,
> Timur Chernykh
> 
> On Wed, Dec 10, 2025 at 11:08???PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 12/9/2025 4:15 PM, Timur Chernykh wrote:
> > > Hello Linus,
> > >
> > > I???m writing to ask for your opinion. What do you think about Linux???s
> > > current readiness for security-focused commercial products? I???m
> > > particularly interested in several areas.
> > >
> > > First, in today???s 3rd-party (out-of-tree) EDR development ??? EDR being
> > > the most common commercial class of security products ??? eBPF has
> > > effectively become the main option. Yet eBPF is extremely restrictive.
> >
> > eBPF has been accepted because of these restrictions. Without them
> > an eBPF program could very easily reek havoc on the system's behavior.
> >
> > > It is not possible to write fully expressive real-time analysis code:
> > > the verifier is overly strict,
> >
> > This is of necessity. It is the only protection against malicious and
> > badly written eBPF programs.
> >
> > > non-deterministic loops are not
> > > allowed,
> >
> > Without this restriction denial of service attacks become trivial.
> >
> > >  and older kernels lack BTF support.
> >
> > Yes. That's true for many kernel features.
> >
> > > These issues create real
> > > limitations.
> > >
> > > Second, the removal of the out-of-tree LSM API in the 4.x kernel
> > > series caused significant problems for many AV/EDR vendors. I was
> > > unable to find an explanation in the mailing lists that convincingly
> > > justified that decision.
> >
> > To the best of my understanding, and I have been working with LSMs
> > and the infrastructure for quite some time, there has never been an
> > out-of-tree LSM API. We have been very clear that the LSM interfaces
> > are fluid. We have also been very clear that supporting out-of-tree
> > security modules is not a requirement. There are members of the
> > community who would prefer that they be completely prohibited.
> >
> >
> > > The next closest mechanism, fanotify, was a genuine improvement.
> > > However, it does not allow an AV/EDR vendor to protect the integrity
> > > of its own product. Is Linux truly expecting modern AV/EDR solutions
> > > to rely on fanotify alone?
> >
> > You will need to provide more detail about why you believe that the
> > integrity of an AV/EDR product cannot be protected.
> >
> > > My main question is: what are the future plans?
> >
> > Security remains a dynamic technology. There are quite a few plans,
> > from a variety of sources, with no shortage of security goals. Trying
> > to keep up with the concern/crisis of the day is more than sufficient
> > to consume the resources committed to Linux security.
> >
> > >  Linux provides very
> > > few APIs for security and dynamic analysis.
> >
> > What APIs do you want? It's possible that some exist that you haven't
> > discovered.
> >
> > >  eBPF is still immature,
> >
> > And it will be for some time. That is, until it is mature.
> >
> > > fanotify is insufficient,
> >
> > Without specifics it is quite difficult to do anything about that.
> > And, as we like to say, patches are welcome.
> >
> > >  and driver workarounds that bypass kernel
> > > restrictions are risky ??? they introduce both stability and security
> > > problems.
> >
> > Yes. Don't do that.
> >
> > >  At the same time, properly implemented in-tree LSMs are not
> > > inherently dangerous and remain the safer, supported path for
> > > extending security functionality. Without safe, supported interfaces,
> > > however, commercial products struggle to be competitive. At the
> > > moment, macOS with its Endpoint Security Framework is significantly
> > > ahead.
> >
> > Please propose the interfaces you want. An API definition would be
> > good, and patches even better.
> >
> > > Yes, the kernel includes multiple in-tree LSM modules, but in practice
> > > SELinux does not simplify operations ??? it often complicates them,
> > > despite its long-standing presence. Many of the other LSMs are rarely
> > > used in production. As an EDR developer, I seldom encounter them, and
> > > when I do, they usually provide little practical value. Across
> > > numerous real-world server intrusions, none of these LSM modules have
> > > meaningfully prevented attacks, despite many years of kernel
> > > development.
> >
> > There are numerous cases where LSMs have mitigated attacks. One case:
> >
> > https://mihail-milev.medium.com/mitigating-malware-risks-with-selinux-e37cf1db7c56
> >
> > Your assertion that LSMs don't provide "real" value is not substantiated
> > in the literature.
> >
> > > Perhaps it is time for Linux to focus on more than a theoretical model
> > > of security.
> >
> > Each of the existing LSMs addresses one or more real world issues. I would
> > hardly call any of the Linux security mechanisms, from mode bits and setuid
> > through SELinux, landlock and EVM, "theoretical".
> >
> > > P.S.
> > > Everything above reflects only my personal opinion. I would greatly
> > > appreciate your response and any criticism you may have.
> >
> > We are always ready to improve the security infrastructure of Linux.
> > If it does not meet your needs, help us improve it. The best way to
> > accomplish this is to provide the changes required.
> >
> > > Best regards,
> > > Timur Chernykh

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
