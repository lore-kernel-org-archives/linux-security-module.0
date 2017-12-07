From: jlayton@kernel.org (Jeff Layton)
Date: Thu, 07 Dec 2017 07:01:38 -0500
Subject: [PATCH] integrity: get rid of unneeded initializations in
	integrity_iint_cache entries
In-Reply-To: <1499370226.3130.36.camel@linux.vnet.ibm.com>
References: <20170706145421.13223-1-jlayton@kernel.org>
	<20170706150424.GA21489@mail.hallyn.com>
	<1499370226.3130.36.camel@linux.vnet.ibm.com>
Message-ID: <1512648098.1350.6.camel@kernel.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-07-06 at 15:43 -0400, Mimi Zohar wrote:
> On Thu, 2017-07-06 at 10:04 -0500, Serge E. Hallyn wrote:
> > Quoting Jeff Layton (jlayton at kernel.org):
> > > From: Jeff Layton <jlayton@redhat.com>
> > > 
> > > The init_once routine memsets the whole object to 0, and then
> > > explicitly sets some of the fields to 0 again. Just remove the explicit
> > > initializations.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > 
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> Thanks, queued.
> 
> Mimi
> 

Hi Mimi,

I notice that this patch hasn't made the last couple of releases. Was it
dropped for some reason?

Thanks,
Jeff

> > 
> > > ---
> > >  security/integrity/iint.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > > index 6fc888ca468e..187b7cb378be 100644
> > > --- a/security/integrity/iint.c
> > > +++ b/security/integrity/iint.c
> > > @@ -153,14 +153,11 @@ static void init_once(void *foo)
> > >  	struct integrity_iint_cache *iint = foo;
> > >  
> > >  	memset(iint, 0, sizeof(*iint));
> > > -	iint->version = 0;
> > > -	iint->flags = 0UL;
> > >  	iint->ima_file_status = INTEGRITY_UNKNOWN;
> > >  	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
> > >  	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
> > >  	iint->ima_read_status = INTEGRITY_UNKNOWN;
> > >  	iint->evm_status = INTEGRITY_UNKNOWN;
> > > -	iint->measured_pcrs = 0;
> > >  }
> > >  
> > >  static int __init integrity_iintcache_init(void)
> > > -- 
> > > 2.13.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
