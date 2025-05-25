Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EF28EA
	for <linux-security-module@vger.kernel.org>; Sun, 25 May 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183035; cv=none; b=nR8o5dV2871QoBEGNm4VVcRsJvUtxDeE5T+f1MtigeKnayShwfWZVHqYcUpWPIMUuBHgst+lgNWuYuw7g+h4NnVFTBlu8TaG5eecdArZEd7PRF5dFG3PqLJxctTwjnqIcKJr45MW3Ag6+nSokqvaDBZWSSG6rd3n6a9eik58dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183035; c=relaxed/simple;
	bh=sCM4sJDcfFwxEyDbavACZ6h2WRzqiGEWv+Vg4M7AMzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7FZ5JoeU12ncvlmXBe9sqPzeswhTn33Fhc9kFDiF3FVNUkTekTlRaEe+R6tv/CrCDBm0KV1Q/3OHTYrDuwyr8khEMc2J8yJwLUvfDJda2GEp8zpcO/6lXxia7hic7/6JT+w5S6UITSQKkrytDrE/z5Ne6n/tRLUbZ9qqhjS2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=f54g+w64; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dbQOd98n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="f54g+w64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dbQOd98n"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30AAF11400B8;
	Sun, 25 May 2025 10:23:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 25 May 2025 10:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748183032;
	 x=1748269432; bh=j1bajeNtGYjYtNhsXeIGJRyw2w3gwjl1vZdvY3z9Ygg=; b=
	f54g+w64kU9FwHtxlfZdixPaUlBTw38kMdgapSzr2MfCPBirjbzcCYabvJvmhW/A
	fGK7ztQ8to+BSLHskzHmQSAhmYkNzDOrHQnvE2sx2z0WNkHVsTvNuik4AZyk/6l3
	2g9fAnSu7bgLacSjUyQTmgV4vySOrCAOqsGPzvg3k6rihfc4tCZaqLmMVsjGJcrf
	XxUnVt5P4rO6e4F2NaSXDo9BkAvtTxEtNfzgJYbqFCpL9VUXTKTTrp51Mzp1gRpm
	MSzfcYs+UbmReQWLt8HiV4E4vbnRGzrVHezG06mw0D64Fpe+6p9VNGLXzAg2Aq3w
	iKoOGkFgAqa6VZaKIikoww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748183032; x=
	1748269432; bh=j1bajeNtGYjYtNhsXeIGJRyw2w3gwjl1vZdvY3z9Ygg=; b=d
	bQOd98n70/VWe2EgXNoktcDSyzUECEGJArG8r7P7aMp0sohKgUUFFOHlV7N/Ih58
	GecVVygQQX+z2qj0twFe4WgxZhYOD1cadCsJMLzdY26WNtwwetjTKvHI2IxflGt3
	aWRAPcms95K/VeuIf1Kz47lCBQoJfS577XmgS3uAmyfC6ztOLjXaydWNAvJ8yehA
	dbbaW1BkAuJesG05CeY9l4Hq5D57ZafiswW0xsqeJJgmkUYU1AXHczyXE/Kx2AIU
	i704JKpbbbrZn/dKX8VTd6myrEGKDv+BfN6iFnDd33Pdl+Qi9MvvB1ywv4TpjIM/
	qxU9vRS0vj7siUF5TNmMw==
X-ME-Sender: <xms:9yczaCGiVq6jbRVe5KBJ4lkZ6QryEKwjYBa4eeUqcUuOMsz1TVTINA>
    <xme:9yczaDXK7my1sucYkVa8XK5bg-PubC9WEjg4zc5B6JveWc_-DQ20at2sVxaRkpL7v
    ynf83DT5bbuWR3l5sI>
X-ME-Received: <xmr:9yczaMIOlEE0Me6QamioBIypTI_G_D42z5pI_KKHb-JzlKztrxYodGKYn3CidJ9rujOPjC6R4C59N0mKUa4j2mm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddugeekgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeefvdehleeutdfhlefgvedv
    gfeklefgleekgedtvdehvdfgtdefieelhfdutefgudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9yczaMEACA3i0JfG7t4Ekx5sZ_08JbCRvwSBr6cuM7sM4DaONkEelw>
    <xmx:9yczaIV8RQm1vZMcktFpf0NwU1yrnHU5szl5CCCWPY7bBsxQTR4HQw>
    <xmx:9yczaPMe-AGbTP1Up3-4zD21ih1UAdOoAxtfu60Vlv-lP65Z_4kvzA>
    <xmx:9yczaP0QFXdgSNiYolTY8LmzDl6Omv6A4-ytAwrcqwd-dSOkaZXx4w>
    <xmx:-CczaK349ZVHGX18SO5AzM0t-vk8zitJ2ZQIZsfgKnmey_CnQ3pK6e7F>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 May 2025 10:23:50 -0400 (EDT)
Message-ID: <7750bee1-bbab-486a-8533-098f650591f2@maowtm.org>
Date: Sun, 25 May 2025 15:23:46 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/landlock: Print a warning about directory
 permissions
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org
References: <cover.1748108582.git.m@maowtm.org>
 <9f5a3c41c1752e8770998f1e5b3e912b139fc13a.1748108582.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <9f5a3c41c1752e8770998f1e5b3e912b139fc13a.1748108582.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/25 18:56, Tingmao Wang wrote:
> Because we drop capabilities (most importantly, CAP_DAC_OVERRIDE), if a
> user runs the selftests under a Linux source checked out by a non-root
> user, the test will fail even when ran under sudo, and will print a
> "Permission denied" error.  This creates a confusing situation if they
> does not realize that the test drops capabilities, and can mislead users
> to think there's something wrong with the test or landlock.
> 
> This patch produces output that looks like:
> 
>    # #  RUN           layout0.ruleset_with_unknown_access ...
>    # # fs_test.c:240:ruleset_with_unknown_access:Expected 0 (0) == mkdir(path, 0700) (-1)
>    # # fs_test.c:244:ruleset_with_unknown_access:Failed to create directory "tmp": Permission denied
>    # # fs_test.c:230:ruleset_with_unknown_access:Hint: fs_tests requires permissions for uid 0 on test directory /home/mao/landlock-selftests/tools/testing/selftests/landlock and files under it (even when running as root).
>    # # fs_test.c:232:ruleset_with_unknown_access:      Try chmod a+rwX -R /home/mao/landlock-selftests/tools/testing/selftests/landlock
>    # # ruleset_with_unknown_access: Test terminated by assertion
>    # #          FAIL  layout0.ruleset_with_unknown_access
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 35 +++++++++++++++++++---
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index e65e6cc80e22..21ed8afcc060 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -216,14 +216,37 @@ static void mkdir_parents(struct __test_metadata *const _metadata,
>   	free(walker);
>   }
>   
> +static void
> +maybe_warn_about_permission_on_cwd(struct __test_metadata *const _metadata,
> +				   int err)
> +{
> +	char abspath_buf[255];
> +
> +	if (err == EACCES) {
> +		const char *realp = realpath(".", abspath_buf);
> +		if (realp == NULL) {
> +			realp = ".";
> +		}
> +		TH_LOG("Hint: fs_tests requires permissions for uid %u on test directory %s and files under it (even when running as root).",
> +		       getuid(), realp);
> +		TH_LOG("      Try chmod a+rwX -R %s", realp);

Actually, just having rwx on the test directory itself is not enough. 
For audit tests, in order to set the executable itself as AUDIT_EXE, we 
pass in an absolute path (which is required), which then means that we 
need path walk permission from root to the executable (otherwise 
audit_alloc_mark -> kern_path_locked fails), so in fact if the user has 
a setup where the home directory, containing the Linux source code, is 
not world-readable (or owned by root), fs_test::audit_layout1 etc will 
fail too...

I wonder if we should in fact drop capabilities only after fixture 
setup?  Alternatively we should have an appropriate message explaining 
that the test dir needs to be walkable and writable by root without 
CAP_DAC_OVERRIDE.

