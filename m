From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sat, 26 May 2018 10:53:04 -0700
Subject: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
In-Reply-To: <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
	<20180526154819.GA14016@avx2>
	<CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
Message-ID: <df12287e-7c19-61a6-b94a-5b7186a1e2a3@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/26/2018 10:30 AM, Salvatore Mesoraca wrote:
> 2018-05-26 17:48 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
>> On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
>>> Prevent a task from opening, in "write" mode, any /proc/*/mem
>>> file that operates on the task's mm.
>>> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
>>> be used by the inspected process itself.
>>> Current implementation always allow a task to access its own
>>> /proc/*/mem file.
>>> A process can use it to overwrite read-only memory, making
>>> pointless the use of security_file_mprotect() or other ways to
>>> enforce RO memory.
>> You can do it in security_ptrace_access_check()
> No, because that hook is skipped when mm == current->mm:
> https://elixir.bootlin.com/linux/v4.17-rc6/source/kernel/fork.c#L1111
>
>> or security_file_open()
> This is true, but it looks a bit overkill to me, especially since many of
> the macros/functions used to handle proc's files won't be in scope
> for an external LSM.
> Is there any particular reason why you prefer it done via LSM?

If you did a Yama style LSM it would be easy to configure.
Even though it might make no sense to allow this behavior,
someone, somewhere is counting on it.

>
> Thank you,
>
> Salvatore
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
