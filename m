From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 11 Apr 2018 06:00:44 +0900
Subject: KASAN: null-ptr-deref Read in xattr_getsecurity
In-Reply-To: <87o9irw2ad.fsf@xmission.com>
References: <0000000000008d2e0d05697a693d@google.com>
	<9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
	<87o9irw2ad.fsf@xmission.com>
Message-ID: <201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
> 
> > From 904d07a6eb014f3df0c5a1ebfcfd4323276a9a76 Mon Sep 17 00:00:00 2001
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date: Tue, 10 Apr 2018 15:15:16 +0900
> > Subject: [PATCH] commoncap: Handle memory allocation failure.
> >
> > syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
> > for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
> > memory allocation failed. Return -ENOMEM if memory allocation failed.
> >
> > [1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Tetsuo I can pick this up, or do you have preferred path for getting
> this change merged?

I don't have preferred path. You can pick this up. Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
