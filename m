From: paul@paul-moore.com (Paul Moore)
Date: Thu, 22 Feb 2018 18:08:05 -0500
Subject: [PATCH V7 2/4] sctp: Add ip option support
In-Reply-To: <161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20180220191527.14307-1-richard_c_haines@btinternet.com>
	<20180221143345.GA3888@localhost.localdomain>
	<161ba1d60d8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Message-ID: <CAHC9VhSnPku5SYnNkyUqvi46OpzPZKbJf+fxeCR0y3ym0zcMYA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 21, 2018 at 3:45 PM, Paul Moore <paul@paul-moore.com> wrote:
> On February 21, 2018 9:33:51 AM Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>> On Tue, Feb 20, 2018 at 07:15:27PM +0000, Richard Haines wrote:
>>> Add ip option support to allow LSM security modules to utilise CIPSO/IPv4
>>> and CALIPSO/IPv6 services.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> LGTM too, thanks!
>>
>> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>
> I agree, thanks everyone for all the work, review, and patience behind this patchset!  I'll work on merging this into selinux/next and I'll send a note when it's done.

I just merged the four patches (1,3,4 from the v6 patchset, 2 from the
v7 patchset) in selinux/next and did a quick sanity test on the kernel
(booted, no basic SELinux regressions).  Additional testing help is
always appreciated ...

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
