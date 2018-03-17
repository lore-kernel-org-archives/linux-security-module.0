From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Fri, 16 Mar 2018 18:20:31 -0700
Subject: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
In-Reply-To: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	<20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
Message-ID: <1521249631.12827.5.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> index 9e80a953d693..1adb976a2e37 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -537,14 +537,26 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip,
> struct tpm_space *space,
> ?			?const char *desc)
> ?{
> ?	const struct tpm_output_header *header = buf;
> +	unsigned int delay_msec = TPM2_DURATION_SHORT;
> ?	int err;
> ?	ssize_t len;
> ?
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> -	if (len <??0)
> -		return len;
> +	for (;;) {
> +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz,
> flags);
> +		if (len <??0)
> +			return len;
> +		err = be32_to_cpu(header->return_code);
> +		if (err != TPM2_RC_TESTING)
> +			break;
> +
> +		delay_msec *= 2;
> +		if (delay_msec > TPM2_DURATION_LONG) {
> +			dev_err(&chip->dev, "the self test is still
> running\n");
> +			break;
> +		}
> +		tpm_msleep(delay_msec);
> +	}

It turns out this bit is wrong ... I just discovered it testing the
RC_RETRY code. ?You can't feed the buf back to tpm_transmit because the
header has already been changed to give you back the return code. ?To
make this work, you have to save the header and handle area and restore
it before the command is resent.

I think the best solution for this hunk of code is to merge it with the
retry code.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
