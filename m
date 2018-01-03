From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 02 Jan 2018 21:52:03 -0500
Subject: [PATCHv6 1/1] ima: re-introduce own integrity cache lock
In-Reply-To: <20180103014048.GE5146@magnolia>
References: <c73e7421902a60bd14c11e1201ba74470d7c782b.1512500794.git.dmitry.kasatkin@huawei.com>
	<CACE9dm-ws8TKEAzFbCoGdhdEuFLoLtz8dAuF8tor19wMx1pH=g@mail.gmail.com>
	<20180103014048.GE5146@magnolia>
Message-ID: <1514947923.3493.2.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-01-02 at 17:40 -0800, Darrick J. Wong wrote:
> [might as well cc linux-xfs]
> 
> On Thu, Dec 14, 2017 at 12:22:37AM +0200, Dmitry Kasatkin wrote:
> > Hi,
> > 
> > Could I ask FS maintainers to test IMA with this patch additionally
> > and provide ack/tested.
> > We tested but may be you have and some special testing.
> 
> Super-late to this party, but unless xfstests has automated tests to
> set up IMA on top of an existing filesystem then I most likely have no
> idea /how/ to test IMA.  I did a quick grep of xfstests git and I don't
> see anything IMA-related.

Back in June I posted a simple xfstests IMA-appraisal test (https://ma
rc.info/?l=linux-fsdevel&m=149703820814885&w=4).

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
