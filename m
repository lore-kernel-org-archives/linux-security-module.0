From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 16 Jan 2018 06:35:34 -0500
Subject: [PATCH] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
In-Reply-To: <CADZs7q6y_d6E3wDmAtsFLZYRfbV+v6gctpJ+a6BtX_02bPrttQ@mail.gmail.com>
References: <20180115144804.GA28856@infradead.org>
	<20180116104121.4231-1-alban@kinvolk.io>
	<CADZs7q6y_d6E3wDmAtsFLZYRfbV+v6gctpJ+a6BtX_02bPrttQ@mail.gmail.com>
Message-ID: <1516102534.6607.103.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> >
> >         /*
> > -        * Reset the measure, appraise and audit cached flags either if
> > -        * ima_inode_setxattr was called or based on policy, forcing
> > -        * the file to be re-evaluated.
> > +        * Reset the measure, appraise and audit cached flags either if:
> > +        * - ima_inode_setxattr was called, or
> > +        * - based on policy ("force"), or
> > +        * - based on filesystem feature flag
> > +        * forcing the file to be re-evaluated.
> >          */
> 
> Now that I think about it, it's also possible to write this patch
> without basing it on Mimi's patch "ima: define a new policy option
> named force", which is not in next-integrity yet. Should I try that?

Yes, thank you. ?As you're proposing a new flag, please remember to Cc
the fsdevel mailing list as well.

Mimi

> 
> >         if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
> >                 iint->flags &= ~IMA_DONE_MASK;
> > -       } else if (action & IMA_FORCE) {
> > +       } else if (action & IMA_FORCE || inode->i_sb->s_type->fs_flags & FS_NO_IMA_CACHE) {
> >                 if (action & IMA_MEASURE) {
> >                         iint->measured_pcrs = 0;
> >                         iint->flags &=
> > --
> > 2.13.6
> >
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
