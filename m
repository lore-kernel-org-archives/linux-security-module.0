From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Mar 2018 16:33:20 -0500
Subject: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT,
	...) between pid namespaces.
In-Reply-To: <7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com> (NAGARATHNAM
	MUTHUSAMY's message of "Fri, 23 Mar 2018 14:17:35 -0700")
References: <87vadmobdw.fsf_-_@xmission.com>
	<20180323191614.32489-9-ebiederm@xmission.com>
	<7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com>
Message-ID: <87lgeio4tb.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:

> Thanks!
>
> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>

Does this look like it will address the issue you have been fighting
with pids?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
