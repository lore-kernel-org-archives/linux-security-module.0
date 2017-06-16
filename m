From: smcv@collabora.com (Simon McVittie)
Date: Fri, 16 Jun 2017 17:13:57 +0100
Subject: Is there a generic LSM/kernel ABI analogous to getcon_raw() and
	aa_getcon()?
In-Reply-To: <d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
References: <20170613174519.nmrdglusytvjtdem@archetype.pseudorandom.co.uk>
	<cc28a551-08b5-aeb4-382a-9ad86f51ddac@schaufler-ca.com>
	<20170614114430.ooti2gqxllkqz2fe@archetype.pseudorandom.co.uk>
	<d95670e5-837e-2cd3-7bf1-424a3cd89eec@schaufler-ca.com>
Message-ID: <20170616161357.4nyqrye7ja5nsl7h@archetype.pseudorandom.co.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 14 Jun 2017 at 09:06:38 -0700, Casey Schaufler wrote:
> If it's going to be a proper LSM API it's got
> to support all the existing modules and provide design guidance
> to someone creating a new module.

This is what I was trying to avoid by having the D-Bus API be defined
in terms of things the kernel already provides, such that any new LSM
that would break dbus-daemon would already be breaking the existing
kernel APIs, and so can safely be ignored :-)

> Consider the option of eschewing the existing module specific APIs
> and going directly to /proc/self/attr/current and SO_PEERSEC.

That's what I did for what we have so far (SO_PEERSEC). The issue I have
is that reading my own /proc/self/attr/current, and a peer who is connected
to me by a socket asking the kernel who I am using SO_PEERSEC, don't seem
to be guaranteed to produce compatible results.

> > We already don't really have enough SELinux expertise among the active
> > dbus maintainers for that part to be a first-class citizen, and we only
> > have AppArmor knowledge because I happen to be using it in another
> > project, so I'd be very reluctant to add new LSM-specifics without
> > someone from the relevant LSM committing to being available to
> > support it.
> 
> Thank you for asking. How do I get on your list?

What LSM support do you want to contribute to dbus?

At the moment my strategy for asking for information on this topic is
to contact this list. If there are some people on this list with
freedesktop.org Bugzilla accounts who I can cc on relevant bug reports
and feature requests to act as an LSM spokesperson, that would be great.

If you're looking to contribute new code that isn't already there (or
audit what we already have), broadly, there are two-and-a-bit ways in
which LSMs are used in dbus-daemon:

Identification
==============

In a direct AF_UNIX connection

           AF_UNIX
    server a<==c client    a: result of accept()ing
         <---------        c: the end that connect()ed
          request
         --------->
          response

the server can use SO_PEERSEC to ask the kernel who the client is.
On D-Bus, because we have a "man in the middle", the dbus-daemon
(aka message bus or broker):

           AF_UNIX           AF_UNIX
    service c==>a dbus-daemon a<==c client
          <--------------------------
                    request
          -------------------------->
                    response

the service does not have a direct connection to the client, so there
is no way for the service to ask the kernel who the client is
(uid, pid, LSM label). So we have IPC APIs by which the service can ask
dbus-daemon for that information instead; the dbus-daemon is directly
connected to the client, so the dbus-daemon *can* get that information
from the kernel.

Because this is security-sensitive, we have to be careful about how
we get this information - the existence of setuid and similar mechanisms
to escalate privilege across exec() while keeping the same pid, and the
existence of pid wrap-around, mean that anything based on "get the pid
of the peer, then get the credentials of that process by looking up its
pid" is unsafe. SO_PEERCRED and SO_PEERSEC are ideal, though, because
they store what the credentials were at the time the socket was
opened (I forget whether it's socket() or connect() that matters,
but either would do for our purposes). If you are the process that
opened a socket and connected it to the dbus-daemon, then you are
considered to be responsible for not letting less-trusted users/contexts
use that socket.

Based on our previous discussion on this list, I believe
GetConnectionCredentials() does this in a way that is generic across
all LSMs - the service still needs to understand what the current LSM(s)
put in SO_PEERSEC in order to make any sensible auth decision, but
the dbus-daemon can just pass this information through without
being required to understand it.

When I added LinuxSecurityLabel to GetConnectionCredentials(), I
checked it with this list. That was a response to two different people
wanting to add GetConnectionSmackContext() for Smack, and
GetConnectionAppArmorLabel() for AppArmor, in addition to our
existing GetConnectionSELinuxContext() - which is clearly at least
two methods too many, given that they are all basically SO_PEERSEC
behind the scenes.

So if you only want the identification feature for dbus on Smack
systems, I think we already have that, without needing to write or
support any code that isn't already shared by other LSMs. The same
is hopefully true for all current and future LSMs (or at least
those with SO_PEERSEC).

Self-identification
-------------------

The problem that I'm trying to solve right now is a special case
of identification. On the D-Bus message bus, we have a naming scheme
for talking about connections, so that the service can identify which
client it is asking about. This naming scheme has a special reserved
name for the dbus-daemon itself, so it is syntactically possible to
ask that question, and it is unexpected if that question doesn't get
a sensible answer. At the moment, asking for the credentials
of the dbus-daemon just doesn't return a LSM label (indicating
"unknown" or "not applicable"), but that's an unexpected special case.
What we would identically like is for the dbus-daemon to return the
same thing that the client would have got by getting the SO_PEERSEC
socket option from its connection to the dbus-daemon.

Because the dbus-daemon does not have an AF_UNIX socket connected to
itself, we can't use SO_PEERSEC directly, hence me looking into using
/proc/self/attr/current. We can't safely use /proc/$pid/attr/current
for an arbitrary other process, because the other process might be
maliciously causing race conditions that would trick us (below) - but we
can use it for /proc/self, because we trust ourselves not to do such things.

Mediation
=========

Some LSM users/developers want the dbus-daemon to filter messages
as they go through it, preventing clients with label A from communicating
with services with label B. We have this code for SELinux (contributed
by Red Hat/Fedora, long before my involvement) and for AppArmor (originating
from Ubuntu/Canonical, with some modifications from me). At some point
in the past there was a feature request to add similar mediation for
Smack, contributed by Tizen/Intel/Samsung people
<https://bugs.freedesktop.org/show_bug.cgi?id=47581> but the proposed
patches were later withdrawn since their authors didn't need that
part any more, only identification.

If you or your Smack-using colleagues want to resurrect that feature
request so that the dbus-daemon can accept or reject messages based on
Smack labels, the dbus at lists.freedesktop.org mailing list is suitable
for general discussion, and freedesktop.org Bugzilla is where we do
detailed patch review. The reviews on #47581 are probably relevant, so
I would advise skim-reading those first.

The same goes for other LSMs: as far as I'm aware, we cannot support
this generically, and mediation always requires LSM-specific code for
each LSM. In general we can't fix bugs (or test fixes) in that
LSM-specific code, so to add new code for mediation we would need
someone we can assign those bugs to.

> The issue is that /proc/.../current doesn't give you the same thing as
> SO_PEERSEC? Or that the format of what comes out of one isn't the same
> as what comes out of the other? I'm a little confused about what problem
> you are solving by using GetConnectionCredentials() instead of reading
> /proc/.../current

Suppose you are some service like NetworkManager, you have been contacted
via D-Bus by a process that claims to be uid 1000's gnome-shell, and you
want to know whether they should be allowed to connect to a different
network or something.

You can't use SO_PEERSEC or SO_PEERCRED yourself, because the way D-Bus
works, you are not directly connected to that process - there is a
dbus-daemon in the middle forwarding messages. So you have to ask the
dbus-daemon who they are instead. D-Bus is a message-passing IPC system
(with some syntactic sugar to make request/response pairs look vaguely
like object-oriented method calls, analogous to other RPC-style protocols),
so for communication directly with the dbus-daemon, we have some messages
that are processed inside the dbus-daemon instead of being forwarded
elsewhere. GetConnectionCredentials() is one of those messages.

You also can't get the process ID (let's say 1234) from dbus-daemon
and then look in /proc/1234/attr, because a malicious caller might
exec() a process that gets higher privileges than their own (racing with
the service in the hope that the exec() will happen before the
access-control check); or, more speculatively, a malicious caller might
_exit() at exactly the right time that their pid is reused by a new
process with higher privileges than theirs (again racing with the service).

> > The SELinux support in dbus-daemon (from Fedora/Red Hat) came first,
> > and I think it may have been the only widespread LSM at the time; but for
> > the AppArmor support (from Ubuntu) I insisted on generalizing the parts
> > that could be generalized.
> 
> General being something other than a text string?

General being: instead of having

- GetConnectionSELinuxContext(string: connection) -> UTF-8 string (?) or error
- GetConnectionAppArmorLabel(string: connection) -> bytestring or error
- GetConnectionSmackContext(string: connection) -> bytestring (?) or error
- GetConnectionMyNewModuleContext(string: conn) -> UTF-8 string or error
- GetConnectionYourNewModuleContext(string: conn) -> 64-bit integer or error

and having to write and maintain specific code for each one, we would
much prefer to have a single code path, and delegate interpretation of
the result to code that needs to be specific to a particular LSM anyway.
(Similar to the way the Linux kernel has SO_PEERSEC and all the LSMs share
it, rather than having SO_PEERSELINUX, SO_PEERAPPARMOR, SO_PEERSMACK...)

> Upstream only SELinux and Smack provide both /proc/.../current
> and SO_PEERSEC. They provide label strings that can be compared.
> AppArmor does not support SO_PEERSEC as of 4.12. So as of today,
> there isn't a problem. Or am I missing something?

What I would need, in order to do what I had hoped, would be a general
statement from the LSM (infrastructure) maintainers something along the
lines of: "If an LSM has labels in both /proc/.../current and SO_PEERSEC
and they differ, then that LSM is wrong and can safely be ignored". Or,
perhaps: "If an LSM has labels in /proc/.../current that end with a
newline, normalizing by stripping that newline does not change the
meaning; and if the label in /proc/.../current (after stripping a possible
newline) differs from the label in SO_PEERSEC, then that LSM is wrong
and can safely be ignored".

(Similar to the way my last thread on this list ended with consensus
that whether an LSM label in SO_PEERSEC includes a "\0" in its length
or not is not significant, and normalizing by adding or removing a
single trailing "\0" does not change the meaning.)

> An option which I have been investigating is to add a
> sockopt to specify which security module's data you want
> getsockopt(..., SO_PEERSEC, ...) to provide. If you haven't
> specified, you get the first available (per the wishes of the
> SELinux crowd). If you specify an LSM name you get the value
> for that. If you specify "context" you get the wacky string
> with all the available modules. I'm leaning in this direction
> because it should be easier on the existing userspace. Only
> those that are aware of the possibility of multiple security
> modules need to be modified.

Hmm. GetConnectionCredentials() returns a data stucture like this:

    { "UnixUserID" => 1000, "ProcessID" => 1234,
      "LinuxSecurityLabel" => "whatever_SO_PEERSEC_said\0" }

which is extensible: we can add or remove whatever string keys we want
(for instance on Windows there's no UnixUserID or LinuxSecurityLabel,
but instead there's WindowsSID for the Windows analogue of a uid),
and a particular string not appearing means "unknown or not applicable"
(for instance LinuxSecurityLabel doesn't appear unless you are on
Linux and have some suitable LSM loaded).

So we have three options for dealing with your new multiplexed strings:

* LinuxSecurityLabel is the first available and is deprecated, and a
  new LinuxSecurityLabels is the multiplexed string
* LinuxSecurityLabel is the first available and is deprecated, and
  the string is parsed (in an LSM-agnostic way) to produce
  "LinuxSecurityLabel.selinux" => "whatever_t\0",
  "LinuxSecurityLabel.apparmor" => "/usr/bin/whatever\0" and so on
  (or a nested mapping { "selinux" => "whatever_t\0", ... } maybe)
* LinuxSecurityLabel is the multiplexed string, and recipients are
  expected to evolve to deal with it

Either way, I would hope that libselinux, libapparmor, libsmack
etc. would eventually be updated so that functions like AppArmor's
aa_splitcon() are able to parse the multiplexed string and discard all
the parts not relevant to this specific LSM?

    S
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
