From: jejb@linux.vnet.ibm.com (James Bottomley)
Date: Tue, 03 Jul 2018 12:06:23 -0700
Subject: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until
	module shutdown
In-Reply-To: <alpine.LRH.2.21.1807040450340.32123@namei.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
	<20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
	<edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
	<1530631615.3142.6.camel@linux.vnet.ibm.com>
	<20180703165102.GB19800@linux.intel.com>
	<alpine.LRH.2.21.1807040450340.32123@namei.org>
Message-ID: <1530644783.3142.37.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-07-04 at 04:51 +1000, James Morris wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> > On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> > 
> > OK, I was not sure how that discussion went. I could add myself as
> > co-maintainer to MAINTAINERS because I anyway need to go through
> > all of these.
> > 
> > If anyone does not vote against, I'll send a patch.
> > 
> 
> For Keys???That would would be useful to help reduce the workload on?
> David.

Well, no, this was for trusted keys, which is the part of the key
infrastructure that goes via the TPM: The KEYS-TRUSTED part in the
MAINTAINERs file.  There's still KEYS-ENCRYPTED, KEYS/KEYRING and
ASYMETRIC KEYS, which don't use the TPM.

However, I've no objection to consolidating the lot under a larger set
of maintainers ... I recently agreed to look at the asymmetric key TPM
patch because it's my area, but it also strays over into crypto,
keyring and asymmetric keys.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
