Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426580;
	b=mMxixeHzpFTdMlfcqhCXIhdTxVree5/6plwYGeG30++jNq5JYGmiaRCde81IVWCNALl9
	 S19BoR3K4e2w3HpqI1wft2muE1jT/+ET8NZqjg/i8wz2PlM4SGQLlZALmHOKE1t/oBpqJ
	 Yy3QGE+F8rDKgmEubeKp2rG124orpykTXYLNpGlZswv7t1s0O1IYd340cvYGK5uUCUojS
	 0GvxeadUtQHjAGTxQwOUaJZI6MZxXjW3OOBVdAX8WFM8qDU/RayTN58Mv8uSZvKB7bNwv
	 VJbGuYoVPs14JAoMtlyjVB586c490xpSIuFh5jPzlVZyTrLY/0NBR4qDVbaQqof2xeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=908k6raXrWe+5Y/o5xLdrCwQN00EKqLfE0+2dYcSwcI=;
	b=EoVw5bPO9VbyPc4zF4sSuIUgnFPgh5oyhulO3cWRQr40wq7eo4euX5gQUmkQ3U5uoRB1
	 F5znNdXlDlaBFmj1hpd8YiiAbPKfOqZzvnCeh0OZBnDmnw43SKLXa73YqmFfftmhl2xGR
	 mrF/TwbAiefkk7zBQZIUr6NKqw2Zmyk57WIDHyF8a7cQm0EvcpMWL5eoQOPrF1qUNMA13
	 CBE1cij0Jqs64MZ8yNZLkzl86pbsj+PsdMUmglqQodzDOUb3sdklDY20N9nsvPeJvPudI
	 81vLd8LBPXdXRYJvVRRaRYCUoLZeF2TiYFh2E2csw0jUfjS0X8LUwP9CKxgAW3mBtyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1gv0wca;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C330606A32E
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1gv0wca
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC891F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426573;
	bh=908k6raXrWe+5Y/o5xLdrCwQN00EKqLfE0+2dYcSwcI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=J1gv0wcaoJzEUgYzEwmRlXDPiHuQTEGV/IaVGJk0RY4pSSFev+zHtR9XXRsC7ogrj
	 Q3oEvo3D+xClzEmc7MJ0RoZeGQCi9dCxlQzVKTZda7QARuKI4ILPlQ8kswBnZ0PpXQ
	 pP1QnVT/zUpI9s8WqFFqR/w+ziWdPMMXTvhL/j/qGTZ77BA2vqX4ps5e2y2pV7wnjF
	 Js7H8jkzkbqN7nS0JHmW5/I03L60+XZWNV7LESqsfGEyEJiRApIr0VFU0lFX6lF/QP
	 dyWs6WTFrqz1QPVn+wtihvSupaCkntuKZjfFM6Trd8aPJ9fTIg9E9UF2co7ys9UR1u
	 S33Ju8b8OwauQ==
Message-ID: <sashiko-outbox-177855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KEYS: Return user session keyring on lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019145624.309790-1-jarkko@kernel.org>
References: <20261019145624.309790-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:16:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] keys: NULL dereference in keyctl_session_to_parent() without s=
ession keyring
--

commit e79a6a32e7b5e470d5cab49936bcd7b8bfc551d1
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Return user session keyring on lookup

This commit changes lookup_user_key() so that looking up
KEY_SPEC_SESSION_KEYRING without KEY_LOOKUP_CREATE returns the user session
keyring directly instead of installing it into the current task's
credentials.

> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index a63c46bb2d148..a5aa056a67259 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
[ ... ]
> @@ -665,20 +640,21 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned=
 long lflags,
> =20
>  	case KEY_SPEC_SESSION_KEYRING:
>  		if (!ctx.cred->session_keyring) {
> -			/* always install a session keyring upon access if one
> -			 * doesn't exist yet */
>  			ret =3D look_up_user_keyrings(NULL, &user_session);
>  			if (ret < 0)
>  				goto error;
> -			if (lflags & KEY_LOOKUP_CREATE)
> +
> +			if (lflags & KEY_LOOKUP_CREATE) {
> +				key_put(user_session);
>  				ret =3D join_session_keyring(NULL);
> -			else
> -				ret =3D install_session_keyring(user_session);
> +				if (ret < 0)
> +					goto error;
> +				goto reget_creds;
> +			}
> =20
> -			key_put(user_session);
> -			if (ret < 0)
> -				goto error;
> -			goto reget_creds;
> +			key =3D user_session;
> +			key_ref =3D make_key_ref(key, 1);
> +			break;

[Severity: Critical]
Could returning user_session here without installing it into the current
task's credentials cause a NULL pointer dereference in
keyctl_session_to_parent()?

In security/keys/keyctl.c, keyctl_session_to_parent() looks up
KEY_SPEC_SESSION_KEYRING without KEY_LOOKUP_CREATE and stores the returned
keyring in cred->session_keyring:

security/keys/keyctl.c:keyctl_session_to_parent() {
	keyring_r =3D lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_LINK);
	if (IS_ERR(keyring_r))
		return PTR_ERR(keyring_r);
	...
	cred->session_keyring =3D key_ref_to_ptr(keyring_r);
	...
	mycred =3D current_cred();
	pcred =3D __task_cred(parent);
	if (mycred =3D=3D pcred ||
	    mycred->session_keyring =3D=3D pcred->session_keyring) {
		ret =3D 0;
		goto unlock;
	}
	...
	/* the keyrings must have the same UID */
	if ((pcred->session_keyring &&
	     !uid_eq(pcred->session_keyring->uid, mycred->euid)) ||
	    !uid_eq(mycred->session_keyring->uid, mycred->euid))
		goto unlock;
}

Previously, lookup_user_key() installed user_session into the current
task's credentials, guaranteeing that mycred->session_keyring was non-NULL.

With this change, if a child process has no session keyring
(mycred->session_keyring is NULL) and its parent has a non-NULL
pcred->session_keyring with matching ownership, the check
mycred->session_keyring =3D=3D pcred->session_keyring is false, and
!uid_eq(mycred->session_keyring->uid, mycred->euid) dereferences NULL
while holding write_lock_irq(&tasklist_lock) and rcu_read_lock().

Additionally, if both the child and the parent have session_keyring =3D=3D =
NULL,
mycred->session_keyring =3D=3D pcred->session_keyring evaluates to true (NU=
LL =3D=3D
NULL), causing keyctl_session_to_parent() to return 0 early without
installing cred->session_keyring onto the parent.

Should keyctl_session_to_parent() check cred->session_keyring instead of
mycred->session_keyring (and avoid the mycred =3D=3D pcred early exit when
mycred->session_keyring is NULL)?

>  		} else if (test_bit(KEY_FLAG_UID_KEYRING,
>  				    &ctx.cred->session_keyring->flags) &&
>  			   lflags & KEY_LOOKUP_CREATE) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019145624.3097=
90-1-jarkko@kernel.org?part=3D1
