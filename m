From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 3 Apr 2018 12:01:08 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <9758.1522775763@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
	<CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
	<CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
	<9758.1522775763@warthog.procyon.org.uk>
Message-ID: <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Apr 3, 2018, at 10:16 AM, David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> wrote:
>
>>> A kernel that allows users arbitrary access to ring 0 is just an
>>> overfeatured bootloader. Why would you want secure boot in that case?
>>
>> To get a chain of trust.
>
> You don't have a chain of trust that you can trust in that case.
>

Please elaborate on why I can?t trust it. Please also elaborate on how
lockdown helps at all.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
