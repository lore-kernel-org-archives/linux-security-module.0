From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 16 Feb 2018 12:59:12 -0800
Subject: [PATCH v3 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <1518813234-5874-2-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-2-git-send-email-takondra@cisco.com>
Message-ID: <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/16/18 12:33, Taras Kondratiuk wrote:
> Many of the Linux security/integrity features are dependent on file
> metadata, stored as extended attributes (xattrs), for making decisions.
> These features need to be initialized during initcall and enabled as
> early as possible for complete security coverage.
> 
> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
> support including them into the archive.
> 
> This patch describes "extended" newc format (newcx) that is based on
> newc and has following changes:
> - extended attributes support
> - increased size of filesize to support files >4GB
> - increased mtime field size to have 64 bits of seconds and added a
>   field for nanoseconds
> - removed unused checksum field
> 

If you are going to implement a new, non-backwards-compatible format,
you shouldn't replicate the mistakes of the current format.  Specifically:

1. The use of ASCII-encoded fixed-length numbers is an idiotic legacy
from an era before there were any portable way of dealing with numbers
with prespecified endianness.  If you are going to use ASCII, make them
delimited so that they don't have fixed limits, or just use binary.

The cpio header isn't fixed size, so that argument goes away, in fact
the only way to determine the end of the header is to scan forward.

2. Alignment sensitivity!  Because there is no header length
information, the above scan tells you where the header ends, but there
is padding before the data, and the size of that padding is only defined
by alignment.

3. Inband encoding of EOF: if you actually have a filename "TRAILER!!!"
you have problems.

But first, before you define a whole new format for which no tools exist
(you will have to work with the maintainers of the GNU tools to add
support) you should see how complex it would be to support the POSIX
tar/pax format, which already has all the features you are seeking, and
by now is well-supported.

	-hpa

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
