From: john.johansen@canonical.com (John Johansen)
Date: Sun, 12 Mar 2017 16:56:14 -0700
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <alpine.LRH.2.20.1703131012360.2317@namei.org>
References: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAEiveUfGHiz_oXgG9cscOF3ErdH9DJtp5zRxyCW+QbpzpYqc1w@mail.gmail.com>
	<alpine.LRH.2.20.1703131012360.2317@namei.org>
Message-ID: <02803f61-29e6-97ea-7ed2-babce48206da@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/12/2017 04:17 PM, James Morris wrote:
> On Sun, 12 Mar 2017, Djalal Harouni wrote:
> 
>> ...
> 
> Please trim quotes when replying.
> 
>> Is it possible to adapt some stacking bits from Casey's patches and
>> stack this security field ? or at least try first to stack
>> task->security without having to stack all the others cred->security,
>> inode->security ... ?
>>
>> IMO it would be better if the first LSM user gets this right, or at
>> least the second LSM that uses the field without having to wait for
>> the support of all security fields stacking.
> 
> As Tetsuo mentions in the changelog, he aims to revive the hook before 
> modifying it for stacking.  I would also want to see a strong use-case for 
> the stacking aspect (e.g. an existing LSM planning to use it, or as part 
> of a proposal to merge a new LSM).
> 
To add to this Tetsuo did have versions with some stacking infrastructure
in them, and we asked that the stacking be separated, to keep the patch
as simple as possible, and separate it from the stacking discussion.

Once this goes in, I expect stacking patches and discussion will follow

> JJ: can you confirm that you'll use the revived hook in AppArmor?  I can 
> see your acked-by but the context of it is lost due to the lack of mail 
> archives.
> 
Yes, it will cleanup apparmor's abuse of the cred, storing the info for
a tasks setexecon and change_hat tokens. We can get away with doing this
on the cred like selinux but it is worse for apparmor as its not just
copying a secid around, but involves a manipulating a couple of reference
counts.

I floated a patch for apparmor to use the task security field in support
of this in reply last time Tetsuo posted this up. I can reply with the patch
again to add it to this thread if you would like.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
