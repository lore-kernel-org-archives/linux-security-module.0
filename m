From: smcv@collabora.com (Simon McVittie)
Date: Fri, 23 Jun 2017 18:42:39 +0100
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <20170623163925.550a1faf@d-jobol.iot.bzh>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
	<20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
	<20170623163925.550a1faf@d-jobol.iot.bzh>
Message-ID: <20170623174239.yn6woylszpggi6dv@archetype.pseudorandom.co.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 23 Jun 2017 at 16:39:25 +0200, Jos? Bollo wrote:
> I'm working for AGL (automotivelinux.org)
> that use that discontinued job of SAMSUNG/TIZEN. But I had in mind that
> you were not warm to intgrate the job done. The developper, Patrick
> Ohly made an interesting job to allow asynchronous request to the
> policy server within the dbus-daemon.

I'd consider whatever patches were submitted upstream (so far, none were,
if I remember correctly) but my instinct is to say that checking policy
asynchronously might well add too much complexity to be maintainable.
The dbus-daemon is already quite complicated enough with strict in-order
processing, we should try not to make it worse :-)

> The case of Tizen/AGL use a policy
> manager comparable to polkit. Are you developing currently a
> generalisation of this?

I assume you are referring to Cynara?

The freedesktop.org approach to sysadmin-configurable policy is polkit,
which is used by having services (not the dbus-daemon) call out to it,
preferably asynchronously. That has a latency and throughput overhead,
but it has the major advantage (over anything the dbus-daemon could do)
that the operations being queried are something high-level that makes
sense to the service author (such as "mount a removable disk on a
different seat" for udisks2, which is my usual example of a polkit user).
Everything dbus-daemon knows is at the level of D-Bus message-passing
and header fields, which isn't necessarily very useful when making a
policy decision. See <http://smcv.pseudorandom.co.uk/2015/why_polkit/>
for more background on that.

dbus-daemon's only involvement in services' use of polkit is:
* reliably identifying clients of the service (uid, pid, LSM label) when
  the service asks about them, which is related to this thread
* delivering opaque messages (not understood by dbus-daemon) between all
  the components involved

I am not active in polkit development.

> > The same goes for other LSMs: as far as I'm aware, we cannot support
> > this generically, and mediation always requires LSM-specific code for
> > each LSM. In general we can't fix bugs (or test fixes) in that
> > LSM-specific code, so to add new code for mediation we would need
> > someone we can assign those bugs to.
> 
> But is there really a need except for dbus-daemon itself?

I'm not sure I understand your question here?

If people who use a particular LSM want dbus-daemon to mediate messages
according to that LSM's rules, then there needs to be code in dbus-daemon
that is both specific to dbus-daemon (not shared with whatever other
component might mediate IPC, although there is probably nothing else that
would want to), and specific to that LSM (not shared with other LSMs).

> > So we have three options for dealing with your new multiplexed
> > strings
>
> More complexity, always...
> 
> Why not just using the result of SO_PEERSEC?

That's what we do right now. However, if I'm understanding what Casey
said correctly, one of the API options under consideration is to
have a socket option that alters what SO_PEERSEC returns, which makes
"the result of SO_PEERSEC" no longer a well-defined concept - it would
be more accurate to say "*a* result of SO_PEERSEC", and we have to decide
which of the several possible results is the right one to appear on D-Bus.

(One of the options I listed was effectively "the result of SO_PEERSEC,
assuming dbus-daemon has not done anything special to select a non-default
result". That's what current dbus-daemon, 1.10.x, will return forever.)

    S
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
