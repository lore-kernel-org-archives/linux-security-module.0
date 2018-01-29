From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 29 Jan 2018 10:44:41 +0200
Subject: [PATCH 1/3] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94203771@hasmsx108.ger.corp.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
	<20180123125426.t6xjgrqcfbkmvkdl@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B94203771@hasmsx108.ger.corp.intel.com>
Message-ID: <20180129084441.6oc4m4jgbqzsfq3v@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 24, 2018 at 06:33:53PM +0000, Winkler, Tomas wrote:
> > > -	pm_runtime_put(dev);
> > > +	pm_runtime_put_sync(dev);
> > 
> > Change to put_sync is needed so that the idle handshake gets completed?
> 
> Right.

Since we seem to agree that your change to get rid of the use of PM
runtime should that be actually the first change in the patch set?

Or are you looking forward to get these backported to stable kernels?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
