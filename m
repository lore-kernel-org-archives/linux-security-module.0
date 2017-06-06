From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 6 Jun 2017 07:45:28 -0700
Subject: [PATCH] procfs: add smack subdir to attrs
In-Reply-To: <20170606135815.0b6372de@d-jobol.iot.bzh>
References: <d2876592-e13a-b407-15b0-bdf9b0d49f75@schaufler-ca.com>
	<alpine.LRH.2.20.1706020937290.16910@namei.org>
	<76f4dd96-76ca-a7ec-313a-b8ab72b0181f@schaufler-ca.com>
	<20170606135815.0b6372de@d-jobol.iot.bzh>
Message-ID: <a79fbe99-20c7-8265-9d7e-d6f0c9490813@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/6/2017 4:58 AM, Jos? Bollo wrote:
> On Thu, 1 Jun 2017 16:59:24 -0700
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> On 6/1/2017 4:38 PM, James Morris wrote:
>>> On Thu, 1 Jun 2017, Casey Schaufler wrote:
>>>  
>>>> Subject: [PATCH] procfs: add smack subdir to attrs  
>>> Is there value in this without major stacking support?  
>> Yes. If a Smack aware application reads /proc/self/attr/current
>> it has no way to know if what it sees is a Smack label or an
>> SELinux context. True, the application can look elsewhere
>> (i.e. /sys/kernel/security/lsm) to find out which is enabled.
>> But the real fix is for Smack to use a different interface
>> than SELinux. Which is what this does. True, it will be even
>> more important when/if major stacking comes in, but it is still
>> significant now, and I would like to have it regardless of
>> the future acceptance of major stacking.
> I agree that it is a nice forward movement to leave the mud.
>
> I have a subsidiary question to ask. Should we keep the name 'attr' for
> the subdirectory? It seems at least convenient but if a better name is
> valuable (security, lsm, ...) why not to switch now?

Too many things would break. It's really a matter of taste in any case.

>
> BR jos?
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-security-module" in the body of a message to
>> majordomo at vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
