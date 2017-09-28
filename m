From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 28 Sep 2017 10:33:23 -0400
Subject: [RFC PATCH 1/3] fs: define new read_iter rwf flag
In-Reply-To: <20170928135416.GA30859@bombadil.infradead.org>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928135416.GA30859@bombadil.infradead.org>
Message-ID: <1506609203.5022.1.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-09-28 at 06:54 -0700, Matthew Wilcox wrote:
> On Thu, Sep 28, 2017 at 08:39:31AM -0400, Mimi Zohar wrote:
> > Writing extended attributes requires exclusively taking the i_rwsem
> > lock.  To synchronize the file hash calculation and writing the file
> > hash as security.ima xattr, IMA-appraisal takes the i_rwsem lock
> > exclusively before calculating the file hash.  (Once the file hash
> > is calculated, the result is cached.  Taking the lock exclusively
> > prevents calculating the file hash multiple times.)
> > 
> > Some filesystems have recently replaced their filesystem dependent
> > lock with the global i_rwsem to read a file.  As a result, when IMA
> > attempts to calculate the file hash, reading the file attempts to
> > take the i_rwsem again.
> > 
> > To resolve this problem, this patch defines a new read_iter flag
> > named "rwf" to indicate that the i_rwsem has already been taken
> > exclusively.  Subsequent patches will set or test the "rwf" flag.
> 
> I don't like adding a bool parameter everywhere.

Me either!

> Why not add a flag
> to the kiocb ki_flags?
> 
> #define IOCB_RWSEM_HELD		(1 << 8)

Thank you for the suggestion.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
