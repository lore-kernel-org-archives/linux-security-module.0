Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D01E520
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jan 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jHnQe4Wx"
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DC1EB3F6E0;
	Tue,  9 Jan 2024 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704793729;
	bh=wKcTA+JfKnm5+S5arxIAKtKFGQurDYm8od3AChi9/6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jHnQe4Wx+zeauOXnhdMYdsDa8IRs+afmjiKJJAZ/Pai04PEpnE3wzAgE+quVJic1M
	 yUdK8veslUKLnh9d1plb1mG1fKRNbZWiYPHfIjbK+Zqmx+NMrzwf4IUMN631TN1N3a
	 0IJ/LfzfoWRDg7hYAUG0nqwCQL7HdvTwvo57uvVGPXb4GqdJcXSmzhieNq1G4OwyH+
	 jC5y2GIWJSCz3oHhuprQPalCjmyVpIBH4m7Tni/fi0svblVHxzJ6jc3pv0Hze4Fucx
	 nwaxSWOrdlxoUFoBugBBEp/BYViBjEaC3gbz4fMTLyiUGGa0sXD5b5G0to7EdfKG6a
	 C9fJ+ob9ik3tQ==
Message-ID: <de306707-7406-4f5a-8827-ea6ed2cc68bc@canonical.com>
Date: Tue, 9 Jan 2024 01:48:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix memory leak in unpack_profile()
Content-Language: en-US
To: Gaosheng Cui <cuigaosheng1@huawei.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, georgia.garcia@canonical.com
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20240105020126.315700-1-cuigaosheng1@huawei.com>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240105020126.315700-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 18:01, Gaosheng Cui wrote:
> The aa_put_pdb(rules->file) should be called when rules->file is
> reassigned, otherwise there may be a memory leak.
> 
> This was found via kmemleak:
> 
> unreferenced object 0xffff986c17056600 (size 192):
>    comm "apparmor_parser", pid 875, jiffies 4294893488
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 89 14 04 6c 98 ff ff  ............l...
>      00 00 8c 11 6c 98 ff ff bc 0c 00 00 00 00 00 00  ....l...........
>    backtrace (crc e28c80c4):
>      [<ffffffffba25087f>] kmemleak_alloc+0x4f/0x90
>      [<ffffffffb95ecd42>] kmalloc_trace+0x2d2/0x340
>      [<ffffffffb98a7b3d>] aa_alloc_pdb+0x4d/0x90
>      [<ffffffffb98ab3b8>] unpack_pdb+0x48/0x660
>      [<ffffffffb98ac073>] unpack_profile+0x693/0x1090
>      [<ffffffffb98acf5a>] aa_unpack+0x10a/0x6e0
>      [<ffffffffb98a93e3>] aa_replace_profiles+0xa3/0x1210
>      [<ffffffffb989a183>] policy_update+0x163/0x2a0
>      [<ffffffffb989a381>] profile_replace+0xb1/0x130
>      [<ffffffffb966cb64>] vfs_write+0xd4/0x3d0
>      [<ffffffffb966d05b>] ksys_write+0x6b/0xf0
>      [<ffffffffb966d10e>] __x64_sys_write+0x1e/0x30
>      [<ffffffffba242316>] do_syscall_64+0x76/0x120
>      [<ffffffffba4000e5>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
> 
> So add aa_put_pdb(rules->file) to fix it when rules->file is reassigned.
> 
> Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

yep, thanks. I have pulled this into the apparmor tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/policy_unpack.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 47ec097d6741..16afe992a724 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1022,8 +1022,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>   		}
>   	} else if (rules->policy->dfa &&
>   		   rules->policy->start[AA_CLASS_FILE]) {
> +		aa_put_pdb(rules->file);
>   		rules->file = aa_get_pdb(rules->policy);
>   	} else {
> +		aa_put_pdb(rules->file);
>   		rules->file = aa_get_pdb(nullpdb);
>   	}
>   	error = -EPROTO;

