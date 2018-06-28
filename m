From: amir73il@gmail.com (Amir Goldstein)
Date: Thu, 28 Jun 2018 20:57:29 +0300
Subject: [PATCH] cap_inode_getsecurity: use d_find_any_alias() instead of
	d_find_alias()
In-Reply-To: <20180628172648.GA12196@mail.hallyn.com>
References: <1530082758.30361.7.camel@mtkswgap22>
	<20180628150152.GA10398@mail.hallyn.com>
	<CAOQ4uxjJJZ=J2oaiga8M6QSM3HCM6a1CP5zUv4uK5vODRJj2Vg@mail.gmail.com>
	<20180628172648.GA12196@mail.hallyn.com>
Message-ID: <CAOQ4uxjOSTvEt5MBmZY7UqrsjuwGF9jKqK-v6YBFQwLt5wZuRg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 28, 2018 at 8:26 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Amir Goldstein (amir73il at gmail.com):
>> On Thu, Jun 28, 2018 at 6:01 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> > Quoting Eddie.Horng (eddie.horng at mediatek.com):
>> >>
>> >> The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
>> >> ("Introduce v3 namespaced file capabilities"), should use
>> >> d_find_any_alias()
>> >> instead of d_find_alias() do handle unhashed dentry correctly. This is
>> >> needed,
>> >> for example, if execveat() is called with an open but unlinked overlayfs
>> >> file, because overlayfs unhashes dentry on unlink.
>> >>
>> >> Below reproducer and setup can reproduce the case.
>> >>   const char* exec="echo";
>> >>   const char *newargv[] = { "echo", "hello", NULL};
>> >>   const char *newenviron[] = { NULL };
>> >>   int fd, err;
>> >>
>> >>   fd = open(exec, O_PATH);
>> >>   unlink(exec);
>> >>   err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
>> >> AT_EMPTY_PATH);
>> >>   if(err<0)
>> >>     fprintf(stderr, "execveat: %s\n", strerror(errno));
>> >>
>> >> gcc compile into ~/test/a.out
>> >> mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
>> >> none /mnt/m
>> >> cd /mnt/m
>> >> cp /bin/echo .
>> >> ~/test/a.out
>> >>
>> >> Expected result:
>> >> hello
>> >> Actually result:
>> >> execveat: Invalid argument
>> >> dmesg:
>> >> Invalid argument reading file caps for /dev/fd/3
>> >>
>> >> Suggested-by: Amir Goldstein <amir73il@gmail.com>
>> >> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
>> >
>> > Did 8db6c34f1dbc actually introduce a regression?
>> >
>>
>> Yes, it did. The regression was reported to the overlayfs list:
>> https://marc.info/?l=linux-unionfs&m=152940239421174&w=2
>>
>> I directed Eddie toward this simple reproducer, but problem
>> was observed in real life environment.
>>
>> I realize now that the information about the original regression
>> is missing from the commit message.
>> Eddie you may add a link to the mailing list thread in your
>> commit message, but please do mention the nature of the
>> regression you reported is a real life application.
>
> Ah, thanks.  I misunderstood, and thought that it was just a case
> of namespaced file capabilities not working.
>
>> > Note this does seem to potentially introduce an attack where a
>> > user fetches an open fd to any file with filecaps, waits for a
>> > CVE publication, then after the admin has updated the package
>> > causing the file to be deleted, then does execveat to run the
>> > deleted package with privs.
>> >
>>
>> Without arguing what the expected behavior should be (I believe
>
> Yes, I avoided mentioning that in my first email because I kept
> waffling.  It seems like requiring a package manager that cares
> to clear the fscaps (maybe just chowning to clear all suid/etc)
> is the right thing.  On the other hand demanding extra work from
> pre-existing users for a new features is wrong.
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
>> execveat is meant to prevent to exact opposite attack), the change
>> in this patch does NOT change behavior for ext4 and probably
>> other local file systems. It *only* changes behavior for overlayfs
>
> Hm, I'll have to take your word for it - following the code in
> vfs_unlink() seems to suggest it's immediately unhashed, and the
> ext4 orphan list only holds the inode without any hashed dentries.
> But I'm probably mis-reading.
>

Hmm, don't take my word for it, but this is what Eddie reported.
Reproducer works with overlayfs and not with ext4.
I see that d_delete() prefers to keep the dentry hashed but turn it
into a negative dentry if "we are the only user",
which is the case in this reproducer.
But I don't expect that d_find_alias() will find a negative dentry!,
so I can't explain why ext4 passes the reproducer.
Overlayfs OTOH, does explicit d_drop() in file system code,
so it is positive that d_find_any_alias() is needed for overlayfs
as the reproducer shows.

Thanks,
Amir.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
