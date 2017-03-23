From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 23 Mar 2017 22:49:40 +0900
Subject: security,
	hugetlbfs: write to user memory in hugetlbfs_destroy_inode
In-Reply-To: <CACT4Y+ZHqNYPE_uMrc1NwX3Rb1FXYoN47D4eJFn=T07bSQ7YEw@mail.gmail.com>
References: <CACT4Y+Z1eodoxayi1qP-x05UoQ3nscXYUwA3UTN8ypOHfGJwjg@mail.gmail.com>
	<CACT4Y+ZHqNYPE_uMrc1NwX3Rb1FXYoN47D4eJFn=T07bSQ7YEw@mail.gmail.com>
Message-ID: <201703232249.CCF09362.LVtHFOFFOMOQJS@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Dmitry Vyukov wrote:
> On Thu, Mar 23, 2017 at 2:06 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hello,
> >
> > I've got the following report while running syzkaller fuzzer on
> > 093b995e3b55a0ae0670226ddfcb05bfbf0099ae. Note the preceding injected
> > kmalloc failure in inode_alloc_security, most likely it's the root
> > cause.

I don't think inode_alloc_security() failure is the root cause.
I think this is a bug in hugetlbfs or mm part.

If inode_alloc_security() fails, inode->i_security remains NULL
which was initialized to NULL at security_inode_alloc(). Thus,
security_inode_alloc() is irrelevant to this problem.

inode_init_always() returned -ENOMEM due to fault injection and

	if (unlikely(inode_init_always(sb, inode))) {
		if (inode->i_sb->s_op->destroy_inode)
			inode->i_sb->s_op->destroy_inode(inode);
		else
			kmem_cache_free(inode_cachep, inode);
		return NULL;
	}

hugetlbfs_destroy_inode() was called via inode->i_sb->s_op->destroy_inode()
when inode initialization failed

static void hugetlbfs_destroy_inode(struct inode *inode)
{
	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);
	call_rcu(&inode->i_rcu, hugetlbfs_i_callback);
}

but mpol_shared_policy_init() is called only when new_inode() succeeds.

	inode = new_inode(sb);
	if (inode) {
(...snipped...)
		info = HUGETLBFS_I(inode);
		/*
		 * The policy is initialized here even if we are creating a
		 * private inode because initialization simply creates an
		 * an empty rb tree and calls rwlock_init(), later when we
		 * call mpol_free_shared_policy() it will just return because
		 * the rb tree will still be empty.
		 */
		mpol_shared_policy_init(&info->policy, NULL);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
