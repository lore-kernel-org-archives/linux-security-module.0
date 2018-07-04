From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 4 Jul 2018 16:52:35 +0300
Subject: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
	shutdown
In-Reply-To: <1530644783.3142.37.camel@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
	<20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
	<edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
	<1530631615.3142.6.camel@linux.vnet.ibm.com>
	<20180703165102.GB19800@linux.intel.com>
	<alpine.LRH.2.21.1807040450340.32123@namei.org>
	<1530644783.3142.37.camel@linux.vnet.ibm.com>
Message-ID: <20180704135235.GA6724@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 03, 2018 at 12:06:23PM -0700, James Bottomley wrote:
> On Wed, 2018-07-04 at 04:51 +1000, James Morris wrote:
> > On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> > 
> > > On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> > > 
> > > OK, I was not sure how that discussion went. I could add myself as
> > > co-maintainer to MAINTAINERS because I anyway need to go through
> > > all of these.
> > > 
> > > If anyone does not vote against, I'll send a patch.
> > > 
> > 
> > For Keys???That would would be useful to help reduce the workload on?
> > David.
> 
> Well, no, this was for trusted keys, which is the part of the key
> infrastructure that goes via the TPM: The KEYS-TRUSTED part in the
> MAINTAINERs file.  There's still KEYS-ENCRYPTED, KEYS/KEYRING and
> ASYMETRIC KEYS, which don't use the TPM.
> 
> However, I've no objection to consolidating the lot under a larger set
> of maintainers ... I recently agreed to look at the asymmetric key TPM
> patch because it's my area, but it also strays over into crypto,
> keyring and asymmetric keys.

Should 2/2 be rolled through my tree? 1/2 is a tpm patch.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
