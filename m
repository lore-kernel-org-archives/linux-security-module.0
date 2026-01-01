Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06301EA65
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305287; cv=none; b=C+4qhkjYsAFwPMtVnorh7ILC/OepvUKkk5/JeM3tbD1jTjJIFysc+PqG+r6cr+phUJ7VuODJD2oMsdOllh+JjXf7Xk8hCMMhjNKARn+NcUyxYUxLBTS55TdHCb9lGjXX1eTXBaHGKYVeZFvNq1RfWiCkTsw2XAZ65eWFoerZ1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305287; c=relaxed/simple;
	bh=7hH0DkpBkQhiYFomFeLoAIt1vuvYpVnCKPBBSowWohU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llqLDVm1NS7svkkQ0apPOJQ3YLhXVoQD9l4A/PiX2/thZLrVNvgB1XBJxGLj2SCN5ihU4lfsglvLMZH2nD6+NXDeDhXb8W7AJJsa1jVASfjdZkguyla1wz8m9RnJkeomvLNkoUa5L1hQNjPpre1dt7akjbFEDqG9I9tO5gkM3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=JdQKygD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6NtfPda; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="JdQKygD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6NtfPda"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BE9661D0008B;
	Thu,  1 Jan 2026 17:08:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 01 Jan 2026 17:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767305283;
	 x=1767391683; bh=rF8RSEQGxNrJ1TkxSM3c8Y4sX2a6Q5cHtuIo/Bhbkgc=; b=
	JdQKygD6LPEkGHhS7xxOuMGLTNYDDWa+x9k/TYdmdsfKGHwiqoeiY1Sw/JW4NloM
	4XGOnv7jUb8Ao+Yca1U7kQL41AGjTGoGQEzowMUDZWg6/FPG4GXY2xcyvFL4zzzT
	k+AD3PNUPav0oHBU8hljOW1/XcOHZjOK5d1FcFNsWNRtX7dJvenKwNbJxwCtfxd/
	BMZjUHgq+yqf6WAqoDdDGsBjDgnSZKuFdil3A4WbPiODjWCeGCDN+yjTLZyFBvcV
	5dxHsOCGkswItTd2zhnNvPhTt/rpKW7JpNfCqgYjHgGLk/ili924L22XxkmDZExZ
	p4qdiLhgUacacBZyxToE8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767305283; x=
	1767391683; bh=rF8RSEQGxNrJ1TkxSM3c8Y4sX2a6Q5cHtuIo/Bhbkgc=; b=O
	6NtfPdau366VK10+avZhoJWw+8UFBuy9i3/8niNdHth5eJFfd015bByp95zde+QN
	u5LAY7fruBEdw7BTNbpuiksFLv/64FZ75lkT+3nUuRC8Z7QiuE7zyPRZ+dKhtJt2
	KIcMKLQ0VFwyAHGD8P+RdGs8LcADclbyLm1M0DIi7/P0uql+RmSeRNLkxQjO6Ftp
	lLXuScZFMBSajgrAdDouStcfX92Tn23iXxgkQnXkP0Z8u6G3NWYd4+51KGO2tcRb
	qyUoM+mlzznQE3Af/4Vj83nvV4QXNNFcG87h1KeiIuHse75YwA05SA8Kxg308wOv
	zgffYF1X37kYxDOyKW7zQ==
X-ME-Sender: <xms:QvBWafvOiCoIt5QiUJ7KVxwGIRMn_chYIgQCeh2OX-y5NYFtDxkBew>
    <xme:QvBWaWbEifxZ81MiDLDTWANeREB5gIKz0dkM3TlpKPfLAKLeOSWvoJNA9-6DK0IWr
    R-dwk4vGHEZgirFUDHKocxiBuW2UUbrHPKLXT03Os2Ftnayg0hM7e0>
X-ME-Received: <xmr:QvBWaf7ikTQvLf5lxPJDlz-HxbMQyqJ1Jnr3j42JiHYlOxSJBabwkoolWwuDpEcWKrJyC_4SelhhtApfmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekieelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgnhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhopehuthhilh
    hithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvmhhiohgsvghn
    ohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehfrghhihhmihhtrghhvghrrgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhihsshgrrdhishdprhgtphhtthho
    pehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtoh
    hmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhho
    nhhsthgrnhhtihhnrdhmvghskhhhihguiigvsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:QvBWae_kH5PpWNjLXbhLC3MyQfF5tcShdauX_xddK10AGWiAfV3FJw>
    <xmx:QvBWabZ_QagDAclDn7uFLAKhtp6KPsrkJBL1OSVL7b6QNziSbwMcMA>
    <xmx:QvBWaX7HVoasIMFH-mTuYo51tW7NhtPHmC7usQXkyDGpsZqWJ7Rekw>
    <xmx:QvBWaQkYHPQ3F5axXN4cVBycEJD3I0iP6uStPRJxwrvvNvP4U5LoNA>
    <xmx:Q_BWaS35IItIfFTufN6OKtjjq7u-YVm5RL9Bnzx76YxFLIhJTAbKeLbC>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 17:08:00 -0500 (EST)
Message-ID: <423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org>
Date: Thu, 1 Jan 2026 22:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>
Cc: demiobenour@gmail.com, fahimitahera@gmail.com, hi@alyssa.is,
 ivanov.mikhail1@huawei-partners.com, jannh@google.com,
 konstantin.meskhidze@huawei.com, linux-security-module@vger.kernel.org,
 matthieu@buffet.re, mic@digikod.net, paul@paul-moore.com,
 samasth.norway.ananda@oracle.com
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260101193009.4005972-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/1/26 19:30, Justin Suess wrote:
> Allow users to separately specify unix socket rights,
> document the variable, and make the right optional.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Cc: Günther Noack <gnoack3000@gmail.com>
> ---
> 
> Notes:
> 
>     Small fixup suggestion patch to this RFC series.
> 
>     Handling the unix connect rights separate from
>     other rights makes more sense, and makes the sandboxer
>     much easier to use. Also connect doesn't really neatly
>     correspond to "roughly write" in my opinion, so this puts
>     it in a separate variable documented in the help printout.
>     
>     This also makes it possible to specify rights on the socket itself,
>     which wasn't possible.
>     
>     before:
>     ~ # LL_FS_RO=/ LL_FS_RW=/tmp/test.sock landlock-sandboxer sh -c 'echo "hello" |
>     socat - UNIX-CONNECT:/tmp/test.sock'
>     Executing the sandboxed command...
>     2026/01/01 19:14:33 socat[78] E connect(, AF=1 "/tmp/test.sock", 16): Permission denied
>     
>     after:
>     ~ # LL_FS_RO=/ LL_FS_RW= LL_UNIX_CONNECT=/tmp/test.sock landlock-sandboxer sh -c
>      'echo "hello" | socat - UNIX-CONNECT:/tmp/test.sock'
>     Executing the sandboxed command...
>     hello
> 
>  samples/landlock/sandboxer.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index b24ef317d1ea..3df7e7c8b6f1 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -62,6 +62,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
>  #define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
> +#define ENV_UNIX_CONNECT_NAME "LL_UNIX_CONNECT"
>  #define ENV_DELIMITER ":"
>  
>  static int str2num(const char *numstr, __u64 *num_dst)
> @@ -163,8 +164,14 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  			goto out_free_name;
>  		}
>  		path_beneath.allowed_access = allowed_access;
> -		if (!S_ISDIR(statbuf.st_mode))
> +		if (!S_ISDIR(statbuf.st_mode)) {
>  			path_beneath.allowed_access &= ACCESS_FILE;
> +			/* Keep CONNECT_UNIX for socket files. */
> +			if (S_ISSOCK(statbuf.st_mode))
> +				path_beneath.allowed_access |=
> +					allowed_access &
> +					LANDLOCK_ACCESS_FS_CONNECT_UNIX;

Looking at this I guess it might also make sense for the kernel side to
enforce only being able to add LANDLOCK_ACCESS_FS_CONNECT_UNIX on socket
files (S_ISSOCK(d_backing_inode)) too in landlock_append_fs_rule?

Also, for the sandboxer logic, maybe a better way would be having
LANDLOCK_ACCESS_FS_CONNECT_UNIX in ACCESS_FILE (matching the kernel code),
then another if(!S_ISSOCK) below this that will clear out
LANDLOCK_ACCESS_FS_CONNECT_UNIX if not socket.
