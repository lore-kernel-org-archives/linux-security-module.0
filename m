From: david@fromorbit.com (Dave Chinner)
Date: Mon, 2 Oct 2017 14:54:19 +1100
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFwV=mO4NjJ2nqOsme7Pg_Lno7hPO6o+ahf-qSpunm9scA@mail.gmail.com>
References: <1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	<1506859691.5691.211.camel@linux.vnet.ibm.com>
	<CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
	<20171001223402.GG15067@dastard>
	<CA+55aFwV=mO4NjJ2nqOsme7Pg_Lno7hPO6o+ahf-qSpunm9scA@mail.gmail.com>
Message-ID: <20171002035419.GH15067@dastard>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 01, 2017 at 04:15:07PM -0700, Linus Torvalds wrote:
> On Sun, Oct 1, 2017 at 3:34 PM, Dave Chinner <david@fromorbit.com> wrote:
> >
> > We already have a change counter on the inode, which is modified on
> > any data or metadata write (i_version) under filesystem locks.  The
> > i_version counter has well defined semantics - it's required by
> > NFSv4 to increment on any metadata or data change - so we should be
> > able to rely on it's behaviour to implement IMA as well.
> 
> I actually think i_version has exactly the wrong semantics.
> 
> Afaik, it doesn't actually version the file _data_ at all, it only
> versions "inode itself changed".

No, the NFSv4 change attribute must change if either data or
metadata on the inode is changed, and be consistent and persistent
across server crashes. For data updates, they piggy back on mtime
updates ....

> But I might have missed something obvious. The updates are hidden in
> some odd places sometimes.

... which are in file_update_time().

Hence every data write or write page fault will call
file_update_time() and trigger an i_version increment, even if the
mtime doesn't change.

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
