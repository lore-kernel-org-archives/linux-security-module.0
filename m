From: smcv@collabora.com (Simon McVittie)
Date: Wed, 14 Jun 2017 12:44:30 +0100
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
Message-ID: <20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 13 Jun 2017 at 11:56:00 -0700, Casey Schaufler wrote:
> On 6/13/2017 10:45 AM, Simon McVittie wrote:
> > For specific LSMs, we can do this: libselinux and libapparmor
> > both have function calls that wrap a read from /proc/self/current/attr[1].
> 
> I assume you mean /proc/self/attr/current

You assume correctly.

> > However, I'm really keen to keep GetConnectionCredentials() LSM-agnostic:
> > using libselinux and libapparmor wouldn't cover Smack or new LSMs,
> 
> Nor should they. 
> 
> There is a smack_new_label_from_self() in libsmack, which is maintained at:
> 
> 	https://github.com/smack-team/smack

That works up to a point, but I hope you can see why this doesn't
really scale very well! For LSMs that are less widespread than SELinux
and AppArmor, we get an unappealing choice between writing and supporting
new LSM-specific code for each LSM, or ignoring those LSMs.

We already don't really have enough SELinux expertise among the active
dbus maintainers for that part to be a first-class citizen, and we only
have AppArmor knowledge because I happen to be using it in another
project, so I'd be very reluctant to add new LSM-specifics without
someone from the relevant LSM committing to being available to
support it.

That's why LinuxSecurityLabel in the result of GetConnectionCredentials()
is defined in terms of SO_PEERSEC, so we can delegate the exact behaviour
to the Linux kernel and LSM maintainers - whatever happens to that socket
option in future LSM development, that's what we make available to clients.
The SELinux support in dbus-daemon (from Fedora/Red Hat) came first,
and I think it may have been the only widespread LSM at the time; but for
the AppArmor support (from Ubuntu) I insisted on generalizing the parts
that could be generalized.

If the kernel/LSMs don't offer a reliable way to find out our own
security label in a form compatible with SO_PEERSEC, then we might have
to just not offer that to clients either.

> You also need to be aware that there is work ongoing to allow
> multiple modules that currently provide these facilities to work
> at the same time. That work could make your efforts both easier
> and harder.

How does this work in SO_PEERSEC? If the result is a "bytestring"
(like a path or environment variable - 0 or more bytes other than '\0',
followed by a '\0' terminator, with length considered to be either
strlen(x) or strlen(x)+1) then dbus-daemon will continue to pass it
through faithfully, without needing to parse or understand it.

Obviously, the eventual consumer of this information (the D-Bus service,
in this case systemd) will need LSM-specific code to parse the forwarded
SO_PEERSEC result and use it in their security rules, and that code
would need to use a suitably updated libselinux or similar that can
parse out just the SELinux label from a stack of labels; but they'd
need those LSM-specifics to make an informed policy decision anyway.
So the LSM-specifics are confined to just the producer (the kernel)
and the eventual consumer (systemd or whatever other service).

Thanks,
    S
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
