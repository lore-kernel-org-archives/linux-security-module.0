Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA2271456
	for <linux-security-module@vger.kernel.org>; Mon, 24 Nov 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995026; cv=none; b=Ilsyc4iyv03CaF3zbYvCb4UrhQQ4Wo2GGzXG6i0HjW1gqBRVAvK8+ORxHQkkveHRtgfUaZfkgUN1d7nX7HERibEKdb7Ax4bnrW5CdB+yr5lultFSDOG5CvETxZg4Vncv069ALlkAeQavl38VwymC4YNJh5xZ2TgmfLgkrkH0EiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995026; c=relaxed/simple;
	bh=yjj2TbEtwwfOD5jmRVCxPA2nCvMWheKhk+JSdjC/AwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKqmy/bXhNHzIuJKjEMW4vh0Kd9m3YqPZ1EIU9qBlT368p++uILCD8HUbyLH8sKD3vOBR53PlaXQGuIOysmHfTvYXJ/3Q/N9dC19nP4mStlyCdqNMZCqI1o7AAUVRbov2e+MGj63ESXNJaiYpV18U2OfhvwZtnHwN+r+tgWlF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdJcf4Sz; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdJcf4Sz"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64107188baeso3792502d50.3
        for <linux-security-module@vger.kernel.org>; Mon, 24 Nov 2025 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763995024; x=1764599824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9q4lkZ/9eEBVfrgLM9F5GrkwHkKooUdSNSuk53tJt4=;
        b=gdJcf4SzffG8CbtTJ3g3Zoyn2oDv0HkF9DGCsRXBmgYbza/UHQVthmFZCX5cpt9pt3
         qLVrARmfBge/jMR6I9w1n0TxTW9wMONTI1qfzZ1S0l7YYqseE6jKJeC0eHwpFtoW5StM
         5vv/k9hhA0YontJz4XrTVLOUh9uXF+4BSlKDxzFLmgXWPhQ206S/NwBF+1Upq+2lalmj
         y3ZIblFi1v2psPjoRtdOPdJmHTIMx9g3sq5BwMjdK+SfxtPnaTgXc/VrhFkP93VEVU+i
         3zYP2RPLMmJzSg5bB7Q7I+rDKgbRDBIHzR+21Sw2FCyNfUr0Csjn3czCkqfR7HcTQGdb
         u1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763995024; x=1764599824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9q4lkZ/9eEBVfrgLM9F5GrkwHkKooUdSNSuk53tJt4=;
        b=qvTL/T6Axif8FWVmOeauh1U6KIR3j8UHRUYnd0dnCvMgzLMMaJetGoKu0xlh3L3q0H
         jSGDMWBjcaAaSvY/V/WtDskcP9JS+wncNOjooz+NXFP5urYoeS8QF+KBDWoKXt64NZk5
         5FbV6CstWfT890kC8xZCBWcN5TZLTfl1ZGg8nd7AI/ktT1eEs6NWxFP9A9SfvvxYq2BF
         JDLEAmPquLEPE5KKLI7XQmuj8J9MopsFktpNVC0c7RlL5+9Uo8kJ0LnbB8nzAqn20rzN
         bwjIH5myoJtFdSy4XuHV6tbG1iehqMiQNUcR1lNrAmg99LyYaTgGmCwKExVcf4eKcOB4
         10Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXeNYqgO11FrsdcgrXhtwqMCMWEVDkH6Lggsxmfm0svKB/PuN0OmIYUirrSiCYyJgGbDRwItxtvsInnX61AF770byLDlII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcXuF5bzfXg+9lCz7HU+H0W7l5dBepXvo86QXKHcETAy1LymF
	ycO9YBiWhJ4QWiOvhfVK8CovxRbYo4hEEoHt6aXg2HidOmam+CY7oIlu
X-Gm-Gg: ASbGnctjx4p2hUMZvnUQXyIDKZDrLZk/rxnGX7Al8TtIqgJ9BlAg7/lkx5LJdSZGorN
	dsP67aq+od10Bbjur3V5nmyMPjI3Vv/52w1IBv6rau5rcvg6Afg/F+0/NWHoGbFrmQcnZbv0TL4
	iqT6t0QNhT865//V1YY4L2lnxvMnC4C82w6aGbdPGms/RmFIK0V8ufuOb8S0jhqUlQW+00eWG8Z
	C2vKm5FppRQfgrY1FcWMdhjAPpeArGtkhVx9Au5rBsYv5YmbqoZuDku1xWlxQzYSaejsUYzuaVY
	8tw8sXt7eXvsidIXcqepGTSQ30/9lQ+CytuNR+s0+ekjV3ZnMAu3oZX/hAVIInGNoeCKHWOPVpF
	VK60GhyhKQX0X7SWU0/3WgTiZXxkJ1WZOzHEVnV9tiNJAjjLXqZmsJKOuCCBxJFM6vbLuQunVk8
	UeIp4Zi7ORSfwNfZzcn4bDqpUSqW69JGPjKkM7TrPKAILVeGfJDzCRWr41vRR9
X-Google-Smtp-Source: AGHT+IGR5CiVn+W0z8SPuTEd3Xd0HKgfW/pS1dXggZMtxVpAEWf1illt5DH8MKhVzK+4+1iEEuyBhA==
X-Received: by 2002:a05:690e:1586:20b0:63f:9b00:70cf with SMTP id 956f58d0204a3-64302a8f588mr7086753d50.16.1763995023506;
        Mon, 24 Nov 2025 06:37:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a8ff9sm44845077b3.23.2025.11.24.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:37:03 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v5 07/10] selftests/landlock: add tests for quiet flag with fs rules
Date: Mon, 24 Nov 2025 09:36:39 -0500
Message-ID: <20251124143639.3321365-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <a839025f9ce9facee60ff8238ee350b5e780b777.1763931318.git.m@maowtm.org>
References: <a839025f9ce9facee60ff8238ee350b5e780b777.1763931318.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good morning,

Great job on the patch.

Small suggestion on the tests and samples. I saw you
added a bool quiet to some methods for the quiet flag.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 943b6e2ac53d..6aa65d344c72 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -718,11 +718,15 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
>  
>  static void add_path_beneath(struct __test_metadata *const _metadata,
>  			     const int ruleset_fd, const __u64 allowed_access,
> -			     const char *const path)
> +			     const char *const path, bool quiet)
>  {
>  	struct landlock_path_beneath_attr path_beneath = {
>  		.allowed_access = allowed_access,
>  	};
> +	__u32 flags = 0;
> +
> +	if (quiet)
> +		flags |= LANDLOCK_ADD_RULE_QUIET;
>  
>  	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
>  	ASSERT_LE(0, path_beneath.parent_fd)


I think that the bool quiet could be replaced with a flags field
so it can support other flags.

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6aa65d344c72..5c38a11f1a05 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -717,16 +717,12 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 }
 
 static void add_path_beneath(struct __test_metadata *const _metadata,
-			     const int ruleset_fd, const __u64 allowed_access,
-			     const char *const path, bool quiet)
+			 const int ruleset_fd, const __u64 allowed_access,
+			 const char *const path, __u32 flags)
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

And then update the tests to account for the changed
function signature. 

I think the bool quiet in the landlock-sandboxer methods 
populate_ruleset_fs and populate_ruleset_net (in 
samples/landlock/sandboxer.c) should be updated as well, 
replacing the bool quiet with a general flags field. 

I have change this in my patch but it might make more sense in 
your patch since this is the first patch to add flags and would
make it easier if anyone else decides to add flags rebased on
your patch.

Great work and thank you for your help.

Kind Regards,
Justin Suess
