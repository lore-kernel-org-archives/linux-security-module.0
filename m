From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 26 Apr 2018 16:40:08 -0700
Subject: Extracting written string from the write syscall
In-Reply-To: <20180426185725.4a53fa47@ivy-bridge>
References: <CAH5sRbr_-nHPb8moqPyZ--JVOzGi+_PHVVteA+TXe-Yqaoa5xA@mail.gmail.com>
	<20180426185725.4a53fa47@ivy-bridge>
Message-ID: <1dfb37cb-b440-a3da-c6e2-c328d43ffa5a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/26/2018 3:57 PM, Steve Grubb wrote:
> On Thu, 26 Apr 2018 20:34:57 +0000
> Wajih Ul Hassan <wajih.lums@gmail.com> wrote:
>
>> Hi all,
>> I am using Linux Audit module to monitor file accesses. However, I
>> want to extract what exactly was written to a specific file. I am
>> catching the events belonging to write syscall, for example:
>>
>> type=SYSCALL msg=audit(04/26/2018 15:11:33.568:307907) : arch=x86_64
>> syscall=write success=yes exit=37 a0=0x3 a1=0x1aee240 a2=0x25 a3=0x477
>> items=0 ppid=11376 pid=26771 auid=wajih uid=wajih gid=wajih euid=wajih
>> suid=wajih fsuid=wajih egid=wajih sgid=wajih fsgid=wajih tty=pts1
>> ses=1 comm=a.out exe=/code/a.out key=(null)
>>
>> I know the "a1" is the pointer to buffer being written; however, is
>> there a way I can take that pointer and extract the exact string? In
>> the example above I was writing "Hello world ...".
> Short answer is no. There is no way I know of to do that via the audit
> system.

You could write a Linux Security Module (LSM) to monitor the
content of writes. The performance impact would be rather
amazing. 

>
> -Steve
>
> --
> Linux-audit mailing list
> Linux-audit at redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
