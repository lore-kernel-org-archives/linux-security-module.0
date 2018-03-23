From: nagarathnam.muthusamy@oracle.com (NAGARATHNAM MUTHUSAMY)
Date: Fri, 23 Mar 2018 14:41:29 -0700
Subject: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT, ...)
	between pid namespaces.
In-Reply-To: <87lgeio4tb.fsf@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
	<20180323191614.32489-9-ebiederm@xmission.com>
	<7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com>
	<87lgeio4tb.fsf@xmission.com>
Message-ID: <1091a91e-f8ee-b091-6d95-78b33520fb2d@oracle.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 3/23/2018 2:33 PM, ebiederm at xmission.com wrote:
> NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:
>
>> Thanks!
>>
>> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> Does this look like it will address the issue you have been fighting
> with pids?

We do use IPC shared memory but it is a single large one, shared by multiple
levels. We are currently looking into using a similar solution based on 
file locks.
When a new level is created, a file representing that level could be 
created in
a common path which could be locked by the init process of that level.
Parent levels could query the locking pid of that file to get the pid 
translation
of the init process of the required level. Then it could open a file 
descriptor
and use the translate_pid API for further translations.

Thanks,
Nagarathnam.
>
> Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
