From: mjg59@google.com (Matthew Garrett)
Date: Tue, 03 Apr 2018 21:08:54 +0000
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
	<CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
	<CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
	<CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
	<CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
Message-ID: <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 2:01 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 1:54 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> >> .. maybe you don't *want* secure boot, but it's been pushed in your
> >> face by people with an agenda?
> >
> > Then turn it off, or build a self-signed kernel that doesn't do this?

> Umm. So you asked a question, and then when you got an answer you said
> "don't do that then".

> The fact is, some hardware pushes secure boot pretty hard. That has
> *nothing* to do with some "lockdown" mode.

Secure Boot ensures that the firmware will only load signed bootloaders. If
a signed bootloader loads a kernel that's effectively an unsigned
bootloader, there's no point in using Secure Boot - you should just turn it
off instead, because it's not giving you any meaningful security. Andy's
example gives a scenario where by constraining your *userland* sufficiently
you can get close to having the same guarantees, but that involves you
having a read-only filesystem and takes you even further away from having a
general purpose computer.

If you don't want Secure Boot, turn it off. If you want Secure Boot, use a
kernel that behaves in a way that actually increases your security.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
