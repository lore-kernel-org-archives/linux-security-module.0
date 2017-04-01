From: paul@paul-moore.com (Paul Moore)
Date: Sat, 1 Apr 2017 10:52:26 -0400
Subject: selinux: Fix an uninitialized variable bug in range_read()
In-Reply-To: <fb1cb81c-4b03-5b21-f933-ea3e58491a13@users.sourceforge.net>
References: <20170331152118.GA8141@mwanda>
	<1490975541.31110.12.camel@tycho.nsa.gov>
	<CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
	<fb1cb81c-4b03-5b21-f933-ea3e58491a13@users.sourceforge.net>
Message-ID: <CAHC9VhT8nXOPpOy5sRpRYjVnj2oOgFGAzibgkj_ZpK7xyg35qg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Apr 1, 2017 at 2:40 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>>> We removed this initialization as a cleanup but it is probably
>>>> required.
>>>>
>>>> The concern is that "nel" can be zero.  I'm not an expert on SELinux
>>>> code but I think it looks possible to write an SELinux policy which
>>>> triggers this bug.  GCC doesn't catch this, but my static checker
>>>> does.
>>>>
>>>> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
>>>> initialisation in range_read()")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> Nice catch, thanks!
>>>
>>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> Yes, indeed.  Thanks Dan, I should have caught this when merging Markus' patch.
>
> How do you think about the possibility to call the function ?range_read? only with
> a system configuration where the interface ?le32_to_cpu? will be resolved to
> a positive value so that statements in the corresponding for loop will be executed
> at least once?

I suggest we leave this as-is for the moment.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
