From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Fri, 30 Mar 2018 00:25:22 +0400
Subject: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic data
In-Reply-To: <20180327105509.62ec0d4d@lwn.net>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
	<20180327105509.62ec0d4d@lwn.net>
Message-ID: <5b2a6d5d-5e33-614b-c362-c02a99509def@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 27/03/18 20:55, Jonathan Corbet wrote:
> On Tue, 27 Mar 2018 18:37:36 +0300
> Igor Stoppa <igor.stoppa@huawei.com> wrote:
> 
>> This patch-set introduces the possibility of protecting memory that has
>> been allocated dynamically.
> 
> One thing that jumps out at me as I look at the patch set is: you do not
> include any users of this functionality.  Where do you expect this
> allocator to be used?  Actually seeing the API in action would be a useful
> addition, I think.

Yes, this is very true.
Initially I had in mind to use LSM hooks as easy example, but sadly they 
seem to be in an almost constant flux.

My real use case is to secure both those and the SELinux policy DB.
I have said this few times, but it didn't seem to be worth mentioning in 
the cover letter.

I was hoping to get this merged and then attack both LSM and SELinux, 
but it didn't fly, so few months ago i decided to try it all together 
and put on hold my efforts to get pmalloc merged.

However, in January, happened this:
http://www.openwall.com/lists/kernel-hardening/2018/01/24/1

which rekindled my hopes to get pmalloc in first, as it would make my 
life easier in proposing the changes to SELinux, if they ar ebased on a 
nAPI that is already merged.

So I hope that, once both API and implementation for pmalloc are in good 
shape, xfs could be the first customer.

If that doesn't happen, I'll go back to the initial plan. Or look for 
some other easier target.

Also the IMA policy could benefit from pmalloc protection, I think, I 
spent about a week hacking on it and it seems feasible.
But it's not exactly small either.

I do not know if I should have followed some other path, but I'm having 
a bit of a hard time, since the API is objectively touching core 
functionality, and the change I'd like to use as example affects such a 
large component a SELinux.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
