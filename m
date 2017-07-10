From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 09:04:15 -0700
Subject: [PATCH v2 1/8] exec: Correct comments about "point of no return"
In-Reply-To: <87van0r86d.fsf@xmission.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
	<1499673451-66160-2-git-send-email-keescook@chromium.org>
	<87van0r86d.fsf@xmission.com>
Message-ID: <CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 10, 2017 at 1:46 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> But you miss it.
>
> The "point of no return" is the call to de_thread.  Or aguably anything in
> flush_old_exec.  Once anything in the current task is modified you can't
> return an error.
>
> It very much does not have anything to do with brpm.    It has
> everything to do with current.

Yes, but the thing that actually enforces this is the test of bprm->mm
and the SIGSEGV in search_binary_handlers().

-Kees

>
>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 904199086490..7842ae661e34 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1285,7 +1285,14 @@ int flush_old_exec(struct linux_binprm * bprm)
>>       if (retval)
>>               goto out;
>>
>> -     bprm->mm = NULL;                /* We're using it now */
>> +     /*
>> +      * After clearing bprm->mm (to mark that current is using the
>> +      * prepared mm now), we are at the point of no return. If
>> +      * anything from here on returns an error, the check in
>> +      * search_binary_handler() will kill current (since the mm has
>> +      * been replaced).
>> +      */
>> +     bprm->mm = NULL;
>>
>>       set_fs(USER_DS);
>>       current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
>
> Eric



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
