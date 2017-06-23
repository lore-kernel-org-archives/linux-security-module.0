From: jmorris@namei.org (James Morris)
Date: Fri, 23 Jun 2017 13:12:16 +1000 (AEST)
Subject: The secmark "one user" policy
In-Reply-To: <118c3a45-8587-5cb9-fcd8-5cd8ca63a779@schaufler-ca.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<118c3a45-8587-5cb9-fcd8-5cd8ca63a779@schaufler-ca.com>
Message-ID: <alpine.LRH.2.20.1706231309350.17128@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 22 Jun 2017, Casey Schaufler wrote:

> The combination of SELinux, Smack, AppArmor and/or TOMOYO is not
> the goal so much as the test case. MAC was the coolest possible
> technology in 1990. We've implemented it. I don't see anyone doing
> a new MAC implementation. I *do* see security modules that implement
> other security models in the pipeline. Some of these need to maintain
> state, which means using security blobs in the LSM architecture.
> Some of these models will want to use secmarks to implement socket
> based controls.

Where are these LSMs and where are the discussions about their LSM API 
needs? 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
