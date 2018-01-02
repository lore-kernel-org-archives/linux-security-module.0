From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 1 Jan 2018 21:40:44 -0700
Subject: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
In-Reply-To: <1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
References: <1514865944-95086-1-git-send-email-azhar.shaikh@intel.com>
	<1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
Message-ID: <20180102044044.GA29208@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jan 01, 2018 at 08:05:43PM -0800, Azhar Shaikh wrote:

> -	return tpm_chip_register(chip);
> +	rc = tpm_chip_register(chip);
> +	if (rc && is_bsw())
> +		iounmap(priv->ilb_base_addr);
> +
> +	return rc;
>  out_err:
>  	tpm_tis_remove(chip);
> +	if (is_bsw())
> +		iounmap(priv->ilb_base_addr);
> +
>  	return rc;
>  }

I thought you were resending this to fix the above, why is is it still
wonky?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
