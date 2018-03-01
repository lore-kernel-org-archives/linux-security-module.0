From: why2jjj.linux@gmail.com (J Freyensee)
Date: Thu, 1 Mar 2018 14:10:17 -0800
Subject: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
	<20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
Message-ID: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

.
.
.
I'm new to this area of the kernel, but I'm not getting these lines:

> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	tpm_buf_destroy(&buf);
>   	if (rc <  0)
Why is this if() check not directly after the tpm_transmit_cmd() call 
that sets rc?? Is it correct you want to destroy buf regardless of the 
tpm_transmit_cmd() outcome?
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	out = (struct tpm_output_header *)buf.data;

So buf has been destroyed, buf.data sill has something valid to assign 
to out?
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
>   
>   	return 0;
Thanks,
Jay
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
