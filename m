From: jobol@nonadev.net (=?UTF-8?B?Sm9zw6k=?= Bollo)
Date: Fri, 23 Jun 2017 16:39:25 +0200
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
	<20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
Message-ID: <20170623163925.550a1faf@d-jobol.iot.bzh>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 16 Jun 2017 17:13:57 +0100
Simon McVittie <smcv@collabora.com> wrote:

(snip)
 
> Self-identification
> -------------------
> 
> The problem that I'm trying to solve right now is a special case
> of identification. On the D-Bus message bus, we have a naming scheme
> for talking about connections, so that the service can identify which
> client it is asking about. This naming scheme has a special reserved
> name for the dbus-daemon itself, so it is syntactically possible to
> ask that question, and it is unexpected if that question doesn't get
> a sensible answer. At the moment, asking for the credentials
> of the dbus-daemon just doesn't return a LSM label (indicating
> "unknown" or "not applicable"), but that's an unexpected special case.
> What we would identically like is for the dbus-daemon to return the
> same thing that the client would have got by getting the SO_PEERSEC
> socket option from its connection to the dbus-daemon.
> 
> Because the dbus-daemon does not have an AF_UNIX socket connected to
> itself, we can't use SO_PEERSEC directly, hence me looking into using
> /proc/self/attr/current. We can't safely use /proc/$pid/attr/current
> for an arbitrary other process, because the other process might be
> maliciously causing race conditions that would trick us (below) - but
> we can use it for /proc/self, because we trust ourselves not to do
> such things.

Hi 

If there were a SO_MYSEC doing the job you had used it. But there is no
SO_MYSEC nor SO_MYCRED.

> Mediation
> =========
> 
> Some LSM users/developers want the dbus-daemon to filter messages
> as they go through it, preventing clients with label A from
> communicating with services with label B. We have this code for
> SELinux (contributed by Red Hat/Fedora, long before my involvement)
> and for AppArmor (originating from Ubuntu/Canonical, with some
> modifications from me). At some point in the past there was a feature
> request to add similar mediation for Smack, contributed by
> Tizen/Intel/Samsung people
> <https://bugs.freedesktop.org/show_bug.cgi?id=47581> but the proposed
> patches were later withdrawn since their authors didn't need that
> part any more, only identification.

That is really interesting! I'm working for AGL (automotivelinux.org)
that use that discontinued job of SAMSUNG/TIZEN. But I had in mind that
you were not warm to intgrate the job done. The developper, Patrick
Ohly made an interesting job to allow asynchronous request to the
policy server within the dbus-daemon.

> If you or your Smack-using colleagues want to resurrect that feature
> request so that the dbus-daemon can accept or reject messages based on
> Smack labels, the dbus at lists.freedesktop.org mailing list is suitable
> for general discussion, and freedesktop.org Bugzilla is where we do
> detailed patch review. The reviews on #47581 are probably relevant, so
> I would advise skim-reading those first.

Good. Seems to be 2 years old. The case of Tizen/AGL use a policy
manager comparable to polkit. Are you developing currently a
generalisation of this?

> The same goes for other LSMs: as far as I'm aware, we cannot support
> this generically, and mediation always requires LSM-specific code for
> each LSM. In general we can't fix bugs (or test fixes) in that
> LSM-specific code, so to add new code for mediation we would need
> someone we can assign those bugs to.

But is there really a need except for dbus-daemon itself?

(snip)

> So we have three options for dealing with your new multiplexed
> strings:
> 
> * LinuxSecurityLabel is the first available and is deprecated, and a
>   new LinuxSecurityLabels is the multiplexed string
> * LinuxSecurityLabel is the first available and is deprecated, and
>   the string is parsed (in an LSM-agnostic way) to produce
>   "LinuxSecurityLabel.selinux" => "whatever_t\0",
>   "LinuxSecurityLabel.apparmor" => "/usr/bin/whatever\0" and so on
>   (or a nested mapping { "selinux" => "whatever_t\0", ... } maybe)
> * LinuxSecurityLabel is the multiplexed string, and recipients are
>   expected to evolve to deal with it

More complexity, always...

Why not just using the result of SO_PEERSEC?

Best regards
Jos? Bollo
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
