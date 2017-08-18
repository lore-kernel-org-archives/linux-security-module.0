From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Fri, 18 Aug 2017 17:47:16 +0300
Subject: [kernel-hardening] [RFC] memory allocations in genalloc
In-Reply-To: <bea38f28-b311-dd54-9323-f90e2b157e35@redhat.com>
References: <299c22f9-2e34-36dc-a6da-22eadbc0a59d@huawei.com>
	<bea38f28-b311-dd54-9323-f90e2b157e35@redhat.com>
Message-ID: <2d087abd-1bf4-55aa-ac92-67a9b8f9d177@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On 18/08/17 16:57, Laura Abbott wrote:
> Again, if you have a specific patch or
> proposal this would be easier to review.


yes, I'm preparing it and will send it out soon,
but it was somehow surprising to me that it was chosen to implement free
with the size parameter.

It made me think that I was overlooking some obvious reason behind the
choice :-S

--
thanks for answering, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
