From: jmorris@namei.org (James Morris)
Date: Tue, 18 Apr 2017 07:38:45 +1000 (AEST)
Subject: [GIT PULL] KEYS: Blacklisting, restrictions and DH
In-Reply-To: <18309.1492008274@warthog.procyon.org.uk>
References: <18309.1492008274@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.20.1704180738310.11039@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 12 Apr 2017, David Howells wrote:

> 
> Hi James,
> 
> Could you pull these changes into security/next please:
> 
>  (1) Provide a blacklist keyring and a blacklist key type such that X.509
>      keys and PKCS#7 certs can be blacklisted.  It is possible to load the
>      blacklist from a file at compile time.  A future patch will
>      additionally load the blacklist from the UEFI blacklist if available.
> 
>  (2) Make it possible to create a userspace keyring and to apply a
>      restriction to it such that no new keys can be added unless they meet
>      the criteria.
> 
>  (3) Add SP800-56A KDF support for the DH operation.
> 

Pulled, thanks.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
