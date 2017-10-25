From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 25 Oct 2017 13:18:17 -0400
Subject: [PATCH v3 2/2] ima: check signature enforcement against cmdline
	param instead of CONFIG
In-Reply-To: <20171025150544.GC26762@glitch>
References: <cover.1508865786.git.brdeoliv@redhat.com>
	<b1bab0d1184f11c06ba0484883c22bc046ffb5a6.1508865786.git.brdeoliv@redhat.com>
	<1508885697.3164.5.camel@linux.vnet.ibm.com>
	<20171025150544.GC26762@glitch>
Message-ID: <1508951897.7367.16.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-10-25 at 13:05 -0200, Bruno E. O. Meneguele wrote:
> On 24-10, Mimi Zohar wrote:
> > On Tue, 2017-10-24 at 15:37 -0200, Bruno E. O. Meneguele wrote:
> > > When the user requests MODULE_CHECK policy and its kernel is compiled
> > > with CONFIG_MODULE_SIG_FORCE not set, all modules would not load, just
> > > those loaded in initram time. One option the user would have would be
> > > set a kernel cmdline param (module.sig_enforce) to true, but the IMA
> > > module check code doesn't rely on this value, it checks just
> > > CONFIG_MODULE_SIG_FORCE.
> > > 
> > > This patch solves this problem checking for the exported value of
> > > module.sig_enforce cmdline param intead of CONFIG_MODULE_SIG_FORCE,
> > > which holds the effective value (CONFIG || param).
> > > 
> > > Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
> > > ---
> > >  security/integrity/ima/ima_main.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > index e4ab8ef8016e..d11a7fcc5c8b 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -356,12 +356,12 @@ void ima_post_path_mknod(struct dentry *dentry)
> > >   */
> > >  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> > >  {
> > > +	bool sig_enforce = is_module_sig_enforced();
> > > +
> > >  	if (!file && read_id == READING_MODULE) {
> > 
> > The only reason for getting here is that you're using the old module
> > load syscall. ?Is there a reason for not using the new one, which
> > passes the file descriptor?

> Basicaly because the way kmod handles compressed (gz/xz) modules. The
> way it's today would require major changes in the code or some kind of
> memfd_create() + xattrs reassignement in order to finit_module() be used
> correctly.
> 
> Considering it would take some time to be accepted or even to figure out
> the correct way to tackle it, the current IMA module check code works
> aside kernel module signature validation, which is fine for now for me,
> but has the problem that this patch tries to solve in the
> CONFIG_MODULE_SIG_FORCE check (ignoring module.sig_enforce cmdline
> param).

Thank you for the reasoning. ?BTW, these patches are now queued.


> > > -#ifndef CONFIG_MODULE_SIG_FORCE
> > > -		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
> > > +		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> > >  		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> > >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > > -#endif
> > >  		return 0;	/* We rely on module signature checking */
> > >  	}
> > >  	return 0;
> > 
> > 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
