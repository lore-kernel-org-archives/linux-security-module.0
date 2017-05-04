From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 4 May 2017 12:18:27 +0300
Subject: [PATCH v2 0/3] Extend the vTPM proxy driver to pass locality to
	emulator
In-Reply-To: <72bacff5-5213-b114-ebf4-6e3fe7284bdc@linux.vnet.ibm.com>
References: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170503223849.qcoc6xqncbyi6jwj@intel.com>
	<72bacff5-5213-b114-ebf4-6e3fe7284bdc@linux.vnet.ibm.com>
Message-ID: <20170504091827.6yzmttjf2kxeen4l@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 03, 2017 at 07:42:06PM -0400, Stefan Berger wrote:
> On 05/03/2017 06:38 PM, Jarkko Sakkinen wrote:
> > On Fri, Apr 28, 2017 at 09:02:15AM -0400, Stefan Berger wrote:
> > > The purpose of this series of patches is to enable the passing of the locality
> > > a command is executing in to a TPM emulator. To enable this we introduce a new
> > > flag for the device creation ioctl that requests that the locality be prepended
> > > to every command. For applications to check which flags the driver supports, we
> > > add a new ioctl that returns a bitmask of supported flags.
> > This is a weird change proposal as you could use tpm_vtpm_proxy for
> > other than some TPM emulator.
> 
> I think in most cases the recipient of the TPM commands from the vtpm_proxy
> driver will be a TPM emulator. What do you have in mind?

Like using Intel SGX to implement TPM in ring-3. I've thought
vtpm_tpm_proxy as generic proxy that you can also use for emulators.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
