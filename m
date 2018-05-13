From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 May 2018 12:41:11 +0100
Subject: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
In-Reply-To: <CALCETrXRVMhjdepkkhSKtV4s1A4uhVe_ANetbgTtwcM9jf_5YQ@mail.gmail.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	<20180429093558.5411-3-hdegoede@redhat.com>
	<CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
	<59023265-bfca-fe5d-e047-4c69404a0dd1@redhat.com>
	<20180503223126.GE27853@wotan.suse.de>
	<CALCETrXRVMhjdepkkhSKtV4s1A4uhVe_ANetbgTtwcM9jf_5YQ@mail.gmail.com>
Message-ID: <b538eda9-2faf-0894-0cf9-a587f94b7b3e@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On 05/03/2018 11:35 PM, Andy Lutomirski wrote:
> On Thu, May 3, 2018 at 3:31 PM Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> 
>> On Wed, May 02, 2018 at 04:49:53PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 05/01/2018 09:29 PM, Andy Lutomirski wrote:
>>>> On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com>
> wrote:
>>>>> +The EFI embedded-fw code works by scanning all
> EFI_BOOT_SERVICES_CODE
>>>> memory
>>>>> +segments for an eight byte sequence matching prefix, if the prefix
> is
>>>> found it
>>>>> +then does a crc32 over length bytes and if that matches makes a
> copy of
>>>> length
>>>>> +bytes and adds that to its list with found firmwares.
>>>>> +
>>>>
>>>> Eww, gross.  Is there really no better way to do this?
>>>
>>> I'm afraid not.
>>>
>>>>   Is the issue that
>>>> the EFI code does not intend to pass the firmware to the OS but that
> it has
>>>> a copy for its own purposes and that Linux is just going to hijack
> EFI's
>>>> copy?  If so, that's brilliant and terrible at the same time.
>>>
>>> Yes that is exactly the issue / what it happening here.
>>>
>>>>
>>>>> +       for (i = 0; i < size; i += 8) {
>>>>> +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
>>>>> +                       continue;
>>>>> +
>>>>> +               /* Seed with ~0, invert to match crc32 userspace
> utility
>>>> */
>>>>> +               crc = ~crc32(~0, mem + i, desc->length);
>>>>> +               if (crc == desc->crc)
>>>>> +                       break;
>>>>> +       }
>>>>
>>>> I hate to play the security card, but this stinks a bit.  The kernel
>>>> obviously needs to trust the EFI boot services code since the EFI boot
>>>> services code is free to modify the kernel image.  But your patch is
> not
>>>> actually getting this firmware blob from the boot services code via
> any
>>>> defined interface -- you're literally snarfing up the blob from a
> range of
>>>> memory.  I fully expect there to be any number of ways for
> untrustworthy
>>>> entities to inject malicious blobs into this memory range on quite a
> few
>>>> implementations.  For example, there are probably unauthenticated EFI
>>>> variables and even parts of USB sticks and such that get read into
> boot
>>>> services memory, and I see no reason at all to expect that nothing in
> the
>>>> so-called "boot services code" range is actually just plain old boot
>>>> services *heap*.
>>>>
>>>> Fortunately, given your design, this is very easy to fix.  Just
> replace
>>>> CRC32 with SHA-256 or similar.  If you find the crypto api too ugly
> for
>>>> this purpose, I have patches that only need a small amount of dusting
> off
>>>> to give an entirely reasonable SHA-256 API in the kernel.
>>>
>>> My main reason for going with crc32 is that the scanning happens before
>>> the kernel is fully up and running (it happens just before the
> rest_init()
>>> call in start_kernel() (from init/main.c) I'm open to using the
>>> crypto api, but I was not sure if that is ready for use at that time.
> 
>> Not being sure is different than being certain. As Andy noted, if that
> does
>> not work please poke Andy about the SHA-256 API he has which would enable
>> its use in kernel.
> 
> Nah, don't use the cryptoapi for this.  You'll probably regret it for any
> number of reasons.  My code is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=crypto/sha256_bpf&id=e9e12f056f2abed50a30b762db9185799f5864e6
> 
> and its two parents.  It needs a little bit of dusting and it needs
> checking that all combinations of modular and non-modular builds work.  Ard
> probably has further comments.

Looks good, I've cherry picked this into my personal tree and will make
the next version of the EFI embedded-firmware patches use SHA256.

As Luis already mentioned geting the EFI embedded-firmware patches
upstream is not something urgent, so it is probably best to just
wait for you to push these upstream I guess?

Regards,

Hans

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
