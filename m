From: keescook@chromium.org (Kees Cook)
Date: Fri, 11 Aug 2017 11:32:50 -0700
Subject: [PATCH v3 2/4] seccomp: Add SECCOMP_FILTER_FLAG_KILL_PROCESS
In-Reply-To: <b1177c7d-7180-a5ad-881e-89ecbf5c80e2@canonical.com>
References: <1502305317-85052-1-git-send-email-keescook@chromium.org>
	<1502305317-85052-3-git-send-email-keescook@chromium.org>
	<b1177c7d-7180-a5ad-881e-89ecbf5c80e2@canonical.com>
Message-ID: <CAGXu5jJ7nq0VF9tLz=i98eo=DaMKXVNO7NqmtxJHNwVwuZHZGg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 11, 2017 at 9:58 AM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> @@ -201,8 +203,25 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>>        */
>>       for (; f; f = f->prev) {
>>               u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
>> +             u32 action = cur_ret & SECCOMP_RET_ACTION;
>>
>> -             if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION)) {
>> +             /*
>> +              * In order to distinguish between SECCOMP_RET_KILL and
>> +              * "higher priority" synthetic SECCOMP_RET_KILL_PROCESS
>> +              * identified by the kill_process filter flag, treat any
>> +              * case as immediately stopping filter processing. No
>> +              * higher priority action can exist, and we can't stop
>> +              * on the first RET_KILL (which may not have set
>> +              * f->kill_process) when a RET_KILL further up the filter
>> +              * list may have f->kill_process set which would go
>> +              * unnoticed.
>> +              */
>> +             if (unlikely(action == SECCOMP_RET_KILL && f->kill_process)) {
>> +                     *match = f;
>> +                     return cur_ret;
>> +             }
>
> Why not let the application enforce this via the seccomp filter? In
> other words, the first filter loaded with
> SECCOMP_FILTER_FLAG_KILL_PROCESS set could have a rule in the filter
> that only allows seccomp(2) to be called in the future with the
> SECCOMP_FILTER_FLAG_KILL_PROCESS flag set.

I've been using the guide of "if SECCOMP_RET_KILL_PROCESS _did_ exist,
how would its semantics differ?"

In that magic world, it wouldn't be possible to create a seccomp
filter to screen out SECCOMP_RET_KILL_PROCESS. Also, being able to
distinguish between the two states (see below).

> I understand the reasoning for wanting to enforce this automatically at
> the kernel level but I think mixing return action priorities with filter
> flags could be confusing and inflexible in the long run since filters
> are inherited and your parent's desire to kill the entire thread group
> may not mix with your desire to only kill a single thread.

Blocking the use of SECCOMP_FILTER_FLAG_KILL_PROCESS just means a
child can never perform a KILL_PROCESS, which doesn't really make much
sense, IMO.

The trouble may be that KILL_PROCESS would be used sparingly by either
parent or child, in the sense that maybe "unknown syscall gets
KILL_PROCESS, but 'connect' should just do KILL_THREAD". Or the
reverse. There isn't a way to mix combinations of return values across
filter chains without treating it exactly like a "real"
SECCOMP_RET_KILL_PROCESS would have worked. That means I have to treat
it as "higher priority" in the seccomp_run_filters() loop (which is
luckily very very cheap, as the "unlikely(register == zero)" test is
correct branch-predicted for the non-zero case, and the test is cheap
(we've already done the assignment which we need for the "<" test
below it, so it's a single pipelined instruction for the zero flag).

I don't expect to adjust KILL_THREAD vs KILL_PROCESS ever again, so
I'm not too worried about inflexibility.

What I don't get in this version is a _single_ filter being able to
distinguish between KILL_THREAD and KILL_PROCESS. Userspace is forced
to split up a rule if it wants to have different results. Also, parent
_can_ stop a child from escalating their KILL_THREADs to KILL_PROCESS
via the filter you mentioned, which is weird.

I spent some time trying to use the high bit in the return, to make
this signed, and in the end it was much much more ugly, and I didn't
want to deal with the fallout to userspace which may suddenly have to
deal with unexpected bits in the BPF return:

basically s/u32/s32/ in __seccomp_filter() and seccomp_run_filters().
add #define SECCOMP_RET_ACTION_FULL 0xffff0000
add #define SECCOMP_RET_KILL_PROC      0x80000000

Then use SECCOMP_RET_ACTION_FULL to mask everything (after forcing a u32 cast).

But the more I stare@this, the more I just want a value that that
works correctly without totally crazy flags and things.

> Another way that this doesn't mix perfectly with the existing design is
> when the action is unknown. In that situation, we treat it as RET_KILL.
> However, this patch hard-codes the comparison with RET_KILL so we get
> into this situation where an unknown action is treated as RET_KILL
> except when the filter has the FILTER_FLAG_KILL_PROCESS flag set and
> then this short-circuit doesn't kick in. It is a corner case, for sure,
> but worth mentioning.

Hm, yeah, good point. This leaves unknown returns as KILL_THREAD, not
KILL_PROCESS.

Let me spent some more time looking at the high bit version of this...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
