From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 8 May 2018 15:38:05 +0000
Subject: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
In-Reply-To: <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
References: <20180408174014.21908-1-hdegoede@redhat.com>
	<20180408174014.21908-3-hdegoede@redhat.com>
	<20180423211143.GZ14440@wotan.suse.de>
	<71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
	<1524586021.3364.20.camel@linux.vnet.ibm.com>
	<20180424234219.GX14440@wotan.suse.de>
	<1524632409.3371.48.camel@linux.vnet.ibm.com>
	<20180425175557.GY14440@wotan.suse.de>
	<CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
Message-ID: <20180508153805.GC27853@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Android became the primary user of CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> >
> > It would be good for us to hear from Android folks if their current use of
> > request_firmware_into_buf() is designed in practice to *never* use the direct
> > filesystem firmware loading interface, and always rely instead on the
> > fallback mechanism.
> 
> It's hard to answer this question for Android in general. As far as I
> can tell the reasons we use CONFIG_FW_LOADER_USER_HELPER(_FALLBACK)
> are:
> 1) We have multiple different paths on our devices where firmware can
> be located, and the direct loader only supports one custom path
> 2) Most of those paths are not mounted by the time the corresponding
> drivers are loaded, because pretty much all Android kernels today are
> built without module support, and therefore drivers are loaded well
> before the firmware partition is mounted
> 3) I think we use _FALLBACK because doing this with uevents is just
> the easiest thing to do; our init code has a firmware helper that
> deals with this and searches the paths that we care about
> 
> 2) will change at some point, because Android is moving towards a
> model where device-specific peripheral drivers will be loaded as
> modules, and since those modules would likely come from the same
> partition as the firmware, it's possible that the direct load would
> succeed (depending on whether the custom path is configured there or
> not). But I don't think we can rely on the direct loader even in those
> cases, unless we could configure it with multiple custom paths.
> 
> I have no reason to believe request_firmware_into_buf() is special in
> this regard; drivers that depend on it may have their corresponding
> firmware in different locations, so just depending on the direct
> loader would not be good enough.

Thanks! This is very useful! This provides yet-another justification and use
case to document for the fallback mechanism. I'll go and extend it.

> >
> > Is ptr below
> >
> >         ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> >                                         ptr, phdr->p_filesz);
> >
> > Also part of the DMA buffer allocated earlier via:
> >
> >         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
> >
> > Android folks?
> 
> I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> cc'd here) are better suited to answer that question.

Andy, David, Bjorn?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
