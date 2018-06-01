From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 01 Jun 2018 19:04:45 -0400
Subject: [PATCH v4 5/8] ima: based on policy require signed firmware
	(sysfs fallback)
In-Reply-To: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
	<20180601182107.GO4511@wotan.suse.de>
	<1527892795.13403.26.camel@linux.vnet.ibm.com>
	<20180601224617.GU4511@wotan.suse.de>
Message-ID: <1527894285.13403.43.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-06-02 at 00:46 +0200, Luis R. Rodriguez wrote:
> On Fri, Jun 01, 2018 at 06:39:55PM -0400, Mimi Zohar wrote:
> > On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> > > On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > > > Luis, is the security_kernel_post_read_file LSM hook in
> > > > firmware_loading_store() still needed after this patch?  Should it be
> > > > calling security_kernel_load_data() instead?
> > > 
> > > That's up to Kees to decide as he added that hook, and knows
> > > what LSMs may be doing with it. From my perspective it is confusing
> > > to have that hook there so I think it could be removed now.
> > > 
> > > Kees?
> > 
> > Commit?6593d92 ("firmware_class: perform new LSM checks") references
> > two methods of loading firmware -??filesystem-found firmware and
> > demand-loaded blobs. ?I assume this call in firmware_loading_store()
> > is the demand-loaded blobs. ?Does that method still exist? ?Is it
> > still being used?
> 
> Yeah its the stupid sysfs interface. So likely loadpin needs porting
> as you IMA as you did.

In this case, it doesn't look like the call to
security_kernel_post_read_file() should be changed, which means that
all the LSMs and IMA still need to support !file.
?
Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
