From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 7 Apr 2018 13:36:10 +0300
Subject: [PATCH] tpm: moves the delay_msec increment after sleep in
	tpm_transmit()
In-Reply-To: <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
	<20180405101210.GA21636@linux.intel.com>
	<95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
Message-ID: <20180407103610.GA22542@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 06, 2018 at 02:03:37PM +0530, Nayna Jain wrote:
> On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> > On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> > > Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> > > handle the TPM2_RC_RETRY error. The loop retries the command after
> > > sleeping for the specified time, which is incremented exponentially in
> > > every iteration. This patch fixes the initial sleep to be the default
> > > sleep time.
> > I think I understand the code change but do not understand what the
> > long description.
> 
> It tells that the first sleep is delay_msec * 2 and not delay_msec.

So the problem is that the loop doubles the time before sleeping
for the first time. This is missing from the description. Please
refine it in some way.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
