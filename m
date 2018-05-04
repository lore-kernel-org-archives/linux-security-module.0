From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 03 May 2018 20:24:26 -0400
Subject: [PATCH 3/6] firmware: differentiate between signed
	regulatory.db and other firmware
In-Reply-To: <20180504000743.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20180504000743.GR27853@wotan.suse.de>
Message-ID: <1525393466.3539.133.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-05-04 at 00:07 +0000, Luis R. Rodriguez wrote:
> On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> > Allow LSMs and IMA to differentiate between signed regulatory.db and
> > other firmware.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > ---
> >  drivers/base/firmware_loader/main.c | 5 +++++
> >  include/linux/fs.h                  | 1 +
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index eb34089e4299..d7cdf04a8681 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> >  			break;
> >  		}
> >  
> > +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> > +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> > +			id = READING_FIRMWARE_REGULATORY_DB;
> > +#endif
> 
> Whoa, no way.

There are two methods for the kernel to verify firmware signatures.
?If both are enabled, do we require both signatures or is one enough.
Assigning a different id for regdb signed firmware allows LSMs and IMA
to handle regdb files differently.

> 
> >  		fw_priv->size = 0;
> >  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
> >  						msize, id);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index dc16a73c3d38..d1153c2884b9 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
> >  	id(FIRMWARE, firmware)		\
> >  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> >  	id(FIRMWARE_FALLBACK, firmware)	\
> > +	id(FIRMWARE_REGULATORY_DB, firmware)	\
> 
> Why could IMA not appriase these files? They are part of the standard path.

The subsequent patch attempts to verify the IMA-appraisal signature,
but on failure it falls back to allowing regdb signatures. ?For
systems that only want to load firmware based on IMA-appraisal, then
regdb wouldn't be enabled.

Mimi

> 
> >  	id(MODULE, kernel-module)		\
> >  	id(KEXEC_IMAGE, kexec-image)		\
> >  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> > -- 
> > 2.7.5
> > 
> > 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
