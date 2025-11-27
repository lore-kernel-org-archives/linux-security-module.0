Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C121E1E16
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207251; cv=none; b=LjlXPe3Moidp5GmovwErG2SOxr1w+GKIMdPKhsy6Rq3W8g9XDEmGIK5yayRTgnCoAcAgJNrLc90sx5esxWivf1/6YQk93HMCBw64Gvb8mrA/FmDUC6MfAoJsnjBXwWmQYjJoZaCyxNiksLdexq4MhwhZajHa4897HMf3A+pHSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207251; c=relaxed/simple;
	bh=uQ5fzJJhHfa+TyGMDQSqzkJTNZFkQj8Lv7c69Kq7kjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN2/P8A7WN+H6aLs1l01RRu5LdQuxgLid4AtZZOnYhU/DvnzdVa0EzJCUuDq3AwtUl6MCvbjMtXVW+pvfE2iRst8YPARngXJOAsVwVch4MMjj+D0U1tZy3kCgYclGwN7uzX2WLi5MoTmRNhPSuz2eTxwvlAL6KXWGCX5J/Cj7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=GpOPb7l4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="GpOPb7l4"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 089483F941
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764207248;
	bh=TRKfXOlkmwqNMgnglxoR4XVNauUDD3kM3GM5CwFK/jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GpOPb7l4x+Qs5hYOyETPp37jbcvrJUV9thke49W6FR5g8vXT8Bq7HhZ3Zgi7x30qB
	 g8DNZlsalqGACglNvUmIxnXdaW0GV1TaoSQS6hlJH0IDQS67/SVnaB/+lgGHWcbjnd
	 p6zVbfEcwV526kbz7TmUzNGcvpnP0mms02FIk/t+APvBF4hEMrJAe4reiCCp8xRrPL
	 lCE1aCffagKSpDNYvI+Cco7sT29f42TZP8uDh/qygTRslGs7NxzbnM9VMBs/Xh22bo
	 cDQLWdF1V+3MNyLkFAiii/R9dVP0Exy5IN/D8FIBMEf9eGQNcUZoKazIKNbozzYUYI
	 dXtReNPLXMzWa7aAKjKH0d77yHdEoUIv5ofza+oKGG8mO2/Ur0we02xgwqP9b2xn23
	 qbNyOjNb3Y4PO5abprn06yvJcHwJERsuRBbYbBGXm7zqJu0uutxvT7DXRf27SLxmIF
	 UfdtEWaoQKCFDvuT1lp3cMnY6f4vNORXPjXOhdMKetOzmM+BHD0hJYOAxAwGEaFDoe
	 TO30wF7eK1z3lzWnjcH8/3kI8wwTuRwquT5gO1jeQKWTamIo+RXC6dIXRrACf7y9Tc
	 4WApqtY0GreaWV8ow3LOkBWP1lXwUaRDsp0W7Gux2cWhJ8CFQ55kgNkWXTFkh9+ssn
	 hfwyZqwxThZYdRAQjqxaRhe8=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34740cc80d5so552560a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 17:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207246; x=1764812046;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRKfXOlkmwqNMgnglxoR4XVNauUDD3kM3GM5CwFK/jE=;
        b=WJOK+b/wpvhMH6OiSOKCpijRN3tg3i9Npvrjmiy7R3/houTrYKawkf0wUynPETRCgO
         aYSxnlYE9Jny8U4O4DS7BpLUORwqqDSYasR9FeuIGPlNY2HaghPvW8ZunEqaXfa5qGru
         i/CCEhFbnu3M5YiwlcP96NYv2saZSR80AiYRVPU1ykywGadK4l9MQOGxsdd11X2Z1m84
         NO+N8aascq11ZPlVkqMphbYBluPR79c+Vz7DY7jff3iZcXzRUdXUj6s/qWoqTTEQOiZL
         wkKCk0skL8fT+/O7pRdVZhmuxiY6hs/+msrKX+qpg4A33Uo2iOmllOVJvD1eJTcCuy96
         wrwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvC+hCvhuB/jCy+7g2979LJO/gqeisWt4D9zwyukmycWRNXUe9H2uG2XeXD4y4+YjFjIKeVpF4vFX3yBcMDgN8d4Elxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyExTyf71s0jASpsxs+nTF2jDzQTuuWnY3qUvCdr6a4zDf5OL2
	Mdrvb4exUL+xparBcut9+THLVFxJb4GhAWPFHoZxdeqhdMBt1ki86ADQlyko6zTIUQObv+VT/qC
	fNV6yiDpWPgdVfJXFz+wYnNbcn8kMvO3006cJR9sU7KxY3bxWboS47vCOlQSRgsQjOIV4P8LRDZ
	L2Z4PtV44rN7I038cGGA==
X-Gm-Gg: ASbGncvbhDDvHrQyk3Bdry9EEwZHjn9vyuHDfUMN5+bYo9I7k37Cm9sl+hYS3DZNGd4
	peuPBr8gkBmkJDv+iq72yrdiGN8wXlU2hXXkQBoyC57GwKqqBeca0jgPEEdRkYkl2sKY60t5fgh
	m3XyiLvX1qJq+y3RX58Z6AUjqohEEPYHLw7pvbHri1pdSP2bN6LKz3k7sH5h6p+igNEV92WYkVX
	XLJqMpI0hwyvkExjrusXom0pkpkgmQhxQIvK0uxGlBKRVQW9my+u/xAUFrZIKKKpUqCrQv7tIR0
	aMENiLDmdTD+IdGkb3x1rxOZDVArIfz1KIHtHhCnt1TxR+LIt4ZDNCY7nUNYnnmt1ceZjlHTCpN
	9Ix1BYRCCc34GUOkH6HgPVqRV
X-Received: by 2002:a17:90b:4c48:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34733f3f6d5mr18438366a91.36.1764207246553;
        Wed, 26 Nov 2025 17:34:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnJZaIInZT52MCGIw+E2FRhO95wkEz5Pp9AmAdLIMmkYiGQZYS09ZQ458I/EYl5otmbG76iA==
X-Received: by 2002:a17:90b:4c48:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34733f3f6d5mr18438351a91.36.1764207246214;
        Wed, 26 Nov 2025 17:34:06 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3476a59e4afsm3828879a91.10.2025.11.26.17.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 17:34:05 -0800 (PST)
Message-ID: <4e34cddb-2d21-4c2c-bf9d-a377ba55ddb1@canonical.com>
Date: Wed, 26 Nov 2025 17:34:04 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: replace sprintf with snprintf in
 aa_new_learning_profile
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251122115446.447925-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251122115446.447925-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/25 03:54, Thorsten Blum wrote:
> Replace unbounded sprintf() calls with snprintf() to prevent potential
> buffer overflows in aa_new_learning_profile(). While the current code
> works correctly, snprintf() is safer and follows secure coding best
> practices.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

I have pulled this into my tree


Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/policy.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index 50d5345ff5cb..b09323867fea 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -697,24 +697,27 @@ struct aa_profile *aa_new_learning_profile(struct aa_profile *parent, bool hat,
>   	struct aa_profile *p, *profile;
>   	const char *bname;
>   	char *name = NULL;
> +	size_t name_sz;
>   
>   	AA_BUG(!parent);
>   
>   	if (base) {
> -		name = kmalloc(strlen(parent->base.hname) + 8 + strlen(base),
> -			       gfp);
> +		name_sz = strlen(parent->base.hname) + 8 + strlen(base);
> +		name = kmalloc(name_sz, gfp);
>   		if (name) {
> -			sprintf(name, "%s//null-%s", parent->base.hname, base);
> +			snprintf(name, name_sz, "%s//null-%s",
> +				 parent->base.hname, base);
>   			goto name;
>   		}
>   		/* fall through to try shorter uniq */
>   	}
>   
> -	name = kmalloc(strlen(parent->base.hname) + 2 + 7 + 8, gfp);
> +	name_sz = strlen(parent->base.hname) + 2 + 7 + 8;
> +	name = kmalloc(name_sz, gfp);
>   	if (!name)
>   		return NULL;
> -	sprintf(name, "%s//null-%x", parent->base.hname,
> -		atomic_inc_return(&parent->ns->uniq_null));
> +	snprintf(name, name_sz, "%s//null-%x", parent->base.hname,
> +		 atomic_inc_return(&parent->ns->uniq_null));
>   
>   name:
>   	/* lookup to see if this is a dup creation */


