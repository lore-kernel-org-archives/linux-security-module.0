Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0B238D5F
	for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823766; cv=none; b=R0GGf4cUJO3OO/khfZwekNiDAYL9fBKB4ya36TVAoCe6h9i4c3sFDscWbxGEqgyhTf87WaSFdYwozCMvP1XG35d3eZE1JKmKZXB59p6GsL1vGO7HWSho5REGJtQ5QoiT2k1A8opzBZb+bcGmGetwPAhWVZb7Mi5ao5AleFaS6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823766; c=relaxed/simple;
	bh=jqFfdj6v+j6ZL/5Lhj7VAenchTd63W8FR16/J9yKku4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9fJ8CyHMHos4wMH0KhVkDj7R46NWbNP0UgoO2IOeEPUXDVAddpamxZRJ706uaKf3CTmWEY/B4c+9AHCo09hPHjmzKcodiJ/jBQ4Dm6XqiUuAPLSiP/lsWU+Ep03jONz0ijRdW1akSmum/2o55JaPCaVhOYo3t4Wf+8kGTs0lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7d6-00057v-9j; Mon, 17 Feb 2025 21:22:12 +0100
Message-ID: <de781a07-d209-4bbe-8945-efcb4490f604@pengutronix.de>
Date: Mon, 17 Feb 2025 21:22:06 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
 <7b6d3226-4422-415a-9146-16c421463ac5@gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <7b6d3226-4422-415a-9146-16c421463ac5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

Hello Matti,

On 22.01.25 12:28, Matti Vaittinen wrote:
> On 13/01/2025 18:25, Ahmad Fatoum wrote:
>> hw_protection_shutdown() will kick off an orderly shutdown and if that
>> takes longer than a configurable amount of time, an emergency shutdown
>> will occur.
>>
>> Recently, hw_protection_reboot() was added for those systems that don't
>> implement a proper shutdown and are better served by rebooting and
>> having the boot firmware worry about doing something about the critical
>> condition.
>>
>> On timeout of the orderly reboot of hw_protection_reboot(), the system
>> would go into shutdown, instead of reboot. This is not a good idea, as
>> going into shutdown was explicitly not asked for.
>>
>> Fix this by always doing an emergency reboot if hw_protection_reboot()
>> is called and the orderly reboot takes too long.
>>
>> Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>   kernel/reboot.c | 70 ++++++++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 49 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index 847ac5d17a659981c6765699eac323f5e87f48c1..222b63dfd31020d0e2bc1b1402dbfa82adc71990 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -932,48 +932,76 @@ void orderly_reboot(void)
>>   }
>>   EXPORT_SYMBOL_GPL(orderly_reboot);
>>   +static const char *hw_protection_action_str(enum hw_protection_action action)
>> +{
>> +    switch (action) {
>> +    case HWPROT_ACT_SHUTDOWN:
>> +        return "shutdown";
>> +    case HWPROT_ACT_REBOOT:
>> +        return "reboot";
>> +    default:
>> +        return "undefined";
>> +    }
>> +}
>> +
>> +static enum hw_protection_action hw_failure_emergency_action;
> 
> nit: Do we have a (theoretical) possibility that two emergency restarts get scheduled with different actions? Should the action be allocated (maybe not) for each caller, or should there be a check if an operation with conflicting action is already scheduled?
> 
> If this was already considered and thought it is not an issue:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

__hw_protection_trigger (née __hw_protection_shutdown) has this at its start:

 static atomic_t allow_proceed = ATOMIC_INIT(1);

 /* Shutdown should be initiated only once. */
 if (!atomic_dec_and_test(&allow_proceed))
         return;

It's thus not possible to have a later emergency restart race against the first.

Thanks for your R-b,
Ahmad

> 
> 
> Yours,
>     -- Matti
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
