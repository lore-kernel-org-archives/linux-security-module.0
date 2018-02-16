From: rob@landley.net (Rob Landley)
Date: Fri, 16 Feb 2018 15:25:07 -0600
Subject: [PATCH v3 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-2-git-send-email-takondra@cisco.com>
	<d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
Message-ID: <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 02/16/2018 02:59 PM, H. Peter Anvin wrote:
> On 02/16/18 12:33, Taras Kondratiuk wrote:
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
>> - increased size of filesize to support files >4GB
>> - increased mtime field size to have 64 bits of seconds and added a
>>   field for nanoseconds
>> - removed unused checksum field
>>
> 
> If you are going to implement a new, non-backwards-compatible format,
> you shouldn't replicate the mistakes of the current format.  Specifically:

So rather than make minimal changes to the existing format and continue to
support the existing format (sharing as much code as possible), you recommend
gratuitous aesthetic changes?

> 1. The use of ASCII-encoded fixed-length numbers is an idiotic legacy
> from an era before there were any portable way of dealing with numbers
> with prespecified endianness.

It lets encoders and decoders easily share code with the existing cpio format,
which we still intend to be able to read and write.

> If you are going to use ASCII, make them
> delimited so that they don't have fixed limits, or just use binary.

When it's gzipped this accomplishes what? (Other than being gratuitously
different from the previous iteration?)

> The cpio header isn't fixed size, so that argument goes away, in fact
> the only way to determine the end of the header is to scan forward.
> 
> 2. Alignment sensitivity!  Because there is no header length
> information, the above scan tells you where the header ends, but there
> is padding before the data, and the size of that padding is only defined
> by alignment.

Again, these are minimal changes to the existing cpio format. You're complaining
about _cpio_, and that the new stuff isn't _different_ enough from it.

> 3. Inband encoding of EOF: if you actually have a filename "TRAILER!!!"
> you have problems.

Been there, done that:

http://lkml.iu.edu/hypermail/linux/kernel/1801.3/01791.html

> But first, before you define a whole new format for which no tools exist
> (you will have to work with the maintainers of the GNU tools to add
> support)

No, he's been working with the maintainer of toybox to add support (for about a
year now), which gets him the Android command line. And the kernel has its own
built-in tool to generate cpio images anyway.

Why would anyone care what the GNU project thinks?

> you should see how complex it would be to support the POSIX
> tar/pax format,

That argument was had (at length) when initramfs went in over a decade ago.
There are links in Documentation/filesystems/ramfs-rootfs-initramfs.txt to the
mailing list entries about it.

> which already has all the features you are seeking, and
> by now is well-supported.

So... tar wasn't well-supported 15 years ago? (Hasn't the kernel source always
been distributed via tarball back since 0.0.1?)

You're suggesting having a whole second codepath that shares no code with the
existing cpio extractor. Are you suggesting abandoning support for the existing
initramfs.cpio.gz file format?

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
