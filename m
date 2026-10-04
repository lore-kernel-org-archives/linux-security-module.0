Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34F353A6D;
	Sun,  4 Oct 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151567; cv=none; b=VmTC45OmyFIMDy03cqmhNFCD3YQalxYGsVCHB6uQtY6sXaYrjqew940WqOuBcwrOVwf+mAZmS4a2efAGvQRtz9BS8kEkrrhRG7xpkO8Hil1wmiuPsAXMnFE13FGtjOfbx6Szj24eTqNxXKzT8VbAkp21qkvUHRpwmfh3c/v+6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151567; c=relaxed/simple;
	bh=e4/e87GJmDIAzGMrT5lDJ8Od/fqkoi5lw7yjfInlkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkd0BD4cbYQmW+5p7B+mV1Td6mpOiip8ITkbsp4Mf+7/+Rl/my6uxmaE0MuuofAddyhJ3XTJAGloRiyMyVg2sb6qGN5lisvoqnkC1D01E5jDj0doZTln4O2KCsNQ06QvGy2Prv471HhmSiAaeVHut0zI0s9+6FWb6LAwidOf0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=s/PARN+d; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="s/PARN+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791151556; bh=e4/e87GJmDIAzGMrT5lDJ8Od/fqkoi5lw7yjfInlkKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/PARN+dX4gsnZ5GlvO1XifnTD4OWnOnsEdXvG0jq6XjlFaOJt6u4he6/fa/w9S4g
	 4dHz0Jl3RDGGwH6Sl5uZ5wG5TvgthjXo2mugqAVF0MEczV+oDpo1TkHL9bhisP6KTH
	 8k2PwhDT6zNY379oIlwiKmSUCNhJxTXaCSdgwYgMhybPfrDxw7CwpFD7UBLD9ncDrx
	 9ncbTkXHPz1QPuy3wWJlJ02GmxNISiFX4eA/bdsi1KUN4T1YNwTGzobIUk+zGs0Jh3
	 O0sM8sjM8tlxtx/fzCqTcDWJMuUA1KY4ZAb9lgGFmL976QLhM97Np+/XYtlMdYwsya
	 vo9IbobwBg+5Q==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1CF9FE1C; Sun,  4 Oct 2026 17:05:56 -0500 (CDT)
Date: Sun, 4 Oct 2026 17:05:56 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: tjdqudcks0424@naver.com
Cc: Micah Morton <mortonm@chromium.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	James Morris <jmorris@namei.org>,
	Thomas Cedeno <thomascedeno@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy
 lookup
Message-ID: <asLNxHYQ/xQ6KaWy@hallyn.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com>
 <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>

On Sat, Oct 03, 2026 at 07:34:15PM +0900, tjdqudcks0424@naver.com wrote:
> From: Sung Byeongchan <tjdqudcks0424@naver.com>
> 
> SafeSetID policies constrain the ID transitions available to a task for
> each source ID.  id_permitted_for_cred() always builds that source key
> from the old real UID, even when it is checking a GID transition.  If the
> real UID and real GID differ, the policy attached to the real GID is
> therefore missed and the lookup can return the unconstrained default.
> 
> On current mainline, a test task with real UID 1000, real GID 2000 and
> only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:2001 GID
> policy.  The bypass reproduced for setgid(), setegid(), setregid(),
> setresgid(), setfsgid() and setgroups() across three clean QEMU boots,
> and enabled access to a synthetic group-protected resource.  This shows
> a SafeSetID GID policy bypass and group privilege expansion; it does not
> show direct UID 0 elevation or a universal local privilege escalation.
> 
> Build the source key from the old real UID for UID policy checks and the
> old real GID for GID policy checks.  In three fixed-kernel boots, all
> tested non-allowlisted transitions were blocked while the allowed target,
> existing-ID, no-policy and UID-policy controls, and the existing SafeSetID
> selftest continued to pass.
> 
> Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handling")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI Codex
> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>

Seems obviously correct.  Thanks for the find and the fix.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/safesetid/lsm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index d5fb949050dd8..18124fc499dbc 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -148,13 +148,16 @@ static int safesetid_security_capable(const struct cred *cred,
>  static bool id_permitted_for_cred(const struct cred *old, kid_t new_id, enum setid_type new_type)
>  {
>  	bool permitted;
> +	kid_t source_id;
>  
>  	/* If our old creds already had this ID in it, it's fine. */
>  	if (new_type == UID) {
> +		source_id.uid = old->uid;
>  		if (uid_eq(new_id.uid, old->uid) || uid_eq(new_id.uid, old->euid) ||
>  			uid_eq(new_id.uid, old->suid))
>  			return true;
>  	} else if (new_type == GID){
> +		source_id.gid = old->gid;
>  		if (gid_eq(new_id.gid, old->gid) || gid_eq(new_id.gid, old->egid) ||
>  			gid_eq(new_id.gid, old->sgid))
>  			return true;
> @@ -162,11 +165,10 @@ static bool id_permitted_for_cred(const struct cred *old, kid_t new_id, enum set
>  		return false;
>  
>  	/*
> -	 * Transitions to new UIDs require a check against the policy of the old
> -	 * RUID.
> +	 * Transitions require a check against the policy of the old real ID.
>  	 */
>  	permitted =
> -	    setid_policy_lookup((kid_t){.uid = old->uid}, new_id, new_type) != SIDPOL_CONSTRAINED;
> +	    setid_policy_lookup(source_id, new_id, new_type) != SIDPOL_CONSTRAINED;
>  
>  	if (!permitted) {
>  		if (new_type == UID) {
> -- 
> 2.43.0
