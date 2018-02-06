From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 6 Feb 2018 22:02:55 +0200
Subject: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
	<20180128075101.6883-2-tomas.winkler@intel.com>
	<20180128201559.GG23869@ziepe.ca>
	<5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
Message-ID: <20180206200255.ib7hblberqj6anh5@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 28, 2018 at 09:17:53PM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:
> > 
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index
> > > bcdd3790e94d..06639fb6ab85 100644
> > > +++ b/include/linux/tpm.h
> > > @@ -44,7 +44,7 @@ struct tpm_class_ops {
> > >  	bool (*update_timeouts)(struct tpm_chip *chip,
> > >  				unsigned long *timeout_cap);
> > >  	int (*request_locality)(struct tpm_chip *chip, int loc);
> > > -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > > +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > 
> > This seems wrong.. What is the core code supposed to do if relinquish fails?
> 
> Not much just propage the error to the caller and leave the policy
> decision to it.

Your patch set must either cover this or keep it as void.

A better idea is to print an error to klog.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
