Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3F13D501;
	Thu,  8 Aug 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140296; cv=none; b=JlYx/u4m5ztx1TS6lKIGzj+TKvCZewEKmSZL8/cii9l3mxa0j5K0aSLEAK2EHbSDCzU2ggTawX8QzWMOKXIz0bGlyQTc6WDoewAtwzr7ZHGWW4D4oXkFkOmn/LR3juBvan7OQZNlQ1FsVk/tocVONTMlHYb3cb7puRYb/YD2aLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140296; c=relaxed/simple;
	bh=6ethFYn/VSKUzo1EX6mqJlH7bhRN8A0cx6bxKUP3s0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHanqOw0bXllTdeYt1nLqsaPJqW88wzeJ4D1rpToH5mbDbYT2rOkc+FhC2Td3LWSkNmK/SLV4akM6NJnV/kpvD5bAzbF/tNXiccoisR6RUrRkJKDmtvdGIVjpsmHN0u63HN8Qehi48tdYf8Z0RP+5c5E5f3Hz81jzRDpHtFcg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1MM+TkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1MM+TkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C71CC32782;
	Thu,  8 Aug 2024 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723140295;
	bh=6ethFYn/VSKUzo1EX6mqJlH7bhRN8A0cx6bxKUP3s0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1MM+TkTWrmEFzHblB3nzenFVoYNRPXlj4b4xqNkb0qds79uUrVXMNoyGiO0oN6tP
	 fkZQyNhxnNHv5+HFZAfjJ7hRNR1+l50grRqQb30zMqwj2SkSacnm2yKPtgdyGjCum+
	 50zeexfNDUUO0xaIMUocFsAKEp9lp8FftNQLXECtu5TV3snYZCs7lspbd9ZbfssZsw
	 TyG0rW1Mq51UOt9JKx3QWRMOoP5MJyRTfarfmNmxNbsoaUVXmdpcURCXMGJ05Ybx9y
	 oQ8nE/HHTFCTvswXjMRvGGdGkbfQ9mLqwJ9KQgv8sjTBHGf5LsV2/d2+FFAAQYLjym
	 LSksQd0sBDp7Q==
Date: Thu, 8 Aug 2024 11:04:54 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] apparmor: fix policy_unpack_test on big endian systems
Message-ID: <202408081104.8805C0BC7@keescook>
References: <20240808155931.1290349-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808155931.1290349-1-linux@roeck-us.net>

On Thu, Aug 08, 2024 at 08:59:31AM -0700, Guenter Roeck wrote:
> policy_unpack_test fails on big endian systems because data byte order
> is expected to be little endian but is generated in host byte order.
> This results in test failures such as:
> 
>  # policy_unpack_test_unpack_array_with_null_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:150
>     Expected array_size == (u16)16, but
>         array_size == 4096 (0x1000)
>         (u16)16 == 16 (0x10)
>     # policy_unpack_test_unpack_array_with_null_name: pass:0 fail:1 skip:0 total:1
>     not ok 3 policy_unpack_test_unpack_array_with_null_name
>     # policy_unpack_test_unpack_array_with_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:164
>     Expected array_size == (u16)16, but
>         array_size == 4096 (0x1000)
>         (u16)16 == 16 (0x10)
>     # policy_unpack_test_unpack_array_with_name: pass:0 fail:1 skip:0 total:1
> 
> Add the missing endianness conversions when generating test data.
> 
> Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
