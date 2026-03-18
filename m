Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA5E571
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815635; cv=none; b=nED/kLPELlkwU15ad3fjC/mR+qprSlPiJUix5WGE3siaV+M9+MNx4AXKaWG8tn8FR+Sbwml2b/7BVy3y5K8GF+izOnULNwVSBlBIvC+IN6+NtyxFup5ij66rqm7s+Y+NJbhq+FfhGW/xWBqaDFx+G3CzjA54q23mFumDaUTf708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815635; c=relaxed/simple;
	bh=CibzX7bbzsEgiiprekpY1SIRDiXHgWMU8csBmSBCWSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF9IWuJBaQxsZjqi+iiOWGaqatg69TCSq7a1niyvPhamtUwcqzXOVV2kHAi4313x7/bstbmQu+4uB4Xh3tnz64kAMTh9+jMygCV7PjpBvt0W4kxlDXs7ArNXsjDVvNwEdszO1fYISyKXqmIuzW4xftyFYuoKr9/MYouvzLs+8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ga2KvIcM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ga2KvIcM"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F4CB3FBB2
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815632;
	bh=tatDLGn7dwY1Bqm/LishEDRy7hSicbRAH8kK4WbxlFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Ga2KvIcM7ldu8vbnMhEk1fOOQIJxHliS53lxskpUkghln85dbx1vjKQFoJeO9+fLA
	 onogKCKfPtOqZB+ton7LmGHXsKFYfYfvD+F77bQGlHRLmEZMOzTt6BD2VXN1wrwmfQ
	 NQodXqMs/+2dgH+HNDJfDbKG/IG7oABYCxCCxky4iLCh4vWiI+UNXJ3eQaO4n5qcr/
	 l+LW9sDEx5EAyz2Iqz09Y8lBuBhEMjRO07GGC0pgxAb5g03ennOB+3ZWTNc5c8EBgx
	 JJ6ZsgdNqCPEPK1j1d1bK2bYG+jnIza2mhZSXitCAP9j4HalvIWpGfdK+b6+Y6Fjo9
	 1mrqRxhTM5BNamu4gTvfVH1ruqLjJxy/mePNxdshL/vInipIcd4cXFNVqk4mz4m9PU
	 ptRWxnF1QI4EfWWiabiAwfhORkjDPiascvy81SkcnlMAjOk1Ya+MHzJkeFsvQnHPT6
	 JSuefsEQBGijufEEBFSkECgvVyxGTAtt1mRWrlDNN0Qr4srd3BsOlJq57ERgImQANI
	 i9NrxuouvJ/yUKsmQzIHjQXGmttdbUUakpyyxm74Gn0HrhHXx8E5QzLprW5Rz/ZxGx
	 8m8t/gt7GHagmSwznRNRs+diIebLYFQCE9rH9SLutvzkvteVxNgULIN+8zOUAPJB5X
	 mpZsSwkygbHCwYowIR/B6D0o=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35a019abd6aso581324a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815631; x=1774420431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tatDLGn7dwY1Bqm/LishEDRy7hSicbRAH8kK4WbxlFQ=;
        b=UrvDRs91C6lp+/MlboZypWw87xH0eNyWBLFc7Rna8ynWZCcJf5cjQG4bW2NT7gXVAP
         GS39ZBHb1a25/RiXT1G+WNFkAC49NXOlCHSGIFixBv7/3huPFgIB+Qm63GQpXNIT0Llv
         CQiJgWBtvltVH5aENvDaeYtH732/CEwv/+5+DfeQ7YkOk/jGAI1Hel2kx9rx9w0oXGPL
         f5XMdKYCYljNWU/7tfgHE2jVQzCnIENSioNnZ6vaFQRq3/0QXbz2rl3/PCZ4eHlgACz2
         KZ22qxcELfNp/tBUpI0pL8X9e8TAQAq06riTQvAUh0ImSUtRq9QuFVDjvghEIGlTpMUe
         xplA==
X-Forwarded-Encrypted: i=1; AJvYcCWUG93bAbfd9ZRCsC/UDXAqSKC1AJ3i9QveH2F838HHJy02jVWlNpVw0IJyBUCptE1DEkAWwypeEAJovybOsmEumLCLTq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyjQchiEJ21GFbYH7mAF/7AI34zsxapdGkZo6/OERd0ZPppyB
	qtpU4vLeCbhIf0WX6VFDbyJaWBWwvJ0ki3a9dFHZtvODI9RMrwM50IH7JldnEwas+Bq4fiuw9f1
	4Nh36GuEVz7fEK7jCDENqrE8dNkQCdUg2tMPjC0kI0UTk9S9kQWJX3h13d1qWJQNyYA9hCs9hpn
	RhbVWZn/M6NdZSej1RRw==
X-Gm-Gg: ATEYQzxpDuYekBZeEDnGBYB98kjw/eMw7QDdZuvj2512IIGhaalzm1+6cOEwEs8L5lQ
	QUS8n6BW1ioVWl547jf9mazo6iACceq/rUc6eKxiyiCSdmtH8tBPYkoe5M4saij7i38QoL5QSzh
	hPrC/kpgECgU9PCcCK0q/lmzeA3CpFM+XkVjpzBn9YTBa2na5mkk9eHmngvpsJbNrOE7iP2iSHG
	GLo9AaWLOSXeV1tMeEYmlDwboyNu1oMJHHBX0F3Vwn6TqIrxF2DZ5J7zoopeobIre4BI41nvPVW
	7qPVK5LE7SHIP4acNFCUekXg23pR1Sw3KVlwDoVbMq4yxJXIfkVr0c7adjVwgT1j/4UV48raEH/
	K6MA05efGj5CJi8huo7kW0ODRfUOvgS7IZBj8hA==
X-Received: by 2002:a17:90b:3fc6:b0:35b:a41e:bcb2 with SMTP id 98e67ed59e1d1-35bada9ee8amr5873753a91.6.1773815630731;
        Tue, 17 Mar 2026 23:33:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc6:b0:35b:a41e:bcb2 with SMTP id 98e67ed59e1d1-35bada9ee8amr5873723a91.6.1773815630314;
        Tue, 17 Mar 2026 23:33:50 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35bba5c3eaasm1443857a91.16.2026.03.17.23.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:33:49 -0700 (PDT)
Message-ID: <e110e1e3-df4d-4827-83ac-bb06b40f45a0@canonical.com>
Date: Tue, 17 Mar 2026 23:33:48 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: hide unused get_loaddata_common_ref() function
To: Arnd Bergmann <arnd@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Cengiz Can <cengiz.can@canonical.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316135935.3321551-1-arnd@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20260316135935.3321551-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/26 06:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly introduced function is only used in an #ifdef block,
> which causes a harmless warning:
> 
> security/apparmor/apparmorfs.c:177:28: error: 'get_loaddata_common_ref' defined but not used [-Werror=unused-function]
>    177 | static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> 
> Move the definition next to the user to avoid the warning.
> 
> Fixes: 8e135b8aee5a ("apparmor: fix race between freeing data and fs accessing it")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: John Johansen <john.johansen@canonical.com>

this has now been pulled into my tree

> ---
> Alternatively, the #ifdef checks could be replaced with an
> 'if(IS_ENABLED(CONFIG_SECURITY_APPARMOR_EXPORT_BINARY) return;'
> check in __aa_fs_create_rawdata(), relying on the compiler's
> dead code elimination.
> ---
>   security/apparmor/apparmorfs.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index ededaf46f3ca..f762b101d682 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -174,14 +174,6 @@ static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
>   	return NULL;
>   }
>   
> -static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> -{
> -	if (ref)
> -		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> -						      count));
> -	return NULL;
> -}
> -
>   static void aa_put_common_ref(struct aa_common_ref *ref)
>   {
>   	if (!ref)
> @@ -1318,6 +1310,14 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
>   	.release	= seq_rawdata_release,				      \
>   }									      \
>   
> +static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> +{
> +	if (ref)
> +		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> +						      count));
> +	return NULL;
> +}
> +
>   static int seq_rawdata_open(struct inode *inode, struct file *file,
>   			    int (*show)(struct seq_file *, void *))
>   {

