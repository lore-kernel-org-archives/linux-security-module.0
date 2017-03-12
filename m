From: jmorris@namei.org (James Morris)
Date: Mon, 13 Mar 2017 10:17:06 +1100 (AEDT)
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <CAEiveUfGHiz_oXgG9cscOF3ErdH9DJtp5zRxyCW+QbpzpYqc1w@mail.gmail.com>
References: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAEiveUfGHiz_oXgG9cscOF3ErdH9DJtp5zRxyCW+QbpzpYqc1w@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1703131012360.2317@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 12 Mar 2017, Djalal Harouni wrote:

> ...

Please trim quotes when replying.

> Is it possible to adapt some stacking bits from Casey's patches and
> stack this security field ? or at least try first to stack
> task->security without having to stack all the others cred->security,
> inode->security ... ?
> 
> IMO it would be better if the first LSM user gets this right, or at
> least the second LSM that uses the field without having to wait for
> the support of all security fields stacking.

As Tetsuo mentions in the changelog, he aims to revive the hook before 
modifying it for stacking.  I would also want to see a strong use-case for 
the stacking aspect (e.g. an existing LSM planning to use it, or as part 
of a proposal to merge a new LSM).

JJ: can you confirm that you'll use the revived hook in AppArmor?  I can 
see your acked-by but the context of it is lost due to the lack of mail 
archives.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
