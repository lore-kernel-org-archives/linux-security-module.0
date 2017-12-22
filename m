From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 21 Dec 2017 19:18:02 -0600
Subject: [PATCH] userns: honour no_new_privs for cap_bset during user ns
	creation/switch
In-Reply-To: <CAHo-OoyrOr5jXwU-j4Z4qYdWo40+qAdAk0r+OpfMUZ6LgbS-RA@mail.gmail.com>
	("Maciej \=\?utf-8\?Q\?\=C5\=BBenczykowski\=22's\?\= message of "Fri,
	22 Dec 2017 02:03:35 +0100")
References: <20171221210605.181720-1-zenczykowski@gmail.com>
	<87wp1foiwa.fsf@xmission.com>
	<CAHo-OoyrOr5jXwU-j4Z4qYdWo40+qAdAk0r+OpfMUZ6LgbS-RA@mail.gmail.com>
Message-ID: <87fu83lfw5.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Maciej ?enczykowski <zenczykowski@gmail.com> writes:

> On Thu, Dec 21, 2017 at 10:44 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> No.  This makes no logical sense.
>>
>> A task that enters a user namespace loses all capabilities to everything
>> outside of the user namespace.  Capabilities inside a user namespace are
>> only valid for objects created inside that user namespace.
>>
>> So limiting capabilities inside a user namespace when the capability
>> bounding set is already fully honored by not giving the processes any of
>> those capabilities makes no logical sense.
>>
>> If the concern is kernel attack surface versus logical permissions we
>> can look at ways to reduce the attack surface but that needs to be fully
>> discussed in the change log.
>
> Here's an example of using user namespaces to read a file you
> shouldn't be able to.
>
> lpk19:~# uname -r
> 4.15.0-smp-d1ce8ceb8ba8
>
> (we start as true global root)
> lpk19:~# id
> uid=0(root) gid=0(root) groups=0(root)
>
> (cleanup after previous run)
> lpk19:~# cd /; chattr -i /immu; rm -f /immu/log; rmdir /immu
>
> (now we create an append only logfile owned by target user:group)
> lpk19:~# cd /; mkdir /immu; touch /immu/log; chown produser:prod
> /immu/log; chmod a-rwx,u+w /immu/log; chattr +a /immu/log
>
> (let's show what things look like)
> lpk19:~# chattr +i /immu; ls -ld / /immu /immu/log; lsattr -d / /immu /immu/log
> drwxr-xr-x 22 root root 4096 Dec 21 16:33 /
> drwxr-xr-x 2 root root 4096 Dec 21 16:23 /immu
> --w------- 1 produser prod 0 Dec 21 16:23 /immu/log
> -----------I--e---- /
> ----i---------e---- /immu
> -----a--------e---- /immu/log
>
> (the immutable bit prevents us from changing permissions on the file)
> lpk19:/# chmod a+rwx /immu/log
> chmod: changing permissions of '/immu/log': Operation not permitted
>
> (the append only bit prevents us from simply overwriting the file)
> lpk19:/# echo log1 > /immu/log
> -bash: /immu/log: Operation not permitted
>
> (but we can append to it)
> lpk19:/# echo log1 >> /immu/log
>
> (we're global root with CAP_DAC_OVERRIDE, so we can *still* read it)
> lpk19:/# cat /immu/log
> log1
>
> (let's transition to target user)
> lpk19:/# su - produser
>
> produser at lpk19:~$ id
> uid=2080(produser) gid=620(prod) groups=620(prod)
>
> (we can't overwrite it)
> produser at lpk19:~$ echo log2 > /immu/log
> -su: /immu/log: Operation not permitted
>
> (but we can log to it: as intended)
> produser at lpk19:~$ echo log2 >> /immu/log
>
> (we can't change its permissions, cause it's in an immutable directory)
> produser at lpk19:~$ chmod u+r /immu/log
> chmod: changing permissions of '/immu/log': Operation not permitted
>
> (we can't dump the file, cause we don't have CAP_DAC_OVERRIDE)
> produser at lpk19:~$ cat /immu/log
> cat: /immu/log: Permission denied
>
> (or can we?)
> produser at lpk19:~$ unshare -U -r cat /immu/log
> log1
> log2
>
> ----
>
> Now, of course, the above patch doesn't actually fix this on it's own,
> since 'su' doesn't (yet?) know to restrict bset or to set
> no_new_privs.
>
> But: it allows the sandbox equivalent of su to drop CAP_DAC_OVERRIDE
> from it's inh/eff/perm/ambient/bset, and set no_new_privs.
> Now the unshare won't gain CAP_DAC_OVERRIDE and won't be able to cat
> the non-readable append-only log file.
>
> IMHO the point of having a capability bounding set and/or no_new_privs
> is to never be able to regain capabilities.
> Note also that 'no_new_privs' isn't cleared across a
> unshare(CLONE_NEWUSER) [presumably also applies to setns()].
>
> We can of course argue the implementation details (for example instead
> of using the existing no_new_privs flag, add a new
> keep_bset_across_userns_transitions securebits flag)... but
> *something* has to be done.

Good point about CAP_DAC_OVERRIDE on files you own.

I think there is an argument that you are playing dangerous games with
the permission system there, as it isn't effectively a file you own if
you can't read it, and you can't change it's permissions.

Given little things like that I can completely see no_new_privs meaning
you can't create a user namespace.  That seems consistent with the
meaning and philosophy of no_new_privs.  So simple it is hard to get
wrong.

We could do more clever things like plug this whole in user namespaces,
and that would not hurt my feelings.   However unless that is our only
choice to avoid badly breaking userspace I would have to have to depend
on user namespaces being perfect for no_new_privs to be a proper jail.

As a general rule user namespaces are where we tackle the subtle scary
things that should work, and no_new_privs is where we implement a simple
hard to get wrong jail.  Most of the time the effect is the same to an
outside observer (bounded permissions), but there is a real difference
in difficulty of implementation.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
