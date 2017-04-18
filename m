From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Apr 2017 10:47:48 -0600
Subject: [PATCH 2/3] tpm: vtpm_proxy: Implement request_locality
In-Reply-To: <1492442371-30252-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1492442371-30252-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1492442371-30252-3-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170418164748.GB7181@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 17, 2017 at 11:19:30AM -0400, Stefan Berger wrote:
> Implement the request_locality function. Accept all localties assuming
> that the emulator handling the localities will check for a valid locality.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm_vtpm_proxy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index be0a268..bf59426 100644
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -371,6 +371,11 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
>  	return ret;
>  }
>  
> +static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
> +{
> +	return locality;
> +}

I thought we had agreed to make this function pass/fail?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
