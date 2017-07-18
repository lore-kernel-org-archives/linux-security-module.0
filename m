From: keescook@chromium.org (Kees Cook)
Date: Mon, 17 Jul 2017 23:39:43 -0700
Subject: [PATCH v2 1/8] exec: Correct comments about "point of no return"
In-Reply-To: <87pod8mdad.fsf@xmission.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
	<1499673451-66160-2-git-send-email-keescook@chromium.org>
	<87van0r86d.fsf@xmission.com>
	<CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
	<87pod8mdad.fsf@xmission.com>
Message-ID: <CAGXu5jLW9ZcQAy6+39a7iEpfDqUTTBJA9e8r51C4gVTrOqKjgQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 10, 2017 at 10:07 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Mon, Jul 10, 2017 at 1:46 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>
>>> But you miss it.
>>>
>>> The "point of no return" is the call to de_thread.  Or aguably anything in
>>> flush_old_exec.  Once anything in the current task is modified you can't
>>> return an error.
>>>
>>> It very much does not have anything to do with brpm.    It has
>>> everything to do with current.
>>
>> Yes, but the thing that actually enforces this is the test of bprm->mm
>> and the SIGSEGV in search_binary_handlers().
>
> So what.  Calling that the point of no return is wrong.
>
> The point of no return is when we kill change anyting in signal_struct
> or task_struct.  AKA killing the first thread in de_thread.

Well, okay, I think this is a semantic difference. Prior to bprm->mm
being NULL, there is still an error return path (yes?), though there
may have been side-effects (like de_thread(), as you say). But after
going NULL, the exec either succeeds or SEGVs. It is literally the
point of no "return".

> It is more than just the SIGSEGV in search_binary_handlers that enforces
> this.  de_thread only returns (with a failure code) after having killed
> some threads if those threads are dead.

This would still result in the exec-ing thread returning with that error, yes?

> Similarly exec_mmap only returns with failure if we know that a core
> dump is pending, and as such the process will be killed before returning
> to userspace.

Yeah, I had looked at this code and mostly decided it wasn't possible
for exec_mmap() to actually get its return value back to userspace.

> I am a little worried that we may fail to dump some threads if a core
> dump races with exec, but that is a quality of implementation issue, and
> the window is very small so I don't know that it matters.
>
> The point of no return very much comes a while before clearing brpm->mm.

I'm happy to re-write the comments, but I was just trying to document
the SEGV case, which is what that comment was originally trying to do
(and got lost in the various shuffles).

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
