From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Jan 2018 10:29:12 +0100
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <1516850875-25066-2-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
Message-ID: <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra@cisco.com> wrote:
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
> - increased size of filesize to support files >4GB.
> - increased mtime field size to have usec precision and more than
>   32-bit of seconds.
> - removed unused checksum field.
>
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>

Ah nice, I like the extension of the time handling, that certainly
addresses one of the issues with y2038 that we have previously
hacked around in an ugly way (interpreting the 32-bit
number as unsigned).

However, if this is to become a generally supported format
for cpio files, could we make it use nanosecond resolution
instead? The issue that I see with microseconds is that
storing a file in an archive and extracting it again would
otherwise keep the mtime stamp /almost/ identical on file
systems that have nanosecond resolution, but most of
the time a comparison would indicate that the files are
not the same.

Unfortunately, the range of a 64-bit nanoseconds counter
is still a bit limited (584 years, or half of that if we make it
signed). While this is clearly enough for the uses in
initramfs, it still has a similar problem: someone creating
a fake timestamp a long time in the past or future on
a file system would lose information after going though
cpio.

         Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
