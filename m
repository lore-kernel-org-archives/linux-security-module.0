Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A81527B4
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974161; cv=none; b=BBLsklOzXV1mRbh7InQ3j0d0SqNFSvXqco22WegqZWHJAwuJs2jJ7ddJXPEJ4TfFSq2NSW1Q6YpdD2Icy6PMJLtTrW+WaDDYsoQnks68nIfJM8WSxb74clOmhEnCF2O8dkjU3uDWXZqg5PoeM//SB1gZp5GmCmwhvJvMeg9TPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974161; c=relaxed/simple;
	bh=e8Rci+PRgCkOoqI4HQmvQmJccf/y2s2K/ZTx7fy2Kcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSl5FDdOWBeZEM1TudbEAU1YpVmRnuKJiYt8XUXjreUyHQ/z8ufZQ+Dza6qhO+wWztCIdqtOIMpRMZVSKv4rEKeEAHmI1NZAREWmh+Ieh3QYPffSxvAhdJkBoSGrWgBL4SH4Hot1a18pONsHKKM0j1k4lZdYS+UVXMg7XvaJx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aqkrLKvk; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aqkrLKvk"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db836c6bd7so11428097b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Oct 2024 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727974159; x=1728578959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8WIrEzq9NW9CgoC1X+T7GSQjclVBzZwaFrQViUkPw4=;
        b=aqkrLKvkv22UjrUHU8jEblW9pkamuANl+3MTSqeX4tIfFkiVZfJ0XlvXR8NpVlsko8
         SFuDQfrKCylcP5+D/lnEwJdPiHB4L5qa1JMbEfgYQRWvVc6EB6zOaDgveRkG3tysPVMf
         8NcGcRqAIBMD/A+L2UV2LFLtyBwWqCPvVHBQsrvNGKhktrY1LcLkef78e6MXbIMpJVf2
         5xgKVprn6B1T/LLPjtRNPFpTfu2nLmGf12C7CXm0lHec15iVpGGizSDmxAcqv3NfVjNZ
         yaIKHgyaJXGNu76BmleepZg0lS5oxg/sgdti6CKPGxf5fqJ8OKr0CK1G2Exhx8KTtlf6
         k2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974159; x=1728578959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8WIrEzq9NW9CgoC1X+T7GSQjclVBzZwaFrQViUkPw4=;
        b=jlzu00i0i5iTAn51XUBhl4kSk398UzsXLpYnOwEUD8oax9PPywHyQnDYHtYUaUwUHD
         /KDv8zbwjC89KmDJ0BbpJsgcWg6ztHA+/5yaffk8E+8m1gwzcdHTIa39ZqUExuV4r6kB
         dyvB7qEub73MwtLOWgKBzQv+TBcDg1qQequT4anNsOq3+GHt5nSxxymMfGU2nNKRbiAA
         xdfGQkS+hEal+3+tRBcuD21oiBZBusAxgn9R/ET4iE4wfYH+sqdf5NdZYvIA+pikONLY
         +RGeKNVGYf4bxXfpVnPOlkNygfGRH3UBmw/XqIcPJ8yupFtO3Mlm5LgsAXf3gsQzKBl6
         v6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVPx0V3UWyo9vRSnuwWTLqL3mqP8xIAV1kmGukobGuJZ+gVF1n43qoAj7CgvX7Wnf9keg+T5yRFsFkkXj6rDI61R2HXd8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1Av61kfRjBfrJduXsfIdJN0gYXpaw9XSxgb7/bthc4AvQywi
	z+5QeoCMI1NIbDYlNRn+k9tbjbqCaM2czh3ZmIjO8M3yNBxaxjfQ14kOoCQl9u3nZjTyd00bLdP
	eesJtC4bugy9RAfXoKHvG2Fwtou7g0T9g/HP/
X-Google-Smtp-Source: AGHT+IEufIOsbLnVH8r8djp676QpZrm3qOEOHXZrf4Yz9RwwxNxZscePaCJz1ROpZu5TMNbmwpJ7mxl8R9auOOhC3BQ=
X-Received: by 2002:a05:690c:10c:b0:6db:d5dd:af76 with SMTP id
 00721157ae682-6e2a30503cbmr69217257b3.32.1727974159139; Thu, 03 Oct 2024
 09:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <f0fc9923-c91a-48b2-ae61-30dd7287ecc2@schaufler-ca.com> <20241003164211.GA849107@mail.hallyn.com>
In-Reply-To: <20241003164211.GA849107@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Oct 2024 12:49:08 -0400
Message-ID: <CAHC9VhStVqH=4qyD2C_YCEAP6q97gNR=s6wto1YtpR5b-KE5Lg@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:42=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> Right, I think this is the biggest reason to request the revert, unless
> Redhat or fedora tells us that they would actually enable it.

To be clear, my objection is independent of what RedHat thinks about
this approach, although we have heard from at least one person with a
distro "hat" that this approach is counter productive and would result
in TOMOYO being disabled if not reverted.  This is simply the wrong
approach to take upstream.

If RedHat wants to enable TOMOYO they have that ability now, but as
we've heard countless times they are not interested in doing so.

--=20
paul-moore.com
