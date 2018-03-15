From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:32:44 +0200
Subject: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <20180310082428.31519-4-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-4-tomas.winkler@intel.com>
Message-ID: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> +			      recd) {
> +			total = -EFAULT;
> +			break;
> +		}
> +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);

This rlength stuff can be handled with tpm_buf_length() as I do
in my pendig-for-review patch set:

https://patchwork.kernel.org/patch/10259331/

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
