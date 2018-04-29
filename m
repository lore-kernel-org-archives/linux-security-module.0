From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Mon, 30 Apr 2018 02:39:53 +0400
Subject: [PATCH 3/3] genalloc: selftest
In-Reply-To: <01ec5680-b1de-5473-f32b-89729d9fcc70@infradead.org>
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
	<20180429024542.19475-4-igor.stoppa@huawei.com>
	<01ec5680-b1de-5473-f32b-89729d9fcc70@infradead.org>
Message-ID: <649d5e8a-6a5a-01c0-d261-c303cf8137fb@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 29/04/18 07:36, Randy Dunlap wrote:
> On 04/28/2018 07:45 PM, Igor Stoppa wrote:

[...]

>> +	test_genalloc();
> 
> Is there a stub for test_genalloc() when its config option is not enabled?
> I don't see it.

I failed to add to the patch include/linux/test_genalloc.h :-/
That's where the stub is hiding.

>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 09565d779324..2bf89af50728 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -303,6 +303,21 @@ config DECOMPRESS_LZ4
>>   config GENERIC_ALLOCATOR
>>   	bool
>>   
> 
> These TEST_ kconfig symbols should be in lib/Kconfig.debug, not lib/Kconfig.

ok, I will fix it

>> +config TEST_GENERIC_ALLOCATOR
>> +	bool "genalloc tester"
>> +	default n
>> +	select GENERIC_ALLOCATOR
> 
> This should depend on GENERIC_ALLOCATOR, not select it.
> 
> See TEST_PARMAN, TEST_BPF, TEST_FIRMWARE, TEST_SYSCTL, TEST_DEBUG_VIRTUAL
> in lib/Kconfig.debug.

I was actually wondering about this.
The dependency I came up with allows to perform the test even if nothing 
is selecting genalloc, but ok, if this is how it is done, I'll adjust to 
it.

>> +	help
>> +	  Enable automated testing of the generic allocator.
>> +	  The testing is primarily for the tracking of allocated space.
>> +
>> +config TEST_GENERIC_ALLOCATOR_VERBOSE
>> +	bool "make the genalloc tester more verbose"
>> +	default n
>> +	select TEST_GENERIC_ALLOCATOR
> 
> 	depends on TEST_GENERIC_ALLOCATOR

ok

[...]

>> + * guarranteed; allowing the boot to continue means risking to corrupt
> 
>        guaranteed;

hmmm

--

thanks, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
