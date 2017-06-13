From: smcv@collabora.com (Simon McVittie)
Date: Tue, 13 Jun 2017 18:45:19 +0100
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
Message-ID: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

As I mentioned in a thread a while ago, I'm trying to reduce the amount
of LSM-specific code (that does very similar things for different LSMs)
in dbus-daemon, in favour of LSM-agnostic APIs. So we now have an IPC
call (method call) GetConnectionCredentials(), which one D-Bus client can
use to ask dbus-daemon for the LSM label (and other credential-like
attributes) of any other D-Bus client, and it's defined in terms of the
result of the SO_PEERSEC getsockopt. A D-Bus service (a client of the
dbus-daemon) would typically make that call as a response to getting a
request, so that it can use the uid, pid and/or LSM label to decide
whether to obey or reject the request.

Services can't just use SO_PEERSEC directly, because D-Bus is a star
topology: everything communicates only with the dbus-daemon, which
acts as a hub/broker and passes on messages. That's why we have to
offer an IPC call by which the dbus-daemon will do the SO_PEERSEC
query on the caller's behalf.

In particular, systemd is one such D-Bus service, and when it gets a
request while SELinux is enabled, it fetches some information about
the initiator.

This works fine for most clients of systemd. However, there is one
situation in which the dbus-daemon itself sends method call messages,
so we need to be prepared to respond to GetConnectionCredentials()
for the special sender name used on messages from the dbus-daemon itself,
org.freedesktop.DBus.

For specific LSMs, we can do this: libselinux and libapparmor
both have function calls that wrap a read from /proc/self/current/attr[1].
However, I'm really keen to keep GetConnectionCredentials() LSM-agnostic:
using libselinux and libapparmor wouldn't cover Smack or new LSMs,
and anyway libapparmor doesn't offer an API to get the raw label,
only a parsed form (with no documented way to compose the parts into
something equivalent to the result of SO_PEERSEC).

My next attempt was to read /proc/self/current/attr, but that doesn't
seem to be guaranteed to be consistent with SO_PEERSEC: in AppArmor,
the result of SO_PEERSEC is a bare string but /proc/self/current/attr
has a newline.

I also tried making a temporary socketpair() and doing SO_PEERSEC on that,
but at least SELinux (possibly other LSMs) doesn't really support
SO_PEERSEC on a socketpair().

Is there an LSM-agnostic API for this? My goal here is that
if we have a chain of communication
(kernel -> AF_UNIX service -> ... -> ultimate requester) and the
ultimate requester wants to see the LSM label, the only LSM-specifics
needed are in the kernel and the ultimate requester, and the rest can
pass through LSM-agnostic bytestrings without special knowledge.

Can I safely assume that, as a matter of LSM-agnostic kernel ABI, the
contents of /proc/self/current/attr are in some sense compatible with the
contents of SO_PEERSEC? (As a minimum, that they come from the same
"namespace" - for instance, for my purposes it would be bad if one had
some sort of quoting or prefix and the other didn't)

Can I safely assume that, as a matter of LSM-agnostic kernel ABI,
any trailing newlines on /proc/self/current/attr are merely a presentation
hint and can safely be stripped? What about other trailing whitespace?

Are there any other useful guarantees or equivalences that I can rely on
for arbitrary LSMs?

I was amused to see that on my AppArmor test system, ps -Z puts AppArmor
labels in the SELinux label column; it calls into libselinux, but
the way in which it uses libselinux doesn't seem to check whether SELinux
is actually active or not, and just blindly reads /proc/self/current/attr.
But ps strips all non-printable characters, which is fine for display
but not something I would be prepared to do in an API, unless this list's
consensus is that LSM labels are guaranteed to be isprint()-compliant.

Thanks,
    S

[1] actually there are some subtleties involving the current task/thread,
    but dbus-daemon is essentially single-threaded, so we can make the
    simplifying assumption that the main thread is the right one
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
