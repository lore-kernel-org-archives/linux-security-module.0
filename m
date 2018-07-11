From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jul 2018 08:24:41 +0200
Subject: [PATCH v5 7/8] ima: based on policy warn about loading firmware
	(pre-allocated buffer)
In-Reply-To: <20180710191951.GF1731@minitux>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
	<CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
	<1531165294.3332.40.camel@linux.ibm.com>
	<CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
	<CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
	<20180710191951.GF1731@minitux>
Message-ID: <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Mon 09 Jul 23:56 PDT 2018, Ard Biesheuvel wrote:
>
>> On 10 July 2018 at 08:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 9 July 2018 at 21:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> >> On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
>> >>> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> [..]
>> > So to summarize again: in my opinion, using a single buffer is not a
>> > problem as long as the validation completes before the DMA map is
>> > performed. This will provide the expected guarantees on systems with
>> > IOMMUs, and will not complicate matters on systems where there is no
>> > point in obsessing about this anyway given that devices can access all
>> > of memory whenever they want to.
>> >
>> > As for the Qualcomm case: dma_alloc_coherent() is not needed here but
>> > simply ends up being used because it was already wired up in the
>> > qualcomm specific secure world API, which amounts to doing syscalls
>> > into a higher privilege level than the one the kernel itself runs at.
>
> As I said before, the dma_alloc_coherent() referred to in this
> discussion holds parameters for the Trustzone call, i.e. it will hold
> the address to the buffer that the firmware was loaded into - it won't
> hold any data that comes from the actual firmware.
>

Ah yes, I forgot that detail. Thanks for reminding me.

>> > So again, reasoning about whether the secure world will look at your
>> > data before you checked the sig is rather pointless, and adding
>> > special cases to the IMA api to cater for this use case seems like a
>> > waste of engineering and review effort to me.
>
> Forgive me if I'm missing something in the implementation here, but
> aren't the IMA checks done before request_firmware*() returns?
>

The issue under discussion is whether calling request_firmware() to
load firmware into a buffer that may be readable by the device while
the IMA checks are in progress constitutes a security hazard.

>> > If we have to do
>> > something to tie up this loose end, let's try switching it to the
>> > streaming DMA api instead.
>> >
>>
>> Forgot to mention: the Qualcomm case is about passing data to the CPU
>> running at another privilege level, so IOMMU vs !IOMMU is not a factor
>> here.
>
> Further more, all scenarios we've look at so far is completely
> sequential, so if the firmware request fails we won't invoke the
> Trustzone operation that would consume the memory or we won't turn on
> the power to the CPU that would execute the firmware.
>
>
> Tbh the only case I can think of where there would be a "race condition"
> here is if we have a device that is polling the last byte of a
> predefined firmware memory area for the firmware loader to read some
> specific data into it. In cases where the firmware request is followed
> by some explicit signalling to the device (or a power on sequence) I'm
> unable to see the issue discussed here.
>

I agree. But the latter part is platform specific, and so it requires
some degree of trust in the driver author on the part of the IMA
routines that request_firmware() is called at an appropriate time.

The point I am trying to make in this thread is that there are cases
where it makes no sense for the kernel to reason about these things,
given that higher privilege levels such as the TrustZone secure world
own the kernel's execution context entirely already, and given that
masters that are not behind an IOMMU can read and write all of memory
all of the time anyway.

The bottom line is that reality does not respect the layering that IMA
assumes, and so the only meaningful way to treat some of the use cases
is simply to ignore them entirely. So we should still perform all the
checks, but we will have to live with the limited utility of doing so
in some scenarios (and not print nasty warnings to the kernel log for
such cases)

-- 
Ard.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
