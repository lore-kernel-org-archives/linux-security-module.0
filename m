From: paul@paul-moore.com (Paul Moore)
Date: Tue, 11 Apr 2017 16:12:02 -0400
Subject: [PATCH 06/12] audit: Use timespec64 to represent audit timestamps
In-Reply-To: <CABeXuvoKmvbo_n3XQ0Y+iWGz88Jr3TwbPA7GiR3pia9407ANLw@mail.gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
	<1491613030-11599-7-git-send-email-deepa.kernel@gmail.com>
	<CAHC9VhTYWeKL+BAb6F3tfwzs7OKUEA8ANM=V05sfoiahNNX=9w@mail.gmail.com>
	<CABeXuvoKmvbo_n3XQ0Y+iWGz88Jr3TwbPA7GiR3pia9407ANLw@mail.gmail.com>
Message-ID: <CAHC9VhTMU7cEJD2rffxOshEnL18i597GBsvHZm-Y8hCE9SJCAA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Apr 8, 2017 at 1:58 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> I have no problem merging this patch into audit/next for v4.12, would
>> you prefer me to do that so at least this patch is merged?
>
> This would be fine.
> But, I think whoever takes the last 2 deletion patches should also take them.
> I'm not sure how that part works out.

FWIW, I just merged this into the audit/next branch so at least this
will go into v4.12.

>> It would probably make life a small bit easier for us in the audit
>> world too as it would reduce the potential merge conflict.  However,
>> that's a relatively small thing to worry about.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
