From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 30 Jan 2018 17:28:08 +0200
Subject: [PATCH v2] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <alpine.LRH.2.21.1801302252020.20741@namei.org>
References: <20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
	<20171106022704.GD26011@ziepe.ca>
	<CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
	<20171107160404.GG21466@ziepe.ca>
	<20171114143421.3jxn6fzvgp2xmyk6@linux.intel.com>
	<20171117132853.cmr3wmsc3biedv7p@linux.intel.com>
	<20171117135758.wvx3w5phndvfmfsh@linux.intel.com>
	<CANc+2y4nALRpw9dY8PK8A56St4NONQoTLc8aHqxuV1RWg_PiCw@mail.gmail.com>
	<20180129220612.ifk7r4md5tynlvz4@linux.intel.com>
	<alpine.LRH.2.21.1801302252020.20741@namei.org>
Message-ID: <20180130152808.2egxs2ki657eyxe3@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 30, 2018 at 10:52:13PM +1100, James Morris wrote:
> On Tue, 30 Jan 2018, Jarkko Sakkinen wrote:
> 
> > On Sat, Jan 27, 2018 at 12:20:18PM +0530, PrasannaKumar Muralidharan wrote:
> > > Hi Jarkko,
> > > 
> > > On 17 November 2017 at 19:27, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > On Fri, Nov 17, 2017 at 03:28:53PM +0200, Jarkko Sakkinen wrote:
> > > >
> > > > At least signed-off-by from PrassanaKumar is missing from the 2nd
> > > > commit. I'll add it.
> > > 
> > > I had the impression that my signed-off-by will be present in this
> > > change. But it is missing in [1]. Is it supposed to be that way?
> > > 
> > > 1. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6e592a065d51d26f9d62b8b7501a5114076af8b4
> > > 
> > > Thanks,
> > > PrasannaKumar
> > 
> > Yes, it would be senseful.
> > 
> > James, would it still be possible to amend this tag to security tree?
> 
> Nope, it's been pushed to Linus.

Damn. Well, good that Tested-by is there. I'm sorry about this.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
