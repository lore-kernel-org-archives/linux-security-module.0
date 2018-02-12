From: rppt@linux.vnet.ibm.com (Mike Rapoport)
Date: Mon, 12 Feb 2018 14:53:47 +0200
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180212114310.GD20737@rapoport-lnx>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-5-igor.stoppa@huawei.com>
	<20180211123743.GC13931@rapoport-lnx>
	<e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
	<20180212114310.GD20737@rapoport-lnx>
Message-ID: <20180212125347.GE20737@rapoport-lnx>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Feb 12, 2018 at 01:43:11PM +0200, Mike Rapoport wrote:
> On Mon, Feb 12, 2018 at 01:26:28PM +0200, Igor Stoppa wrote:
> > On 11/02/18 14:37, Mike Rapoport wrote:
> > > On Sun, Feb 11, 2018 at 05:19:18AM +0200, Igor Stoppa wrote:
> > 
> > >> + * Return: 0 if the object does not belong to pmalloc, 1 if it belongs to
> > >> + * pmalloc, -1 if it partially overlaps pmalloc meory, but incorectly.
> > > 
> > > typo:                                            ^ memory
> > 
> > thanks :-(
> > 
> > [...]
> > 
> > >> +/**
> > >> + * When the sysfs is ready to receive registrations, connect all the
> > >> + * pools previously created. Also enable further pools to be connected
> > >> + * right away.
> > >> + */
> > > 
> > > This does not seem as kernel-doc comment. Please either remove the second *
> > > from the opening comment mark or reformat the comment.
> > 
> > For this too, I thought I had caught them all, but I was wrong ...
> > 
> > I didn't find any mention of automated checking for comments.
> > Is there such tool?
> 
> I don't know if there is a tool. I couldn't find anything in scripts, maybe
> somebody have such tool out of tree.
> 
> For now, I've added mm-api.rst that includes all mm .c files and run 'make
> htmldocs' which spits plenty of warnings and errors.

Actually, you can run 'scripts/kernel-doc -v -none <filename>' to check
comments starting with '/**'. I afraid it won't catch formatted blocks that
start with '/*'
 

-- 
Sincerely yours,
Mike.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
