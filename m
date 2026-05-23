Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA5223DCE;
	Sat, 23 May 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550995; cv=none; b=dejexuulyEEmt1GP6JDSHXilbZa4J+EW2sgeJ5q4CtYTaa0HE52XZTnR8zaDGkC/8xgM8lP87ubcqc45ssoez5tFr91rW5ipB7u/vQ9h+pZ6pTfSILyxxfQUZNWJy+zFYz9+dQ0CpN6wVCo1LC80VEKgLal5Yv2PZpTX5hbJiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550995; c=relaxed/simple;
	bh=/FarOusraaRDyEuS/mEr11UOvNbD1hDeVElYGxSJa1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EiCysAel0sh0BkhMuvwnr6kccnJu4/REdMw9oFCUzEqOOQEZxK/EbzVuTS6jCtjIICxdSw4mLwQG+NaQScNvN/ZCnzEXwhAhoLDUhGxSOvJbmCl+fHmBJfbILoK6XGdFiOF8ZPiFoncoPgg9UPI/Wl32y7PPSXR8drdziG/MvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jEYatmfV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jEYatmfV"
Received: from narnia (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1573720B7167;
	Sat, 23 May 2026 08:43:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1573720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779550984;
	bh=acIj4vWKr0SqCmR5CKEDUtpdjYqdNyAG7m++nOXhjSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jEYatmfViNwX9ZgJW1g/Fxb0tiJuxE7KQxPD3/HcT6+vDRl2mU5bct8dezgjv1ZxI
	 QflXUJ/8zi/BOyIWaJeNRHvLl51RvRGUFJHEbSqGnfO2pJ2ktR4IEo5HJxfvCc/Gd1
	 n1AoNp1AXfaycHZnJjJYSuYdnLkaVgLKkjp41nBQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, LSM List
 <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
In-Reply-To: <19e54ddf1a0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
 <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
 <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <19e54ddf1a0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Date: Sat, 23 May 2026 08:43:09 -0700
Message-ID: <8733ziyvw2.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

> On May 23, 2026 7:40:42 AM Paul Moore <paul@paul-moore.com> wrote:
>> On May 23, 2026 3:40:46 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> sashiko spotted it too.
>>> All other sashiko bugs were ignored as well.
>>
>> Link? I didn't see any feedback from sashiko feedback on list and to the
>> best of my knowledge it hasn't been enabled for LSM patches.
>
> https://sashiko.dev/#/patchset/20260507191416.2984054-1-bboscaccy%40linux.microsoft.com
>
> Blaise, I know you've got another patch coming soon - please take a look at 
> the link above and see if there is anything else that needs to be addressed.
>

Yeah, it found a few things I corrected. It's hooked into the bpf list,
not the lsm list currently. With all melodrama and bravado aside, The
TOCTOU issue it found wasn't the actual attack vector and it completely
missed the real one that Eric found. It seems to be lacking the
multi-step reasoning that vuln researchers actually use. 

Most of it looked like AI slop, and I'm not too keen on providing more
free training material for AI folks to run inference on, so I didn't
respond directly to the bot spam emails.

Sashiko seems to take major issue with the existing user keyring
verification too *shrug*.

I'll take a second look when I'm back home next week and see if there is
anything real leftover after this patchset.

-blaise

> --
> paul-moore.com
