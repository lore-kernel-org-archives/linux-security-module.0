From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 3 Apr 2018 14:51:23 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
	<CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
	<CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
	<CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com>
Message-ID: <CALCETrVR_EcbKv5-4AR6Zm02XHhJQQGNDeO8FGkMbYozmuDTJw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 12:29 PM, Matthew Garrett <mjg59@google.com> wrote:
> On Tue, Apr 3, 2018 at 9:46 AM Andy Lutomirski <luto@kernel.org> wrote:
>> On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
>> > A kernel that allows users arbitrary access to ring 0 is just an
>> > overfeatured bootloader. Why would you want secure boot in that case?
>
>> To get a chain of trust.  I can provision a system with some public
>> keys, stored in UEFI authenticated variables, such that the system
>> will only boot a signed image.  That signed image, can, in turn, load
>> a signed (or hashed or otherwise verfified) kernel and a verified
>> initramfs.  The initramfs can run a full system from a verified (using
>> dm-verity or similar) filesystem, for example.  Now it's very hard to
>> persistently attack this system.  Chromium OS does something very much
>> like this, except that it doesn't use UEFI as far as I know.  So does
>> iOS, and so do some Android versions.  None of this requires lockdown,
>> or even a separation between usermode and kernelmode, to work
>> correctly.  One could even do this on an MMU-less system if one really
>> cared to.  More usefully, someone probably has done this using a
>> unikernel.
>
> That's only viable if you're the only person with the ability to sign stuff
> for your machine - the moment there are generic distributions that your
> machine trusts, an attacker can use one as a bootloader to compromise your
> trust chain.


If you removed "as a bootloader", then I agree with that sentence.

Can someone please explain why the UEFI crowd cares so much about "as
a bootloader"?  Once I'm able to install an OS (Linux kernel +
bootloader, Windows embedded doodad, OpenBSD, whatever) on your
machine, I can use your peripherals, read your data, write your data,
see your keystrokes, use your network connection, re-flash your BIOS
(at least as well as any OS can), run VMs, and generally own your
system.  Somehow you all seem fine with all of this, except that the
fact that I can chainload something else gives UEFI people the
willies.

Can someone explain why?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
