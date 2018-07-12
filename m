From: zohar@linux.ibm.com (Mimi Zohar)
Date: Thu, 12 Jul 2018 16:03:13 -0400
Subject: [PATCH v5 7/8] ima: based on policy warn about loading firmware
	(pre-allocated buffer)
In-Reply-To: <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
	<CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
	<1531165294.3332.40.camel@linux.ibm.com>
	<CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
	<CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
	<20180710191951.GF1731@minitux>
	<CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
Message-ID: <1531425793.3568.275.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-07-11 at 08:24 +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> > Tbh the only case I can think of where there would be a "race condition"
> > here is if we have a device that is polling the last byte of a
> > predefined firmware memory area for the firmware loader to read some
> > specific data into it. In cases where the firmware request is followed
> > by some explicit signalling to the device (or a power on sequence) I'm
> > unable to see the issue discussed here.
> >
> 
> I agree. But the latter part is platform specific, and so it requires
> some degree of trust in the driver author on the part of the IMA
> routines that request_firmware() is called at an appropriate time.

Exactly. ?Qualcomm could be using the pre-allocated buffer
appropriately, but that doesn't guarantee how it will be used in the
future.

> The point I am trying to make in this thread is that there are cases
> where it makes no sense for the kernel to reason about these things,
> given that higher privilege levels such as the TrustZone secure world
> own the kernel's execution context entirely already, and given that
> masters that are not behind an IOMMU can read and write all of memory
> all of the time anyway.

> The bottom line is that reality does not respect the layering that IMA
> assumes, and so the only meaningful way to treat some of the use cases
> is simply to ignore them entirely. So we should still perform all the
> checks, but we will have to live with the limited utility of doing so
> in some scenarios (and not print nasty warnings to the kernel log for
> such cases)

You have convinced me that the warning shouldn't be emitted in either
the non IOMMU or in the IOMMU case, assuming the buffer has not been
DMA mapped.

The remaining concern is using the same buffer mapped to multiple
devices or re-using the same buffer to load multiple firmware blobs.
I'm not sure how easy that would be to detect.

I need to stage the rest of the patch set to be upstreamed. ?Could we
just add a comment in the code reflecting this discussion?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
