From: rob@landley.net (Rob Landley)
Date: Thu, 25 Jan 2018 20:39:56 -0600
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
Message-ID: <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/25/2018 03:29 AM, Arnd Bergmann wrote:
> On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra@cisco.com> wrote:
>> Many of the Linux security/integrity features are dependent on file
>> metadata, stored as extended attributes (xattrs), for making decisions.
>> These features need to be initialized during initcall and enabled as
>> early as possible for complete security coverage.
>>
>> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
>> support including them into the archive.
>>
>> This patch describes "extended" newc format (newcx) that is based on
>> newc and has following changes:
>> - extended attributes support
>> - increased size of filesize to support files >4GB.
>> - increased mtime field size to have usec precision and more than
>>   32-bit of seconds.
>> - removed unused checksum field.
>>
>> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> 
> Ah nice, I like the extension of the time handling, that certainly
> addresses one of the issues with y2038 that we have previously
> hacked around in an ugly way (interpreting the 32-bit
> number as unsigned).

Taras and I exchanged email like a year ago working out format stuff, so
I don't have any real complaints. My feedback's already worked in, and I
can make toybox cpio support -h newcx as soon as the format's finalized
and I get a free weekend.

That said, I don't think -h newcx should emit (or recognize) the
"TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
files have a length, pipes provide EOF, and each cpiox entry starts with
6 bytes of c_magic anyway. (I stopped toybox from producing the TRAILER
entry back in june, toybox commit 32550751997d, and the kernel consumes
the resulting cpio just fine. All the trailer does is prevent you from
concatenating cpio files, which is a feature multiple people asked me for.)

> However, if this is to become a generally supported format
> for cpio files,

After Joerg Schilling dies (or admits solaris has) it might even make it
into posix.

> could we make it use nanosecond resolution
> instead? The issue that I see with microseconds is that
> storing a file in an archive and extracting it again would
> otherwise keep the mtime stamp /almost/ identical on file
> systems that have nanosecond resolution, but most of
> the time a comparison would indicate that the files are
> not the same.

I have no strong opinion on this? The tmpfs is still going to track
nanoseconds, this is just rounding when it populates them.

> Unfortunately, the range of a 64-bit nanoseconds counter
> is still a bit limited (584 years, or half of that if we make it
> signed). While this is clearly enough for the uses in
> initramfs, it still has a similar problem: someone creating
> a fake timestamp a long time in the past or future on
> a file system would lose information after going though
> cpio.

Hence microseconds. This came up in email when we were talking about
this (like a year ago) and I decided I didn't care. :)

64 bits of microseconds is +- 584 centuries, while being accurate
enough[1] that making a getpid() syscall probably takes longer than that
on our highest end boxen, let alone doing a dentry lookup in the vfs
(even if it's hot in cache).

Rob

[1] Is future proofing an issue here? The s-curve of moore's law started
bending down around y2k back when Intel had to recall its 1.13ghz
pentium III for having overclocked its own chip at the factory, and it's
pretty darn flat these days. Clock speeds first hit 4ghz 15 years ago
and haven't been back, most of the work since 2005 has been about
parallelism, and recent performance improvements are once again going to
pentium 4 pipeline length levels of absurdity, as meltdown/spectre
demonstrates (140 instructions of prefetch!??!?). Maybe intel will make
9 nanometer manufacturing work, but atomic limits are already an issue.

The problem with 1 second timestamps was you honestly could confuse
"make" about which file was newer once an exec() could complete in the
same second having done real work. That was the motivating issue causing
the change, going to nanoseconds was just the big hammer of "this is
large enough it won't matter again in our lifetimes". But nanosecond
time stamps are recording more jitter than useful information, and that
seems unlikely to change this century?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
