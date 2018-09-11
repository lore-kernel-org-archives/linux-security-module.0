From: alison.schofield@intel.com (Alison Schofield)
Date: Mon, 10 Sep 2018 19:39:31 -0700
Subject: [RFC 08/12] mm: Track VMA's in use for each memory encryption
	keyid
In-Reply-To: <781e142c17199a6ab44bf0b5fbf07190093fe5dc.camel@linux.intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<3c891d076a376c8cff04403e90d04cf98b203960.1536356108.git.alison.schofield@intel.com>
	<781e142c17199a6ab44bf0b5fbf07190093fe5dc.camel@linux.intel.com>
Message-ID: <20180911023931.GB1732@alison-desk.jf.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 09:20:45PM +0300, Jarkko Sakkinen wrote:
> On Fri, 2018-09-07 at 15:37 -0700, Alison Schofield wrote:
> > Keep track of the VMA's oustanding for each memory encryption keyid.
> > The count is used by the MKTME (Multi-Key Total Memory Encryption)
> > Key Service to determine when it is safe to reprogram a hardware
> > encryption key.
> 
> Maybe a stupid question but why they are tracked and what do you 
> mean by tracking?
> 
> /Jarkko

Perhaps 'Keep a count of' instead of 'Keep track of' will be clearer.

Counting VMA's using each keyid prevents in use keys from being cleared
and reused. The counting is done here, and the mtkme key service checks
these counts to decide if it is OK to allow a userspace key to be revoked.
A successful userspace key revoke will clear the hardware keyid slot and
leave the key available to be reprogrammed.

> 
> > Approach here is to do gets and puts on the encryption reference
> > wherever kmem_cache_alloc/free's of vma_area_cachep's are executed.
> > A couple of these locations will not be hit until cgroup support is
> > added. One of these locations should never hit, so use a VM_WARN_ON.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  arch/x86/mm/mktme.c |  2 ++
> >  kernel/fork.c       |  2 ++
> >  mm/mmap.c           | 12 ++++++++++++
> >  mm/nommu.c          |  4 ++++
> >  4 files changed, 20 insertions(+)
> > 

.... snip ....
