From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 24 Mar 2018 00:37:19 -0500
Subject: [REVIEW][PATCH 03/11] msg/security: Pass kern_ipc_perm not
	msg_queue into the msg_queue security hooks
In-Reply-To: <bb73b0ea-bcda-a996-8f14-48d9dd1b0940@schaufler-ca.com> (Casey
	Schaufler's message of "Fri, 23 Mar 2018 14:55:09 -0700")
References: <87vadmobdw.fsf_-_@xmission.com>
	<20180323191614.32489-3-ebiederm@xmission.com>
	<bb73b0ea-bcda-a996-8f14-48d9dd1b0940@schaufler-ca.com>
Message-ID: <87efkam3u8.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 3/23/2018 12:16 PM, Eric W. Biederman wrote:
>> All of the implementations of security hooks that take msg_queue only
>> access q_perm the struct kern_ipc_perm member.  This means the
>> dependencies of the msg_queue security hooks can be simplified by
>> passing the kern_ipc_perm member of msg_queue.
>>
>> Making this change will allow struct msg_queue to become private to
>> ipc/msg.c.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  include/linux/lsm_hooks.h  | 12 ++++++------
>>  include/linux/security.h   | 25 ++++++++++++-------------
>>  ipc/msg.c                  | 18 ++++++++----------
>>  security/security.c        | 12 ++++++------
>>  security/selinux/hooks.c   | 36 ++++++++++++++++++------------------
>>  security/smack/smack_lsm.c | 24 ++++++++++++------------
>
> Can I reference the comments I made in PATCH 01 of this set
> regarding the Smack changes? The problem in all of your changes
> is the same. You aren't preserving the naming conventions, and
> you've left in some code that is just silly.

Being silly like that is actually important to make a sweeping patch
like that boring and trivial to show that it is correct.  Anything
that is not a rule based transformation is much more likely to hide
a bug.  So for the push down of the type change I think it was the right
way to go.

That said I am happy to add a clean up patch that makes the obvious
cleanups and simplifications to smack_lsm.c.

Eric




--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
