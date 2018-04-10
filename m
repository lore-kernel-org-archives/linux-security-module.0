From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 10 Apr 2018 09:42:50 -0500
Subject: KASAN: null-ptr-deref Read in xattr_getsecurity
In-Reply-To: <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
	(Tetsuo Handa's message of "Tue, 10 Apr 2018 19:13:23 +0900")
References: <0000000000008d2e0d05697a693d@google.com>
	<9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
Message-ID: <87o9irw2ad.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> From 904d07a6eb014f3df0c5a1ebfcfd4323276a9a76 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 10 Apr 2018 15:15:16 +0900
> Subject: [PATCH] commoncap: Handle memory allocation failure.
>
> syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
> for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
> memory allocation failed. Return -ENOMEM if memory allocation failed.
>
> [1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Tetsuo I can pick this up, or do you have preferred path for getting
this change merged?

Serge does this fix look ok to you?  I am a bit worried that
might be a bit brittler but I don't see any issues with this change.

Eric


> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
> Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
> Cc: stable <stable@vger.kernel.org> # 4.14+
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  security/commoncap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48620c9..1ce701f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  				magic |= VFS_CAP_FLAGS_EFFECTIVE;
>  			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
>  			cap->magic_etc = cpu_to_le32(magic);
> +		} else {
> +			size = -ENOMEM;
>  		}
>  	}
>  	kfree(tmpbuf);
> --
> 1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
