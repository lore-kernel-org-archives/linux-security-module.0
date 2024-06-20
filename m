Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E61D556
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915873; cv=none; b=kh7e3vyQx0Fhd3FWs3NSb59Egsv8Kw3eTyIehSv6fVY4Th4elf2SFgUOpIal7ssCPKP341XqGhQgrAo1v21sZgQyoQVZ4xf+9d8IvWl1MHJQ9zwNSJ1uYWZdwvSO3vKwE/7GFSpqs8Gh48J8Kli4rnEHQyzzZ12h6/MpyQcRFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915873; c=relaxed/simple;
	bh=wRPfJl92761YHJsX9H0iK2ApEUOtSGTKizahdfZStH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIxPTSMMoxPvsu8ioT2vipbfVuzs5YcWUGR5O4HAWXS++UuSJcMC5MFk6n1WhaCpty1T59JwxPDSVlmxM9zmGQaeYXzJQjqcU99osXIyofU4/b73yrCwGKsVUADDfIkBKQeSsWIy+F93zt13u60SpiWLnyZ5BIzlSzZh5+310i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 45KKbZqT032205;
	Thu, 20 Jun 2024 15:37:35 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 45KKbY8m032204;
	Thu, 20 Jun 2024 15:37:34 -0500
Date: Thu, 20 Jun 2024 15:37:34 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
Message-ID: <20240620203733.GA31923@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 20 Jun 2024 15:37:35 -0500 (CDT)

On Thu, Jun 20, 2024 at 04:40:09PM +0300, Timur Chernykh wrote:

> Hello!

Good afternoon Timur, I hope the week is going well for you.

> I'm here for yours' opinions.
> 
> The modern Linux, in fact, does not provide convenient options to
> write AV/EDR software with real-time system events analysis as far as
> unified system security events. For now we have only inconsistent
> self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
> cool technology, but even CO-RE sometimes works as not expected or
> gets broken, for example:
> https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
> of a huge amount of the same hacks) looks a bit "crutchy".
> 
> As an EDR developer, I have an idea how to fix this situation, using a
> unified endpoint security framework (ESF) placed in the kernel. Its
> must:
> - Provide unified and consistent security events;
> - API to communicate with kernel:
>  - To send program-defined events (as audit has);
>  - Read events from kernel;
> - Trusted agents delivery mechanisms (signing like kernel modules);
> - Has a possibility to control what happens on system e.g block some
> file operations, binary executions and so on;
> - Has a portable and flexible events structure which doesn't get
> broken from version to version;
> 
> For now I have PoC, which describes the concept in more detail:
> GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
> It contains all listed above points (maybe except portable event
> structures)
> 
> There are an examples with:
> - Security agent:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/samples/esf/agent.c
> - API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/ctl.h
> - Event structures and types:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/defs.h
> - Main ESF source code:
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/security/esf
> 
> Questions I'm interested in:
> How does the community feel about this idea? Is it a viable concept?
> If all is OK, what should I, as developer, do further? How much kernel
> code outside the LSM module may be modified to keep further merge
> acceptable? (currently not all LSM hooks meet to intercept all needed
> data).
> 
> The general purpose is to make AV/EDR software development easier,
> more convinient, and stable for Linux-based operating systems. This
> PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> based on MAC policy.

I'm not sure how much you follow the Linux Security Mailing List so
you may have missed it.  I believe you will find that our Trusted
Security Event Modeling (TSEM) architecture, that we have submitted
for review and inclusion in the kernel, provides a superset of the
type of functionality that you and others in the industry are looking
for.

Here are links to the three releases:

V1
https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t

V2:
https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

V3:
https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#m1cc4ad76677d07517220f1fadc2303c36a75bab0

The first release was in February of 2023, a year and a half ago, we
are on schedule for the fourth release, which is now largely feature
complete, after the US Fourth of July holiday week.

We describe TSEM as a generic security modeling architecture for the
kernel.  It is based on the generation of security state coefficients
for each LSM based security event that occurs.  These coefficients can
be used to drive mathematical models that very precisely describe the
security state of either the platform at large or an isolated
workload.

The underlying model is capable of providing very precise detection of
attempts to implement concepts such as Living Off The Land, ie. Hello
Volt Typhoon.

The operative premise is that in all aspects of science and
engineering it is routine to build mathematical models for the
performance of things like airplanes, bridges, buildings, the
electronic state of molecular systems etc., why not the security
behavior of an operating system.

Obviously the current zest for machine learning/AI is an embodiment of
the principal of modeling.

Over the last year it has become increasingly apparent that TSEM can
play a very powerful role in endpoint security and anomaly detection
systems.  Particularly with respect to driving machine learning models
in environments where deterministic or quasi-deterministic models are
infeasible.

So TSEM now has an efficient export only mode that provides JSON
encoded description streams of almost all of the security relevant
events that the LSM can capture.  So it provides a framework for doing
everything from security reconaissance to enforcement.

Others have already commented on this, but the notion of having
'standardized' event descriptions for any system of this type is
problematic.  Given that it has been made clear that there is no
intention to have a stable API for the Linux security architecture.
FWIW, in practice we have not found this to be a significant
impediment to what can be implemented from a security perspective.

I believe we address the issue of security event handlers that run in
atomic context as best as can be expected.  If you look through the
e-mail threads surrounding our three releases you will see timing
information as to how fast our external modelers can react, on the
order of tens of micro-seconds, as compared to current agent based
systems that have measured reaction latencies in excess of multiple
seconds if not longer.

If external modeling is infeasible, and the default TSEM deterministic
model is insufficient, the v4 release TSEM has the ability to use
loadable modules to build customized in kernel modelers that can
detect and react at event time, regardless of process context.

We are always looking for thoughts and feedback from others on how to
enhance what we are working to deliver.

Our GitHub site has GIT trees for not only the TSEM kernel component
but also the Quixote userspace tools that make the kernel driver
useful.

The kernel sources include very extensive documentation describing the
design and motivation of the system, including the JSON encoding of
the event descriptions.

We are in the process of providing a public, MQTT based broker system,
that will provide access to event streams of some of our internal
systems if anyone wants to look at what the security event description
streams look like or if there would be a desire to experiment with
building models.

In closing, one of the increasingly important objectives with TSEM is
to provide kernel based security event description infrastructure that
reduces the potential supply chain attack scenarios that are possible,
given the amount of privilege being afforded to current agent systems.

> Best regards,
> Timur Chernykh,
> Lead developer, F.A.C.C.T.

We hope the above information is useful.

On behalf of the Quixote Team, have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
