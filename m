Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55ED1537C9;
	Sat,  9 Nov 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180971; cv=none; b=gj5iHAOqwSM0KgSKdWUwj7VxIdRMa6hqa3Dxc6NqiHqBRZ/Pa+vd/t6IrXniGO5R/zI6D0HYmv9uV8fy/Ls27Dnrzoa6RiP3ZvvhNdk+dnz2D+fnncadpFSXPKrIA2kxPEDRLahugEafC8Vtzv05BSWliP8SxQinotckAYZkeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180971; c=relaxed/simple;
	bh=tFRVNOjEhKYqT4YUsK94NttB+rml9lmmYxpieMCsAM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NdVdigscYtgI5p27jftwK84KEqFxoMlsThrxT2ehdVX6t2i8yqzodIPLqkswspL3oIchUoG6BGcYMFVjfygmJjlSILPRAbkWTAQfil4zfJP9iH7a6sQD9cqYrqTkE/yZFz/b3EnhGZ7ix3gbKO9kS8Mo1jnKGIO7CXwo8AxKEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OiyUTL0N; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OiyUTL0N"
Received: from [192.168.192.84] (unknown [50.39.104.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 041933FB5B;
	Sat,  9 Nov 2024 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731180965;
	bh=JzJNnoQrpU/iYPtVZfycqLIjcRlhJ2rMhkvmbw89daw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type;
	b=OiyUTL0NytAUwvlwDdEjajzLaUcXoVrfGxr8dVRC7SO5le7AFypc2NR5sUR63SxKz
	 9MOlLNb5UVVnBIaOmEutWYdU2e1sc3qHyOO8RuWNJbYVlLfujejua7ZUjrw8aZ8938
	 GSO/c97KFaol7hQAJfe8Z/BeBU7U5+AllUM38hW7QvLE8JfAhY51qLJK5Rdd4Rk4UV
	 +8TVbEZfKYMfVs8Ce98kXUX7c4gVGRjyZBi6wP/eBoYp5uLpDQjjXQO85YK0faSuRT
	 nuAs/L3qrBcwxzYyBUZWyxhSwWxLsaONHANbKKdupvyOjkanLDLzZva7MyUEbVtbGz
	 p/osSnW3JE1Sg==
Message-ID: <4b7f9b0b-1a24-46fc-9046-069f06f3c965@canonical.com>
Date: Sat, 9 Nov 2024 11:36:02 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: test: Fix memory leak for aa_unpack_strdup()
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, skhan@linuxfoundation.org,
 mike.salvatore@canonical.com, kees@kernel.org, brendan.higgins@linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241011012241.3251128-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20241011012241.3251128-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 18:22, Jinjie Ruan wrote:
> The string allocated by kmemdup() in aa_unpack_strdup() is not
> freed and cause following memory leaks, free them to fix it.
> 
> 	unreferenced object 0xffffff80c6af8a50 (size 8):
> 	  comm "kunit_try_catch", pid 225, jiffies 4294894407
> 	  hex dump (first 8 bytes):
> 	    74 65 73 74 69 6e 67 00                          testing.
> 	  backtrace (crc 5eab668b):
> 	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
> 	    [<000000006e6c7776>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
> 	    [<000000006870467c>] kmemdup_noprof+0x34/0x60
> 	    [<000000001176bb03>] aa_unpack_strdup+0xd0/0x18c
> 	    [<000000008ecde918>] policy_unpack_test_unpack_strdup_with_null_name+0xf8/0x3ec
> 	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000adf936cf>] kthread+0x2e8/0x374
> 	    [<0000000041bb1628>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80c2a29090 (size 8):
> 	  comm "kunit_try_catch", pid 227, jiffies 4294894409
> 	  hex dump (first 8 bytes):
> 	    74 65 73 74 69 6e 67 00                          testing.
> 	  backtrace (crc 5eab668b):
> 	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
> 	    [<000000006e6c7776>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
> 	    [<000000006870467c>] kmemdup_noprof+0x34/0x60
> 	    [<000000001176bb03>] aa_unpack_strdup+0xd0/0x18c
> 	    [<0000000046a45c1a>] policy_unpack_test_unpack_strdup_with_name+0xd0/0x3c4
> 	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000adf936cf>] kthread+0x2e8/0x374
> 	    [<0000000041bb1628>] ret_from_fork+0x10/0x20
> 
> Cc: stable@vger.kernel.org
> Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/policy_unpack_test.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index c64733d6c98f..f070902da8fc 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -281,6 +281,8 @@ static void policy_unpack_test_unpack_strdup_with_null_name(struct kunit *test)
>   			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
>   			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
>   	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +
> +	kfree(string);
>   }
>   
>   static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
> @@ -296,6 +298,8 @@ static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
>   			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
>   			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
>   	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +
> +	kfree(string);
>   }
>   
>   static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
> @@ -313,6 +317,8 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
>   	KUNIT_EXPECT_EQ(test, size, 0);
>   	KUNIT_EXPECT_NULL(test, string);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> +
> +	kfree(string);
>   }
>   
>   static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)

