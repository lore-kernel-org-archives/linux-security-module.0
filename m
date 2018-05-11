From: jmorris@namei.org (James Morris)
Date: Sat, 12 May 2018 06:09:49 +1000 (AEST)
Subject: [PATCH v3 1/3] big key: get rid of stack array allocation
In-Reply-To: <20180424202639.19830-1-tycho@tycho.ws>
References: <20180424202639.19830-1-tycho@tycho.ws>
Message-ID: <alpine.LRH.2.21.1805120609250.6601@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 24 Apr 2018, Tycho Andersen wrote:

> We're interested in getting rid of all of the stack allocated arrays in the
> kernel [1]. This patch simply hardcodes the iv length to match that of the
> hardcoded cipher.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
>     sanity check in init(), Eric Biggers
> v3: * remember to free big_key_aead when sanity check fails
>     * define a constant for big key IV size so it can be changed along side
>       the algorithm in the code

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


Thanks!


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
