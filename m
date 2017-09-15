From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Sep 2017 11:21:21 -0400
Subject: [PATCH 3/3] ima: use fs method to read integrity data
In-Reply-To: <20170915144903.GA3854@infradead.org>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<CA+55aFwVujvsdaq09O216u-uBbBbo5i_1d6aw3ksottR_uiJ6w@mail.gmail.com>
	<20170915144903.GA3854@infradead.org>
Message-ID: <1505488881.4200.96.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-09-15 at 07:49 -0700, Christoph Hellwig wrote:
> On Thu, Sep 14, 2017 at 10:50:27PM -0700, Linus Torvalds wrote:
> > This is still wrong.
> > 
> > (a) there is no explanation for why we need that exclusive lock in the
> > first place
> > 
> > Why should a read need exclusive access? You'd think shared is sufficient.
> > But regardless, it needs *explanation*.
> 
> Shared is sufficient, and nothing in the patch (except for the
> description) actually requires an exclusive lock.  It just happens that
> ima holds it exclusive for other internal reasons.

Although reading the file to calculate the file hash doesn't require
taking the lock exclusively, in either "fix" mode or called from
__fput, immediately after calculating the file hash, the file hash is
written out as an xattr. ?Writing the xattr requires taking the lock
exclusively.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
