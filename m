From: why2jjj.linux@gmail.com (J Freyensee)
Date: Thu, 8 Mar 2018 13:47:00 -0800
Subject: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	<20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
Message-ID: <3f3f9059-06ae-cb78-0d02-2658b2edc234@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 3/5/18 8:56 AM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm2-cmd.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index abe6ef4a7a0b..890d83c5c78b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -851,22 +851,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>    */
>   int tpm2_probe(struct tpm_chip *chip)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_output_header *out;
> +	struct tpm_buf buf;
>   	int rc;
>   
> -	cmd.header.in = tpm2_get_tpm_pt_header;
> -	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
> -	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
> -	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
> -	if (rc <  0)
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	if (rc)
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	if (rc <  0)
> +		goto out;
> +	out = (struct tpm_output_header *)buf.data;
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> -	return 0;
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;


Looks better :-).


Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>


>   }
>   EXPORT_SYMBOL_GPL(tpm2_probe);
>   

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
