From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 10 Aug 2018 21:43:31 +0300
Subject: [PATCH v4 1/2] tpm: add ptr to the tpm_space struct to file_priv
In-Reply-To: <2bacb3d8-3897-e147-252f-c49de9e7806b@intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
	<153367366462.18015.12915462188877575543.stgit@tstruk-mobl1.jf.intel.com>
	<20180810172700.GU4692@linux.intel.com>
	<2bacb3d8-3897-e147-252f-c49de9e7806b@intel.com>
Message-ID: <20180810184331.GA5294@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 10, 2018 at 11:05:17AM -0700, Tadeusz Struk wrote:
> On 08/10/2018 10:27 AM, Jarkko Sakkinen wrote:
> > On Tue, Aug 07, 2018 at 01:27:44PM -0700, Tadeusz Struk wrote:
> >> Add a ptr to struct tpm_space to the file_priv to have an easy
> >> access to it in the async job without the need to allocate memory.
> >> This also allows to consolidate of the write operations for
> >> the two interfaces.
> > 
> > I think the 2nd premise should be the priority and the first premise should
> > be removed as it is not needed in any possible way to justify the
> > change.
> 
> Jarkko,
> The main reason why the pointer to tpm_space struct was added to the
> file_priv was to have access to space in the async job when it is enqueued
> via the /dev/tpm<N> interface. Currently it is only available in tpmrm_priv.
> Otherwise I would need to introduce yet another struct what would consist of
> a ptr file_priv and a ptr to tpm_space and allocate it on every enqueue.
> Much easier was to to it this way. The consolidation was only a side effect
> of this so I think the description is correct.
> Thanks,
> -- 
> Tadeusz

The less dependencies a commit has more easy it is for me pick up. Here
the consodilation is enough to accept the commit but with the current
commit message I cannot apply it without accepting the whole patch set.

/Jarkko
