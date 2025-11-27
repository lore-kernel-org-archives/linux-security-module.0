Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818421A9FAB
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207218; cv=none; b=iVVlALqYCNfWnU2gNEfvQEST+fkKo+qwssFXxO96j8b58rggaqeFLEBWJXpBHi0oznG2++BqSYtwHBjbxfC+kWYOTYUabXa2DHF4i8FaZrfKW2CS121ygui/jY5rwdyfv58RfKCUrBmtm4YVa+5pPc3075oe+4D7MaKJPqSM2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207218; c=relaxed/simple;
	bh=6hRnfwCsh3hm9wICLVK0h5rEEW0i2J03Tl1MTO88/+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLI18sYfY6cs/4j4zE18mfrdYbBPEuRQFFg3Op2A7ABXSXdOSSd3Vje/cqfHCph7zloqSkQlgwS108gcwUFHxlS79P2PXpkYnHaJrbhoYl+/MCYd+HVNqP/Fgbsem38mVms9LCFv9BdJJf2frfjuDHwnlihEXGSDxJUPGpl77rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jnomzRyU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jnomzRyU"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64A3D40F18
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764207214;
	bh=w1WNEsEOXQyU5I7NFYOe1wob1k7a/n93rnsmBECbBUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jnomzRyUdnXZnmo0PTxOb513s6O2egAlLadiJ+zENWoOeqkmma38DSICPRio7r29k
	 gz0ZMxkUR+X5EPcguAcONsLlGZhZQcfP91J94yl7rpoHuOyB/99jHacn6kphrky93/
	 /Vs7JPWg/2DP9fkFsee2khCiBseq54d2lYAV4gJSUfQhr4At9Do7uTggopZEZ9NoQK
	 uzjnUEh3peiUc4I7qeMSvKTTVFJBWCM3v3ZH5z+jjeBQUtyljgXDyYXLxD1+VjQ2pw
	 rl1yyserGjrp5SxmiRqfD5pQPaNkAO6cC8JRxl5RqwbvTLhRpFHyqg3tMawowmjr3x
	 4boZapD2z4bkZvpXkwazW8F9xOia8vuqgXwToGD4/6U2AyVAFcjJ6crMtkRpf5Muzr
	 ZEYMmNdnbXGEzhVHooBhAjCtviM7nkk7++UpQG9RSgAcUy4JtRTfMohQjj++OS9wqi
	 v1nbn3KMkSbw632ecJFzFEhqogpVwLwAjOsLJ9R1sMJj40rmp3OIpb93Eq5ckAgZU1
	 DA8rwpIBZDvvuBX4Yn3UulgbaTR00ahkoBO16w205WaLjxsO9YBbt/+4b2R3lrLtnK
	 AYzChpgFtEb4szf9LSvZJZPA7muSfhnfhL0WxJls6L/gWwwcwD7ogCISHg3HS+kGE1
	 BfYJU7R5f+fyapbnMxheeOVo=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-298535ef0ccso3692485ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 17:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207212; x=1764812012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1WNEsEOXQyU5I7NFYOe1wob1k7a/n93rnsmBECbBUA=;
        b=Lga/GIVKu4aeUMd8q0J8ZI/DNw9I04SfVU441BnqEUrfV64uzRvMByFW1CX8hxl7r9
         8URjEogOYMy6NXfKSD2sn/F7KMFeaaqeR6t/O66TmfY1Qkn2dM1rLDJu/TSFCc4eEl7G
         ZAdP0VBq6P8jeFWAYknzur38FBg/hHJLift3oRxVGeGjal0L18PcAshbXwtNaZ65Xv7I
         +lQB2wf+yZhI55HmO5mjq0Fk2/SGJp1tnu7O1qK/SqrvoknKfU/XUssTgO9M6OXbxRW+
         RFq5sULLLbuzta5njRkHWP9/ADwT6g6vN1i6VhySEoAoBZBggjfPzOuT1uBiAZ14CPKZ
         qMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPUfY1nXuTBSrhpMg/83RhAbAsZ2q3vmZIZjfjTezYc4hnGhD4uzTcdWvKvkqbTahYgqiJ9aafI/ZnMKqkh5AdFWdwMKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJU32ZhU50ROSNzXfXNjbFx+haZnUNofbU/YOm64udYy/UhkS6
	BgHjlq9Q4Q35HozVTzt9dt/c2ZwaImGVEeYjJkdlapczyVwN5IzJSBK0l91qJU6eDlhEu5BTbtp
	G4qX+AGvAaXiay9ZPGdjFnxLYsqDhxiKwvNdL/YYy9j8FxIETDeKyegYLgXHT+7SBGTOqdpXQKl
	6TqMXTkNx5oWDo25EflQ==
X-Gm-Gg: ASbGncu6wujBEpD25huTial71VmMaQTijb60Mq/OUgDNMsOw/+VWyRZbDCUUjadA4i5
	6oyJr55s8LNAJaddqwgODTuS53whHhujTbAp6GtCdWhb64IY+g4lJVNVOA6rBJgL2qH9tYowf/9
	F3CcFkDBzqxNFbsOJK5KEqkXJdrG/Kq9+kwbjzIRCIFdj5m1gncYnpwhCLae9MmDLhktIDCuKzd
	HT1NkLpcvR9G1Bgp3c4H1MZMEJ79u6zrnEWwNRsQtHeu1Vl+JqRk4kOgr+HjJwhG4R1NKcRTtkh
	NfjAja+5qNNcnNF7iQ4a2dN7iumSrOrGNv3mx0Xc487BC+uC3doU2f3BLfRjNar1YabKphpLuWn
	TuUoCa1DUz1NPUVTBFI5SmN0X
X-Received: by 2002:a17:903:90c:b0:295:54cb:a8df with SMTP id d9443c01a7336-29bab160a4amr86858815ad.36.1764207212681;
        Wed, 26 Nov 2025 17:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlGuhRGgdpoYL6MEbEVDBJWRcjdLBA9zSDy8IX0iEmr5D08qy2ccENoEiBbRJ8CCWPELi0jA==
X-Received: by 2002:a17:903:90c:b0:295:54cb:a8df with SMTP id d9443c01a7336-29bab160a4amr86858595ad.36.1764207212335;
        Wed, 26 Nov 2025 17:33:32 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29b5b107edesm207043365ad.5.2025.11.26.17.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 17:33:30 -0800 (PST)
Message-ID: <72b1d078-7283-45a7-9709-ee899af09bdb@canonical.com>
Date: Wed, 26 Nov 2025 17:33:30 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace sprintf/strcpy with
 scnprintf/strscpy in aa_policy_init
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251122115549.448042-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251122115549.448042-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/25 03:55, Thorsten Blum wrote:
> strcpy() is deprecated and sprintf() does not perform bounds checking
> either. Although an overflow is unlikely, it's better to proactively
> avoid it by using the safer strscpy() and scnprintf(), respectively.
> 
> Additionally, unify memory allocation for 'hname' to simplify and
> improve aa_policy_init().
> 
> Link: https://github.com/KSPP/linux/issues/88
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

I have pulled this into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/lib.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 82dbb97ad406..acf7f5189bec 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -478,19 +478,17 @@ bool aa_policy_init(struct aa_policy *policy, const char *prefix,
>   		    const char *name, gfp_t gfp)
>   {
>   	char *hname;
> +	size_t hname_sz;
>   
> +	hname_sz = (prefix ? strlen(prefix) + 2 : 0) + strlen(name) + 1;
>   	/* freed by policy_free */
> -	if (prefix) {
> -		hname = aa_str_alloc(strlen(prefix) + strlen(name) + 3, gfp);
> -		if (hname)
> -			sprintf(hname, "%s//%s", prefix, name);
> -	} else {
> -		hname = aa_str_alloc(strlen(name) + 1, gfp);
> -		if (hname)
> -			strcpy(hname, name);
> -	}
> +	hname = aa_str_alloc(hname_sz, gfp);
>   	if (!hname)
>   		return false;
> +	if (prefix)
> +		scnprintf(hname, hname_sz, "%s//%s", prefix, name);
> +	else
> +		strscpy(hname, name, hname_sz);
>   	policy->hname = hname;
>   	/* base.name is a substring of fqname */
>   	policy->name = basename(policy->hname);

