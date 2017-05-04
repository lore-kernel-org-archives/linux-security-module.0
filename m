From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 4 May 2017 12:17:38 +0300
Subject: [PATCH v2 3/3] tpm: vtpm_proxy: Add ioctl to request locality
	prepended to command
In-Reply-To: <40cd7d48-f6d1-39f4-99a3-916c7cdbb636@linux.vnet.ibm.com>
References: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1493384538-27883-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170503223747.zefh76m4youqlgje@intel.com>
	<40cd7d48-f6d1-39f4-99a3-916c7cdbb636@linux.vnet.ibm.com>
Message-ID: <20170504091738.rxl77hjzf6vnpuda@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 03, 2017 at 07:40:48PM -0400, Stefan Berger wrote:
> On 05/03/2017 06:37 PM, Jarkko Sakkinen wrote:
> > On Fri, Apr 28, 2017 at 09:02:18AM -0400, Stefan Berger wrote:
> > > Add an ioctl to request that the locality be prepended to every TPM
> > > command.
> > Don't really understand this change. Why locality is prenpended?
> 
> Commands can be executed under locality 0-3 and for some commands it is
> important to know which locality a user may have chosen. How else should we
> convey that locality to the TPM emulator ?

Why this is not in the commit message?

More scalable way to do this would be to have a set of vtpm proxy
commands. There could be a command for requesting and releasing
locality. That would be more clean.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
