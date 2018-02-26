From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Mon, 26 Feb 2018 13:59:42 +0000
Subject: [PATCH 1/2 v5] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <1519646980.12825.4.camel@linux.intel.com>
References: <20180225120049.29308-1-tomas.winkler@intel.com>
	<1519646980.12825.4.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94229743@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> 
> On Sun, 2018-02-25 at 14:00 +0200, Tomas Winkler wrote:
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip->locality);
> > +		/* this coud be on error path, don't override error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip, chip-
> > >locality);
> > +
> > +		if (l_rc)
> > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> > %d\n",
> > +				__func__, l_rc);
> > +
> >  		chip->locality = -1;
> >  	}
> 
> The 'l_rc' declaration causes NAK as I've stated before.

I will provide a sixth version that let us both down the tree

> 
> Why don't you just make a helper function:
> 
> static void tpm_relinquish_locality(struct tpm_chip *chip) {
> 	int rc;
> 
> 	if (!chip->ops->relinquish_locality)
> 		return 0;
> 
> 	rc = chip->ops->relinquish_locality(chip);
> 	if (rc)
> 		dev_err(&chip->dev, "%s: error %d\n", __func__, rc);
> 
> 	chip->locality = -1;
> }
> 
> Then the original code would be simply:
> 
> if (need_locality)
> 	tpm_relinquish_locality(chip);
> 
> /Jarkko
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
