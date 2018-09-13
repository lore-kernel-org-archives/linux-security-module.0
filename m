From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Sep 2018 16:06:25 -0700
Subject: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
In-Reply-To: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
	<CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
	<CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
	<CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
	<CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
	<CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
	<CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
	<CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
Message-ID: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 13, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
> At the very least, to avoid stacking now (i.e. TOMOYO being enabled
> with another major LSM), we just do nothing. The existing code already
> makes the existing major LSMs exclusive. Adding a stackable LSM would
> need to just have its own "enable" flag (i.e. ignore
> security_module_enable()), and then either check a runtime "is
> stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
> think the CONFIG will force distros into enabling it without any
> runtime opt-out.)

Before stacking, we have:

- major LSM, pick one
- all CONFIG minor LSMs, in security.c order

There are two minor LSMs: Yama and LoadPin. If built, Yama is always
on (though it has sysctl knobs). If built, LoadPin is controlled by a
boot param.

Picking the major LSM happens via "security=$LSM" and a per-LSM check
of security_module_enable("$LSM").

Ordering is major, then per security.c for minors.


Under stacking, we have:

The minor LSMs remain unchanged.

We don't have SARA and Landlock yet, but we do have TOMOYO, which we
can use as an example to future "compatible blob-using LSMs".

I see two issues:

- how to determine which set of LSMs are enabled at boot
- how to determine the ORDER of the LSMs


Casey's implementation does this (correct me if I'm wrong):

The minor LSMs remain unchanged.

SECURITY_$lsm_STACKED determines which major is enabled, with
SECURITY_TOMOYO_STACKED allowed in addition. If security= is
specified, all other major LSMs are disabled (i.e. it is not possible
to switch between SELinux/AppArmor/SMACK without also disabling
TOMOYO).

Ordering is per security/Makefile modulo enabled-ness for majors (i.e.
TOMOYO is always _before_ AppArmor if stacked together, otherwise
after SELinux and SMACK), and per security.c for minors.


I don't think this is how we want it to work. For example, Ubuntu
builds in all LSMs, and default-enables AppArmor. If an Ubuntu user
wants TOMOYO, the boot with "security=tomoyo". If Ubuntu wants to make
stacking available to users but off by default, what CONFIGs do they
pick? They could try SECURITY_APPARMOR_STACKED=y and
SECURITY_TOMOYO_STACKED=n, but then how does an end user choose
"apparmor and tomoyo" (or more meaningfully, for the future:
"apparmor, sara, and landlock")? They can still pick
"security=tomoyo", but there isn't a runtime way to opt into stacking.


What about leaving SECURITY_$lsm_DEFAULT as-is, and then...

In the past I'd suggested using "security=" to determine both enabled
and order: "security=tomoyo,smack" would mean stacked LSMs, with
tomoyo going first.

Currently I'm leaning towards "security=" to select ONLY the
incompatible LSM, and per-LSM "enable" flags to determine stacking:

    tomoyo.enabled=1 security=smack

This doesn't explicitly address ordering, though. If we made param
_position_ meaningful, then we could get ordering (i.e. above would
mean "tomoyo first").

Note, ordering matters because call_int_hook() will _stop_ on a
non-zero return value: potentially hiding events from later LSMs. Do
we need to revisit this? I seem to remember if being a very dead
horse, and we needed to quick-abort otherwise we ended up in
nonsensical states.

The reason for the new approach is because I can't find a meaningful
way to provide CONFIGs that make sense. We want to provide a few
things:

- is an LSM built into the kernel at all? (CONFIG_SECURITY_$lsm)
- is an LSM enabled by default? (CONFIG_SECURITY_$lsm_ENABLED?)
- has an LSM been enable for this boot? $lsm.enabled=1 or security=$lsm,$lsm ?
- what order should any stacking happen? Makefile? security=?

And for the incompatible-major, do we stick with CONFIG_SECURITY_$lsm_DEFAULT ?



Anyway, if the concern is with exposed behavior for distros, what do
we want? i.e. what should be done for patch 10. Everything else looks
good.

-Kees

-- 
Kees Cook
Pixel Security
