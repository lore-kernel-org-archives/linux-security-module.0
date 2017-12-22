From: azhar.shaikh@intel.com (Shaikh, Azhar)
Date: Fri, 22 Dec 2017 19:14:39 +0000
Subject: [PATCH v2] tpm: Fix the driver cleanup code
In-Reply-To: <20171222184143.aqkg7vjbkjarod2z@linux.intel.com>
References: <1513898019-164487-1-git-send-email-azhar.shaikh@intel.com>
	<20171222184143.aqkg7vjbkjarod2z@linux.intel.com>
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF5828989512@ORSMSX109.amr.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



>-----Original Message-----
>From: Jarkko Sakkinen [mailto:jarkko.sakkinen at linux.intel.com]
>Sent: Friday, December 22, 2017 10:42 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: jgg at ziepe.ca; javierm at redhat.com; peterhuewe at gmx.de; linux-security-
>module at vger.kernel.org; linux-integrity at vger.kernel.org; linux-
>kernel at vger.kernel.org
>Subject: Re: [PATCH v2] tpm: Fix the driver cleanup code
>
>On Thu, Dec 21, 2017 at 03:13:39PM -0800, Azhar Shaikh wrote:
>> Commit 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout the
>> duration of transmit_cmd()") added code which accessed
>> chip->ops, even after it was set to NULL in tpm_del_char_device(),
>> called from tpm_chip_unregister() in error / driver exit paths.
>> So fix this code.
>>
>> Fixes: 3c1701339284353c41 ("tpm: Keep CLKRUN enabled throughout the
>> duration of transmit_cmd()")
>>
>> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
>> ---
>> Changes in v2:
>> - Remove TPM_CHIP_FLAG_DO_NOT_CLEAR_OPS flag, instead call
>>   tpm_tis_clkrun_enable() directly in tpm_tis_remove()
>> - Add comment to tpm_tis_clkrun_enable()
>>
>>  drivers/char/tpm/tpm_tis.c      |  6 ------
>>  drivers/char/tpm/tpm_tis_core.c | 29 +++++++++++++++++------------
>>  2 files changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>> index d29add49b033..c847fc69a2fc 100644
>> --- a/drivers/char/tpm/tpm_tis.c
>> +++ b/drivers/char/tpm/tpm_tis.c
>> @@ -275,9 +275,6 @@ static void tpm_tis_pnp_remove(struct pnp_dev
>> *dev)
>>
>>  	tpm_chip_unregister(chip);
>>  	tpm_tis_remove(chip);
>> -	if (is_bsw())
>> -		iounmap(priv->ilb_base_addr);
>> -
>>  }
>>
>>  static struct pnp_driver tis_pnp_driver = { @@ -329,9 +326,6 @@
>> static int tpm_tis_plat_remove(struct platform_device *pdev)
>>  	tpm_chip_unregister(chip);
>>  	tpm_tis_remove(chip);
>>
>> -	if (is_bsw())
>> -		iounmap(priv->ilb_base_addr);
>> -
>>  	return 0;
>>  }
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c
>> b/drivers/char/tpm/tpm_tis_core.c index c2227983ed88..519e4a78c8f8
>> 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -37,6 +37,8 @@
>>   */
>>  #define TPM_POLL_SLEEP	1  /* msec */
>>
>> +static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>> +
>>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>>  					bool check_cancel, bool *canceled)  {
>@@ -716,8 +718,7 @@ void
>> tpm_tis_remove(struct tpm_chip *chip)
>>  	u32 interrupt;
>>  	int rc;
>>
>> -	if (chip->ops->clk_enable != NULL)
>> -		chip->ops->clk_enable(chip, true);
>> +	tpm_tis_clkrun_enable(chip, true);
>>
>>  	rc = tpm_tis_read32(priv, reg, &interrupt);
>>  	if (rc < 0)
>> @@ -725,8 +726,10 @@ void tpm_tis_remove(struct tpm_chip *chip)
>>
>>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>>
>> -	if (chip->ops->clk_enable != NULL)
>> -		chip->ops->clk_enable(chip, false);
>> +	tpm_tis_clkrun_enable(chip, false);
>> +
>> +	if (priv->ilb_base_addr)
>> +		iounmap(priv->ilb_base_addr);
>>  }
>>  EXPORT_SYMBOL_GPL(tpm_tis_remove);
>>
>> @@ -736,6 +739,9 @@ void tpm_tis_remove(struct tpm_chip *chip)
>>   * @chip:	TPM chip to use
>>   * @value:	1 - Disable CLKRUN protocol, so that clocks are free running
>>   *		0 - Enable CLKRUN protocol
>> + *
>> + * Call this function directly in tpm_tis_remove() in error or driver
>> + removal
>> + * path, since the chip->ops is set to NULL in tpm_chip_unregister().
>>   */
>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>> { @@ -922,21 +928,20 @@ int tpm_tis_core_init(struct device *dev,
>> struct tpm_tis_data *priv, int irq,
>>  	}
>>
>>  	rc = tpm_chip_register(chip);
>> -	if (rc && is_bsw())
>> -		iounmap(priv->ilb_base_addr);
>> +	if (rc)
>> +		goto out_err;
>>
>>  	if (chip->ops->clk_enable != NULL)
>>  		chip->ops->clk_enable(chip, false);
>>
>> -	return rc;
>> -out_err:
>> -	tpm_tis_remove(chip);
>> -	if (is_bsw())
>> -		iounmap(priv->ilb_base_addr);
>> +	return 0;
>>
>> -	if (chip->ops->clk_enable != NULL)
>> +out_err:
>> +	if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
>>  		chip->ops->clk_enable(chip, false);
>>
>> +	tpm_tis_remove(chip);
>> +
>>  	return rc;
>>  }
>>  EXPORT_SYMBOL_GPL(tpm_tis_core_init);
>> --
>> 1.9.1
>>
>
>Since the original commit is not in the mainline yet, you should rather
>send an updated version of that commit.
>

Ok, I will send an updated version of the original commit "tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()"

>/Jarkko

Regards,
Azhar Shaikh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
