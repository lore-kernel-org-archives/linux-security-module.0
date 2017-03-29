From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 17:36:16 -0400
Subject: [PATCH] fs: switch order of CAP_DAC_OVERRIDE and
	CAP_DAC_READ_SEARCH checks
In-Reply-To: <CAHC9VhT42v2Z5hw8PSUqOtzhz1Ba3K4bL=DuSXTJwPberWtjLQ@mail.gmail.com>
References: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
	<CAHC9VhT42v2Z5hw8PSUqOtzhz1Ba3K4bL=DuSXTJwPberWtjLQ@mail.gmail.com>
Message-ID: <CAHC9VhQ7TOXhcCKTg4QaH3EsdVHxzJr5gX1xvLD=RSQ-xmfVCg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 10, 2017 at 2:54 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 10, 2017 at 12:14 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> generic_permission() presently checks CAP_DAC_OVERRIDE prior to
>> CAP_DAC_READ_SEARCH.  This can cause misleading audit messages when
>> using a LSM such as SELinux or AppArmor, since CAP_DAC_OVERRIDE
>> may not be required for the operation.  Flip the order of the
>> tests so that CAP_DAC_OVERRIDE is only checked when required for
>> the operation.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  fs/namei.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> This is the second posting of this patch and so far no comment ... if
> I don't see any negative responses by next week I'll go ahead and
> merge this into the selinux/next tree.

No objections, but plenty of ACKs and Reviewed-bys so I just merged
this into the selinux/next tree.

Thanks all.

>> diff --git a/fs/namei.c b/fs/namei.c
>> index d41fab7..482414a 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -340,22 +340,14 @@ int generic_permission(struct inode *inode, int mask)
>>
>>         if (S_ISDIR(inode->i_mode)) {
>>                 /* DACs are overridable for directories */
>> -               if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
>> -                       return 0;
>>                 if (!(mask & MAY_WRITE))
>>                         if (capable_wrt_inode_uidgid(inode,
>>                                                      CAP_DAC_READ_SEARCH))
>>                                 return 0;
>> -               return -EACCES;
>> -       }
>> -       /*
>> -        * Read/write DACs are always overridable.
>> -        * Executable DACs are overridable when there is
>> -        * at least one exec bit set.
>> -        */
>> -       if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
>>                 if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
>>                         return 0;
>> +               return -EACCES;
>> +       }
>>
>>         /*
>>          * Searching includes executable on directories, else just read.
>> @@ -364,6 +356,14 @@ int generic_permission(struct inode *inode, int mask)
>>         if (mask == MAY_READ)
>>                 if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
>>                         return 0;
>> +       /*
>> +        * Read/write DACs are always overridable.
>> +        * Executable DACs are overridable when there is
>> +        * at least one exec bit set.
>> +        */
>> +       if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
>> +               if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
>> +                       return 0;
>>
>>         return -EACCES;
>>  }
>> --
>> 2.7.4
>>
>
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
