From: paul@paul-moore.com (Paul Moore)
Date: Thu, 4 May 2017 11:51:37 -0400
Subject: [PATCH v6 0/9] SELinux support for Infiniband RDMA
In-Reply-To: <VI1PR05MB167880A4D79F8FC3F8C740A9C4160@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
	<CAHC9VhSB6AORJf_8cBGt-AynMsEh3snKU5SpsmNXoy9hDSrGaA@mail.gmail.com>
	<VI1PR05MB167880A4D79F8FC3F8C740A9C4160@VI1PR05MB1678.eurprd05.prod.outlook.com>
Message-ID: <CAHC9VhRE+bkPAnFgqOOQQQZwA8U0tSWHdeM5+LiadXfN63kS=g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 3, 2017 at 3:45 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 5/3/2017 9:41 AM, Paul Moore wrote:
>> On Wed, Nov 23, 2016 at 9:17 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>
>>> Infiniband applications access HW from user-space -- traffic is generated
>>> directly by HW, bypassing the kernel. Consequently, Infiniband Partitions,
>>> which are associated directly with HW transport endpoints, are a natural
>>> choice for enforcing granular mandatory access control for Infiniband. QPs may
>>> only send or receives packets tagged with the corresponding partition key
>>> (PKey). The PKey is not a cryptographic key; it's a 16 bit number identifying
>>> the partition ...
>>>
>> Hi Dan,
>>
>> I haven't heard anything from you in a while, where do things stand
>> with this effort?  Unless I missed them, I believe we are still
>> waiting on the userspace, SELinux reference policy, and
>> selinux-testsuite patches.
>>
> Hi Paul,
>
>     I got distracted for a while.  I've just rebased the kernel and userspace.  I'll do some testing and submit the userspace code in the next couple days.  I still have to write the selinux-testsuite tests, I'll work on those concurrently with the userspace review cycle.

Great, thanks for the update.  We'll look forward to the patches.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
