From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 02 Jan 2018 23:03:16 -0500
Subject: [PATCHv6 1/1] ima: re-introduce own integrity cache lock
In-Reply-To: <20180103031621.GK5858@dastard>
References: <c73e7421902a60bd14c11e1201ba74470d7c782b.1512500794.git.dmitry.kasatkin@huawei.com>
	<CACE9dm-ws8TKEAzFbCoGdhdEuFLoLtz8dAuF8tor19wMx1pH=g@mail.gmail.com>
	<20180103014048.GE5146@magnolia>
	<1514947923.3493.2.camel@linux.vnet.ibm.com>
	<20180103031621.GK5858@dastard>
Message-ID: <1514952196.3493.57.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-01-03 at 14:16 +1100, Dave Chinner wrote:
> On Tue, Jan 02, 2018 at 09:52:03PM -0500, Mimi Zohar wrote:
> > On Tue, 2018-01-02 at 17:40 -0800, Darrick J. Wong wrote:
> > > [might as well cc linux-xfs]
> > > 
> > > On Thu, Dec 14, 2017 at 12:22:37AM +0200, Dmitry Kasatkin wrote:
> > > > Hi,
> > > > 
> > > > Could I ask FS maintainers to test IMA with this patch additionally
> > > > and provide ack/tested.
> > > > We tested but may be you have and some special testing.
> > > 
> > > Super-late to this party, but unless xfstests has automated tests to
> > > set up IMA on top of an existing filesystem then I most likely have no
> > > idea /how/ to test IMA.  I did a quick grep of xfstests git and I don't
> > > see anything IMA-related.
> > 
> > Back in June I posted a simple xfstests IMA-appraisal test (https://ma
> > rc.info/?l=linux-fsdevel&m=149703820814885&w=4).
> 
> That's a really, really basic test and it doesn't exercise the
> problematic direct IO path this patch fixes problems with. nor does
> it exercise the chmod path, or try to trigger deadlocks or other
> conditions through all the other paths that can trigger IMA actions
> and or failures (e.g. ENOSPC).  IOWs, we need a lot more than a
> "hello world" test to be able to verify filesystems interact with
> IMA properly. e.g. how does it behave at ENOSPC?

True, but for now we were looking for some basic testing - opening a
file and calculating the file hash - on different filesystems, not the
direct-IO path in particular. ?Expanding the IMA-appraisal xfstests is
high on my "todo" list.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
