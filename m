Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12083C140D
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507359; cv=none; b=hZo4L2Udte/9cFCAH0GGNRzMSdBF1ODYDoWQ1CUL/CiW0SG9TjKMrsEpbhmgbIZFxbYZKDAPEBi5RtE87IaXZXlpZOd1kk9aSJD8xm1YyAtOzv/KDLvTybUUTV0ACpplioDIa6Vwa43VR5IBtA6AGCUw+GffRiFSq5zFCeXnMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507359; c=relaxed/simple;
	bh=VZgUdV2A7pZjLp6C/BH+7oAEipYUhSeWuVMjB9UBZSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRaaDNsdZysgXhMge95IesvNnNQnvuSHVxV+CJaqnfpXPpDBE45eRU9VRLf2OS6jvvMXfcWIsbMRIrzSQt1gldC29RljuSwqhrY5nVDbJRK5jd8GGXoXHr2gaFoBtAU1HH1BrwNMmXAi6rw4Jf0/534Qw5kKtC3rEaDW2o2Y2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nIK2iBP4; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nIK2iBP4"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwF6B4WdSzD1M;
	Wed,  8 Jul 2026 12:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783507346;
	bh=Wg6f8s2e6QLWTvt1elGbzdKqXJ9qbnt5tU9p1LjHfq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIK2iBP4vM0qd3XgRSYJQB5+67ybWxa1r1r823kbFdX56HIuk+9zscjmNCcj2SSe1
	 bGRZQy6PDBMWy+w1Pc/T25Qz/rj9DyslsW5PUcjCGOzr2VPd85f3gtgaucJZVlR6B4
	 FlO9JiHXPWU4lFVSQr1s0WpiDN+pYNwGWfX7w3Ik=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gwF695pr1zPtL;
	Wed,  8 Jul 2026 12:42:25 +0200 (CEST)
Date: Wed, 8 Jul 2026 12:42:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: gnoack@google.com, shuah@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/landlock: fix spelling error in fs_test
 comment
Message-ID: <20260708.toQuea2Gi4zi@digikod.net>
References: <20260702015823.368529-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702015823.368529-1-wangyan01@kylinos.cn>
X-Infomaniak-Routing: alpha

Applied, thanks!

On Thu, Jul 02, 2026 at 09:58:23AM +0800, Wang Yan wrote:
> Fix typo "allowes" -> "allows" in Landlock filesystem test comment.
> 
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 86e08aa6e0a7..e672089e9329 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -6927,7 +6927,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>  		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
>  	}
>  
> -	/* Only allowes access to the merge hierarchy. */
> +	/* Only allows access to the merge hierarchy. */
>  	enforce_fs(_metadata, ACCESS_RW, layer5_merge_only);
>  
>  	/* Checks new accesses on lower layer. */
> -- 
> 2.25.1
> 
> 
