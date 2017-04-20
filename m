From: tixxdz@gmail.com (Djalal Harouni)
Date: Thu, 20 Apr 2017 22:39:21 +0200
Subject: [kernel-hardening] Re: [PATCH v3 1/2] modules:capabilities:
	automatic module loading restriction
In-Reply-To: <1492700543.31767.23.camel@decadent.org.uk>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-2-git-send-email-tixxdz@gmail.com>
	<1492654942.31767.21.camel@decadent.org.uk>
	<CAEiveUdS=GbyxDVeNFrjTmhvQB-a6UgrJXcGY=BYJLu+3z0x_Q@mail.gmail.com>
	<1492700543.31767.23.camel@decadent.org.uk>
Message-ID: <CAEiveUdFL53XyQpacmN6f8F28M0bLQDcetpRXJjrJ10vDmQi8Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 20, 2017 at 5:02 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Thu, 2017-04-20 at 14:44 +0200, Djalal Harouni wrote:
>> > On Thu, Apr 20, 2017 at 4:22 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>> > On Thu, 2017-04-20 at 00:20 +0200, Djalal Harouni wrote:
>> > [...]
[...]
>> modules_disabled is too restrictive and once set it can't be changed,
>> maybe that's why not all users use it.
>>
>> With modules_disabled=0 and modules_autoload=2
> [...]
>
> Hmm, OK.  How about naming this modules_autoload_mode, then, so that
> it's obviously not a boolean?

Yes that's fine by me, kees already suggested to rename it to
"modules_autoload" I can change it to that if it's the best
suggestion!

Thanks!

> Ben.
>
> --
> Ben Hutchings
> It is easier to change the specification to fit the program than vice
> versa.
>



-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
