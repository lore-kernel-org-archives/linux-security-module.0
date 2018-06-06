From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 6 Jun 2018 22:32:57 +0200
Subject: Do Qualcomm drivers use DMA buffers for request_firmware_into_buf()?
In-Reply-To: <20180601192346.GQ4511@wotan.suse.de>
References: <20180408174014.21908-3-hdegoede@redhat.com>
	<20180423211143.GZ14440@wotan.suse.de>
	<71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
	<1524586021.3364.20.camel@linux.vnet.ibm.com>
	<20180424234219.GX14440@wotan.suse.de>
	<1524632409.3371.48.camel@linux.vnet.ibm.com>
	<20180425175557.GY14440@wotan.suse.de>
	<CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
	<20180508153805.GC27853@wotan.suse.de>
	<20180601192346.GQ4511@wotan.suse.de>
Message-ID: <20180606203257.GH4511@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 01, 2018 at 09:23:46PM +0200, Luis R. Rodriguez wrote:
> On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> > On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > > 
> > > I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> > > cc'd here) are better suited to answer that question.
> > 
> > Andy, David, Bjorn?
> 
> Andy, David, Bjorn?

A month now with no answer...

Perhaps someone who has this hardware can find out empirically for us, as
follows (mm folks is this right?):

page = virt_to_page(address);
if (!page)
   fail closed...
if (page_zone(page) == ZONE_DMA || page_zone(page) == ZONE_DMA32)
	this is a DMA buffer
else
	not DMA!

Note that when request_firmware_into_buf() was being reviewed Mimi had asked back
in 2016 [0] that if a DMA buffer was going to be used READING_FIRMWARE_DMA should be
used otherwise READING_FIRMWARE_PREALLOC_BUFFER was fine.

If it is a DMA buffer *now*, why / how did this change?

[0] https://patchwork.kernel.org/patch/9074611/

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
