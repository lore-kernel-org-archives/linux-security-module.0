Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701292629D;
	Fri, 14 Mar 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974303; cv=none; b=uIlKrLjm57r5wyNV822p2icXdawd6itoWPkmKSqtdFiYXi9KAW7a32uhcO/IzaSbbShVLb5bugUY/5P9utwMn1Bo/TWbMiOCKDv4YudJi/vICfIp2Riy0zLBPp9+lXNWiFadGGRKSDbOcJpTPiv/h++w1uKkOmOY9REcbQmkLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974303; c=relaxed/simple;
	bh=IudoS3tWFygkixhr5W7NaCnVIiBxoRIaZA8TWY3GaK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcyXWKmH9OXC2M3vUeP/9L4q02xT4U4EY2P4tHd2r/jMYkLfqtEbn4UhJI8zIheVyUPP0FcX8f5G8VJq7lA0DoyJpkoZSIaazidG0UcOS9dNKTIlRztfnmeyC53b7nI6aB+Rk3lGayAjrsTSNDC2yA9eKBIduv7xEHjQq9uSwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfu4ZL4q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfu4ZL4q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso64922045ad.2;
        Fri, 14 Mar 2025 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974301; x=1742579101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XTK+zFsZSk+m7SXsEBUdWvQ9eyMFzVYuOZ0uuc5BCqc=;
        b=Mfu4ZL4qFFas2msbw52YAEC8txJ4ZHMBVgj/Wv4UW99CdKxxACd9VP53x99GZLY4DY
         cyWbM1ur/snuNGzwYv4wgFYo890pukRnTqr67PWwpgbOELQlqk6wVSq1VA/SipcNWni1
         1Tfw+oNAYT4SXVksbQlrTu8pckIT6vFu7wvWYMAnWMKva8rPnbablRnlMxpNpEFbHjzN
         nxXdrdvT3WBJtFCaOLuLsmwFbLQ2DBguCn52zsnQLXwH78g5CyXGkuxmKhCK9zCQmAXp
         6WS9w4yaT6iFGmwj09h2aJqkcR2OqN3elMjU/ztS8POYG7Wl/+uyIrbmX6rhJ2WoQXdg
         /7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974301; x=1742579101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTK+zFsZSk+m7SXsEBUdWvQ9eyMFzVYuOZ0uuc5BCqc=;
        b=daH0uDmWWY7bMmkr+mmxFTCiZYNYEuoIVs6macOcniMJuY81y1cFN1eNEazuOWsSKH
         or3T7Gux3t5AvXrdY9UryuXpL5qQJXL7g/XIXars12h3KmDhAv3pv5pi7ie5sNsUFmT1
         2PFr5szfUMvrHuch3OtAvJ4G5ZLesAzsL1kNuwCTuJRNWvYxcgjivaXdHldZpCf1wPxN
         XAn7gYOP+uwh0dgpLQPFo5j53tsdZErBZA/tnBgAVWEdXRZ4DxS64mMyS8p/GqDHaZr2
         hVsS9tacoEgOGKWU96OteBkT+mWDUFCWWMXoksNKgBgzuSPwx/jyvQTcYTBKNscGZNEV
         QOyA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBHqE0Lc5sqOLfZkJnZygWiMx2WRwOpaHCa4nqY/+MFFS0E2glDsgNK5K/qCaSaFiRcoqwIhf+1aDnKH+gda6e3iaM9aQ@vger.kernel.org, AJvYcCVYWETWALwVM3ugRw4uxK5Z6UOC0Rbrm5VkrP1uf4wAQdLG03yJZty+Mkjo63KwhLAuuq+dlYUpADVROyXz@vger.kernel.org, AJvYcCXD6qHpyjXhCSCVPzD0GxJTunXVOvLgZ8YjHSorPuaCYOvkliB1wxrDZGKxQt03UPd9a6IUkovVtJqcnYrSlS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6TUwd/Qh5p62AFiWHp/mLslkwN552bskIy5zk6H9G8zme6nm
	wmPrvQW5YoCqeAYsBryEp68BQoToZ+EtGQrpUYaIFdL6c7/JHIRX
X-Gm-Gg: ASbGnct/LNWHx69OYFXko2iObRDl+1MOSQtsFP/EUAgSPTex0Yr2xjraMLzMDd1Qukp
	eHoMOaW65xqnnXe1I29kigCo589xzhw/aZeCCUztbeHHO2AgRGhlDz0msj9AIsrnN8AVjDFAZob
	dIAf9wc9U52eqQIEHp2d8yd9mspxetTXAt+cLuZxnKzCwmQsDIzdv4tKLJPa9QV8gXFfqOrwLnR
	OI0OWIi+PletqTHbFrb2A+PG4p0LdEciRW/qYL2l0Y5ji+31T8yUmYvVVejXZ/R0HB9uofR67qw
	dcBZ77beMPdEQJDwTcD/3la405wUdYcT6QBqB2qQMb08oG0IABW1pF0l9imB8fUGOJJI5x5I6iU
	y9IewFA1h9DoFlGZSwGfMxIw04YQ9
X-Google-Smtp-Source: AGHT+IG8t2RiWWHqExlCkH4UwwB/yJrN/VA6OIGwl2mVQE7y86DFcAhX5X9HvMhZiSS2xp1OznHmTQ==
X-Received: by 2002:a05:6a00:2e20:b0:736:34ff:be8 with SMTP id d2e1a72fcca58-73722412c0amr3677682b3a.19.1741974300516;
        Fri, 14 Mar 2025 10:45:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e018sm3221272b3a.91.2025.03.14.10.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:45:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
Date: Fri, 14 Mar 2025 10:44:58 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hwmon: (pmbus/tps53679) Add support for TPS53685
To: Chiang Brian <chiang.brian@inventec.com>, Jean Delvare
 <jdelvare@suse.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org
References: <CAJCfHmW61d2jd_tYpNEqBG_Z58bEnVKAmsvhrEP1zXQoXqrUVw@mail.gmail.com>
 <20250314033040.3190642-1-chiang.brian@inventec.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250314033040.3190642-1-chiang.brian@inventec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 20:30, Chiang Brian wrote:
> The TPS53685 is a fully AMD SVI3 compliant step down
> controller with trans-inductor voltage regulator
> (TLVR) topology support, dual channels, built-in
> non-volatile memory (NVM), PMBus interface, and
> full compatible with TI NexFET smart power
> stages.
> Add support for it to the tps53679 driver.
> 
> Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
> ---
> v4 -> V5:
>      1. document the compatible of tps53685 into dt-bindings
> 	2. add the buffer length as argument for %*ph
> 	3. Add Changelog
> v3 -> V4:
>      1. Add length comparison into the comparison of "id",or it may be true when
> 	   the substring of "id" matches device id.
> 	2. Restore `return 0;` in `tps53679_identify_chip()`
> V2 -> V3:
>      1. Remove the length comparsion in the comparison of "id".
> V1 -> V2:
> 	1. Modify subject and description to meet requirements
> 	2. Add "tps53685" into enum chips with numeric order
> 	3. Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81"
> 	   Add marco "TPS53685_DEVICE_ID" with content "TIShP"
> 	4. Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
> 	5. Modify the comparison of "id". It will be true if the string "id" matches
> 	   device ID and compare with type char*,
> 	6. Add the length comparsion into the comparison of "id".
> 	7. Modify "len" as return code in `tps53679_identify_chip()`
> 	8. Output device error log with %*ph, instead of 0x%x\n"
>      9. Use existing tps53679_identify_multiphase() with argument
> 	   "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one
> 	   tps53685_identify_multiphase()
> 
> boot-log:

This is completely useless noise.

> 	
>   drivers/hwmon/pmbus/tps53679.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
> index 63524dff5e75..091d5eacbee0 100644
> --- a/drivers/hwmon/pmbus/tps53679.c
> +++ b/drivers/hwmon/pmbus/tps53679.c
> @@ -16,7 +16,7 @@
>   #include "pmbus.h"
>   
>   enum chips {
> -	tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
> +	tps53647, tps53667, tps53676, tps53679, tps53681, tps53685, tps53688
>   };
>   
>   #define TPS53647_PAGE_NUM		1
> @@ -31,7 +31,8 @@ enum chips {
>   #define TPS53679_PROT_VR13_5MV		0x07 /* VR13.0 mode, 5-mV DAC */
>   #define TPS53679_PAGE_NUM		2
>   
> -#define TPS53681_DEVICE_ID		0x81
> +#define TPS53681_DEVICE_ID     "\x81"
> +#define TPS53685_DEVICE_ID     "TIShP"
>   
>   #define TPS53681_PMBUS_REVISION		0x33
>   
> @@ -86,7 +87,7 @@ static int tps53679_identify_phases(struct i2c_client *client,
>   }
>   
>   static int tps53679_identify_chip(struct i2c_client *client,
> -				  u8 revision, u16 id)
> +				  u8 revision, char *id)
>   {
>   	u8 buf[I2C_SMBUS_BLOCK_MAX];
>   	int ret;
> @@ -102,8 +103,8 @@ static int tps53679_identify_chip(struct i2c_client *client,
>   	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
>   	if (ret < 0)
>   		return ret;
> -	if (ret != 1 || buf[0] != id) {
> -		dev_err(&client->dev, "Unexpected device ID 0x%x\n", buf[0]);
> +	if (ret != strlen(id) || strncmp(id, buf, ret)) {
> +		dev_err(&client->dev, "Unexpected device ID: %*ph\n", ret, buf);
>   		return -ENODEV;
>   	}
>   	return 0;
> @@ -138,6 +139,14 @@ static int tps53679_identify(struct i2c_client *client,
>   	return tps53679_identify_mode(client, info);
>   }
>   
> +static int tps53685_identify(struct i2c_client *client,
> +				 struct pmbus_driver_info *info)
> +{
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +	return tps53679_identify_chip(client, TPS53681_PMBUS_REVISION,
> +					   TPS53685_DEVICE_ID);
> +}
> +
>   static int tps53681_identify(struct i2c_client *client,
>   			     struct pmbus_driver_info *info)
>   {
> @@ -215,7 +224,9 @@ static struct pmbus_driver_info tps53679_info = {
>   		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
>   		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
>   		PMBUS_HAVE_POUT,
> -	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +	    PMBUS_HAVE_STATUS_INPUT |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |

This changes the attributes supported for the other chips supported by this
driver. If those chips indeed support the additional attributes, the change
should be submitted as separate patch. Otherwise, please explain how the change
is supposed to work for those chips (and why you don't add the additional flags
after determining that the chip is a tps53685 and after copying the data structure).

Guenter

