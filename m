Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805149;
	b=mnSuaEB9W3rucamGnRSDfC+OTb7W7JwCw8N8VosJuXlaF4XvFpL6pYP3pFSfAw0BdVRF
	 OaWWNZNPmNcExwT2WPd34FnpLs97X/qFMTapOwEvT6/x7AJZfj+Zyz5UXznTZ2QpsnaTS
	 Mm8D3g5NtmTRh+wvbWndy5Wp6cDT/wWtWi/7TN6ljqL/QzuKJpd+NfaUL4EUCOEESiMzP
	 t7jTc6N7uATRcEBEf1D7OGh54xVYs/RKTufo0VAfPajbHM5smsaoFR+lwTFDB2BBNwsle
	 TWL3W2KrBsS5sj2PI3cBTs8LfKSraS44P52Ap2oXCXffMkDZt3Sv146srsZwat3hmng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805149;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mNsnA0TOEyA9RhXjY4UU+b1bbqT9HnTY9NFdJypcu0g=;
	b=ICfBr7e+p5yGx9yyEq3cG4y74y+0zpA6BQpg2ksOsmA4s5zqDQvY5KHTo4DAawfIH5DO
	 y5WvF/75dC1rHj/vlMzSwx3KeN+g4mWuINZ4Pnw6c1U2tAmR0hpSGGqXpPeib+EbAOQZS
	 0p85UA8zNmGWnDbb8uQHuzqtmx0cG7Iva3dMkBFjrHin0XpaymVmATVg4WCyPucXVPmUy
	 FNMTNEXR/KjnIEWJFHd+TjuyosoSeSEgw4ZLnaCKQvV4x+rjTMuDYik5cSi4mamzAk89c
	 jtIeknNscNW+hrMRESbhTAwolwT1wfypFEJihARJwZmQc3nbqm9/uhFQ+RS3yXXQNfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lPKt0UGS;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC84606A332
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC84606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lPKt0UGS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793805139; bh=QfBxvP/UKTnrXRWjxb4yZqeh7C5nfHHXm4pym5fHzmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPKt0UGSJKATtwhsQxuStCgyUe8FfGIoKZE05EAoLL/RZiZ1hBq6Pprs/INBERT3S
	 27eSrIZQgz88Nkbd68pOZxMFaKiH4D/3pzCCYh2pLpyckpLRw4U4hnOVxzMhczxvgH
	 hMGTlWG3N/6nJz07URCS5MDUZfaov5oUvge6HUEm67KqZa/X6+VxOFMQ52RjzU+Imd
	 LyqP/H2A+uPW8BDDV95JoVXFACmxfkGgUXlxYu5HsRfouD/J7ezlWCNeLxxr8CnbFm
	 rTHNbVk29LIGLNlQOpEpR4rxmFmn9pr2GGwZWHh4nuJOjt/EfCROLFdj7lcNjAgdAt
	 XxK8HVQQu755A==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 17DD521D1; Wed,  4 Nov 2026 09:12:19 -0600 (CST)
Date: Wed, 4 Nov 2026 09:12:19 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] security: commoncap: drop stale CAP_FS_MASK FIXME
Message-ID: <autLU/4nEnRQ+lWA@hallyn.com>
References: <20261026131010.1822069-1-adrianox@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026131010.1822069-1-adrianox@gmail.com>

On Mon, Oct 26, 2026 at 10:10:10AM -0300, Adriano Cordova wrote:
> CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so cap_task_fix_setuid() drops that set from the effective set when
> fsuid leaves 0.  Remove the stale FIXME.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Thanks.  Will add this to caps-next for next merge.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v3: just drop the FIXME instead of replacing it with another explanation.
> 
>  security/commoncap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fe..484d2b9256e9 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1171,9 +1171,6 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>  	case LSM_SETID_FS:
>  		/* juggle the capabilities to follow FSUID changes, unless
>  		 * otherwise suppressed
> -		 *
> -		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
> -		 *          if not, we might be a bit too harsh here.
>  		 */
>  		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>  			kuid_t root_uid = make_kuid(old->user_ns, 0);
> -- 
> 2.51.0
