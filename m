From: paul@paul-moore.com (Paul Moore)
Date: Tue, 16 May 2017 14:21:44 -0400
Subject: [PATCH] selinux: Use task_alloc hook rather than task_create hook
In-Reply-To: <CAHC9VhTMNXtjToD3XmgfkT_sPsRgfRpFzdrgpgM0xrtbqy22pg@mail.gmail.com>
References: <1490706772-8013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<1490707796.6046.1.camel@tycho.nsa.gov>
	<201703282308.BHJ95808.MFFHVQLOOtJFOS@I-love.SAKURA.ne.jp>
	<CAHC9VhTxG95_iBy6WMtWj_xR1-=_=meykw1cTxN8-XepP8oo2w@mail.gmail.com>
	<201703302013.CFF26504.JFOQFSOHtFOMVL@I-love.SAKURA.ne.jp>
	<CAHC9VhTMNXtjToD3XmgfkT_sPsRgfRpFzdrgpgM0xrtbqy22pg@mail.gmail.com>
Message-ID: <CAHC9VhQ+uBpVxk_prc0tNcJU+QU317a2cYCY4kXfN7nm=zSKKw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 31, 2017 at 3:20 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 30, 2017 at 7:13 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Paul Moore wrote:
>>> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> > ---
>>> >  security/selinux/hooks.c | 5 +++--
>>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> When are you planning to remove the task_create() hook?
>>>
>>> I have no objection to this patch, and I plan to merge it, but merging
>>> it now would require rebasing the selinux/next and I try to keep from
>>> rebasing during the development cycle unless absolutely necessary.  I
>>> think this can wait until after the next merge window, what do you
>>> think?
>>
>> Nothing to hurry. SELinux is the only user. We can wait as much as you want.
>
> Okay, I'll leave this in the queue and I'll merge it after the next
> merge window.
>
> Thanks.

Merged, thanks again.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
