From: wangboshi@huawei.com (Boshi Wang)
Date: Sat, 30 Sep 2017 09:55:15 +0800
Subject: A potential issue in security_inode_init_security function
In-Reply-To: <092f7fe1-2b5d-c418-ecbe-6493e13346fc@schaufler-ca.com>
References: <cedbcdd2-ef0c-afa9-627a-406ed0712af8@huawei.com>
	<092f7fe1-2b5d-c418-ecbe-6493e13346fc@schaufler-ca.com>
Message-ID: <2c0aba8f-2805-d1df-6db2-231b85258af4@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thank you for your reply. I await the update.


On 2017/9/30 1:47, Casey Schaufler wrote:
> On 9/29/2017 5:37 AM, Boshi Wang wrote:
>> In security_inode_init_security function of security/security.c, lsm_xattr can be modified by multiple functions due to call_init_hook function. I think that it is a potential issue when inode_init_security list is associated with more security modules, although inode_init_security list is associated with only selinux and smack currrently and the two security modules usually are not used at the same time.
> Yes, this needs significant work for SELinux and Smack to work
> together. Work is in progress on security module stacking. Please
> see the current state of  this work at
>
> 	git://github.com/cschaufler/smack-next#stacking-4.13-rc2
>
> Updates for 4.15 are in progress.
>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> .


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
