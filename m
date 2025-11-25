Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE81E2834
	for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032279; cv=none; b=OtxWWYVMl5DJ0ol+j5MwF3cD8TEqwx33lDqU1h/5xp6MNkopTf23MsCynMV2yKK0rImBiRnO4FNUOiNt5u6XsEkIIKEz+Q+Xnqp2xSAxUG0/qxjDViUFWA/ml1smGEhVcTfU4E8e2mfPP5eqFpukoVHYsj1SNyF8/eIK4nGhxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032279; c=relaxed/simple;
	bh=Q7motHxZ8La2rNTjTIAMY5vhRVLiqPmSzeMWXaa73kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuuITX56KAcVNr7HpxsPAmzfq9KMjZZ7Hxdb7GOY9xTfe7d0R6dpDUCsJdAZCtEoTn4Czs5maVR3Me0MsPVRxSWkgd3ZkjZBuAG5bk1k9teaMjswEfsXIK6gJoPjve3p1sPWOXg9tIDjeHSRooiRdctgsUeLtv0vixRxvs6YJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Q0ZZLYPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpNloVA+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Q0ZZLYPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpNloVA+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E4547A01BF;
	Mon, 24 Nov 2025 19:57:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 19:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764032274;
	 x=1764118674; bh=8vWPZENfzZOYoOV3Y6Wbw0Yo96gdyNYZQS9pKE61ckg=; b=
	Q0ZZLYPYGRGAugZDEWyPGkjQ4ABLquGzCVjCVWg0cS3RAgo4DO1gW/veZTtTOND2
	sOLnFj1+SjM+pZ7assjp5d9us5fTvW8H5o1YvG2a2jha5ilbW4xSeQ5wjVAioOZB
	14D4f6LG4OWSVMufatXb74orj0cPNV9fKoSXS9v9DZmlgiqOoMQY2QE/BOM63EDg
	ovOKHWEnvEV1FB9TZKiqNKXa+vWPUZnx9j+AWGbUC+KtS4QeskybiQhr+lTsd3if
	/IVh6w8NEF0hYUwqeevCKnJ+mm4lTM5tn3w8fYE6WNmDUX+AEf2MUNz436SsL6uu
	lVPDdXt4ZEHM/VkWdkndNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764032274; x=
	1764118674; bh=8vWPZENfzZOYoOV3Y6Wbw0Yo96gdyNYZQS9pKE61ckg=; b=T
	pNloVA+uL8A/ci7b8+aDrYBEIW3+H3/y/mLbalQNhreRue9pleqpdrhwXrdRxuy1
	6coMCAnROKw+4TVeVWaSHaglj4/Eirm0IIbEb2VidWSqJG7J7za94E2STJO97AgQ
	W4t7R1yhCq1tPd7nTipstwr+Z1rFYw5b8a+gA9avI59ZO99NmnGN33BH6EpvUjJc
	4FO9EMu4BgR/TKRAzYBAbsqmhNnwkm612RwpomygVjhbm0Hx4cSluqcMTVpvjwuD
	Czr7bINM1/ewrF+MHiZ3gM6LXX1eL8eLQhJiqY4cWkQCbQT3b4h5QqQHQP42bc10
	IEiSIVHkBqhSxIUzRoRnQ==
X-ME-Sender: <xms:Ev8kaSH4h4-GEXYTfUUsXSnpCOYrQBHBRj4njxVDPY2baqBKEMGlZA>
    <xme:Ev8kaXCNr5nbXvCpcLRQc3rYOku-OSi8EZN1N4k0Vv-9BJ_yrufjs-eID9NJYqaGU
    FTZLYoxeWvCoz4Ud8j4hVoCsOR4KpEehuTUkw1nncxIfJw0RUDAqQU>
X-ME-Received: <xmr:Ev8kaV8z1fQTGuxpOqaan59WUaQ7yc9AXOq6-vHdEo4v9A3B480hL04HBBJHDBYG-BqGyFmPwQSkY0vPpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekre
    dttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdho
    rhhgqeenucggtffrrghtthgvrhhnpeffhffhgeeujeekfefhffefteeijeffveetudethf
    fhjeejgeelueeijeffgfegudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    hitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnh
    gufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ev8kaTCpb2yyhGO09CbNthf69bJIwqUBbURqHS0SYP2AAg27QW2TUA>
    <xmx:Ev8kaaT4QXw7ENWunrKO_brQtSQ6Ev-z4YNAPT1qQa4ptiAsZEdH9g>
    <xmx:Ev8kaatU2iuLQ2s8CFwVGVbtzk-Ubv7C61LhethC454owQ2pi4Ltow>
    <xmx:Ev8kaW0ltDlZ4VW1Vnu7Ol36oCd2KKe3TYQnC5aR2DPXKHVJer_PSA>
    <xmx:Ev8kaTK5tLWtPMJd0Z22GuM88Qg3zgDRkcXFNvFB1dD7vEMDMYhh7nj1>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:57:53 -0500 (EST)
Message-ID: <8a901f10-5a59-4f02-b290-f849d3ba9301@maowtm.org>
Date: Tue, 25 Nov 2025 00:57:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] selftests/landlock: add tests for quiet flag
 with fs rules
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: gnoack@google.com, jack@suse.cz, xandfury@gmail.com,
 linux-security-module@vger.kernel.org
References: <a839025f9ce9facee60ff8238ee350b5e780b777.1763931318.git.m@maowtm.org>
 <20251124143639.3321365-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251124143639.3321365-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 14:36, Justin Suess wrote:
> [...]
> Small suggestion on the tests and samples. I saw you
> added a bool quiet to some methods for the quiet flag.
>
>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>> index 943b6e2ac53d..6aa65d344c72 100644
>> --- a/tools/testing/selftests/landlock/fs_test.c
>> +++ b/tools/testing/selftests/landlock/fs_test.c
>> @@ -718,11 +718,15 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
>>
>>  static void add_path_beneath(struct __test_metadata *const _metadata,
>>  			     const int ruleset_fd, const __u64 allowed_access,
>> -			     const char *const path)
>> +			     const char *const path, bool quiet)
>>  {
>>  	struct landlock_path_beneath_attr path_beneath = {
>>  		.allowed_access = allowed_access,
>>  	};
>> +	__u32 flags = 0;
>> +
>> +	if (quiet)
>> +		flags |= LANDLOCK_ADD_RULE_QUIET;
>>
>>  	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
>>  	ASSERT_LE(0, path_beneath.parent_fd)
>
>
> I think that the bool quiet could be replaced with a flags field
> so it can support other flags.
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 6aa65d344c72..5c38a11f1a05 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -717,16 +717,12 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
>  }
>
>  static void add_path_beneath(struct __test_metadata *const _metadata,
> -			     const int ruleset_fd, const __u64 allowed_access,
> -			     const char *const path, bool quiet)
> +			 const int ruleset_fd, const __u64 allowed_access,
> +			 const char *const path, __u32 flags)
>  {
>  	struct landlock_path_beneath_attr path_beneath = {
>  		.allowed_access = allowed_access,
>  	};
> -	__u32 flags = 0;
> -
> -	if (quiet)
> -		flags |= LANDLOCK_ADD_RULE_QUIET;
>
>  	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
>  	ASSERT_LE(0, path_beneath.parent_fd)
>
> And then update the tests to account for the changed
> function signature.
>
> I think the bool quiet in the landlock-sandboxer methods
> populate_ruleset_fs and populate_ruleset_net (in
> samples/landlock/sandboxer.c) should be updated as well,
> replacing the bool quiet with a general flags field.

Good point - I think both suggestions makes sense for future-proofing.
Here are the proper changes, which I will apply to v6.  For your
convenience, the new set of commits are available at
https://github.com/micromaomao/linux-dev/pull/13/commits

Mickaël - let me know if you have any other feedback on this series, and I
will send v6 afterwards.

squash! selftests/landlock: add tests for quiet flag with fs rules

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6aa65d344c72..c29ee72b2cc1 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -718,15 +718,11 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 
 static void add_path_beneath(struct __test_metadata *const _metadata,
 			     const int ruleset_fd, const __u64 allowed_access,
-			     const char *const path, bool quiet)
+			     const char *const path, __u32 flags)
 {
 	struct landlock_path_beneath_attr path_beneath = {
 		.allowed_access = allowed_access,
 	};
-	__u32 flags = 0;
-
-	if (quiet)
-		flags |= LANDLOCK_ADD_RULE_QUIET;
 
 	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd)
@@ -790,7 +786,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 			continue;
 
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
-				 rules[i].path, false);
+				 rules[i].path, 0);
 	}
 	return ruleset_fd;
 }
@@ -1368,7 +1364,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * ANDed with the previous ones.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d2, false);
+			 dir_s1d2, 0);
 	/*
 	 * According to ruleset_fd, dir_s1d2 should now have the
 	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
@@ -1400,7 +1396,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * Try to get more privileges by adding new access rights to the parent
 	 * directory: dir_s1d1.
 	 */
-	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, false);
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
@@ -1423,7 +1419,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * that there was no rule tied to it before.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d3, false);
+			 dir_s1d3, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1476,7 +1472,7 @@ TEST_F_FORK(layout1, inherit_superset)
 	add_path_beneath(_metadata, ruleset_fd,
 			 LANDLOCK_ACCESS_FS_READ_FILE |
 				 LANDLOCK_ACCESS_FS_READ_DIR,
-			 dir_s1d2, false);
+			 dir_s1d2, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -7647,7 +7643,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 			continue;
 
 		add_path_beneath(_metadata, rs_fd, r->access, r->path,
-				 r->quiet);
+				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
 	}
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));


squash! samples/landlock: Add quiet flag support to sandboxer

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 2d8e3e94b77b..07dc0013ff19 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -121,7 +121,7 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access, bool quiet)
+			       const __u64 allowed_access, __u32 flags)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -171,8 +171,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath,
-				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
+				      &path_beneath, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -190,7 +189,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 }
 
 static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
-				const __u64 allowed_access, bool quiet)
+				const __u64 allowed_access, __u32 flags)
 {
 	int ret = 1;
 	char *env_port_name, *env_port_name_next, *strport;
@@ -218,8 +217,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		}
 		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-				      &net_port,
-				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
+				      &net_port, flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with port \"%llu\": %s\n",
 				net_port.port, strerror(errno));
@@ -595,35 +593,31 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
-				false)) {
+	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro, 0))
 		goto err_close_ruleset;
-	}
-	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
-				false)) {
+	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw, 0))
 		goto err_close_ruleset;
-	}
+
 	/* Don't require this env to be present. */
 	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
 		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
-					true)) {
+					LANDLOCK_ADD_RULE_QUIET))
 			goto err_close_ruleset;
-		}
 	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP, false)) {
+				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP, false)) {
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
 		goto err_close_ruleset;
 	}
 
 	/* Don't require this env to be present. */
 	if (quiet_supported && getenv(ENV_NET_QUIET_NAME)) {
 		if (populate_ruleset_net(ENV_NET_QUIET_NAME, ruleset_fd, 0,
-					 true)) {
+					 LANDLOCK_ADD_RULE_QUIET)) {
 			goto err_close_ruleset;
 		}
 	}
