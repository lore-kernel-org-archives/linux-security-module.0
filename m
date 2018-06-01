From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 01 Jun 2018 18:39:55 -0400
Subject: [PATCH v4 5/8] ima: based on policy require signed firmware
	(sysfs fallback)
In-Reply-To: <20180601182107.GO4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
	<20180601182107.GO4511@wotan.suse.de>
Message-ID: <1527892795.13403.26.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > Luis, is the security_kernel_post_read_file LSM hook in
> > firmware_loading_store() still needed after this patch?  Should it be
> > calling security_kernel_load_data() instead?
> 
> That's up to Kees to decide as he added that hook, and knows
> what LSMs may be doing with it. From my perspective it is confusing
> to have that hook there so I think it could be removed now.
> 
> Kees?

Commit?6593d92 ("firmware_class: perform new LSM checks") references
two methods of loading firmware -??filesystem-found firmware and
demand-loaded blobs. ?I assume this call in firmware_loading_store()
is the demand-loaded blobs. ?Does that method still exist? ?Is it
still being used?

> 
>   Luis
> 
> > 
> > ---
> > 
> > With an IMA policy requiring signed firmware, this patch prevents
> > the sysfs fallback method of loading firmware.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Matthew Garrett <mjg59@google.com>
> > ---
> >  security/integrity/ima/ima_main.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index a565d46084c2..4a87f78098c8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >  
> >  	if (!file && read_id == READING_FIRMWARE) {
> >  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> > -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> > +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > +			pr_err("Prevent firmware loading_store.\n");
> >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > +		}
> >  		return 0;
> >  	}
> >  
> > @@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
> >  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
> >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> >  		}
> > +		break;
> > +	case LOADING_FIRMWARE:
> > +		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> > +			pr_err("Prevent firmware sysfs fallback loading.\n");
> > +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > +		}
> >  	default:
> >  		break;
> >  	}
> > -- 
> > 2.7.5
> > 
> > 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
