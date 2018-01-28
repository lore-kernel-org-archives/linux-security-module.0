From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Sun, 28 Jan 2018 21:17:53 +0000
Subject: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180128201559.GG23869@ziepe.ca>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
	<20180128075101.6883-2-tomas.winkler@intel.com>
	<20180128201559.GG23869@ziepe.ca>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> 
> On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:
> 
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index
> > bcdd3790e94d..06639fb6ab85 100644
> > +++ b/include/linux/tpm.h
> > @@ -44,7 +44,7 @@ struct tpm_class_ops {
> >  	bool (*update_timeouts)(struct tpm_chip *chip,
> >  				unsigned long *timeout_cap);
> >  	int (*request_locality)(struct tpm_chip *chip, int loc);
> > -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
> 
> This seems wrong.. What is the core code supposed to do if relinquish fails?

Not much just propage the error to the caller and leave the policy decision to it.

> Just returning an error code from transmit doesn't really do anything helpful
> from a broad subsytem perspective.

Yes, you are right, but I'm not sure even if the subsystem is broad enough to understand
the system setup,  or in another direction specific enough to behave upon hw limitations. 
> 
> I think if a driver can fail reliquish then it needs some kind of strategy to
> recover.
Maybe some driver can and some not, but if it doesn't succeed it should return an error.
> 
> Suggest trying the reliquish again on every next request until success,
> otherwise fail request locality, potentially permanently.

This is something I rather prevent because it leaves the HW in kind of undefined state 
( and we should probably work on that a bit more later).
As far as I've debugged the flow now, the driver just fails, and the error goes up 
user space caller or the internal flow is stopped.
A user can reboot the system or whatever it helps in his/her particular setup.

Make sense?

Anyhow I will dig to it more how fatal is that relinquish failure. 

Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
