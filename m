From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 12 Apr 2018 08:29:08 -0700
Subject: [PATCH] security: Remove unused field from security_hook_list
In-Reply-To: <201804122318.GEE52615.HOJOFFQVLFOSMt@I-love.SAKURA.ne.jp>
References: <20180412022536.GA8919@ircssh-2.c.rugged-nimbus-611.internal>
	<201804122318.GEE52615.HOJOFFQVLFOSMt@I-love.SAKURA.ne.jp>
Message-ID: <34a6f2aa-f977-a060-3959-004b33939a0a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/12/2018 7:18 AM, Tetsuo Handa wrote:
> Sargun Dhillon wrote:
>> It appears like char * lsm on struct security_hook_list is unused. Even
>> since its inception: https://patchwork.kernel.org/patch/9525051/
>> it hasn't been read, only written to. This removes that.

tl;dr - I hope to use it in 4.18

I have been trying to get my patch for Smack that creates a
subdirectory in /proc/.../attr/ in for some time. That
patch uses the lsm field in security_hook_list. While the
Smack directory is very important for stacking, I want it
regardless as reusing the SELinux attribute files was a mistake.

> It was preserved based on an assumption that complete stacking is accepted in
> near future, but still not available. Maybe we can delete this field for now?

Yes, we can. There would be a merge conflict should I get my way
on the Smack subdirectory.

James, I *still* want /proc/.../attr/smack regardless of the rest
of stacking. I want to start fixing the Smack user space. This is
required, by stacking, but strongly desired in any case.

> http://kernsec.org/pipermail/linux-security-module-archive/2017-March/000104.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
