From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 18 Jul 2017 08:12:22 -0500
Subject: [PATCH v2 1/8] exec: Correct comments about "point of no return"
In-Reply-To: <CAGXu5jLW9ZcQAy6+39a7iEpfDqUTTBJA9e8r51C4gVTrOqKjgQ@mail.gmail.com>
	(Kees Cook's message of "Mon, 17 Jul 2017 23:39:43 -0700")
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
	<1499673451-66160-2-git-send-email-keescook@chromium.org>
	<87van0r86d.fsf@xmission.com>
	<CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
	<87pod8mdad.fsf@xmission.com>
	<CAGXu5jLW9ZcQAy6+39a7iEpfDqUTTBJA9e8r51C4gVTrOqKjgQ@mail.gmail.com>
Message-ID: <87lgnlkhxl.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, Jul 10, 2017 at 10:07 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>>> On Mon, Jul 10, 2017 at 1:46 AM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>>
>>>> But you miss it.
>>>>
>>>> The "point of no return" is the call to de_thread.  Or aguably anything in
>>>> flush_old_exec.  Once anything in the current task is modified you can't
>>>> return an error.
>>>>
>>>> It very much does not have anything to do with brpm.    It has
>>>> everything to do with current.
>>>
>>> Yes, but the thing that actually enforces this is the test of bprm->mm
>>> and the SIGSEGV in search_binary_handlers().
>>
>> So what.  Calling that the point of no return is wrong.
>>
>> The point of no return is when we kill change anyting in signal_struct
>> or task_struct.  AKA killing the first thread in de_thread.
>
> Well, okay, I think this is a semantic difference. Prior to bprm->mm
> being NULL, there is still an error return path (yes?), though there
> may have been side-effects (like de_thread(), as you say). But after
> going NULL, the exec either succeeds or SEGVs. It is literally the
> point of no "return".

Nope.  The only exits out of de_thread without de_thread completing
successfully are when we know the processes is already exiting
(signal_group_exit) or when a fatal signal is pending
(__fatal_signal_pending).  With a process exit already pending there is
no need to send a separate signal.

Quite seriously after exec starts having side effects on the process we may
not return to userspace.

>> It is more than just the SIGSEGV in search_binary_handlers that enforces
>> this.  de_thread only returns (with a failure code) after having killed
>> some threads if those threads are dead.
>
> This would still result in the exec-ing thread returning with that
> error, yes?

Nope.  The process dies before it gets to see the failure code. 

>> Similarly exec_mmap only returns with failure if we know that a core
>> dump is pending, and as such the process will be killed before returning
>> to userspace.
>
> Yeah, I had looked at this code and mostly decided it wasn't possible
> for exec_mmap() to actually get its return value back to userspace.
>
>> I am a little worried that we may fail to dump some threads if a core
>> dump races with exec, but that is a quality of implementation issue, and
>> the window is very small so I don't know that it matters.
>>
>> The point of no return very much comes a while before clearing brpm->mm.
>
> I'm happy to re-write the comments, but I was just trying to document
> the SEGV case, which is what that comment was originally trying to do
> (and got lost in the various shuffles).

My objection is you are misdocumenting what is going on.  If we are
going to correct the comment let's correct the comment.

The start of flush_old_exec is the point of no return.  Any errors after
that point the process will never see.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
