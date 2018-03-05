From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Mon, 5 Mar 2018 18:04:56 +0000
Subject: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180305175912.GD5791@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180305125642.GA3425@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
	<20180305175912.GD5791@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E568@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > enum tpm_duration {
> > > 	TPM_DURATION_DEFAULT = 2000,
> > > 	TPM_DURATION_LONG = 300000,
> > > };
> > >
> > How is this aligned with the spec PTP spec?
> 
> For TPM 2.0 that spec only partially defines durations for CCs and thus our
> look up table is already kind "flakky". In a sense that the default duration is
> upper limit for spec defined durations.

The timeouts for LONG and MEDIUM is defined by the  PTP spec,  we need to maintain those as those effect the system.
The UNDEFINED and LONG LONG is the implementation choice we driver from empirical data we have so far.

> 
> > > These would be both for TPM 1.2 and TPM 2.0. Instead of having table
> > > for every ordinal there should be a small tables describing commands
> > > that require long timeout.
> >
> > Yeah I didn't cover the 1.2.
> 
> I could probably help with TPM 1.2 changes if required.

In middle of it, will send for review in few.

Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
