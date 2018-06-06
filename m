From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 6 Jun 2018 10:23:01 +0100
Subject: [PATCH v2] integrity: silence warning when CONFIG_SECURITYFS is
	not enabled
In-Reply-To: <1528210182.3237.160.camel@linux.vnet.ibm.com>
References: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
	<1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
	<1528210182.3237.160.camel@linux.vnet.ibm.com>
Message-ID: <107b20b7-6123-e0fa-6945-59af13d3973c@arm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 05/06/18 15:49, Mimi Zohar wrote:
> On Tue, 2018-06-05 at 11:25 +0100, Sudeep Holla wrote:
>> When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
>> -ENODEV which throws the following error:
>> 	"Unable to create integrity sysfs dir: -19"
>>
>> However, if the feature is disabled, it can't be warning and hence
>> we need to silence the error. This patch checks for the error -ENODEV
>> which is returned when CONFIG_SECURITYFS is disabled to stop the error
>> being thrown.
> 
> Both IMA and EVM require securityfs, at least for the time being.
> ?Under what circumstances would integrity and not securityfs be
> enabled. ?Is this a Kconfig issue?
> 

Could be, looks like it's not enforced and hence I have ended up with
a config that has CONFIG_SECURITYFS disabled. I have bot IMA and EVM
disabled too. However CONFIG_INTEGRITY is enabled.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
