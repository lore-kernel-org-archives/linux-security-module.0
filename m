Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854715B10C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664069; cv=none; b=dkAQJbeowVenBLTfOCPB6uGLP+cGXkNMLicYk/feIiwDsMR7xlpre/nLIzAGyPy6/z8TLH4f1t/oTomJjzwh00xpzQlCKxB7+bBf/jKDnlSI7EVFOb/QOw1Z4EQnIRjcZFd0xVMrTH0jpyfOxkq1nkZbajbKy5/+iWGMypwpM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664069; c=relaxed/simple;
	bh=ef3HrEgDtu4ft+ZmlgTfdbkDsLyBnVrav+g26MJalvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSfWCLX9tPE2s8yLqdFYM869gyAFZ6/hCP/5PCT8TSRXDT40Hf1hORpmpGSUlI1ctlpbHQQCFsOa6vfblhWIpHnRdtvIPuBHd3JKk53dH3kN6REUPvslW8hbKQxnRUSFyzx26OaTtgpreqijXcaGYn2sHXXg2kDqYqEONMkDrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RcPAlBQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RcPAlBQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a8de19f5fso3078993276.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726664067; x=1727268867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRc08FCczPdsW71H9JOH0y/m0GfJajHcBYzYYeDq6A=;
        b=0RcPAlBQ5LXPemWWpnsKJ/2PvyCL8G8+RQNwROoPvWDHMMvh54DHljCJwB5W2sABZC
         ui9r6H6zs1U29tumUmtvFtCrN0VHeoirUJNzOrQePQc1nnH0+NK0VeOQ+WvN9Wnort6S
         aw3zhloTf+qfhpeE3xSdHtfkJIrsJQEp5mwOCt1pgLdhqcxZS6dz0btU514zx/kBz6rZ
         RF4hFdKWZ23E7tQ6oOONFIt4fonASdPgorj1+5Yuq7C40FBJkTJ4B08siROHAnoP5LXm
         UePNQgi2QiBJ4k137bfPyrRNP2TEXxBeusUsj36KRzloDv0nrS9zXgEN71RYETjlJqdK
         gjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664067; x=1727268867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRc08FCczPdsW71H9JOH0y/m0GfJajHcBYzYYeDq6A=;
        b=KSdD/PAV+V5xfszv9xaB11pa/MSa6di9+ea0MeaAvdZE8wqRbxwA33Fn3wBmhljOeJ
         zifLF1hxCDpwWAcyq+RnEO2n8iLdqOFjAI83pEoDrRHPT8xry0e+P7CPUysC6A4/ciU0
         yHkppzeFwXd+oFteDrg1sBmvpbBcJzAs7u9e2Ca9nrX9IJH8oXgJ4dR8qa+9BLZP0wXB
         6O/f1GTdoYCcSTNK4ScUPI3pXOMV43FVlULjmkKMstcpnjCSNdijUrxjlWTC2310+/LN
         roviMEMo2jFalGG+x6ZYClhJ13HCMWlOL6Hpo/4a2OrglKZXy0Te9JdVskmrafBMs2ka
         A97Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg5wJdhT/cc+8HpMvyerr+JeW2waWmgbi5Sonm1P3/jm/1x/fJUgXZ5CAMFTMntekeew86H9aBvY3dbTcB7Mwgi4o4+aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOnDKAQl8C8O/6cSw8H9/3xJmaLZkuKA7A+SPuaF/omgTCrsF
	BeCkuniKseLqxAokw1/ErPRYj2aqaxblKUif+kXHKTO1VluMP4Lly/sn0GKXYZrFHsg2JBvHgQn
	yGA==
X-Google-Smtp-Source: AGHT+IG15o1jupjyYUDnAEDGWyZO2IZfc9aAQm42wZdtbhtjP347i/eQgmQspm1GEYKrYUVWJmrn23hrnl0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:d344:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e1daff59debmr60712276.2.1726664067072; Wed, 18 Sep 2024 05:54:27
 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:54:24 +0200
In-Reply-To: <20240904104824.1844082-12-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-12-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurNgJKzG-oWL3Tq@google.com>
Subject: Re: [RFC PATCH v3 11/19] selftests/landlock: Test unsupported
 protocol restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 04, 2024 at 06:48:16PM +0800, Mikhail Ivanov wrote:
> Add test validating that Landlock doesn't wrongfully
> return EACCES for unsupported address family and protocol.
> 
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v1:
> * Adds socket(2) error code check when ruleset is not established.
> * Tests unsupported family for error code consistency.
> * Renames test to `unsupported_af_and_prot`.
> * Refactors commit title and message.
> * Minor fixes.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
> index 047603abc5a7..ff5ace711697 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -581,4 +581,51 @@ TEST_F(prot_outside_range, add_rule)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
>  
> +TEST(unsupported_af_and_prot)

Nit: If I am reading this test correctly, the point is to make sure that for
unsuported (EAFNOSUPPORT and ESOCKTNOSUPPORT) combinations of "family" and
"type", socket(2) returns the same error code, independent of whether that
combination is restricted with Landlock or not.  Maybe we could make it more
clear from the test name or a brief docstring that this is about error code
compatibility when calling socket() under from within a Landlock domain?

> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	struct landlock_socket_attr socket_af_unsupported = {
> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNSPEC,
> +		.type = SOCK_STREAM,
> +	};
> +	struct landlock_socket_attr socket_prot_unsupported = {
                                           ^^^^
Here and in the test name: Should this say "type" instead of "prot"?
It seems that the part that is unsupported here is the socket(2) "type"
argument, not the "protocol" argument?

> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNIX,
> +		.type = SOCK_PACKET,
> +	};
> +	int ruleset_fd;
> +
> +	/* Tries to create a socket when ruleset is not established. */
> +	ASSERT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	ASSERT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &socket_af_unsupported, 0));
> +	EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &socket_prot_unsupported, 0));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create a socket when protocols are allowed. */
> +	EXPECT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	EXPECT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create a socket when protocols are restricted. */
> +	EXPECT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	EXPECT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
