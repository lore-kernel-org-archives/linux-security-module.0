From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 19 Feb 2018 13:27:00 +0200
Subject: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180214134319.4400-2-tomas.winkler@intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
	<20180214134319.4400-2-tomas.winkler@intel.com>
Message-ID: <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 14, 2018 at 03:43:18PM +0200, Tomas Winkler wrote:
>  	if (need_locality && chip->ops->relinquish_locality) {
> -		chip->ops->relinquish_locality(chip, chip->locality);
> +		/* this coud be on error path, don't override error code */
> +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);

All local variable declarations must be in the beginning of the
function.

> +
> +		if (l_rc) {
> +			dev_err(&chip->dev, "%s: relinquish_locality: error %d\n",
> +				__func__, l_rc);
> +			rc = l_rc;
> +		}

Your comment about not overriding error code is incorrect.

The value of 'rc' should be never overridden, which kind of supports
to "just print" behavior that we had for a locality error.

Is your fix somehow dependent on changing relinquish_locality()
behavior? If not, please remove this change. If you want to contribute
such behavioral change, you should make a separate patch of it.

Now it's like a trojan horse bundled inside a bug fix.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
