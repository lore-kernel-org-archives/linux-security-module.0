From: keescook@chromium.org (Kees Cook)
Date: Tue, 5 Jun 2018 15:37:22 -0700
Subject: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
	(pre-allocated buffer)
In-Reply-To: <20180601192545.GR4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
	<20180601191545.GP4511@wotan.suse.de>
	<20180601192545.GR4511@wotan.suse.de>
Message-ID: <CAGXu5jKkg_=iHGgrED4qB4TCFJaWgLkLp61RHgJ6UEhAj89GwQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 1, 2018 at 12:25 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Fri, Jun 01, 2018 at 09:15:45PM +0200, Luis R. Rodriguez wrote:
>> On Tue, May 29, 2018 at 02:01:59PM -0400, Mimi Zohar wrote:
>> > Some systems are memory constrained but they need to load very large
>> > firmwares.  The firmware subsystem allows drivers to request this
>> > firmware be loaded from the filesystem, but this requires that the
>> > entire firmware be loaded into kernel memory first before it's provided
>> > to the driver.  This can lead to a situation where we map the firmware
>> > twice, once to load the firmware into kernel memory and once to copy the
>> > firmware into the final resting place.
>> >
>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
>> > that allows drivers to request firmware be loaded directly into a
>> > pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
>> > allocate this buffer.  According to Documentation/DMA-API.txt,
>> >
>> >      Consistent memory is memory for which a write by either the
>> >      device or the processor can immediately be read by the processor
>> >      or device without having to worry about caching effects.  (You
>> >      may however need to make sure to flush the processor's write
>> >      buffers before telling devices to read that memory.)
>> >
>> > Devices using pre-allocated DMA memory run the risk of the firmware
>> > being accessible by the device prior to the kernel's firmware signature
>> > verification has completed.
>>
>> Indeed. And since its DMA memory we have *no idea* what can happen in
>> terms of consumption of this firmware from hardware, when it would start
>> consuming it in particular.
>>
>> If the device has its own hardware firmware verification mechanism this is
>> completely obscure to us, but it may however suffice certain security policies.
>>
>> The problem here lies in the conflicting security policies of the kernel wanting
>> to not give away firmware until its complete and the current inability to enable
>> us to have platforms suggest they trust hardware won't do something stupid.
>> This becomes an issue since the semantics of the firmware API preallocated
>> buffer do not require currently allow the kernel to inform LSMs of the fact
>> that a buffer is DMA memory or not, and a way for certain platforms then
>> to say that such use is fine for specific devices.
>>
>> Given a pointer can we determine if a piece of memory is DMA or not?
>
> FWIW
>
> Vlastimil suggests page_zone() or virt_to_page() may be able to.

I don't see a PAGEFLAG for DMA, but I do see ZONE_DMA for
page_zone()... So maybe something like

struct page *page;

page = virt_to_page(address);
if (!page)
   fail closed...
if (page_zone(page) == ZONE_DMA)
    handle dma case...
else
    non-dma

But I've CCed Laura and Rik, who I always lean on when I have these
kinds of page questions...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
