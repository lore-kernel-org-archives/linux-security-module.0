From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 5 May 2017 09:18:46 -0700
Subject: [PATCH v3 2/2] modules:capabilities: add a per-task modules
	autoload restriction
In-Reply-To: <CAEiveUf4p1A1fggwibN+kJW7ruasQCmzr6=GSpTZXoyjJuz00Q@mail.gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-3-git-send-email-tixxdz@gmail.com>
	<CALCETrXFp-apnfRPg9qx6E7g3KDU8DanBW1pMUnA1zShrB5xKg@mail.gmail.com>
	<CAGXu5jJ5dm8yJJ34tEyOP78OxUr2awXmNhm6RaVP8jE4q+L5Ng@mail.gmail.com>
	<CALCETrUueOx1tqj+Ru93KGpy2HHR-A_GQ6DrAppiomkPTtX7Lw@mail.gmail.com>
	<CAGXu5jJBp6VHvDP9182hJgvzS2sBUbUFpmZZ+196K2FcEHUxzw@mail.gmail.com>
	<CALCETrVZ2KH4s2uGW2J3zUQ8RNsrq=N7pJP=YDqd=+cp6fJW=g@mail.gmail.com>
	<CAEiveUdbQcfn1xC5xWMv91vL_uR1MGTvARqw-E4GDTMUZ6t=bA@mail.gmail.com>
	<CAEiveUf4p1A1fggwibN+kJW7ruasQCmzr6=GSpTZXoyjJuz00Q@mail.gmail.com>
Message-ID: <CALCETrWahivwjfMLQuLqg5w5K_xZG-+Yczqwr8Xyic4RACyBrA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 4, 2017 at 6:07 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
> On Sat, Apr 22, 2017 at 2:17 PM, Djalal Harouni <tixxdz@gmail.com> wrote:
>> On Sat, Apr 22, 2017 at 1:28 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> [...]
>>>
>>> My point is that all of these need some way to handle configuration
>>> and inheritance, and I don't think that a bunch of per-task prctls is
>>> the right way.  As just an example, saying that interactive users can
>>> autoload modules but other users can't, or that certain systemd
>>> services can, etc, might be nice.  Linus already complained that he
>>> (i.e. user "torvalds" or whatever) should be able to profile the
>>> kernel but that other uids should not be able to.
>>
>> Neat, maybe this could already be achieved with this interface and
>> systemd-logind,  "ModulesAutoloadUsers=andy" in logind.conf where
>> "andy" is the only logged-in user able to trigger and autoload kernel
>> modules. However maybe we should not restrict too much other bits or
>> functionality of the other users, please let me will follow up later
>> on it.
>>
>>> I personally like my implicit_rights idea, and it might be interesting
>>> to prototype it.
>>
>
> Andy following on the idea of per user settings, I'm curious did you
> manage to make some advance on how to store the user settings ? the
> user database format is old and not extensible, there was cgmanager or
> other libcgroup but for resources, and no simple thing for such
> restrictions example: "RestrictLinuxModules=user" that will prevent
> such users from making/loading extra Linux features/modules that are
> not already available...
>

I figured that user code would figure it out somehow.  Text config file?

There is another odd way it could be configured: just leave the inodes
around in /dev/rights with appropriate permissions.  Some startup
script could re-instantiate them with the same permissions (via a
syscall that does that atomically).
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
