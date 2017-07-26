From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 26 Jul 2017 08:24:52 -0700
Subject: [PATCH v3 05/15] smack: Refactor to remove bprm_secureexec hook
In-Reply-To: <CAGXu5jKChNAKb-ySH2X6c49=VKSRn2ff3qw3T1YTDOi9_tS+wA@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-6-git-send-email-keescook@chromium.org>
	<CAGXu5jKChNAKb-ySH2X6c49=VKSRn2ff3qw3T1YTDOi9_tS+wA@mail.gmail.com>
Message-ID: <16990524-73ab-b5e9-89d5-548be2d9aa9b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 7/25/2017 8:58 PM, Kees Cook wrote:
> On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
>> The Smack bprm_secureexec hook can be merged with the bprm_set_creds
>> hook since it's dealing with the same information, and all of the details
>> are finalized during the first call to the bprm_set_creds hook via
>> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
>> via bprm->called_set_creds).
>>
>> Here, the test can just happen at the end of the bprm_set_creds hook,
>> and the bprm_secureexec hook can be dropped.
>>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> How does this look to you, Casey? I've only got a few unreviewed
> patches in this series. Two touch Smack. :)

The eyes don't see any problems, but I haven't had a chance
to try it out.

>
> Thanks!
>
> -Kees
>
>> ---
>>  security/smack/smack_lsm.c | 21 ++++-----------------
>>  1 file changed, 4 insertions(+), 17 deletions(-)
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 7d4b2e221124..4f1967be3d20 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -950,6 +950,10 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
>>         bsp->smk_task = isp->smk_task;
>>         bprm->per_clear |= PER_CLEAR_ON_SETID;
>>
>> +       /* Decide if this is a secure exec. */
>> +       if (bsp->smk_task != bsp->smk_forked)
>> +               bprm->secureexec = 1;
>> +
>>         return 0;
>>  }
>>
>> @@ -967,22 +971,6 @@ static void smack_bprm_committing_creds(struct linux_binprm *bprm)
>>                 current->pdeath_signal = 0;
>>  }
>>
>> -/**
>> - * smack_bprm_secureexec - Return the decision to use secureexec.
>> - * @bprm: binprm for exec
>> - *
>> - * Returns 0 on success.
>> - */
>> -static int smack_bprm_secureexec(struct linux_binprm *bprm)
>> -{
>> -       struct task_smack *tsp = current_security();
>> -
>> -       if (tsp->smk_task != tsp->smk_forked)
>> -               return 1;
>> -
>> -       return 0;
>> -}
>> -
>>  /*
>>   * Inode hooks
>>   */
>> @@ -4646,7 +4634,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>>
>>         LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
>>         LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
>> -       LSM_HOOK_INIT(bprm_secureexec, smack_bprm_secureexec),
>>
>>         LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
>>         LSM_HOOK_INIT(inode_free_security, smack_inode_free_security),
>> --
>> 2.7.4
>>
>
>


.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
