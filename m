From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 07 Dec 2017 09:35:47 -0500
Subject: [PATCH] integrity: get rid of unneeded initializations in
	integrity_iint_cache entries
In-Reply-To: <1512648098.1350.6.camel@kernel.org>
References: <20170706145421.13223-1-jlayton@kernel.org>
	<20170706150424.GA21489@mail.hallyn.com>
	<1499370226.3130.36.camel@linux.vnet.ibm.com>
	<1512648098.1350.6.camel@kernel.org>
Message-ID: <1512657347.3527.48.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-12-07 at 07:01 -0500, Jeff Layton wrote:
> On Thu, 2017-07-06 at 15:43 -0400, Mimi Zohar wrote:
> > On Thu, 2017-07-06 at 10:04 -0500, Serge E. Hallyn wrote:
> > > Quoting Jeff Layton (jlayton at kernel.org):
> > > > From: Jeff Layton <jlayton@redhat.com>
> > > > 
> > > > The init_once routine memsets the whole object to 0, and then
> > > > explicitly sets some of the fields to 0 again. Just remove the explicit
> > > > initializations.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > 
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > 
> > Thanks, queued.
> > 
> > Mimi
> > 
> 
> Hi Mimi,
> 
> I notice that this patch hasn't made the last couple of releases. Was it
> dropped for some reason?

Thanks for the reminder. ?I accidentally dropped it (and Sascha
Hauer's patch). ?The subject line is too long. ?Assuming you don't
object, I'll replace the "get rid of" with "removed" and queue the
patch in the next-queued-testing branch.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
