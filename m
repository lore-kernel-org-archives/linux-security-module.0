From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 23 Jun 2017 08:26:44 -0700
Subject: The secmark "one user" policy
In-Reply-To: <alpine.LRH.2.20.1706231309350.17128@namei.org>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<118c3a45-8587-5cb9-fcd8-5cd8ca63a779@schaufler-ca.com>
	<alpine.LRH.2.20.1706231309350.17128@namei.org>
Message-ID: <734c4437-866b-ef10-0e1c-14b8d55dd528@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/22/2017 8:12 PM, James Morris wrote:
> On Thu, 22 Jun 2017, Casey Schaufler wrote:
>
>> The combination of SELinux, Smack, AppArmor and/or TOMOYO is not
>> the goal so much as the test case. MAC was the coolest possible
>> technology in 1990. We've implemented it. I don't see anyone doing
>> a new MAC implementation. I *do* see security modules that implement
>> other security models in the pipeline. Some of these need to maintain
>> state, which means using security blobs in the LSM architecture.
>> Some of these models will want to use secmarks to implement socket
>> based controls.
> Where are these LSMs and where are the discussions about their LSM API 
> needs? 

LandLock, CaitSith, LoadPin (now in), Checmate, HardChroot,
PTAGS, SimpleFlow, SafeName, WhiteEgret, shebang, and S.A.R.A.
have all been discussed on the LSM list in the past two years.
There is a growing interest in LSM as a hardening mechanism,
and there is discussion on kernel-hardening at lists.openwall.com.
I get inquiries from people who are considering writing, or
have started on new security modules but don't think they're
ready for general comment. This isn't surprising as I am the
vocal advocate for new, modern security modules. As you might
guess, some of those proposals never see wider discussion.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
