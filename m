From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 10 Nov 2017 12:30:11 -0800
Subject: [RFC PATCH] fw_lockdown: new micro LSM module to prevent loading
	unsigned firmware
In-Reply-To: <1510344812.3404.28.camel@linux.vnet.ibm.com>
References: <1510336703.3404.17.camel@linux.vnet.ibm.com>
	<1510344812.3404.28.camel@linux.vnet.ibm.com>
Message-ID: <CAB=NE6XgC8079iMNh0AWN9iyw9e4tLBqGia3MEZYU_gLp1QqEA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Nov 10, 2017 at 12:13 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-11-10 at 12:58 -0500, Mimi Zohar wrote:
>>
>> +
>> +static struct security_hook_list fw_lockdown_hooks[] = {
>> +     LSM_HOOK_INIT(fw_lockdown_file_check, fw_lockdown_bprm_check)
>
> Sigh, that should have be:
>         LSM_HOOK_INIT(kernel_read_file, fw_lockdown_read_file)

Hah, I thought i was going crazy :) That makes much more sense now!

 Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
