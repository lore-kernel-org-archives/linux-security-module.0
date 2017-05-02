From: tixxdz@gmail.com (Djalal Harouni)
Date: Tue, 2 May 2017 16:00:41 +0200
Subject: [PATCH RFC v2 5/6] proc: instantiate only pids that we can ptrace
	on 'limit_pids=1' mount option
In-Reply-To: <CALCETrXM7-NBnBcXbuuhDJZyUFLT7iRfcGGvaqUhDJBGkYJgcQ@mail.gmail.com>
References: <1493123038-30590-1-git-send-email-tixxdz@gmail.com>
	<1493123038-30590-6-git-send-email-tixxdz@gmail.com>
	<CALCETrXM7-NBnBcXbuuhDJZyUFLT7iRfcGGvaqUhDJBGkYJgcQ@mail.gmail.com>
Message-ID: <CAEiveUcX8Wg2jw+jt9hqGMpEXEM5RLj3chKvHyOzd9vkW=ePNg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello Andy,

(Sorry for my late response)

On Thu, Apr 27, 2017 at 12:09 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Apr 25, 2017 at 5:23 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
>> If "limit_pids=1" mount option is set then do not instantiate pids that
>> we can not ptrace. "limit_pids=1" means that procfs should only contain
>> pids that the caller can ptrace.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
>> ---
>>  fs/proc/base.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 2e0f661..a663284 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3149,6 +3149,7 @@ struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsign
>>         unsigned tgid;
>>         struct proc_fs_info *fs_info = proc_sb(dir->i_sb);
>>         struct pid_namespace *ns = fs_info->pid_ns;
>> +       int limit_pids = proc_fs_limit_pids(fs_info);
>
> Shouldn't the addition of proc_fs_limit_pids() be in this patch?

Actually I think this patch should be part of proc_fs_limit_pids()
since it will cover paths that are not handled by inode ->permission()
checks. But I will review this patch ad discussion "devpts: Make each
mount of devpts an independent filesystem" [1] and try to get the
rational about it, if doing permission like checks in lookups is
related, or if it should be done in the first place...

The other thing that I didn't have time to check is standardizing on
returned error codes: I prefer to always return -ENOENT, instead of
-EPERM or sometimes -ENOENT.

> Also, can we name it something self-documented?
> "ptraceable_pids_only=1", perhaps?  Or even pids=ptraceable (as
> opposed to pids=all or maybe other choices in the future)?

Yes, I will update.

[1] https://patchwork.kernel.org/patch/9150781/

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
