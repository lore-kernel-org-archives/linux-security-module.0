From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Fri, 1 Dec 2017 13:17:57 +0200
Subject: [RFC 0/3] Safe, dynamically (un)loadable LSMs
In-Reply-To: <8c8dd781-d30a-7105-011d-127cf5188426@schaufler-ca.com>
References: <20171126221545.GA13751@ircssh-2.c.rugged-nimbus-611.internal>
	<8c8dd781-d30a-7105-011d-127cf5188426@schaufler-ca.com>
Message-ID: <32d9ec9c-d664-3f1c-ebd9-90a726e3da4f@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 30/11/17 04:28, Casey Schaufler wrote:
> On 11/26/2017 2:15 PM, Sargun Dhillon wrote:
>> This patchset introduces safe dynamic LSM support. It does this via
>> SRCU-protected security hooks. It also EXPORT_SYMBOL_GPLs the symbols
>> required to perform runtime loading, and unloading. The patchset is
>> meant to introduce as little overhead as possible when not used.
>> Additionally, the functionality is disabled by default.
> 
> Can you explain the value in being able to unload a security module?
> I can see having a throttle on an active module, but what do you gain
> by being able to unload it? Can it possibly be worth the inevitable
> memory leaks and almost certain dangling pointers? The restrictions on
> a security module that can work safely in this environment are significant.
> I don't see any point in unloading a module that could work with those
> restrictions. The overhead of making it unloadable is likely to exceed
> the overhead of running it.

There is also another aspect: a readily available "unload" functionality
means that if an attacker is capable of modifying some function pointer,
the unload capability provides an easier way to get rid of the module,
compared to having to poke into memory (like it typically happens when
disabling SELinux, where the attacker flips one of the various state
variables that allow to control how strict it is).

Unload capability might be useful during development, but I am not
really sure it would be a good idea in a production system.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
