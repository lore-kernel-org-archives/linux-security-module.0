From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 28 Jun 2018 13:28:50 -0500
Subject: [PATCH] cap_inode_getsecurity: use d_find_any_alias() instead of
	d_find_alias()
In-Reply-To: <CAOQ4uxjOSTvEt5MBmZY7UqrsjuwGF9jKqK-v6YBFQwLt5wZuRg@mail.gmail.com>
References: <1530082758.30361.7.camel@mtkswgap22>
	<20180628150152.GA10398@mail.hallyn.com>
	<CAOQ4uxjJJZ=J2oaiga8M6QSM3HCM6a1CP5zUv4uK5vODRJj2Vg@mail.gmail.com>
	<20180628172648.GA12196@mail.hallyn.com>
	<CAOQ4uxjOSTvEt5MBmZY7UqrsjuwGF9jKqK-v6YBFQwLt5wZuRg@mail.gmail.com>
Message-ID: <20180628182850.GA12845@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Amir Goldstein (amir73il at gmail.com):
...
> >> Without arguing what the expected behavior should be (I believe
> >
> > Yes, I avoided mentioning that in my first email because I kept
> > waffling.  It seems like requiring a package manager that cares
> > to clear the fscaps (maybe just chowning to clear all suid/etc)
> > is the right thing.  On the other hand demanding extra work from
> > pre-existing users for a new features is wrong.
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> >> execveat is meant to prevent to exact opposite attack), the change
> >> in this patch does NOT change behavior for ext4 and probably
> >> other local file systems. It *only* changes behavior for overlayfs
> >
> > Hm, I'll have to take your word for it - following the code in
> > vfs_unlink() seems to suggest it's immediately unhashed, and the
> > ext4 orphan list only holds the inode without any hashed dentries.
> > But I'm probably mis-reading.
> >
> 
> Hmm, don't take my word for it, but this is what Eddie reported.
> Reproducer works with overlayfs and not with ext4.
> I see that d_delete() prefers to keep the dentry hashed but turn it
> into a negative dentry if "we are the only user",
> which is the case in this reproducer.
> But I don't expect that d_find_alias() will find a negative dentry!,
> so I can't explain why ext4 passes the reproducer.
> Overlayfs OTOH, does explicit d_drop() in file system code,
> so it is positive that d_find_any_alias() is needed for overlayfs
> as the reproducer shows.

Ah - I just tried his reproducer, and in fact got:

0 ? serge at sl ~/test $ getcap execveat
execveat = cap_sys_admin+ep
0 ? serge at sl ~/test $ ./execveat
execveat: Bad file descriptor

on ext4, with 4.15.0-22-generic #24~16.04.1-Ubuntu

Without the filecap, it works.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
