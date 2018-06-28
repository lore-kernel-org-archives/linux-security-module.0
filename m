From: amir73il@gmail.com (Amir Goldstein)
Date: Thu, 28 Jun 2018 19:54:02 +0300
Subject: [PATCH] cap_inode_getsecurity: use d_find_any_alias() instead of
	d_find_alias()
In-Reply-To: <20180628150152.GA10398@mail.hallyn.com>
References: <1530082758.30361.7.camel@mtkswgap22>
	<20180628150152.GA10398@mail.hallyn.com>
Message-ID: <CAOQ4uxjJJZ=J2oaiga8M6QSM3HCM6a1CP5zUv4uK5vODRJj2Vg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 28, 2018 at 6:01 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Eddie.Horng (eddie.horng at mediatek.com):
>>
>> The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
>> ("Introduce v3 namespaced file capabilities"), should use
>> d_find_any_alias()
>> instead of d_find_alias() do handle unhashed dentry correctly. This is
>> needed,
>> for example, if execveat() is called with an open but unlinked overlayfs
>> file, because overlayfs unhashes dentry on unlink.
>>
>> Below reproducer and setup can reproduce the case.
>>   const char* exec="echo";
>>   const char *newargv[] = { "echo", "hello", NULL};
>>   const char *newenviron[] = { NULL };
>>   int fd, err;
>>
>>   fd = open(exec, O_PATH);
>>   unlink(exec);
>>   err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
>> AT_EMPTY_PATH);
>>   if(err<0)
>>     fprintf(stderr, "execveat: %s\n", strerror(errno));
>>
>> gcc compile into ~/test/a.out
>> mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
>> none /mnt/m
>> cd /mnt/m
>> cp /bin/echo .
>> ~/test/a.out
>>
>> Expected result:
>> hello
>> Actually result:
>> execveat: Invalid argument
>> dmesg:
>> Invalid argument reading file caps for /dev/fd/3
>>
>> Suggested-by: Amir Goldstein <amir73il@gmail.com>
>> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
>
> Did 8db6c34f1dbc actually introduce a regression?
>

Yes, it did. The regression was reported to the overlayfs list:
https://marc.info/?l=linux-unionfs&m=152940239421174&w=2

I directed Eddie toward this simple reproducer, but problem
was observed in real life environment.

I realize now that the information about the original regression
is missing from the commit message.
Eddie you may add a link to the mailing list thread in your
commit message, but please do mention the nature of the
regression you reported is a real life application.

> Note this does seem to potentially introduce an attack where a
> user fetches an open fd to any file with filecaps, waits for a
> CVE publication, then after the admin has updated the package
> causing the file to be deleted, then does execveat to run the
> deleted package with privs.
>

Without arguing what the expected behavior should be (I believe
execveat is meant to prevent to exact opposite attack), the change
in this patch does NOT change behavior for ext4 and probably
other local file systems. It *only* changes behavior for overlayfs
and possibly other networking file systems that unhash the dentry
on unlink.

So the attack vector you are referring to exists in current code
as well for local file systems.

Thanks,
Amir.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
