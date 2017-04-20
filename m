From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Apr 2017 14:28:59 -0700
Subject: [kernel-hardening] Re: [PATCH v3 1/2] modules:capabilities:
	automatic module loading restriction
In-Reply-To: <CAEiveUdFL53XyQpacmN6f8F28M0bLQDcetpRXJjrJ10vDmQi8Q@mail.gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-2-git-send-email-tixxdz@gmail.com>
	<1492654942.31767.21.camel@decadent.org.uk>
	<CAEiveUdS=GbyxDVeNFrjTmhvQB-a6UgrJXcGY=BYJLu+3z0x_Q@mail.gmail.com>
	<1492700543.31767.23.camel@decadent.org.uk>
	<CAEiveUdFL53XyQpacmN6f8F28M0bLQDcetpRXJjrJ10vDmQi8Q@mail.gmail.com>
Message-ID: <CAGXu5j+L9=tGH2xCKJ53NDYRM8PVVYyC2R8w7uahBO88cftZNg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 20, 2017 at 1:39 PM, Djalal Harouni <tixxdz@gmail.com> wrote:
> On Thu, Apr 20, 2017 at 5:02 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
>> On Thu, 2017-04-20 at 14:44 +0200, Djalal Harouni wrote:
>>> > On Thu, Apr 20, 2017 at 4:22 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>>> > On Thu, 2017-04-20 at 00:20 +0200, Djalal Harouni wrote:
>>> > [...]
> [...]
>>> modules_disabled is too restrictive and once set it can't be changed,
>>> maybe that's why not all users use it.
>>>
>>> With modules_disabled=0 and modules_autoload=2
>> [...]
>>
>> Hmm, OK.  How about naming this modules_autoload_mode, then, so that
>> it's obviously not a boolean?
>
> Yes that's fine by me, kees already suggested to rename it to
> "modules_autoload" I can change it to that if it's the best
> suggestion!

That's fine by me.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
