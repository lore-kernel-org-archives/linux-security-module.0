From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 1 Aug 2017 06:12:53 -0700
Subject: [PATCH v3 06/15] commoncap: Refactor to remove bprm_secureexec
	hook
In-Reply-To: <CAGXu5jLyahmnWevHm02pJm7HSChaAOyNddbsLJepKvP2xYWJXw@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-7-git-send-email-keescook@chromium.org>
	<CALCETrVwR580iJA-Wb=-Do+XhyfQhefp6R7Hxy=TLE53hMvFvw@mail.gmail.com>
	<CALCETrVjCgcGvHberis3eiGDf6S4gVyp5EGdpsK4giibssAooQ@mail.gmail.com>
	<CAGXu5jLyahmnWevHm02pJm7HSChaAOyNddbsLJepKvP2xYWJXw@mail.gmail.com>
Message-ID: <CALCETrVpQzn18sX_H=tzbBE_YVqr5O1TrCAtmLL+v2e3QXgmmg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 3:43 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 19, 2017 at 9:53 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Tue, Jul 18, 2017 at 6:10 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> The commoncap implementation of the bprm_secureexec hook is the only LSM
>>>> that depends on the final call to its bprm_set_creds hook (since it may
>>>> be called for multiple files, it ignores bprm->called_set_creds). As a
>>>> result, it cannot safely _clear_ bprm->secureexec since other LSMs may
>>>> have set it.  Instead, remove the bprm_secureexec hook by introducing a
>>>> new flag to bprm specific to commoncap: cap_elevated. This is similar to
>>>> cap_effective, but that is used for a specific subset of elevated
>>>> privileges, and exists solely to track state from bprm_set_creds to
>>>> bprm_secureexec. As such, it will be removed in the next patch.
>>>>
>>>> Here, set the new bprm->cap_elevated flag when setuid/setgid has happened
>>>> from bprm_fill_uid() or fscapabilities have been prepared. This temporarily
>>>> moves the bprm_secureexec hook to a static inline. The helper will be
>>>> removed in the next patch; this makes the step easier to review and bisect,
>>>> since this does not introduce any changes to inputs nor outputs to the
>>>> "elevated privileges" calculation.
>>>>
>>>> The new flag is merged with the bprm->secureexec flag in setup_new_exec()
>>>> since this marks the end of any further prepare_binprm() calls.
>>>
>>> Reviewed-by: Andy Lutomirski <luto@kernel.org>
>>>
>>> with the redundant caveat that...
>>>
>>>> --- a/fs/exec.c
>>>> +++ b/fs/exec.c
>>>> @@ -1330,6 +1330,13 @@ EXPORT_SYMBOL(would_dump);
>>>>
>>>>  void setup_new_exec(struct linux_binprm * bprm)
>>>>  {
>>>> +       /*
>>>> +        * Once here, prepare_binrpm() will not be called any more, so
>>>> +        * the final state of setuid/setgid/fscaps can be merged into the
>>>> +        * secureexec flag.
>>>> +        */
>>>> +       bprm->secureexec |= bprm->cap_elevated;
>>>> +
>>>
>>> ...the weird placement of the other assignments to bprm->secureexec
>>> makes this exceedingly confusing.
>>
>> Can you just put the bprm->secureexec |=
>> security_bprm_secureexec(bprm); assignment in prepare_binprm() right
>> after security_bprm_set_creds()? This would make patch 1 make sense
>> and make this make sense too, I think.  Or is there some reason why it
>> wouldn't work?  If the latter, I think the patch descriptions and
>> comments should maybe be fixed up.
>
> Yeah, I'll make this change for the next version. It makes things a
> little less ugly in the series. In this version I was trying to focus
> on eliminating the LSM hook instead of first moving it (to
> setup_new_exec()) and then moving it a second time (to the
> bprm_set_creds() hook).
>
> Have you had a chance to review the later consolidation patches? So
> far no one else has reviewed those. (David, any chance you have some
> time too?) I'd love to get at least some Reviewed-bys for them...

I looked briefly.  I'll try to look more closely tomorrow.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
