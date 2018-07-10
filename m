From: zohar@linux.ibm.com (Mimi Zohar)
Date: Tue, 10 Jul 2018 14:47:21 -0400
Subject: [PATCH v5 7/8] ima: based on policy warn about loading firmware
	(pre-allocated buffer)
In-Reply-To: <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
	<CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
	<1531165294.3332.40.camel@linux.ibm.com>
	<CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
	<CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
Message-ID: <1531248441.3332.142.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-07-10 at 08:56 +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 08:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 9 July 2018 at 21:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
> >>> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >>> > Some systems are memory constrained but they need to load very large
> >>> > firmwares.  The firmware subsystem allows drivers to request this
> >>> > firmware be loaded from the filesystem, but this requires that the
> >>> > entire firmware be loaded into kernel memory first before it's provided
> >>> > to the driver.  This can lead to a situation where we map the firmware
> >>> > twice, once to load the firmware into kernel memory and once to copy the
> >>> > firmware into the final resting place.
> >>> >
> >>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> >>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
> >>> > that allows drivers to request firmware be loaded directly into a
> >>> > pre-allocated buffer. (Based on the mailing list discussions, calling
> >>> > dma_alloc_coherent() is unnecessary and confusing.)
> >>> >
> >>> > (Very broken/buggy) devices using pre-allocated memory run the risk of
> >>> > the firmware being accessible to the device prior to the completion of
> >>> > IMA's signature verification.  For the time being, this patch emits a
> >>> > warning, but does not prevent the loading of the firmware.
> >>> >
> >>>
> >>> As I attempted to explain in the exchange with Luis, this has nothing
> >>> to do with broken or buggy devices, but is simply the reality we have
> >>> to deal with on platforms that lack IOMMUs.
> >>
> >>> Even if you load into one buffer, carry out the signature verification
> >>> and *only then* copy it to another buffer, a bus master could
> >>> potentially read it from the first buffer as well. Mapping for DMA
> >>> does *not* mean 'making the memory readable by the device' unless
> >>> IOMMUs are being used. Otherwise, a bus master can read it from the
> >>> first buffer, or even patch the code that performs the security check
> >>> in the first place. For such platforms, copying the data around to
> >>> prevent the device from reading it is simply pointless, as well as any
> >>> other mitigation in software to protect yourself from misbehaving bus
> >>> masters.
> >>
> >> Thank you for taking the time to explain this again.
> >>
> >>> So issuing a warning in this particular case is rather arbitrary. On
> >>> these platforms, all bus masters can read (and modify) all of your
> >>> memory all of the time, and as long as the firmware loader code takes
> >>> care not to provide the DMA address to the device until after the
> >>> verification is complete, it really has done all it reasonably can in
> >>> the environment that it is expected to operate in.
> >>
> >> So for the non-IOMMU system case, differentiating between pre-
> >> allocated buffers vs. using two buffers doesn't make sense.
> >>
> >>>
> >>> (The use of dma_alloc_coherent() is a bit of a red herring here, as it
> >>> incorporates the DMA map operation. However, DMA map is a no-op on
> >>> systems with cache coherent 1:1 DMA [iow, all PCs and most arm64
> >>> platforms unless they have IOMMUs], and so there is not much
> >>> difference between memory allocated with kmalloc() or with
> >>> dma_alloc_coherent() in terms of whether the device can access it
> >>> freely)
> >>
> >> What about systems with an IOMMU?
> >>
> >
> > On systems with an IOMMU, performing the DMA map will create an entry
> > in the IOMMU page tables for the physical region associated with the
> > buffer, making the region accessible to the device. For platforms in
> > this category, using dma_alloc_coherent() for allocating a buffer to
> > pass firmware to the device does open a window where the device could
> > theoretically access this data while the validation is still in
> > progress.
> >
> > Note that the device still needs to be informed about the address of
> > the buffer: just calling dma_alloc_coherent() will not allow the
> > device to find the firmware image in its memory space, and arbitrary
> > DMA accesses performed by the device will trigger faults that are
> > reported to the OS. So the window between DMA map (or
> > dma_alloc_coherent()) and the device specific command to pass the DMA
> > buffer address to the device is not inherently unsafe IMO, but I do
> > understand the need to cover this scenario.
> >
> > As I pointed out before, using coherent DMA buffers to perform
> > streaming DMA is generally a bad idea, since they may be allocated
> > from a finite pool, and may use uncached mappings, making the access
> > slower than necessary (while streaming DMA can use any kmalloc'ed
> > buffer and will just flush the contents of the caches to main memory
> > when the DMA map is performed).
> >
> > So to summarize again: in my opinion, using a single buffer is not a
> > problem as long as the validation completes before the DMA map is
> > performed. This will provide the expected guarantees on systems with
> > IOMMUs, and will not complicate matters on systems where there is no
> > point in obsessing about this anyway given that devices can access all
> > of memory whenever they want to.

It sound like as long as the pre-allocated buffer is not being re-
used, either by being mapped to multiple devices or used to load
multiple firmware blobs, it is safe.

> >
> > As for the Qualcomm case: dma_alloc_coherent() is not needed here but
> > simply ends up being used because it was already wired up in the
> > qualcomm specific secure world API, which amounts to doing syscalls
> > into a higher privilege level than the one the kernel itself runs at.
> > So again, reasoning about whether the secure world will look at your
> > data before you checked the sig is rather pointless, and adding
> > special cases to the IMA api to cater for this use case seems like a
> > waste of engineering and review effort to me. If we have to do
> > something to tie up this loose end, let's try switching it to the
> > streaming DMA api instead.
> >
> 
> Forgot to mention: the Qualcomm case is about passing data to the CPU
> running at another privilege level, so IOMMU vs !IOMMU is not a factor
> here.

Agreed. ?It sounds like the dependency would be on whether the buffer
has been DMA mapped.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
