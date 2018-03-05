From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 12:56:33 +0200
Subject: [PATCH 2/3] tpm: reduce poll sleep time between send() and
	recv() in tpm_transmit()
In-Reply-To: <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
	<20180228191828.20056-2-nayna@linux.vnet.ibm.com>
	<20180301092222.GC29420@linux.intel.com>
	<6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
Message-ID: <20180305105633.GE25377@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 02, 2018 at 12:26:35AM +0530, Nayna Jain wrote:
> 
> 
> On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> > On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> > > In tpm_transmit, after send(), the code checks for status in a loop
> > Maybe cutting hairs now but please just use the actual function name
> > instead of send(). Just makes the commit log more useful asset.
> Sure, will do.
> > 
> > > -		tpm_msleep(TPM_TIMEOUT);
> > > +		tpm_msleep(TPM_TIMEOUT_POLL);
> > What about just calling schedule()?
> I'm not sure what you mean by "schedule()".? Are you suggesting instead of
> using usleep_range(),? using something with an even finer grain construct?
> 
> Thanks & Regards,
> ???? - Nayna

kernel/sched/core.c

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
