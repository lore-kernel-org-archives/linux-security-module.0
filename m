From: jmorris@namei.org (James Morris)
Date: Thu, 28 Sep 2017 09:14:58 +1000 (AEST)
Subject: [GIT PULL] KEYS: Fixes and crypto fixes
In-Reply-To: <28036.1506547164@warthog.procyon.org.uk>
References: <28036.1506547164@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1709280912400.12069@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 27 Sep 2017, David Howells wrote:

>  (2) Fixing big_key to use safe crypto from Jason A. Donenfeld.
> 

I'm concerned about the lack of crypto review mentioned by Jason -- I 
wonder if we can get this rewrite any more review from crypto folk.

Also, are there any tests for this code?  If not, it would be good to make 
some.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
