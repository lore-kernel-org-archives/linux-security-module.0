From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 01 May 2018 19:29:19 +0000
Subject: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
In-Reply-To: <20180429093558.5411-3-hdegoede@redhat.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	<20180429093558.5411-3-hdegoede@redhat.com>
Message-ID: <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE
memory
> +segments for an eight byte sequence matching prefix, if the prefix is
found it
> +then does a crc32 over length bytes and if that matches makes a copy of
length
> +bytes and adds that to its list with found firmwares.
> +

Eww, gross.  Is there really no better way to do this?  Is the issue that
the EFI code does not intend to pass the firmware to the OS but that it has
a copy for its own purposes and that Linux is just going to hijack EFI's
copy?  If so, that's brilliant and terrible at the same time.

> +       for (i = 0; i < size; i += 8) {
> +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
> +                       continue;
> +
> +               /* Seed with ~0, invert to match crc32 userspace utility
*/
> +               crc = ~crc32(~0, mem + i, desc->length);
> +               if (crc == desc->crc)
> +                       break;
> +       }

I hate to play the security card, but this stinks a bit.  The kernel
obviously needs to trust the EFI boot services code since the EFI boot
services code is free to modify the kernel image.  But your patch is not
actually getting this firmware blob from the boot services code via any
defined interface -- you're literally snarfing up the blob from a range of
memory.  I fully expect there to be any number of ways for untrustworthy
entities to inject malicious blobs into this memory range on quite a few
implementations.  For example, there are probably unauthenticated EFI
variables and even parts of USB sticks and such that get read into boot
services memory, and I see no reason at all to expect that nothing in the
so-called "boot services code" range is actually just plain old boot
services *heap*.

Fortunately, given your design, this is very easy to fix.  Just replace
CRC32 with SHA-256 or similar.  If you find the crypto api too ugly for
this purpose, I have patches that only need a small amount of dusting off
to give an entirely reasonable SHA-256 API in the kernel.

(To be clear, I don't love my own suggestion here.  What I'd *really* like
to see is a better interface and no attempt to match the data to some
built-in hash at all.  In particular, there are plenty of devices for which
the driver wants access to a genuinely device-specific blob.  For example,
I'm typing this email while connected to a router that is running ath10k
and is using a calibration blob awkwardly snarfed out of flash somewhere.
It would be really nice if there was a way to pull a blob out of EFI space
that is marked, by EFI, as belonging to a particular device.  Then the
firmware could just pass it over without any particular verification.  But
since your code is literally scanning a wide swath of physical memory for
something that looks like a valid blob, I think you need to use a
cryptographically strong concept of validity.)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
