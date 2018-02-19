From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Mon, 19 Feb 2018 11:43:19 +0000
Subject: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
	<20180214134319.4400-2-tomas.winkler@intel.com>
	<20180219112700.yfoywzegqzrpynlk@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B942240B1@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Wed, Feb 14, 2018 at 03:43:18PM +0200, Tomas Winkler wrote:
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip->locality);
> > +		/* this coud be on error path, don't override error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);
> 
> All local variable declarations must be in the beginning of the function.

Who says?


> 
> > +
> > +		if (l_rc) {
> > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> %d\n",
> > +				__func__, l_rc);
> > +			rc = l_rc;
> > +		}
> 
> Your comment about not overriding error code is incorrect. 

Please explain? 

> The value of 'rc' should be never overridden, which kind of supports to "just
> print" behavior that we had for a locality error.

You are not consistent, you've agreed with propagating it to user space. 
The error will  be propagated in case of an error in locality relinquish
the device is pretty much in non functional state and provious errors do not matter much,
but rc value won't be modified if locality_reliquish succeeds.

> Is your fix somehow dependent on changing relinquish_locality() behavior? If
> not, please remove this change. If you want to contribute such behavioral
> change, you should make a separate patch of it.

The issue is structural, this is required just because the relinquish locality  is inside the error path handling.

> Now it's like a trojan horse bundled inside a bug fix.

Not sure I understand your methaphore. 
Please review again.

Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
