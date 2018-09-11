From: jarkko.sakkinen@intel.com (Jarkko Sakkinen)
Date: Tue, 11 Sep 2018 17:31:09 +0300
Subject: [RFC 10/12] x86/pconfig: Program memory encryption keys on a
	system-wide basis
In-Reply-To: <20180911024657.GC1732@alison-desk.jf.intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<0947e4ad711e8b7c1f581a446e808f514620b49b.1536356108.git.alison.schofield@intel.com>
	<73c60d4f8a953476f1e29aaccbeb7f732c209190.camel@intel.com>
	<20180911024657.GC1732@alison-desk.jf.intel.com>
Message-ID: <20180911143108.GA9717@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 07:46:57PM -0700, Alison Schofield wrote:
> On Mon, Sep 10, 2018 at 11:24:20AM -0700, Sakkinen, Jarkko wrote:
> > On Fri, 2018-09-07 at 15:38 -0700, Alison Schofield wrote:
> > > The kernel manages the MKTME (Multi-Key Total Memory Encryption) Keys
> > > as a system wide single pool of keys. The hardware, however, manages
> > > the keys on a per physical package basis. Each physical package
> > > maintains a key table that all CPU's in that package share.
> > > 
> > > In order to maintain the consistent, system wide view that the kernel
> > > requires, program all physical packages during a key program request.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > Just kind of checking that are you talking about multiple cores in
> > a single package or really multiple packages?
> 
> System wide pool.
> System has multiple packages.  
> Packages have multiple CPU's.
> 
> The hardware KEY TABLE is per package. I need that per package KEY TABLE
> to be the same in every package across the system. So, I pick one 'lead'
> CPU in each package to program that packages KEY TABLE.
> 
> (BTW - I'm going to look into Kai's suggestion to move the system wide view
> of this key programming into the key service. Not sure if that's a go.)

Thanks. I think could be perhaps a fair addition to the documentation?

/Jarkko
