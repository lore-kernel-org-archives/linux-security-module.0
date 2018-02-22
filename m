From: jbohac@suse.cz (Jiri Bohac)
Date: Thu, 22 Feb 2018 19:44:28 +0100
Subject: [PATCH 04/30] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <30284.1519304877@warthog.procyon.org.uk>
References: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<30284.1519304877@warthog.procyon.org.uk>
Message-ID: <20180222184428.yby6usf4b5pd6nrw@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Feb 22, 2018 at 01:07:57PM +0000, David Howells wrote:
> I'm considering folding the attached changes into this patch.
> 
> It adjusts the errors generated:
> 
>  (1) If there's no signature (ENODATA) or we can't check it (ENOPKG, ENOKEY),
>      then:
> 
>      (a) If signatures are enforced then EKEYREJECTED is returned.
> 
>      (b) If IMA will have validated the image, return 0 (okay).
> 
>      (c) If there's no signature or we can't check it, but the kernel is
> 	 locked down then EPERM is returned (this is then consistent with
> 	 other lockdown cases).
> 
>  (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
>      the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we return
>      the error we got.
> 
> Note that the X.509 code doesn't check for key expiry as the RTC might not be
> valid or might not have been transferred to the kernel's clock yet.

Looks good. 

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
